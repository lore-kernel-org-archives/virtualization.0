From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] dma: Uninline dma_max_mapping_size()
Date: Thu, 31 Jan 2019 09:43:51 -0500
Message-ID: <20190131094319-mutt-send-email-mst__21066.8671106518$1548967647$gmane$org@kernel.org>
References: <20190130164007.26497-1-joro@8bytes.org>
	<20190130164007.26497-4-joro@8bytes.org>
	<20190131104129.GA9241@lst.de> <20190131130127.GP32526@8bytes.org>
	<20190131143723.GA32329@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190131143723.GA32329@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Thomas.Lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Joerg Roedel <joro@8bytes.org>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 31, 2019 at 03:37:23PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 31, 2019 at 02:01:27PM +0100, Joerg Roedel wrote:
> > On Thu, Jan 31, 2019 at 11:41:29AM +0100, Christoph Hellwig wrote:
> > > Sorry for not noticing last time, but since 5.0 we keep all non-fast
> > > path DMA mapping interfaces out of line, so this should move to
> > > kernel/dma/mapping.c.
> > 
> > Okay, attached patch does that. It applies on-top of this patch-set.
> > 
> > Michael, feel free to either apply this on-top of the patch-set or merge
> > the diff into patch 3, whatever you prefer.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> I'd prefer it to be squashed if possible.

OK. Joerg can you repost the series with this squashed
and all acks applied?
