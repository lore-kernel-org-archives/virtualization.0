From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date: Wed, 23 Jan 2019 22:27:55 +0100
Message-ID: <20190123212755.GA9032__47431.0418868967$1548278887$gmane$org@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123163049.24863-3-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190123163049.24863-3-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Jens Axboe <axboe@kernel.dk>, jon.grimm@amd.com, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, jroedel@suse.de, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 23, 2019 at 05:30:46PM +0100, Joerg Roedel wrote:
> +bool is_swiotlb_active(void)
> +{
> +	return !no_iotlb_memory;
> +}

As I've just introduced and fixed a bug in this area in the current
cycle - I don't think no_iotlb_memory is what your want (and maybe
not useful at all): if the arch valls swiotlb_exit after previously
initializing a buffer it won't be set.  You probably want to check
for non-zero io_tlb_start and/or io_tlb_end.
