From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Sun, 21 Sep 2014 09:47:51 -0400
Message-ID: <541ED707.4050100@oracle.com>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<20140901063730.GB20186@redhat.com> <11860049.kd4R4PIiz4@k>
	<20140921080914.GA2489@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140921080914.GA2489@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Fritsch <sf@sfritsch.de>
Cc: kvm@vger.kernel.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, penberg@iki.fi
List-Id: virtualization@lists.linuxfoundation.org

On 09/21/2014 04:09 AM, Michael S. Tsirkin wrote:
>> The virtio 0.9.5 spec says that ISR is "unused" when in MSI-X mode. I 
>> > don't think that you can depend on the device to set the configuration 
>> > changed bit.
>> > The virtio 1.0 spec seems to have fixed that.
> Yes, virtio 0.9.5 has this bug. But in practice qemu always set this
> bit, so for qemu we could do that unconditionally.  Pekka's lkvm tool
> doesn't unfortunately.  It's easy to fix that, but it would be nicer to
> additionally probe for old versions of the tool, and disable IRQF_SHARED
> in that case.
>
> To complicate things, lkvm does not use a distinct subsystem vendor ID,
> in spite of the fact the virtio spec always required this explicitly.

I think I may be a bit confused here, but AFAIK we do set subsystem vendor
ID properly for our virtio-pci devices?

        vpci->pci_hdr = (struct pci_device_header) {
                .vendor_id              = cpu_to_le16(PCI_VENDOR_ID_REDHAT_QUMRANET),
                .device_id              = cpu_to_le16(device_id),
		[...]
                .subsys_vendor_id       = cpu_to_le16(PCI_SUBSYSTEM_VENDOR_ID_REDHAT_QUMRANET),


Thanks,
Sasha
