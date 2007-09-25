From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 2/3] virtio ring implementation
Date: Wed, 26 Sep 2007 09:37:55 +1000
Message-ID: <1190763475.2227.20.camel__16789.8591411815$1190763772$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
	<1190625256.27805.201.camel@localhost.localdomain>
	<1190625307.27805.203.camel@localhost.localdomain>
	<46F7BF41.9060705@qumranet.com>
	<1190727156.27805.332.camel@localhost.localdomain>
	<46F94243.2000602@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F94243.2000602@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-09-25 at 19:15 +0200, Dor Laor wrote:
> At the moment it's not good enough, there is a potential race were the
> guest optimistically turn off
> the VRING_AVAIL_F_NO_INTERRUPT in the vring_restart and afterwards
> finds there are more_used so
> it consume them in the poll function. 
> If in the middle, packets arrive the host will see the flag is off and
> send irq.
> In that case the above irq handler will report IRQ_NONE.

Good point.  On the one hand, reporting IRQ_NONE occasionally is not
fatal.  On the other, it'd be nice to get this right.

> It's also not trivial to cancel the optimistic approach in the restart
> function since then there might be another race
> that will result in missing irq reaching the guest.

I did it optimistically because otherwise we need two barriers (and
still have a window).

> I'll try to think of something better than a hypercall for switching
> irq on/off.

Erk.  That would be v. bad...

Thanks,
Rusty.
