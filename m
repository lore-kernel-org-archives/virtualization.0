From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V8 0/17] Paravirtualized ticket spinlocks
Date: Tue, 08 May 2012 06:43:31 +0530
Message-ID: <4FA8733B.70402__33810.5202223689$1336439677$gmane$org@linux.vnet.ibm.com>
References: <20120502100610.13206.40.sendpatchset@codeblue.in.ibm.com>
	<20120507082928.GI16608@gmail.com> <4FA7888F.80505@redhat.com>
	<4FA7AAD8.6050003@linux.vnet.ibm.com> <4FA7BABA.4040700@redhat.com>
	<4FA7CC05.50808@linux.vnet.ibm.com> <4FA7CCA2.4030408@redhat.com>
	<4FA7D06B.60005@linux.vnet.ibm.com>
	<20120507134611.GB5533@linux.vnet.ibm.com>
	<4FA7D2E5.1020607@redhat.com> <4FA8579C.3000205@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4FA8579C.3000205@goop.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Avi Kivity <avi@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, KVM <kvm@vger.kernel.org>, linux-doc@vger.kernel.org, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Xen Devel <xen-devel@lists.xensource.com>, X86 <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Virtualization <virtualization@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Attilio Rao <attilio.rao@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/08/2012 04:45 AM, Jeremy Fitzhardinge wrote:
> On 05/07/2012 06:49 AM, Avi Kivity wrote:
>> On 05/07/2012 04:46 PM, Srivatsa Vaddagiri wrote:
>>> * Raghavendra K T<raghavendra.kt@linux.vnet.ibm.com>  [2012-05-07 19:08:51]:
>>>
>>>> I 'll get hold of a PLE mc  and come up with the numbers soon. but I
>>>> 'll expect the improvement around 1-3% as it was in last version.
>>> Deferring preemption (when vcpu is holding lock) may give us better than 1-3%
>>> results on PLE hardware. Something worth trying IMHO.
>> Is the improvement so low, because PLE is interfering with the patch, or
>> because PLE already does a good job?
>
> How does PLE help with ticket scheduling on unlock?  I thought it would
> just help with the actual spin loops.

Hmm. This strikes something to me. I think I should replace while 1 hog
in with some *real job*  to measure over-commit case. I hope to see
greater improvements because of fairness and scheduling of the
patch-set.

May be all the way I was measuring something equal to 1x case.
