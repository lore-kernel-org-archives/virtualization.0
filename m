From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Mon, 07 May 2012 20:17:10 +0530
Message-ID: <4FA7E06E.20304@linux.vnet.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com> <4FA7BABA.4040700@redhat.com>
	<4FA7CC05.50808@linux.vnet.ibm.com> <4FA7CCA2.4030408@redhat.com>
	<4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA7D3F7.9080005@linux.vnet.ibm.com>
	<4FA7D50D.1020209@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FA7D50D.1020209@redhat.com>
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

On 05/07/2012 07:28 PM, Avi Kivity wrote:
> On 05/07/2012 04:53 PM, Raghavendra K T wrote:
>>> Is the improvement so low, because PLE is interfering with the patch, or
>>> because PLE already does a good job?
>>>
>>
>>
>> It is because PLE already does a good job (of not burning cpu). The
>> 1-3% improvement is because, patchset knows atleast who is next to hold
>> lock, which is lacking in PLE.
>>
>
> Not good.  Solving a problem in software that is already solved by
> hardware?  It's okay if there are no costs involved, but here we're
> introducing a new ABI that we'll have to maintain for a long time.
>

Hmm agree that being a step ahead of mighty hardware (and just an
improvement of 1-3%) is no good for long term (where PLE is future).

Having said that, it is hard for me to resist saying :
  bottleneck is somewhere else on PLE m/c and IMHO answer would be
combination of paravirt-spinlock + pv-flush-tb.

But I need to come up with good number to argue in favour of the claim.

PS: Nikunj had experimented that pv-flush tlb + paravirt-spinlock is a 
win on PLE where only one of them alone could not prove the benefit.
