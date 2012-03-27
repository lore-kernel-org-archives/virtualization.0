From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Tue, 27 Mar 2012 13:07:21 +0530
Message-ID: <4F716E31.3000803__24302.4262752899$1332833910$gmane$org@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4F707C5F.1000905@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/26/2012 07:55 PM, Avi Kivity wrote:
> On 03/21/2012 12:20 PM, Raghavendra K T wrote:
>> From: Jeremy Fitzhardinge<jeremy.fitzhardinge@citrix.com>
[...]
>>
>> This series provides a Xen implementation, but it should be
>> straightforward to add a KVM implementation as well.
>>
>
> Looks like a good baseline on which to build the KVM implementation.  We
> might need some handshake to prevent interference on the host side with
> the PLE code.
>

Avi, Thanks for reviewing. True, it is sort of equivalent to PLE on non 
PLE machine.

Ingo, Peter,
Can you please let us know if this series can be considered for next 
merge window?
OR do you still have some concerns that needs addressing.

I shall rebase patches to 3.3 and resend. (main difference would be 
UNINLINE_SPIN_UNLOCK and jump label changes to use 
static_key_true/false() usage instead of static_branch.)

Thanks,
Raghu
