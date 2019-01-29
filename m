From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Tue, 29 Jan 2019 18:12:29 +0100
Message-ID: <20190129171229.GA15195__24127.7465874859$1548825492$gmane$org@lst.de>
References: <20190129084342.26030-1-joro@8bytes.org>
	<20190129084342.26030-2-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190129084342.26030-2-joro@8bytes.org>
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

On Tue, Jan 29, 2019 at 09:43:38AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The function returns the maximum size that can be remapped
> by the SWIOTLB implementation. This function will be later
> exposed to users through the DMA-API.
> 
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
