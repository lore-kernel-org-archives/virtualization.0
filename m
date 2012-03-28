From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V6 0/11] Paravirtualized ticketlocks
Date: Wed, 28 Mar 2012 23:51:01 +0530
Message-ID: <4F73568D.7000703@linux.vnet.ibm.com>
References: <20120321102041.473.61069.sendpatchset@codeblue.in.ibm.com>
	<4F707C5F.1000905@redhat.com>	<4F716E31.3000803@linux.vnet.ibm.com>
	<CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMy5W3foop40+R1RLv_JPhnO5ZmV90uMmNERYY-e3QCeaJfqLw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alan Meadows <alan.meadows@gmail.com>, Avi Kivity <avi@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, Attilio Rao <attilio.rao@citrix.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/28/2012 09:39 PM, Alan Meadows wrote:
> I am happy to see this issue receiving some attention and second the
> wish to see these patches be considered for further review and inclusion
> in an upcoming release.
>
> Overcommit is not as common in enterprise and single-tenant virtualized
> environments as it is in multi-tenant environments, and frankly we have
> been suffering.
>
> We have been running an early copy of these patches in our lab and in a
> small production node sample set both on3.2.0-rc4 and 3.3.0-rc6 for over
> two weeks now with great success. With the heavy level of vCPU:pCPU
> overcommit required for our situation, the patches are increasing
> performance by an _order of magnitude_ on our E5645 and E5620 systems.
>

Thanks Alan for the support. I feel timing of this patch was little bad
though. (merge window)

>
>
>         Looks like a good baseline on which to build the KVM
>         implementation.  We
>         might need some handshake to prevent interference on the host
>         side with
>         the PLE code.
>

I think I still missed some point in Avi's comment. I agree that PLE
may be interfering with above patches (resulting in less performance
advantages). but we have not seen performance degradation with the
patches in earlier benchmarks. [ theoretically since patch has very
slight advantage over PLE that atleast it knows who should run next ].

So TODO in my list on this is:
1. More analysis of performance on PLE mc.
2. Seeing how to implement handshake to increase performance (if PLE +
patch combination have slight negative effect).

Sorry that, I could not do more analysis on PLE (as promised last time)
because of machine availability.

I 'll do some work on this and comeback. But in the meantime, I do not
see it as blocking for next merge window.

>
>     Avi, Thanks for reviewing. True, it is sort of equivalent to PLE on
>     non PLE machine.
>
>     Ingo, Peter,
>     Can you please let us know if this series can be considered for next
>     merge window?
>     OR do you still have some concerns that needs addressing.
>
>     I shall rebase patches to 3.3 and resend. (main difference would be
>     UNINLINE_SPIN_UNLOCK and jump label changes to use
>     static_key_true/false() usage instead of static_branch.)
