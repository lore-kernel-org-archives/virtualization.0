From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Wed, 17 Apr 2019 18:42:44 -0300
Message-ID: <878sw871gr.fsf@morokweng.localdomain>
References: <87zhrj8kcp.fsf@morokweng.localdomain>
	<87womn8inf.fsf@morokweng.localdomain>
	<20190129134750-mutt-send-email-mst@kernel.org>
	<877eefxvyb.fsf@morokweng.localdomain>
	<20190204144048-mutt-send-email-mst@kernel.org>
	<87ef71seve.fsf@morokweng.localdomain>
	<20190320171027-mutt-send-email-mst@kernel.org>
	<87tvfvbwpb.fsf@morokweng.localdomain>
	<20190323165456-mutt-send-email-mst@kernel.org>
	<20190325005710.GC29295@umbus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <20190325005710.GC29295@umbus>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Mike Anderson <andmike@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Paul Mackerras <paulus@ozlabs.org>, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org


David Gibson <david@gibson.dropbear.id.au> writes:

> On Sat, Mar 23, 2019 at 05:01:35PM -0400, Michael S. Tsirkin wrote:
>> On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
>> > Michael S. Tsirkin <mst@redhat.com> writes:
> [snip]
>> > >> > Is there any justification to doing that beyond someone putting
>> > >> > out slow code in the past?
>> > >>
>> > >> The definition of the ACCESS_PLATFORM flag is generic and captures the
>> > >> notion of memory access restrictions for the device. Unfortunately, on
>> > >> powerpc pSeries guests it also implies that the IOMMU is turned on
>> > >
>> > > IIUC that's really because on pSeries IOMMU is *always* turned on.
>> > > Platform has no way to say what you want it to say
>> > > which is bypass the iommu for the specific device.
>> >
>> > Yes, that's correct. pSeries guests running on KVM are in a gray area
>> > where theoretically they use an IOMMU but in practice KVM ignores it.
>> > It's unfortunate but it's the reality on the ground today. :-/
>
> Um.. I'm not sure what you mean by this.  As far as I'm concerned
> there is always a guest-visible (paravirtualized) IOMMU, and that will
> be backed onto the host IOMMU when necessary.

There is, but vhost will ignore it and directly map the guest memory
when ACCESS_PLATFORM (the flag previously known as IOMMU_PLATFORM) isn't
set. From QEMU's hw/virtio/vhost.c:

static int vhost_dev_has_iommu(struct vhost_dev *dev)
{
    VirtIODevice *vdev = dev->vdev;

    return virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
}

static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
                              hwaddr *plen, int is_write)
{
    if (!vhost_dev_has_iommu(dev)) {
        return cpu_physical_memory_map(addr, plen, is_write);
    } else {
        return (void *)(uintptr_t)addr;
    }
}

--
Thiago Jung Bauermann
IBM Linux Technology Center
