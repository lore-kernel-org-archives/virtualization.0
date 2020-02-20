From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Date: Thu, 20 Feb 2020 17:11:46 +0100
Message-ID: <20200220161146.GA12709@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-2-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200220160606.53156-2-pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 20, 2020 at 05:06:05PM +0100, Halil Pasic wrote:
> Currently force_dma_unencrypted() is only used by the direct
> implementation of the DMA API, and thus resides in dma-direct.h. But
> there is nothing dma-direct specific about it: if one was -- for
> whatever reason -- to implement custom DMA ops that have to in the
> encrypted/protected scenarios dma-direct currently deals with, one would
> need exactly this kind of information.

I really don't think it has business being anywhre else, and your completely
bogus second patch just proves the point.
