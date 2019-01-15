From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Tue, 15 Jan 2019 09:37:42 +0100
Message-ID: <20190115083742.GF5825__17537.3789076277$1547692024$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
	<20190111091502.GC5825@8bytes.org>
	<38bcbd46-674c-348a-cbd6-66bd431e986a@redhat.com>
	<20190114095002.GA29874@lst.de>
	<ac6d83d8-02de-dbdf-e309-3a1115642d50@redhat.com>
	<20190114131114-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190114131114-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 14, 2019 at 01:20:45PM -0500, Michael S. Tsirkin wrote:
> Which would be fine especially if we can manage not to introduce a bunch
> of indirect calls all over the place and hurt performance.

Which indirect calls? In case of unset dma_ops the DMA-API functions
call directly into the dma-direct implementation, no indirect calls at
all.

Regards,

	Joerg
