From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: Bug in SeaBIOS virtio-ring handling bug with vhost-scsi-pci
Date: Mon, 08 Apr 2013 21:33:21 -0700
Message-ID: <1365482001.24346.135.camel__43627.1995226436$1365482020$gmane$org@haakon2.linux-iscsi.org>
References: <1365130792.8507.30.camel@haakon2.linux-iscsi.org>
	<1365480594.24346.133.camel@haakon2.linux-iscsi.org>
	<20130409042432.GB26647@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130409042432.GB26647@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: target-devel <target-devel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, seabios-devel <seabios@seabios.org>, qemu-devel <qemu-devel@nongnu.org>, lf-virt <virtualization@lists.linux-foundation.org>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2013-04-09 at 12:24 +0800, Asias He wrote:
> On Mon, Apr 08, 2013 at 09:09:54PM -0700, Nicholas A. Bellinger wrote:
> > Ping.
> > 
> > Any ideas on this one..?  It seems like this bug would be effecting
> > non vhost-scsi-pci code as well..
> 
> Nicholas, where is the latest v3 code. Can you push it to your tree. 
> 

Sure.  Just pushed to:

http://git.kernel.org/cgit/virt/kvm/nab/qemu-kvm.git/log/?h=vhost-scsi-for-1.4

and should be appearing momentarily.

--nab

> > --nab
> > 
> > On Thu, 2013-04-04 at 19:59 -0700, Nicholas A. Bellinger wrote:
> > > Hi Paolo & Co,
> > > 
> > > So I've been running into another bug with SeaBIOS w/ virtio-scsi +
> > > vhost-scsi-pci code..
> > > 
> > > During the last weeks debugging on the QEMU vhost memory re-mapping bug,
> > > my seabios builds have been using a smaller target ID (16) for scanning
> > > than the default hard coded value of 256 in init_virtio_scsi().
> > > 
> > > After bumping this value back to 256 recently, a bogus out_num value
> > > from vhost_get_vq_desc() start appearing on the tcm_vhost side:
> > > 
> > > [17348.044031] Invalid buffer layout out: 0 in: 2
> > > 
> > > After adding more debug output to SeaBIOS, the vring->num value appears
> > > to be reset from the expected MAX_QUEUE_NUM=128, then incremented each
> > > time after vring_more_used() is called to poll for completion.. 
> > > 
> > > init virtio-scsi
> > > found virtio-scsi at 0:4
> > > vring_init Setting vr->num: 128
> > > Calling virtio_scsi_scan_target for target: 0
> > > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@0,0
> > > virtio_scsi_cmd, using vring_add_buf for out_num: 1 in_num: 2
> > > virtio_scsi_cmd, using vring_add_buf vr: 0x000ed404 vr->num: 128
> > > vring_add_buf, vr: 0x000ed404 vr->num: 128
> > > vring_add_buf, head: 0, index: 0
> > > vring_add_buf, setting desc[prev=2].flags
> > > vring_add_buf, setting free_head: 3
> > > vring_add_buf, setting q->vdata[head=0]
> > > vring_add_buf, setting q->ring[av=0]
> > > virtio_scsi_cmd, after vring_add_buf vr: 0x000ed404 vr->num: 128
> > > virtio_scsi_cmd, after vring_kick vr: 0x000ed404 vr->num: 128
> > > virtio_scsi_cmd, after vring_more_used #4 vr: 0x000ed404 vr->num: 1
> > >                                           ^^^^^^^^^^^^^^^^^^^^^^^^^   
> > > 
> > >    Reset from 128 to 1 immediate after first vring_more_used()..?
> > > 
> > > vring_get_buf last_used_idx: 0 vr: 0x000ed404 vr->num: 1
> > > vring_get_buf checking &used->ring[0]
> > > vring_get_buf, using new last_unsed: 0 >>>>>>>>>>>>>>>>>>
> > > vring_get_buf using id: 0 from elem->id: 0x000ed004
> > > vring_detach: vq->free_head: 3
> > > vring_detach: Setting new vq->free_head: 0
> > > virtio_scsi_cmd, after vring_get_buf #5 vr: 0x000ed404 vr->num: 1
> > > Calling virtio_scsi_scan_target for target: 1
> > > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@1,0
> > > virtio_scsi_cmd, using vring_add_buf for out_num: 1 in_num: 2
> > > virtio_scsi_cmd, using vring_add_buf vr: 0x000ed404 vr->num: 1
> > > vring_add_buf, vr: 0x000ed404 vr->num: 1
> > > vring_add_buf, head: 0, index: 0
> > > vring_add_buf, setting desc[prev=2].flags
> > > vring_add_buf, setting free_head: 3
> > > vring_add_buf, setting q->vdata[head=0]
> > > vring_add_buf, setting q->ring[av=0]
> > > virtio_scsi_cmd, after vring_add_buf vr: 0x000ed404 vr->num: 1
> > > virtio_scsi_cmd, after vring_kick vr: 0x000ed404 vr->num: 1
> > > virtio_scsi_cmd, after vring_more_used #4 vr: 0x000ed404 vr->num: 2
> > >                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > >   Incremented from 1 to 2 after second vring_more_used()..?
> > > 
> > > vring_get_buf last_used_idx: 1 vr: 0x000ed404 vr->num: 2
> > > vring_get_buf checking &used->ring[1]
> > > vring_get_buf, using new last_unsed: 1 >>>>>>>>>>>>>>>>>>
> > > vring_get_buf using id: 0 from elem->id: 0x000ed00c
> > > vring_detach: vq->free_head: 3
> > > vring_detach: Setting new vq->free_head: 0
> > > virtio_scsi_cmd, after vring_get_buf #5 vr: 0x000ed404 vr->num: 2
> > > virtio-scsi vendor='LIO-ORG' product='RAMDISK-MCP' rev='4.0' type=0 removable=0
> > > virtio_scsi_cmd, using vring_add_buf for out_num: 1 in_num: 1
> > > virtio_scsi_cmd, using vring_add_buf vr: 0x000ed404 vr->num: 2
> > > vring_add_buf, vr: 0x000ed404 vr->num: 2
> > > vring_add_buf, head: 0, index: 0
> > > vring_add_buf, setting desc[prev=1].flags
> > > vring_add_buf, setting free_head: 2
> > > vring_add_buf, setting q->vdata[head=0]
> > > vring_add_buf, setting q->ring[av=0]
> > > virtio_scsi_cmd, after vring_add_buf vr: 0x000ed404 vr->num: 2
> > > virtio_scsi_cmd, after vring_kick vr: 0x000ed404 vr->num: 2
> > > virtio_scsi_cmd, after vring_more_used #4 vr: 0x000ed404 vr->num: 3
> > >                                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > 
> > >   Incremented from 2 to 3, and so on..
> > > 
> > > and this keeps happening until vr->num begins to exceed
> > > MAX_QUEUE_NUM around scanning of target ID 127:
> > > 
> > > virtio_scsi_cmd, after vring_add_buf vr: 0x000ed404 vr->num: 128
> > > virtio_scsi_cmd, after vring_kick vr: 0x000ed404 vr->num: 128
> > > virtio_scsi_cmd, after vring_more_used #4 vr: 0x000ed404 vr->num: 129
> > > vring_get_buf last_used_idx: 128 vr: 0x000ed404 vr->num: 129
> > > vring_get_buf checking &used->ring[128]
> > > vring_get_buf, using new last_unsed: 128 >>>>>>>>>>>>>>>>>>
> > > vring_get_buf using id: 129 from elem->id: 0x000ed404
> > > vring_detach: vq->free_head: 3
> > > vring_detach: Setting new vq->free_head: 129
> > > virtio_scsi_cmd, after vring_get_buf #5 vr: 0x000ed404 vr->num: 129
> > > Calling virtio_scsi_scan_target for target: 127
> > > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@127,0
> > > virtio_scsi_cmd, using vring_add_buf for out_num: 1 in_num: 2
> > > virtio_scsi_cmd, using vring_add_buf vr: 0x000ed404 vr->num: 129
> > > vring_add_buf, vr: 0x000ed404 vr->num: 129
> > > vring_add_buf, head: 129, index: 0
> > > vring_add_buf, setting desc[prev=4].flags
> > > vring_add_buf, setting free_head: 5
> > > vring_add_buf, setting q->vdata[head=0]
> > > vring_add_buf, setting q->ring[av=129]
> > > virtio_scsi_cmd, after vring_add_buf vr: 0x000ed404 vr->num: 129
> > > virtio_scsi_cmd, after vring_kick vr: 0x000ed404 vr->num: 129
> > > virtio_scsi_cmd, after vring_more_used #4 vr: 0x000ed404 vr->num: 130
> > > vring_get_buf last_used_idx: 129 vr: 0x000ed404 vr->num: 130
> > > vring_get_buf checking &used->ring[129]
> > > vring_get_buf, using new last_unsed: 129 >>>>>>>>>>>>>>>>>>
> > > vring_get_buf using id: 968704 from elem->id: 0x000ed40c
> > > vring_detach: vq->free_head: 5
> > > vring_detach: Setting new vq->free_head: 968704
> > > virtio_scsi_cmd, after vring_get_buf #5 vr: 0x000ed404 vr->num: 130
> > > Calling virtio_scsi_scan_target for target: 128
> > > Searching bootorder for: /pci@i0cf8/*@4/*@0/*@128,0
> > > virtio_scsi_cmd, using vring_add_buf for out_num: 1 in_num: 2
> > > virtio_scsi_cmd, using vring_add_buf vr: 0x000ed404 vr->num: 130
> > > vring_add_buf, vr: 0x000ed404 vr->num: 130
> > > vring_add_buf, head: 51200, index: 0
> > > vring_add_buf, setting desc[prev=1].flags
> > > vring_add_buf, setting free_head: 2
> > > vring_add_buf, setting q->vdata[head=0]
> > > vring_add_buf, setting q->ring[av=51200]
> > > 
> > > until '[17348.044031] Invalid buffer layout out: 0 in: 2' appears on the
> > > vhost.
> > > 
> > > So it's clear this definitely is not supposed to be happening, but I've
> > > not yet been able to ascertain why it's suddenly being triggered now..?
> > > I don't recall Asias running into a similar issue during his earlier
> > > testing, but this bug is happening after every I/O in SeaBIOS with the
> > > most recent vhost-scsi-pci code.
> 
> Ah, I did not see this before. If we disable SeaBIOS and only use guest
> kernel to access tcm_vhost disk, do you see this.
> 
> > > I'm using the following to work-around this issue for the moment, and
> > > would like some input from virtio / SeaBIOS folks..
> > > 
> > > WDYT..?
> > > 
> > > --nab
> > > 
> > > diff --git a/src/virtio-ring.c b/src/virtio-ring.c
> > > index bddb090..e046141 100644
> > > --- a/src/virtio-ring.c
> > > +++ b/src/virtio-ring.c
> > > @@ -35,10 +35,16 @@
> > >  
> > >  int vring_more_used(struct vring_virtqueue *vq)
> > >  {
> > > +    struct vring *vr = &vq->vring;
> > >      struct vring_used *used = GET_LOWFLAT(vq->vring.used);
> > >      int more = GET_LOWFLAT(vq->last_used_idx) != GET_LOWFLAT(used->idx);
> > >      /* Make sure ring reads are done after idx read above. */
> > >      smp_rmb();
> > > +
> > > +    /* Huh..?  vr->num is somehow changing from below us..? */
> 
> Pretty strange.
> 
> > > +    if (GET_LOWFLAT(vr->num) != MAX_QUEUE_NUM) {
> > > +           SET_LOWFLAT(vr->num, MAX_QUEUE_NUM);
> > > +    }
> > >      return more;
> > >  }
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe target-devel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> 
