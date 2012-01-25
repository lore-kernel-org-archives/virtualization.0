From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V4 0/5] kvm : Paravirt-spinlock support for KVM guests
Date: Wed, 25 Jan 2012 14:25:12 +0530
Message-ID: <4F1FC370.5020506@linux.vnet.ibm.com>
References: <20120114182501.8604.68416.sendpatchset@oc5400248562.ibm.com>
	<3EC1B881-0724-49E3-B892-F40BEB07D15D@suse.de>
	<20120116142014.GA10155@linux.vnet.ibm.com>
	<B6E21B69-17D1-48E0-AFD4-B52075094005@suse.de>
	<4F146EA5.3010106@linux.vnet.ibm.com>
	<E9F33AFD-F051-4D68-84FF-D259FD6AD19D@suse.de>
	<4F15AF9E.9000907@linux.vnet.ibm.com>
	<1485A122-9D48-46E3-A01E-E37B5C9EC54A@suse.de>
	<4F15BFAE.7060500@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030109060407080508000302"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F15BFAE.7060500@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen <xen-devel@lists.xensource.com>, Dave Jiang <dave.jiang@intel.com>, KVM <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Sasha Levin <levinsasha928@gmail.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linu>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------030109060407080508000302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/18/2012 12:06 AM, Raghavendra K T wrote:
> On 01/17/2012 11:09 PM, Alexander Graf wrote:
[...]
>>>>> A. pre-3.2.0 with CONFIG_PARAVIRT_SPINLOCKS = n
>>>>> B. pre-3.2.0 + Jeremy's above patches with
>>>>> CONFIG_PARAVIRT_SPINLOCKS = n
>>>>> C. pre-3.2.0 + Jeremy's above patches with
>>>>> CONFIG_PARAVIRT_SPINLOCKS = y
>>>>> D. pre-3.2.0 + Jeremy's above patches + V5 patches with
>>>>> CONFIG_PARAVIRT_SPINLOCKS = n
>>>>> E. pre-3.2.0 + Jeremy's above patches + V5 patches with
>>>>> CONFIG_PARAVIRT_SPINLOCKS = y
[...]
>> Maybe it'd be a good idea to create a small in-kernel microbenchmark
>> with a couple threads that take spinlocks, then do work for a
>> specified number of cycles, then release them again and start anew. At
>> the end of it, we can check how long the whole thing took for n runs.
>> That would enable us to measure the worst case scenario.
>>
>
> It was a quick test. two iteration of kernbench (=6runs) and had ensured
> cache is cleared.
>
> echo "1" > /proc/sys/vm/drop_caches
> ccache -C. Yes may be I can run test as you mentioned..
>

Sorry for late reply. Was trying to do more performance analysis.
Measured the worst case scenario with a spinlock stress driver
[ attached below ]. I think S1 (below) is what you were
looking for:

2 types of scenarios:
S1.
lock()
increment counter.
unlock()

S2:
do_somework()
lock()
do_conditional_work() /* this is to give variable spinlock hold time */
unlock()

Setup:
Machine : IBM xSeries with Intel(R) Xeon(R) x5570 2.93GHz CPU with 8
core , 64GB RAM, 16 online cpus.
The below results are taken across total 18 Runs of
insmod spinlock_thread.ko nr_spinlock_threads=4 loop_count=4000000

Results:
scenario S1: plain counter
==========================
     total Mega cycles taken for completion (std)
A.  12343.833333      (1254.664021)
B.  12817.111111      (917.791606)
C.  13426.555556      (844.882978)

%improvement w.r.t BASE     -8.77

scenario S2: counter with variable work inside lock + do_work_outside_lock
=========================================================================
A.   25077.888889      (1349.471703)
B.   24906.777778      (1447.853874)
C.   21287.000000      (2731.643644)

%improvement w.r.t BASE      15.12

So it seems we have worst case overhead of around 8%. But we see 
improvement of at-least 15% once when little more time is spent in
critical section.

>>>
>>> Guest Run
>>> ============
>>> case A case B %improvement case C %improvement
>>> 166.999 (15.7613) 161.876 (14.4874) 3.06768 161.24 (12.6497) 3.44852
>>
>> Is this the same machine? Why is the guest 3x slower?
> Yes non - ple machine but with all 16 cpus online. 3x slower you meant
> case A is slower (pre-3.2.0 with CONFIG_PARAVIRT_SPINLOCKS = n) ?

Got your point, There were multiple reasons. guest was 32 bit, and had
only 8vcpu  and the current RAM was only 1GB (max 4GB) when I increased
it to 4GB it came around just 127 second.

There is a happy news:
I created a new 64 bit guest and ran with 16GB RAM and 16VCPU.
Kernbench in The pv spinlock (case E)  took just around 42sec (against
57 sec of host), an improvement of around 26% against host.
So its much faster rather than 3x slower.

--------------030109060407080508000302
Content-Type: text/x-csrc;
 name="spinlock_thread.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="spinlock_thread.c"

/*
 * spinlock_thread.c 
 *
 * Author: Raghavendra K T
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/kobject.h>
#include <linux/sysfs.h>
#include <asm/uaccess.h>
#include <linux/slab.h>
#include <linux/string.h>
#include <linux/sched.h>
#include <linux/kthread.h>
#include <asm/msr.h>

unsigned int start, end, diff;

static struct task_struct **spintask_pid;
static DECLARE_COMPLETION(spintask_exited);

static int total_thread_exit = 0;
static DEFINE_SPINLOCK(counter_spinlock);

#define DEFAULT_NR_THREADS 4
#define DEFAULT_LOOP_COUNT 4000000L

static int nr_spinlock_threads = DEFAULT_NR_THREADS;
static long loop_count = DEFAULT_LOOP_COUNT;

module_param(nr_spinlock_threads, int, S_IRUGO);
module_param(loop_count, long, S_IRUGO);

static long count = 0;
static int a[2][2] = {{2, 5}, {3, 7}};
static int b[2][2] = {{1, 19}, {11, 13}};
static int m[2][2];
static int n[2][2];
static int res[2][2];

static inline void matrix_initialize(int id)
{
	int i, j;
	for (i=0; i<2; i++)
		for(j=0; j<2; j++) {
			m[i][j] = (id + 1) * a[i][j];
			n[i][j] = (id + 1) * b[i][j];
		}
}

static inline void matrix_mult(void)
{
	int i, j, k;
	for (i=0; i<2; i++)
		for (j=0; j<2; j++) {
			res[i][j] = 0;
			for(k=0; k<2; k++) 
				res[i][j] += m[i][k] * n[k][j];
		} 
}

static int input_check_thread(void* arg)
{
	int id = (int)arg;
	long i = loop_count;
	allow_signal(SIGKILL);
#if 0
	matrix_initialize(id);
	matrix_mult();	
#endif
	do {

		spin_lock(&counter_spinlock);
		count++;
#if 0
		if (id%3) 
			matrix_initialize(id);
		else if (id%3 + 1)
			matrix_mult();	
#endif
		spin_unlock(&counter_spinlock);
	} while(i--); 

	spin_lock(&counter_spinlock);
	total_thread_exit++;
	spin_unlock(&counter_spinlock);
	if(total_thread_exit == nr_spinlock_threads) {
		rdtscl(end);
		diff = end - start;
		complete_and_exit(&spintask_exited, 0);
	}

	return 0;
}

static int spinlock_init_module(void)
{
	int i;
	char name[20];
	printk(KERN_INFO "insmod nr_spinlock_threads = %d\n", nr_spinlock_threads);
	spintask_pid = kzalloc(sizeof(struct task_struct *)* nr_spinlock_threads, GFP_KERNEL);
	rdtscl(start);
	for (i=0; i<nr_spinlock_threads; i++)
	{
		sprintf(name, "spintask%d", i);
		spintask_pid[i] = kthread_run(input_check_thread,(void *)i, name);
	}

	return 0;
}

static void spinlock_cleanup_module(void)
{
	wait_for_completion(&spintask_exited);
	kfree(spintask_pid);
	printk(KERN_INFO "rmmod count = %ld time elaspsed=%u\n", count, diff);
}

module_init(spinlock_init_module);
module_exit(spinlock_cleanup_module);

MODULE_PARM_DESC(loopcount, "How many iterations counter should be incremented");
MODULE_PARM_DESC(nr_spinlock_threads, "How many kernel threads to be spawned");
MODULE_AUTHOR("Raghavendra K T");
MODULE_DESCRIPTION("spinlock stress driver");
MODULE_LICENSE("GPL");

--------------030109060407080508000302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------030109060407080508000302--
