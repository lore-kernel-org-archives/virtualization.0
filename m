From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/5] swiotlb: Introduce swiotlb_max_mapping_size()
Date: Thu, 24 Jan 2019 09:47:48 +0100
Message-ID: <20190124084748.GA19510__32597.0857682236$1548319683$gmane$org@lst.de>
References: <20190123163049.24863-1-joro@8bytes.org>
	<20190123163049.24863-2-joro@8bytes.org>
	<20190123212813.GB9032@lst.de> <20190124082431.GH32526@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190124082431.GH32526@8bytes.org>
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

On Thu, Jan 24, 2019 at 09:24:31AM +0100, Joerg Roedel wrote:
> On Wed, Jan 23, 2019 at 10:28:13PM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 23, 2019 at 05:30:45PM +0100, Joerg Roedel wrote:
> > > +extern size_t swiotlb_max_mapping_size(struct device *dev);
> > 
> > No need for the extern keyword on function declarations in headers.
> 
> Right, but all other function declarations in that header file have
> 'extern' too, so I added it also for that one.

Your patch 3 also doesn't use an extern.  And I have to say I
much prefer it that way..
