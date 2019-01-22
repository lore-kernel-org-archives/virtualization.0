From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio_ring: check dma_mem for xen_domain
Date: Mon, 21 Jan 2019 21:36:39 -0500
Message-ID: <20190121213617-mutt-send-email-mst__31228.2702697971$1548124715$gmane$org@kernel.org>
References: <20190121050056.14325-1-peng.fan@nxp.com>
	<20190121082830.GC12420@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190121082830.GC12420@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "hch@infradead.org" <hch@infradead.org>
Cc: Peng Fan <peng.fan@nxp.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 21, 2019 at 12:28:30AM -0800, hch@infradead.org wrote:
> On Mon, Jan 21, 2019 at 04:51:57AM +0000, Peng Fan wrote:
> > on i.MX8QM, M4_1 is communicating with DomU using rpmsg with a fixed
> > address as the dma mem buffer which is predefined.
> > 
> > Without this patch, the flow is:
> > vring_map_one_sg -> vring_use_dma_api
> >                  -> dma_map_page
> > 		       -> __swiotlb_map_page
> > 		                ->swiotlb_map_page
> > 				->__dma_map_area(phys_to_virt(dma_to_phys(dev, dev_addr)), size, dir);
> > However we are using per device dma area for rpmsg, phys_to_virt
> > could not return a correct virtual address for virtual address in
> > vmalloc area. Then kernel panic.
> 
> And that is the right thing to do.  You must not call dma_map_* on
> memory that was allocated from dma_alloc_*.
> 
> We actually have another thread which appears to be for this same issue.

Sorry, which thread do you refer to?

-- 
MST
