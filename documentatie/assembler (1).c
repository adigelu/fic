#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int push_OR_pop = 0;
int branch = 0;

int check_operation(char op[], char instr[]) {
    if (strcmp(op,"ADD") == 0)
        strcpy(instr,"001101");
    else if (strcmp(op,"SUB") == 0) 
        strcpy(instr,"001110");
    else if (strcmp(op,"LSR") == 0) 
        strcpy(instr,"001111");
    else if (strcmp(op,"LSL") == 0) 
        strcpy(instr,"010000");
    else if (strcmp(op,"MUL") == 0) 
        strcpy(instr,"010001");
    else if (strcmp(op,"DIV") == 0) 
        strcpy(instr,"010010");
    else if (strcmp(op,"MOD") == 0) 
        strcpy(instr,"010011");
    else if (strcmp(op,"CMP") == 0) 
        strcpy(instr,"010100");
    else if (strcmp(op,"INC") == 0) 
        strcpy(instr,"010101");
    else if (strcmp(op,"DEC") == 0) 
        strcpy(instr,"010110");
    else if (strcmp(op,"AND") == 0) 
        strcpy(instr,"010111");
    else if (strcmp(op,"OR") == 0) 
        strcpy(instr,"011000");
    else if (strcmp(op,"XOR") == 0) 
        strcpy(instr,"011001");
    else if (strcmp(op,"NOT") == 0) 
        strcpy(instr,"011010");
    else if (strcmp(op,"RSR") == 0) 
        strcpy(instr,"011011");
    else if (strcmp(op,"RSL") == 0) 
        strcpy(instr,"011100");
    else if (strcmp(op,"MOV") == 0) 
        strcpy(instr,"011110");
    else if (strcmp(op,"TRX") == 0) 
        strcpy(instr,"000000");
    else if (strcmp(op,"TRY") == 0) 
        strcpy(instr,"000001");
    else if (strcmp(op,"LDR") == 0) 
        strcpy(instr,"000010");
    else if (strcmp(op,"STR") == 0) 
        strcpy(instr,"000011");
    else if (strcmp(op,"PSH") == 0) 
        strcpy(instr,"000100");
    else if (strcmp(op,"POP") == 0) 
        strcpy(instr,"000101");
    else if (strcmp(op,"BRZ") == 0) 
        strcpy(instr,"000110");
    else if (strcmp(op,"BRN") == 0) 
        strcpy(instr,"000111");
    else if (strcmp(op,"BRC") == 0) 
        strcpy(instr,"001000");
    else if (strcmp(op,"BRO") == 0) 
        strcpy(instr,"001001");
    else if (strcmp(op,"BRA") == 0) 
        strcpy(instr,"001010");
    else { return 0; }
    return 1;
}
char *int2bin_branch(int n)
{
	char *s = malloc(sizeof(char) * 11);
	int i;
	for (i = 0; i < 10; i++)
	{
		s[i] = ((n >> (9 - i)) & 1) + '0';
	}
	s[i] = '\0';
	return s;
}

char *int2bin(int n)
{
	char *s = malloc(sizeof(char) * 10);
	int i;
	for (i = 0; i < 9; i++)
	{
		s[i] = ((n >> (8 - i)) & 1) + '0';
	}
	s[i] = '\0';
	return s;
}

void check_R(char R[], char instr[]) {
    if (strcmp(instr,"000100") == 0 || strcmp(instr, "000101") == 0) {
        printf("of %d\n", atoi(instr));
        push_OR_pop = 1;
        branch =  0;
        if (strcmp(R,"X") == 0) {
            strcat(instr,"00");
        }
        if (strcmp(R,"Y") == 0) {
            strcat(instr,"01");
        }
        if (strcmp(R,"ACC") == 0) {
            strcat(instr,"10");
        }
        if (strcmp(R,"PC") == 0) {
            strcat(instr,"11");
        }
    } else if (strcmp(instr, "000011") == 0 || strcmp(instr, "000010") == 0 || (atoi(instr) >= 1101)) {
        push_OR_pop = 0;
        branch = 0;
        if (strcmp(R,"X") == 0) {
            strcat(instr,"0");
        }
        if (strcmp(R,"Y") == 0) {
            strcat(instr,"1");
        }
    } else {
        push_OR_pop = 0;
        branch = 1;
        int opr_to_int = atoi(R);
        printf("R este %d\n", opr_to_int);
        char* converted_binary = int2bin_branch(opr_to_int);
        strcat(instr, converted_binary);
    }
}

void check_operand(char opr[], char instr[]) {
    int opr_to_int = atoi(opr);
    char* converted_binary = int2bin(opr_to_int);
    strcat(instr, converted_binary);

}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr,"Argumente invalide");
        exit(1);
    }

    char linie[1024];
    FILE* cod = fopen(argv[1],"r");
    FILE* asm1 = fopen("result.asm","w");
    if (!cod) {
        fprintf(stderr,"Fisier eronat");
        exit(1);
    }

    if (!asm1) {
        fprintf(stderr,"Fisier eronat");
        exit(1);
    }

    while (fgets(linie, 1024, cod)) {
        char* aux = strtok(linie," \n");
        char instr[17] = {};
        int i = 0;
        while (aux != NULL) {
            if (i == 0){
                if(!check_operation(aux,instr))
                {
                    aux = strtok(NULL, " ");
                    check_operation(aux, instr);
                    printf("in %s\n", instr);
                }
                printf("out %s\n", instr);
            }
            else if (i == 1)
                check_R(aux,instr);
            else if (i == 2)
                check_operand(aux,instr);
            i++;
            aux = strtok(NULL, " \n");
        }
        if (i == 2) {
             if (push_OR_pop) {
                strcat(instr, "00000000");
             } else if (!branch) {
                strcat(instr, "000000000");
             }
        }
        fprintf(asm1,"%s\n",instr);
    }

    fclose(cod);
    fclose(asm1);
    return 0;
}