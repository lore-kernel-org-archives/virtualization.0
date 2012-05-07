From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Mon, 07 May 2012 15:06:18 +0300
Message-ID: <4FA7BABA.4040700@redhat.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FA7AAD8.6050003@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/07/2012 01:58 PM, Raghavendra K T wrote:
> On 05/07/2012 02:02 PM, Avi Kivity wrote:
>> On 05/07/2012 11:29 AM, Ingo Molnar wrote:
>>> This is looking pretty good and complete now - any objections
>>> from anyone to trying this out in a separate x86 topic tree?
>>
>> No objections, instead an
>>
>> Acked-by: Avi Kivity<avi@redhat.com>
>>
>
> Thank you.
>
> Here is a benchmark result with the patches.
>
> 3 guests with 8VCPU, 8GB RAM, 1 used for kernbench
> (kernbench -f -H -M -o 20) other for cpuhog (shell script while
> true with an instruction)
>
> unpinned scenario
> 1x: no hogs
> 2x: 8hogs in one guest
> 3x: 8hogs each in two guest
>
> BASE: 3.4-rc4 vanilla with CONFIG_PARAVIRT_SPINLOCK=n
> BASE+patch: 3.4-rc4 + debugfs + pv patches with
> CONFIG_PARAVIRT_SPINLOCK=y
>
> Machine : IBM xSeries with Intel(R) Xeon(R) x5570 2.93GHz CPU (Non
> PLE) with 8 core , 64GB RAM
>
> (Less is better. Below is time elapsed in sec for x86_64_defconfig
> (3+3 runs)).
>
>          BASE                    BASE+patch            %improvement
>          mean (sd)               mean (sd)
> case 1x:     66.0566 (74.0304)      61.3233 (68.8299)     7.16552
> case 2x:     1253.2 (1795.74)      131.606 (137.358)     89.4984
> case 3x:     3431.04 (5297.26)      134.964 (149.861)     96.0664
>

You're calculating the improvement incorrectly.  In the last case, it's
not 96%, rather it's 2400% (25x).  Similarly the second case is about
900% faster.

-- 
error compiling committee.c: too many arguments to function
