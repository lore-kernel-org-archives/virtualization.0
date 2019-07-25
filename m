From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio/virtio_ring: Fix the dma_max_mapping_size call
Date: Thu, 25 Jul 2019 07:25:29 +0200
Message-ID: <20190725052529.GA24355__4146.47813174582$1564032347$gmane$org@lst.de>
References: <20190722145509.1284-1-eric.auger@redhat.com>
	<20190722145509.1284-3-eric.auger@redhat.com>
	<e4a288f2-a93a-5ce4-32da-f5434302551f@arm.com>
	<20190723153851.GE720@lst.de>
	<20190723114750-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190723114750-mutt-send-email-mst@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Auger <eric.auger@redhat.com>, iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 24, 2019 at 06:10:53PM -0400, Michael S. Tsirkin wrote:
> Christoph - would a documented API wrapping dma_mask make sense?
> With the documentation explaining how users must
> desist from using DMA APIs if that returns false ...

We have some bigger changes in this are planned, including turning
dma_mask into a scalar instead of a pointer, please stay tuned.
