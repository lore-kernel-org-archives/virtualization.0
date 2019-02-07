From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB
Date: Thu, 7 Feb 2019 09:46:13 +0100
Message-ID: <20190207084613.GW32526__10107.3517276504$1549529191$gmane$org@8bytes.org>
References: <20190131163403.11363-1-joro@8bytes.org>
	<20190205155133-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190205155133-mutt-send-email-mst@kernel.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Thomas.Lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jon.grimm@amd.com, jfehlig@suse.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

On Tue, Feb 05, 2019 at 03:52:38PM -0500, Michael S. Tsirkin wrote:
> On Thu, Jan 31, 2019 at 05:33:58PM +0100, Joerg Roedel wrote:
> > Changes to v5 are:
> > 
> > 	- Changed patch 3 to uninline dma_max_mapping_size()
> 
> And this lead to problems reported by kbuild :(

Hmm, I didn't get any kbuild emails for this series. Can you please
forward it me so that I can look into it?

> BTW when you repost, can I ask you to pls include
> the version in all patches? Both --subject-prefix
> and -v flags to git format-patch will do this for you.

Will do, thanks.


Regards,

	Joerg
