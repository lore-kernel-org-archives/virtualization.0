From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Sun, 21 Sep 2014 18:02:59 +0300
Message-ID: <20140921150259.GA27059@redhat.com>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<20140901063730.GB20186@redhat.com> <11860049.kd4R4PIiz4@k>
	<20140921080914.GA2489@redhat.com> <541ED707.4050100@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <541ED707.4050100@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <sasha.levin@oracle.com>
Cc: kvm@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, Stefan Fritsch <sf@sfritsch.de>, penberg@iki.fi
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Sep 21, 2014 at 09:47:51AM -0400, Sasha Levin wrote:
> On 09/21/2014 04:09 AM, Michael S. Tsirkin wrote:
> >> The virtio 0.9.5 spec says that ISR is "unused" when in MSI-X mode. I 
> >> > don't think that you can depend on the device to set the configuration 
> >> > changed bit.
> >> > The virtio 1.0 spec seems to have fixed that.
> > Yes, virtio 0.9.5 has this bug. But in practice qemu always set this
> > bit, so for qemu we could do that unconditionally.  Pekka's lkvm tool
> > doesn't unfortunately.  It's easy to fix that, but it would be nicer to
> > additionally probe for old versions of the tool, and disable IRQF_SHARED
> > in that case.
> >
> > To complicate things, lkvm does not use a distinct subsystem vendor ID,
> > in spite of the fact the virtio spec always required this explicitly.
> 
> I think I may be a bit confused here, but AFAIK we do set subsystem vendor
> ID properly for our virtio-pci devices?
> 
>         vpci->pci_hdr = (struct pci_device_header) {
>                 .vendor_id              = cpu_to_le16(PCI_VENDOR_ID_REDHAT_QUMRANET),
>                 .device_id              = cpu_to_le16(device_id),
> 		[...]
>                 .subsys_vendor_id       = cpu_to_le16(PCI_SUBSYSTEM_VENDOR_ID_REDHAT_QUMRANET),
> 
> 
> Thanks,
> Sasha


Yes but the spec says:
	The Subsystem Vendor ID should reflect the PCI Vendor ID of the environment.

IOW lkvm shouldn't reuse the ID from qemu, it should have its own
(qemu and lkvm hypervisors being a different environment).

virtio 1.0 have weakened this requirement:
	The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
	reflect the PCI Vendor and Device
	ID of the environment (for informational purposes by the driver).

I reasoned that since it's for informational purposes only, there's no
reason to make it a SHOULD.

It might or might not be a good idea to change it back, worth
considering.


-- 
MST
