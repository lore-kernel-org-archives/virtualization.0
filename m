From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Mon, 4 Jun 2018 04:14:53 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B6DD85E@SHSMSX103.ccr.corp.intel.com>
References: <1527558144-3825-1-git-send-email-changpeng.liu@intel.com>
	<20180531103047.GB27838@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DCEE5@SHSMSX103.ccr.corp.intel.com>
	<20180601085935.GA8196@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180601085935.GA8196@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "cavery@redhat.com" <cavery@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Friday, June 1, 2018 5:00 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> <wei.w.wang@intel.com>
> Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
> support
> 
> On Thu, May 31, 2018 at 11:53:26PM +0000, Liu, Changpeng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > > Sent: Thursday, May 31, 2018 6:31 PM
> > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> > > jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> > > <wei.w.wang@intel.com>
> > > Subject: Re: [PATCH v4] virtio_blk: add DISCARD and WRIET ZEROES commands
> > > support
> > >
> > > On Tue, May 29, 2018 at 09:42:24AM +0800, Changpeng Liu wrote:
> > > >  	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > > >  	if (num) {
> > > > -		if (rq_data_dir(req) == WRITE)
> > > > +		if (rq_data_dir(req) == WRITE || type == VIRTIO_BLK_T_DISCARD
> > > ||
> > > > +		    type == VIRTIO_BLK_T_WRITE_ZEROES)
> > > >  			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev,
> > > VIRTIO_BLK_T_OUT);
> > >
> > > The VIRTIO specification says:
> > >
> > >   The type of the request is either a read (VIRTIO_BLK_T_IN), a write
> > >   (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> > >   (VIRTIO_BLK_T_WRITE_ZEROES) or a flush (VIRTIO_BLK_T_FLUSH).
> > >
> > > But this patch actually uses VIRTIO_BLK_T_DISCARD | VIRTIO_BLK_T_OUT or
> > > VIRTIO_BLK_T_WRITE_ZEROES | VIRTIO_BLK_T_OUT.  "either A or B" is
> > > exclusive, it does not mean "A and B".
> > Hi Stefan,
> >
> > For the new add DISCARD and WRITE ZEROES commands, I defined the
> > type code to 11 and 13, so the last bit always is 1, there is no difference
> > in practice.
> 
> Then the code is misleading.  This is clearer:
> 
>   if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES)
>       /* Do nothing, type already set */
>   else if (rq_data_dir(req) == WRITE)
>       vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_OUT);
>   ...
This change sounds good to me, will change the patch accordingly.
> 
> > But I believe the specification says VIRTIO_BLK_T_OUT means direction, so
> > OR the two bits together should compliance with the specification.
> 
> I cannot find that in the specification:
> 
>   http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-
> 2020002
> 
> and it would contradict the "The type of the request is either ... or
> ..." wording that I quoted from the spec above.
> 
> If you do find something in the spec, please let me know and we can
> figure out how to make the spec consistent.
I saw comments from file linux/usr/include/uapi/linux/virtio_blk.h, which says
VIRTIO_BLK_T_OUT may be combined with other commands and means direction,
the specification does not have such description.
