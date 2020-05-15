From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 25/38] drm: virtio: fix common struct sg_table related
 issues
Date: Fri, 15 May 2020 12:12:24 +0200
Message-ID: <20200515101224.vrr6rlzgwc6d35az@sirius.home.kraxel.org>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133314eucas1p2f04e32d65e71c613a2a9aacb29064a7d@eucas1p2.samsung.com>
 <20200513133245.6408-25-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200513133245.6408-25-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, May 13, 2020 at 03:32:32PM +0200, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
> 
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
> 
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.

Looks all sane.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd
