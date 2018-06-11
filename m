From: "Liu, Changpeng" <changpeng.liu@intel.com>
Subject: RE: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands
	support
Date: Mon, 11 Jun 2018 03:37:00 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B6DF62C@SHSMSX103.ccr.corp.intel.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
	<20180607131003.GN19032@stefanha-x1.localdomain>
	<FF7FC980937D6342B9D289F5F3C7C2625B6DED4D@SHSMSX103.ccr.corp.intel.com>
	<20180608102027.GB31164@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180608102027.GB31164@stefanha-x1.localdomain>
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
> Sent: Friday, June 8, 2018 6:20 PM
> To: Liu, Changpeng <changpeng.liu@intel.com>
> Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> <wei.w.wang@intel.com>
> Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands
> support
> 
> On Thu, Jun 07, 2018 at 11:07:06PM +0000, Liu, Changpeng wrote:
> >
> >
> > > -----Original Message-----
> > > From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> > > Sent: Thursday, June 7, 2018 9:10 PM
> > > To: Liu, Changpeng <changpeng.liu@intel.com>
> > > Cc: virtualization@lists.linux-foundation.org; cavery@redhat.com;
> > > jasowang@redhat.com; pbonzini@redhat.com; Wang, Wei W
> > > <wei.w.wang@intel.com>
> > > Subject: Re: [PATCH v6] virtio_blk: add DISCARD and WRIET ZEROES commands
> > > support
> > >
> > > On Wed, Jun 06, 2018 at 12:19:00PM +0800, Changpeng Liu wrote:
> > > > Existing virtio-blk protocol doesn't have DISCARD/WRITE ZEROES commands
> > > > support, this will impact the performance when using SSD backend over
> > > > file systems.
> > > >
> > > > Commit 88c85538 "virtio-blk: add discard and write zeroes features to
> > > > specification"(see https://github.com/oasis-tcs/virtio-spec) extended
> > > > existing virtio-blk protocol, adding extra DISCARD and WRITE ZEROES
> > > > commands support.
> > > >
> > > > While here, using 16 bytes descriptor to describe one segment of DISCARD
> > > > or WRITE ZEROES commands, each command may contain one or more
> > > decriptors.
> > > >
> > > > The following data structure shows the definition of one descriptor:
> > > >
> > > > struct virtio_blk_discard_write_zeroes {
> > > >         le64 sector;
> > > >         le32 num_sectors;
> > > >         le32 unmap;
> > > > };
> > > >
> > > > Field 'sector' means the start sector for DISCARD and WRITE ZEROES,
> > > > filed 'num_sectors' means the number of sectors for DISCARD and WRITE
> > > > ZEROES, if both DISCARD and WRITE ZEROES are supported, field 'unmap'
> > > > maybe used for WRITE ZEROES command with DISCARD enabled.
> > > >
> > > > We also extended the virtio-blk configuration space to let backend
> > > > device put DISCARD and WRITE ZEROES configuration parameters.
> > > >
> > > > struct virtio_blk_config {
> > > >         [...]
> > > >
> > > >         le32 max_discard_sectors;
> > > >         le32 max_discard_seg;
> > > >         le32 discard_sector_alignment;
> > > >         le32 max_write_zeroes_sectors;
> > > >         le32 max_write_zeroes_seg;
> > > >         u8 write_zeroes_may_unmap;
> > > > }
> > > >
> > > > New feature bit [VIRTIO_BLK_F_DISCARD (13)]: Device can support discard
> > > > command, maximum discard sectors size in field 'max_discard_sectors' and
> > > > maximum discard segment number in field 'max_discard_seg'.
> > > >
> > > > New feature [VIRTIO_BLK_F_WRITE_ZEROES (14)]: Device can support write
> > > > zeroes command, maximum write zeroes sectors size in field
> > > > 'max_write_zeroes_sectors' and maximum write zeroes segment number in
> > > > field 'max_write_zeroes_seg'.
> > > >
> > > > The parameters in the configuration space of the device field
> > > > 'max_discard_sectors' and field 'discard_sector_alignment' are expressed in
> > > > 512-byte units if the VIRTIO_BLK_F_DISCARD feature bit is negotiated. The
> > > > field 'max_write_zeroes_sectors' is expressed in 512-byte units if the
> > > > VIRTIO_BLK_F_WRITE_ZEROES feature bit is negotiated.
> > > >
> > > > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > > > ---
> > > > CHANGELOG:
> > > > v6: don't set T_OUT bit to discard and write zeroes commands.
> > >
> > > I don't see this in the patch...
> > Yeah, do noting with DISCARD/WRITE ZEROES means no need to OR BLK_T_OUT
> again.
> > >
> > > > @@ -225,6 +260,7 @@ static blk_status_t virtio_queue_rq(struct
> > > blk_mq_hw_ctx *hctx,
> > > >  	int qid = hctx->queue_num;
> > > >  	int err;
> > > >  	bool notify = false;
> > > > +	bool unmap = false;
> > > >  	u32 type;
> > > >
> > > >  	BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
> > > > @@ -237,6 +273,13 @@ static blk_status_t virtio_queue_rq(struct
> > > blk_mq_hw_ctx *hctx,
> > > >  	case REQ_OP_FLUSH:
> > > >  		type = VIRTIO_BLK_T_FLUSH;
> > > >  		break;
> > > > +	case REQ_OP_DISCARD:
> > > > +		type = VIRTIO_BLK_T_DISCARD;
> > > > +		break;
> > > > +	case REQ_OP_WRITE_ZEROES:
> > > > +		type = VIRTIO_BLK_T_WRITE_ZEROES;
> > > > +		unmap = !(req->cmd_flags & REQ_NOUNMAP);
> > > > +		break;
> > > >  	case REQ_OP_SCSI_IN:
> > > >  	case REQ_OP_SCSI_OUT:
> > > >  		type = VIRTIO_BLK_T_SCSI_CMD;
> > > > @@ -256,6 +299,12 @@ static blk_status_t virtio_queue_rq(struct
> > > blk_mq_hw_ctx *hctx,
> > > >
> > > >  	blk_mq_start_request(req);
> > > >
> > > > +	if (type == VIRTIO_BLK_T_DISCARD || type ==
> > > VIRTIO_BLK_T_WRITE_ZEROES) {
> > > > +		err = virtblk_setup_discard_write_zeroes(req, unmap);
> > > > +		if (err)
> > > > +			return BLK_STS_RESOURCE;
> > > > +	}
> > > > +
> > > >  	num = blk_rq_map_sg(hctx->queue, req, vbr->sg);
> > > >  	if (num) {
> > > >  		if (rq_data_dir(req) == WRITE)
> > >
> > > ...since we still do blk_rq_map_sg() here and num should be != 0.
> > No, while here, we should keep the original logic for READ/WRITE commands.
> 
> My question is: why does the changelog say "don't set T_OUT" but the
> code *will* set it because blk_rq_map_sg() returns != 0 and
> rq_data_dir(req) == WRITE?
Since the last bit of DISCARD/WRITE ZEROES commands are already 1, so I said we don't need to set
T_OUT bit to DISCARD/WRITE ZEROES commands again. But the original logic for WRITE, T_OUT is still
needed, so just keep the original code here is fine.
> 
> Maybe I'm misreading the code, but it looks to me like this patch
> does the opposite of what the changelog says.
> 
> Stefan
