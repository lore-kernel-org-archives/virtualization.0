From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 4/5] virtio: Introduce virtio_max_dma_size()
Date: Wed, 30 Jan 2019 16:49:23 +0100
Message-ID: <20190130154922.GO32526__38987.3311667301$1548873329$gmane$org@8bytes.org>
References: <20190129084342.26030-1-joro@8bytes.org>
	<20190129084342.26030-5-joro@8bytes.org>
	<e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e138b703-188c-59d2-edec-65fe3e76d229@amd.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Grimm, Jon" <Jon.Grimm@amd.com>, "Singh,
	Brijesh" <brijesh.singh@amd.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, "jfehlig@suse.com" <jfehlig@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "jroedel@suse.de" <jroedel@suse.de>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Hi Tom,

On Wed, Jan 30, 2019 at 03:10:29PM +0000, Lendacky, Thomas wrote:
> On 1/29/19 2:43 AM, Joerg Roedel wrote:

> > +size_t virtio_max_dma_size(struct virtio_device *vdev)
> > +{
> > +	size_t max_segment_size = SIZE_MAX;
> > +
> > +	if (vring_use_dma_api(vdev))
> > +		max_segment_size = dma_max_mapping_size(&vdev->dev);
> > +
> > +	return max_segment_size;
> > +}
> 
> When I build with these patches and with the virtio devices as modules I
> get a build failure. Looks like this needs an EXPORT_SYMBOL_GPL().

Thanks for pointing that out, I added the missing EXPORTs and will send
a new version shortly.

Regards,

	Joerg
