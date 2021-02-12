#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>


int arr_size = 100;
int chars_size=1;

void CharFreqEq(char all[]){
int i=0;
size_t n = strlen(all);
    if(n>0 && all[n-1] == '\n')
    all[n-1] = '\0';
char chars[n];
int chars_freq[n] ;
chars[0]=all[0];
chars_freq[0]=1;
int j,x=0;

for (i=1;i<n;i++){
            x=0;
            //check if already added to chars
            for(j=0;j<chars_size;j++){
                if(all[i]==chars[j]){
                    chars_freq[j]++;
                    x=1;
                }
            }
            //if not added to chars
            if(x==0){
                chars[chars_size]=all[i];
                chars_freq[chars_size]=1;
                chars_size++;
            }
        }
for(i=0;i<chars_size;i++){

    printf("%c \n",chars[i]);
}
for(i=0;i<chars_size;i++){

if(chars_freq[i]==1){
printf("%c \t frequency = (1) \n",chars[i]);
}
else if(chars_freq[i]==2){
printf("%c  frequency = (2) \n",chars[i]);
}
else if(chars_freq[i]==3){
printf("%c  frequency = (3) \n",chars[i]);
}
else{
    continue;
}
}

}



void WordsFreqEq(char paragraph[arr_size]){

    int i=0;
    int count = 0;
    int j = 0;
    int k=0;
    int space = 0;
    int flag = 0;
    char words [arr_size][arr_size] ;
    int wcount=0;

    for (i = 0;i<strlen(paragraph);i++)

    {
        if ((paragraph[i] == ' '))
        {
            space++;
        }

    }
i = 0 ;
k = 0 ;
/*
   for ( j = 0;j < strlen(paragraph);j++)
    {
        if ((paragraph[j] == ' '))
        {
            arr[i][k] = '\0';
            i++;
            k = 0;
        }
        else
             arr[i][k++] = paragraph[j];
    }
    */

    //seperating paragraph into words
    j=0;

    for(i=0;i<=(strlen(paragraph));i++)
    {
        if(paragraph[i]==' '||paragraph[i]=='\0')
        {
            words[wcount][j]='\0';
            wcount++;
            j=0;
        }
        else
        {
            words[wcount][j]=paragraph[i];
            j++;
        }
    }
    //////////////////////////////////////////
    //calculate freq of each word and store it into wfreq array

    int wfreq[space+1];

    for (i = 0;i <= space;i++)
    {

        for (j = 0;j <= space;j++)
        {
            k= 0 ;
            while(words[i][k] != '\0')
            {

                if(words[i][k] != words[j][k])
                {
                    flag = 1;
                    break;

                }
                k++;

            }
            if(flag == 0){
                count++;}
            flag = 0;
        }
        //printf("%s -> %d times\n", arr[i], count);
        wfreq[i]=count;
        count = 0;
    }
    //////////////////////////
    for(i=0;i<space;i++){
        if(wfreq[i]==1)
        printf("%s  frequency = (1) \n",words[i]);

        if(wfreq[i]==2)
        printf("%s  frequency = (2) \n",words[i]);

        if(wfreq[i]==3)
        printf("%s  frequency = (3) \n",words[i]);

    }

}
/* Swaps position of strings in array (char**) */
void swap(char **a,  char **b) {
	char *temp = *a;
	*a = *b;
	*b = temp;
}

void quicksort(char * arr[], unsigned int length) {
	unsigned int i, piv = 0;
	if (length <= 1)
		return;

	for (i = 0; i < length; i++) {
		// if curr str < pivot str, move curr into lower array and  lower++(pvt)
		if (strcmp(arr[i], arr[length -1]) < 0){	//use string in last index as pivot
			swap(arr + i, arr + piv);
			piv++;
		}
	}
	//move pivot to "middle"
	swap(arr + piv, arr + length - 1);

	//recursively sort upper and lower
	quicksort(arr, piv);			//set length to current pvt and increase for next call
	piv++;
	quicksort(arr + piv, length - piv);
}
int countOccurrences(char * str, char * toSearch)
{
    int i, j, found, count;
    int stringLen, searchLen;

    stringLen = strlen(str);      // length of string
    searchLen = strlen(toSearch); // length of word to be searched

    count = 0;

    for(i=0; i < stringLen; i++)
    {
        /* Match word with string */
        found = 1;
        for(j=0; j<searchLen; j++)
        {
            if(str[i + j] != toSearch[j])
            {
                found = 0;
                break;
            }
        }

        if(found == 1)
        {
            count++;
        }

    }

    return count;
}
void v_CharFrequency ( char paragraph[])
{
    char arr[100];
    int i,j;
    int freq = 0;
    int m = 0,flag = 0;




    for(i=0; paragraph[i] != '\0';i++)
    {
        for(j=0 ; arr[j] != '\0'; j++)
        {
            if(arr[j] == paragraph[i])
            {
                flag = 1;
                continue;
            }
        }
        if(flag == 0)
        {

            arr[m] = paragraph[i];
            m++;

        }
        flag = 0;


    }

    for(i=0; arr[i] != '\0' ; i++)
    {
        for(j=0;  paragraph[j] != '\0' ; j++)
        {

            if(paragraph[j] ==  arr[i])
            {
                freq ++;
            }
        }
        if (arr[i] != ' ' && arr[i] != '\n' && freq != 0)
        {

            printf("Character %c Occurs %d\n", arr[i] ,freq);

        }
        freq = 0;
    }
}

void Word_Statistics(char paragraph[100]){



    int count = 0;
    int i;
    int j = 0;
    int k=0;
    int space = 0;
    int flag = 0;
    char arr [100][100] ;


    for (i = 0;i<strlen(paragraph);i++)

    {
        if ((paragraph[i] == ' '))
        {
            space++;
        }

    }
i = 0 ;
k = 0 ;
   for ( j = 0;j < strlen(paragraph);j++)
    {
        if ((paragraph[j] == ' '))
        {

            arr[i][k] = '\0';
            i++;
            k = 0;
        }
        else

             arr[i][k++] = paragraph[j];

    }

    for (i = 0;i <= space;i++)
    {

        for (j = 0;j <= space;j++)
        {
            k= 0 ;
            while(arr[i][k] != '\0')
            {

                if(arr[i][k] != arr[j][k])
                {
                    flag = 1;
                    break;

                }
                k++;

            }
            if(flag == 0){
                count++;}
            flag = 0;
        }
        printf("%s -> %d times\n", arr[i], count);
        count = 0;
    }
    }

int findandreplae(char s1[100],char sw[20],char rw[20]){
    char w[20],ch;
    strcat(s1," ");
    int i,k=0,flag=0;
	for(i=0;s1[i]!='\0';i++)
	{
		ch=s1[i];
		if(ch!=' ')
		{
			w[k]=ch;
			k++;
		}
		else
		{
			w[k]='\0';
			k=0;
			if(strcmp(w,sw)==0)
			{   flag=1;
				printf("%s ",rw);

			}
			else
			{
				printf("%s ",w);
			}
		}
	}
return flag;
}

int main(int argc, char** argv)
{     char sw[20],rw[20];
 char *arr[100];
 char all2[100];
 char *token;

    int count;
    char all[arr_size];
    printf("enter a paragraph\n");
    fgets(all,sizeof(all),stdin);
    strcpy(all2, all);
    /*The C library function char *fgets(char *str, int n, FILE *stream) reads a line from the specified stream and stores it into
    the string pointed to by str. It stops when either (n-1) characters are read,
    the newline character is read, or the end-of-file is reached, whichever comes first.*/

    //sizeof function is fun return the size of array or any datatype in bytes

    size_t n = strlen(all);
    /*The datatype size_t is unsigned integral type.
    It represents the size of any object in bytes and returned by sizeof operator.
    It is used for array indexing and counting.*/

    if(n>0 && all[n-1] == '\n')
    all[n-1] = '\0';




    //saves each char and its freq
        char chars[n];
        int chars_freq[n] ;

        chars[0]=all[0];
        chars_freq[0]=1;

        int i,j,x=0;
        int choose123;
       // int arr4[200];


        int choise;
        printf("select from \n1    Character Statistics ,Frequency \n2    Word Statistics \n3    Find and replace a character or a word.\n4    Get all characters/wordsthat have frequencies of one, twoand three.\n5    Search on a specific word/character \n6    sort word  using quicksort\n");
        scanf("%d",&choise);

    switch(choise){
        case 1:
            //1st point

        //char paragraph[200];

        v_CharFrequency(all2);

        break;

        case 2:
            //2nd point

    Word_Statistics(&all);
        break;

        case 3:
            //3nd point find and replace
            printf("\nEnter search word or char: ");
             scanf("%s",sw);
            printf("\nEnter replace word or char : ");
                scanf("%s",rw);
            printf("\nOutput = ");
            int flag=findandreplae(&all,&sw,&rw);
            if(flag==0){
                printf("\nyour word to search not found");
            }
        break;

        case 4:
            //4nd point
            printf("\n if you want freqs1,2,3 for chars press 1 ,for words press 2 \n");
            scanf("%d",&choose123);
            if(choose123==1){
                CharFreqEq(&all);
            }
            else if(choose123==2){
                WordsFreqEq(&all);
            }
            else{
                printf("worng choise");
            }
        break;

        case 5:
            //5nd point


            printf("Enter word to search occurrences: ");
       scanf("%s",sw);


            count = countOccurrences(all, sw);

            printf("Total occurrences of '%s': %d", sw, count);
        break;
            case 6:
            //6nd point

    // Extract the first token
     token = strtok(all2, " ");

    // loop through the string to extract all other tokens
    int length=0;
    while( token != NULL ) {
        arr[length] = token ; //take each token
        token = strtok(NULL, " ");
        length++;
    }
	quicksort(arr, length);
	int i;
	for (i=0 ; i < length ; i++) {
		printf("%s ",arr[i]);
	}
        break;

    }
    return 0;
}