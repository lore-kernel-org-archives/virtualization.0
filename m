From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [virtio-dev] [PATCH] virtio-blk: add DISCARD support to
	virtio-blk driver
Date: Tue, 28 Mar 2017 01:52:02 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B56706B@SHSMSX103.ccr.corp.intel.com>
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
	<00d28fcc-446b-eff6-a5a3-6675216802b9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <00d28fcc-446b-eff6-a5a3-6675216802b9@redhat.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: virtio-dev@lists.oasis-open.org [mailto:virtio-dev@lists.oasis-open.org] On
> Behalf Of Paolo Bonzini
> Sent: Monday, March 27, 2017 7:34 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>; virtio-dev@lists.oasis-open.org;
> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; hch@lst.de
> Cc: qemu-devel@nongnu.org
> Subject: Re: [virtio-dev] [PATCH] virtio-blk: add DISCARD support to virtio-blk driver
> 
> 
> 
> On 28/03/2017 10:39, Changpeng Liu wrote:
> > +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> > +		q->limits.discard_zeroes_data = 0;
> 
> Maybe you could use another feature bit to populate discard_zeroes_data.
> 
> Paolo
> 
Sounds good to me, Christoph Hellwig mentioned this field will be removed in next release, just removed this line makes clear.
> > +		q->limits.discard_alignment = blk_size;
> > +		q->limits.discard_granularity = blk_size;
> > +		blk_queue_max_discard_sectors(q, UINT_MAX);
> > +		blk_queue_max_discard_segments(q, 1);
> > +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> > +	}
> > +
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
