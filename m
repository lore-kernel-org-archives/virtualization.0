From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [virtio-dev] [RFC PATCH linux] iommu: Add virtio-iommu driver
Date: Fri, 16 Jun 2017 12:36:53 +0100
Message-ID: <c19161b2-b32f-4039-67a2-633ee57bcd07__12387.9136205234$1497612916$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192314.26720-1-jean-philippe.brucker@arm.com>
	<AM5PR0401MB25450471C7161CC6386FC8CE9AC10@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AM5PR0401MB25450471C7161CC6386FC8CE9AC10@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 16/06/17 09:48, Bharat Bhushan wrote:
> Hi Jean
>> +static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>> +		      phys_addr_t paddr, size_t size, int prot) {
>> +	int ret;
>> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
>> +	struct virtio_iommu_req_map req = {
>> +		.head.type	= VIRTIO_IOMMU_T_MAP,
>> +		.address_space	= cpu_to_le32(vdomain->id),
>> +		.virt_addr	= cpu_to_le64(iova),
>> +		.phys_addr	= cpu_to_le64(paddr),
>> +		.size		= cpu_to_le64(size),
>> +	};
>> +
>> +	pr_debug("map %llu 0x%lx -> 0x%llx (%zu)\n", vdomain->id, iova,
>> +		 paddr, size);
> 
> A query, when I am tracing above prints I see same physical address is mapped with two different virtual address, do you know why kernel does this?

That really depends which driver is calling into viommu. iommu_map is
called from the DMA API, which can be used by any device drivers. Within
an address space, multiple IOVAs pointing to the same PA isn't forbidden.

For example, looking at MAP requests for a virtio-net device, I get the
following trace:

ioas[1] map   0xfffffff3000 -> 0x8faa0000 (4096)
ioas[1] map   0xfffffff2000 -> 0x8faa0000 (4096)
ioas[1] map   0xfffffff1000 -> 0x8faa0000 (4096)
ioas[1] map   0xfffffff0000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffef000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffee000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffed000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffec000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffeb000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffea000 -> 0x8faa0000 (4096)
ioas[1] map   0xffffffe8000 -> 0x8faa0000 (8192)
...

During initialization, the virtio-net driver primes the rx queue with
receive buffers, that the host will then fill with network packets. It
calls virtqueue_add_inbuf_ctx to create descriptors on the rx virtqueue
for each buffer. Each buffer is 0x180 bytes here, so one 4k page can
contain around 10 (actually 11, with the last one crossing page boundary).

I guess the call trace goes like this:
 virtnet_open
 try_fill_recv
 add_recvbuf_mergeable
 virtqueue_add_inbuf_ctx
 vring_map_one_sg
 dma_map_page
 __iommu_dma_map

But the IOMMU cannot map fragments of pages, since the granule is 0x1000.
Therefore when virtqueue_add_inbuf_ctx maps the buffer, __iommu_dma_map
aligns address and size on full pages. Someone motivated could probably
optimize this by caching mapped pages and reusing IOVAs, but currently
that's how it goes.

Thanks,
Jean
