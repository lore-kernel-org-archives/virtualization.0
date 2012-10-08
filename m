From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] Using PCI config space to indicate config location
Date: Mon, 08 Oct 2012 16:58:28 +0200
Message-ID: <5072EA14.30809@redhat.com>
References: <87zk4c2tqq.fsf@rustcorp.com.au> <874nmajcmj.fsf@codemonkey.ws>
	<87y5jhpuu2.fsf@rustcorp.com.au> <87bogddq0l.fsf@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87bogddq0l.fsf@codemonkey.ws>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

  Hi,

> But I think we could solve this in a different way.  I think we could
> just move the virtio configuration space to BAR1 by using a transport
> feature bit.

Why hard-code stuff?

I think it makes alot of sense to have a capability simliar to msi-x
which simply specifies bar and offset of the register sets:

[root@fedora ~]# lspci -vvs4
00:04.0 SCSI storage controller: Red Hat, Inc Virtio block device
        [ ... ]
	Region 0: I/O ports at c000 [size=64]
	Region 1: Memory at fc029000 (32-bit) [size=4K]
	Capabilities: [40] MSI-X: Enable+ Count=2 Masked-
		Vector table: BAR=1 offset=00000000
		PBA: BAR=1 offset=00000800

So we could have for virtio something like this:

        Capabilities: [??] virtio-regs:
                legacy: BAR=0 offset=0
                virtio-pci: BAR=1 offset=1000
                virtio-cfg: BAR=1 offset=1800

> That then frees up the entire BAR0 for use as virtio-pci registers.  We
> can then always include the virtio-pci MSI-X register space and
> introduce all new virtio-pci registers as simply being appended.

BAR0 needs to stay as-is for compatibility reasons.  New devices which
don't have to care about old guests don't need to provide a 'legacy'
register region.

Most devices have mmio at BAR1 for msi-x support anyway, we can place
the virtio-pci and virtio configuration registers there too by default.
 I wouldn't hardcode that though.

> This new feature bit then becomes essentially a virtio configuration
> latch.  When unacked, virtio configuration hides new registers, when
> acked, those new registers are exposed.

I'd just expose them all all the time.

>> 2) ISTR an argument about mapping the ISR register separately, for
>>    performance, but I can't find a reference to it.
> 
> I think the rationale is that ISR really needs to be PIO but everything
> else doesn't.  PIO is much faster on x86 because it doesn't require
> walking page tables or instruction emulation to handle the exit.

Is this still a pressing issue?  With MSI-X enabled ISR isn't needed,
correct?  Which would imply that pretty much only old guests without
MSI-X support need this, and we don't need to worry that much when
designing something new ...

cheers,
  Gerd
