From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: [PATCH 09/14] xen/pvticketlock: Xen	
	implementation for PV ticket locks
Date: Wed, 17 Nov 2010 09:41:07 -0800
Message-ID: <4CE413B3.3010207__17385.375701315$1290015808$gmane$org@goop.org>
References: <cover.1289940821.git.jeremy.fitzhardinge@citrix.com><cover.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<aa32da076143b8e13c23c1f589d7e6cbedb22907.1289940821.git.jeremy.fitzhardinge@citrix.com>
	<4CE39C3C0200007800022AE2@vpn.id2.novell.com>
	<4CE397E7.2010107@goop.org> <4CE3A714.9010509@goop.org>
	<4CE3BDCF0200007800022BF1@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4CE3BDCF0200007800022BF1@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Eric Dumazet <dada1@cosmosbay.com>, Xen-devel <xen-devel@lists.xensource.com>, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, xiyou.wangcong@gmail.com, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/17/2010 02:34 AM, Jan Beulich wrote:
>> Actually, on second thoughts, maybe it doesn't matter so much.  The main
>> issue is making sure that the interrupt will make the VCPU drop out of
>> xen_poll_irq() - if it happens before xen_poll_irq(), it should leave
>> the event pending, which will cause the poll to return immediately.  I
>> hope.  Certainly disabling interrupts for some of the function will make
>> it easier to analyze with respect to interrupt nesting.
> That's not my main concern. Instead, what if you get interrupted
> anywhere here, the interrupt handler tries to acquire another
> spinlock and also has to go into the slow path? It'll overwrite part
> or all of the outer context's state.

That doesn't matter if the outer context doesn't end up blocking.  If it
has already blocked then it will unblock as a result of the interrupt;
if it hasn't yet blocked, then the inner context will leave the event
pending and cause it to not block.  Either way, it no longer uses or
needs that per-cpu state: it will return to the spin loop and (maybe)
get re-entered, setting it all up again.

I think there is a problem with the code as posted because it sets up
the percpu data before clearing the pending event, so it can end up
blocking with bad percpu data.

>> Another issue may be making sure the writes and reads of "w->want" and
>> "w->lock" are ordered properly to make sure that xen_unlock_kick() never
>> sees an inconsistent view of the (lock,want) tuple.  The risk being that
>> xen_unlock_kick() sees a random, spurious (lock,want) pairing and sends
>> the kick event to the wrong VCPU, leaving the deserving one hung.
> Yes, proper operation sequence (and barriers) is certainly
> required here. If you allowed nesting, this may even become
> simpler (as you'd have a single write making visible the new
> "head" pointer, after having written all relevant fields of the
> new "head" structure).

Yes, simple nesting should be quite straightforward (ie allowing an
interrupt handler to take some other lock than the one the outer context
is waiting on).

    J
