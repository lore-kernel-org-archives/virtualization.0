From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date: Fri, 11 Jan 2019 10:15:02 +0100
Message-ID: <20190111091502.GC5825__26613.9116058641$1547692985$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5ae1341e-62ec-0478-552b-259eabf9fb17@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jfehlig@suse.com, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 11, 2019 at 11:29:31AM +0800, Jason Wang wrote:
> Just wonder if my understanding is correct IOMMU_PLATFORM must be set for
> all virtio devices under AMD-SEV guests?

Yes, that is correct. Emulated DMA can only happen on the SWIOTLB
aperture, because that memory is not encrypted. The guest bounces the
data then to its encrypted memory.

Regards,

	Joerg
