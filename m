From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Sun, 13 May 2012 23:29:28 +0530
Message-ID: <4FAFF680.6030307__32176.1413863443$1336932036$gmane$org@linux.vnet.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com> <4FA7BABA.4040700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FA7BABA.4040700@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/07/2012 05:36 PM, Avi Kivity wrote:
> On 05/07/2012 01:58 PM, Raghavendra K T wrote:
>> On 05/07/2012 02:02 PM, Avi Kivity wrote:
>>> On 05/07/2012 11:29 AM, Ingo Molnar wrote:
>> (Less is better. Below is time elapsed in sec for x86_64_defconfig
>> (3+3 runs)).
>>
>>           BASE                    BASE+patch            %improvement
>>           mean (sd)               mean (sd)
>> case 1x:     66.0566 (74.0304)      61.3233 (68.8299)     7.16552
>> case 2x:     1253.2 (1795.74)      131.606 (137.358)     89.4984
>> case 3x:     3431.04 (5297.26)      134.964 (149.861)     96.0664
>>
>
> You're calculating the improvement incorrectly.  In the last case, it's
> not 96%, rather it's 2400% (25x).  Similarly the second case is about
> 900% faster.
>

speedup calculation is clear.

I think confusion for me was more because of the types of benchmarks.

I always did

|(patch - base)| * 100 / base


So,  for
(1) lesser is better sort of benchmarks,
improvement calculation would be like

|(patched -  base)| * 100/ patched
e.g for kernbench,

suppose base    = 150 sec
         patched = 100 sec
improvement = 50 % ( = 33% degradation of base)


(2) for higher is better sort of benchmarks improvement calculation 
would be like

|(patched - base)| * 100 / base

for e.g say for pgbench/ ebizzy...

     base = 100 tps (transactions per sec)
     patched = 150 tps

  improvement  = 50 % of pathched kernel ( OR 33 % degradation of base )


Is this is what generally done? just wanted to be on same page before 
publishing benchmark results, other than kernbench.
