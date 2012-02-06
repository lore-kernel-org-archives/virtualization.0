From: Jidong Xiao <jidong.xiao@gmail.com>
Subject: Strange finding about kernel samepage merging
Date: Mon, 6 Feb 2012 17:44:43 -0500
Message-ID: <CAG4AFWaXVEHP+YikRSyt8ky9XsiBnwQ3O94Bgc7-b7nYL_2PZQ__21994.6433594034$1328568292$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-mm@kvack.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

This is a very very strange thing I have seen in Linux Kernel. I wrote
a simple program, all it does is to load a file into memory. This
programming is running on a virtual machine while linux-kvm is working
as the hypervisor. I enabled ksm in the hypervisor level, my host
machine was installed with a Opensuse11.4 while the guest OS is
Fedora14, the strange thing is, whenever I run following simple
program, the number exported by /sys/kernel/mm/ksm/page_sharing
increase dramatically, I mean, no matter what file I am loading, the
corresponding pages will always be merged.

Here is the simple program:

[root@fedora14 kernel]# cat testmkv.c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int ae_load_file_to_memory(const char *filename, char **result)
{
       int size = 0;
       int ret;
       FILE *f = fopen(filename, "rb");
       if (f == NULL)
       {
               *result = NULL;
               return -1; // -1 means file opening fail
       }
       fseek(f, 0, SEEK_END);
       size = ftell(f);
       fseek(f, 0, SEEK_SET);
       ret = posix_memalign(result,4096,size+1);
//        *result = (char *)malloc(size+1);
       if (size != fread(*result, sizeof(char), size, f))
       {
               free(*result);
               return -2; // -2 means file reading fail
       }
       fclose(f);
       (*result)[size] = 0;
       return size;
}

int main()
{
       char *content;
       int size,pages;
       int read;
       struct timeval tb,ta;
       double tv;
       size = ae_load_file_to_memory("test.mkv", &content);
       if (size < 0)
       {
               puts("Error loading file");
               return 1;
       }
       sleep(150);
       return 0;

}

Here is my observation, before I run the program:

jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14539
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14539
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
14540

After I run the program (during the the sleeping time period and after
the program exits.)

jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
25526
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
32368
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
35066
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
38010
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
40410
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
43012
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
45562
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
47866
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
50072
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
52314
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54010
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54486
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54655
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54969
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54969
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54969
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54968
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54968
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54968
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54968
jxiao@yosemite:~> cat /sys/kernel/mm/ksm/pages_sharing
54968

The increased number pretty equals to the pages of the applicaiton,
i.e. test.mkv (file size, 158M). I just cannot understand who will
share pages with test.mkv, test.mkv is a special application, it's
unique, moreover, I tried many other files/applications, I mean, I
replaced test.mkv with many other files, including some windows
specific files such *.exe files, but I still saw the same result. How
could that happen??

If you need more information, just let me know. Thank you.

Regards
