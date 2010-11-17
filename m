From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [PATCH 13/14] x86/ticketlock: add slowpath logic
Date: Wed, 17 Nov 2010 07:25:33 -0800
Message-ID: <4CE3F3ED.2060501__41840.5784447261$1290007668$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com>	<97ed99ae9160bdb6477284b333bd6708fb7a19cb.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<1289996503.2109.728.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289996503.2109.728.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jan Beulich <JBeulich@novell.com>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, =?UTF-8?B?QW3DqXJpY28gV2FuZw==?= <xiyou.wangcong@gmail.com>, Eric Dumazet <dada1@cosmosbay.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 04:21 AM, Peter Zijlstra wrote:
> On Tue, 2010-11-16 at 13:08 -0800, Jeremy Fitzhardinge wrote:
>> Maintain a flag in both LSBs of the ticket lock which indicates whether
>> anyone is in the lock slowpath and may need kicking when the current
>> holder unlocks.  The flags are set when the first locker enters
>> the slowpath, and cleared when unlocking to an empty queue.
> So here you say you set both LSBs in order to keep head == tail working,
> but the code seems to suggest you only use the tail LSB.
>
> I think I see why using only one LSB is sufficient, but some consistency
> would be nice :-)

I tried that initially, but it turned out more messy.  The problem is
that the flag can change while you're spinning on the lock, so you need
to mask it out every time you read tail before you can compare it to
head; if head has the flag set too, you just need to mask it out of
there as well:

	ticket = xadd(lock, 2 << TICKET_SHIFT);
	ticket.tail &= ~TICKET_SLOW_FLAGS;

	while (ticket.head != ticket.tail) {
		relax();
		ticket.head = lock->head /* & ~TICKET_SLOW_FLAGS */;
	}

IOW setting both doesn't help anything, and just requires an extra mask
in the spin loop (and anywhere else that uses 'head').

And hey, extra bit.  Bound to be useful for something.

    J
