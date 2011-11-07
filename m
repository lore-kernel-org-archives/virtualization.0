From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio-pci new configuration proposal
Date: Tue, 08 Nov 2011 10:23:33 +1030
Message-ID: <87aa87sd4y.fsf@rustcorp.com.au>
References: <20111104114033.GA21308@redhat.com> <1320409939.3334.6.camel@lappy>
	<20111104135113.GA24452@redhat.com>
	<1320414804.3334.13.camel@lappy>
	<20111104142338.GB24452@redhat.com>
	<1320418385.3334.25.camel@lappy> <20111106073007.GA7146@redhat.com>
	<1320611097.3299.10.camel@lappy>
	<20111106213849.GA14292@redhat.com>
	<871utktsuw.fsf@rustcorp.com.au>
	<20111107211413.GA11577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111107211413.GA11577@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, virtualization <virtualization@lists.linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, kvm <kvm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 7 Nov 2011 23:14:14 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Nov 07, 2011 at 03:46:23PM +1030, Rusty Russell wrote:
> > So far, the only three things make sense to have in a capability list:
> > MSI-X, the upper 32 feature bits, and the per-device config.
> 
> You mean the queue # to MSI-X vector mapping?

Yep.

> One thing to remember is that it must be in the same type of BAR as
> the queue selection, since by PCI rules MMIO writes aren't I think
> ordered with PIO writes (it doesn't matter with KVM but might
> with another hypervisor).

OK, I'm slowly getting up to speed.

Next dumb q: Sasha, why did you introduce the idea of a separate
virtio-pci capability list, rather than just using PCI capabilities
directly?  ie. instead of VIRTIO_PCI_C_LAYOUT, have VIRTIO_PCI_CORE,
VIRTIO_PCI_MSIX, VIRTIO_PCI_DEV_SPECIFIC?

Is it because we really want this stuff outside the PCI configuration
space?  Even so, should we just use the PCI cap list, and have each
cap entry just contain a BIR & offset?

Thanks,
Rusty.
