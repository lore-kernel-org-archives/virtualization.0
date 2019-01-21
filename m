From: "hch@infradead.org" <hch@infradead.org>
Subject: Re: [RFC] virtio_ring: check dma_mem for xen_domain
Date: Mon, 21 Jan 2019 00:28:30 -0800
Message-ID: <20190121082830.GC12420__23231.3358145349$1548059396$gmane$org@infradead.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190121050056.14325-1-peng.fan@nxp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "sstabellini@kernel.org" <sstabellini@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "hch@infradead.org" <hch@infradead.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 21, 2019 at 04:51:57AM +0000, Peng Fan wrote:
> on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> address as the dma mem buffer which is predefined.
> 
> Without this patch, the flow is:
> vring_map_one_sg -> vring_use_dma_api
>                  -> dma_map_page
> 		       -> __swiotlb_map_page
> 		                ->swiotlb_map_page
> 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> However we are using per device dma area for rpmsg, phys_to_virt
> could not return a correct virtual address for virtual address in
> vmalloc area. Then kernel panic.

And that is the right thing to do.  You must not call dma_map_* on
memory that was allocated from dma_alloc_*.

We actually have another thread which appears to be for this same issue.
