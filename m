From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/3] swiotlb: Export maximum allocation size
Date: Fri, 11 Jan 2019 10:12:31 +0100
Message-ID: <20190111091231.GB5825__18436.6013193086$1547692960$gmane$org@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
	<20190110134433.15672-2-joro@8bytes.org>
	<20190110170205.GB27546@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190110170205.GB27546@char.us.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Joerg Roedel <jroedel@suse.de>, brijesh.singh@amd.com, "Michael S . Tsirkin" <mst@redhat.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 10, 2019 at 12:02:05PM -0500, Konrad Rzeszutek Wilk wrote:
> Why not use swiotlb_nr_tbl ? That is how drivers/gpu/drm use to figure if they
> need to limit the size of pages.

That function just exports the overall size of the swiotlb aperture, no?
What I need here is the maximum size for a single mapping.

Regards,

	Joerg
