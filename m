From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 3/3] virtio-blk: Add bio-based IO path for virtio-blk
Date: Mon, 18 Jun 2012 11:45:52 +0100
Message-ID: <CAJSP0QXQi5bjza7yRbBBJCjrC0BzafY1-T5aq8tGb+-S0CToYg@mail.gmail.com>
References: <1340002390-3950-1-git-send-email-asias@redhat.com>
	<1340002390-3950-4-git-send-email-asias@redhat.com>
	<20120618102108.GD23134@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120618102108.GD23134@redhat.com>
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
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 18, 2012 at 11:21 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jun 18, 2012 at 02:53:10PM +0800, Asias He wrote:
>> +static void virtblk_make_request(struct request_queue *q, struct bio *b=
io)
>> +{
>> + =A0 =A0 struct virtio_blk *vblk =3D q->queuedata;
>> + =A0 =A0 unsigned int num, out =3D 0, in =3D 0;
>> + =A0 =A0 struct virtblk_req *vbr;
>> +
>> + =A0 =A0 BUG_ON(bio->bi_phys_segments + 2 > vblk->sg_elems);
>> + =A0 =A0 BUG_ON(bio->bi_rw & (REQ_FLUSH | REQ_FUA));
>> +
>> + =A0 =A0 vbr =3D virtblk_alloc_req(vblk, GFP_NOIO);
>> + =A0 =A0 if (!vbr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 bio_endio(bio, -ENOMEM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 vbr->bio =3D bio;
>> + =A0 =A0 vbr->req =3D NULL;
>> + =A0 =A0 vbr->out_hdr.type =3D 0;
>> + =A0 =A0 vbr->out_hdr.sector =3D bio->bi_sector;
>> + =A0 =A0 vbr->out_hdr.ioprio =3D bio_prio(bio);
>> +
>> + =A0 =A0 sg_set_buf(&vbr->sg[out++], &vbr->out_hdr, sizeof(vbr->out_hdr=
));
>> +
>> + =A0 =A0 num =3D blk_bio_map_sg(q, bio, vbr->sg + out);
>> +
>> + =A0 =A0 sg_set_buf(&vbr->sg[num + out + in++], &vbr->status,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(vbr->status));
>> +
>> + =A0 =A0 if (num) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bio->bi_rw & REQ_WRITE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vbr->out_hdr.type |=3D VIRTIO_=
BLK_T_OUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out +=3D num;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vbr->out_hdr.type |=3D VIRTIO_=
BLK_T_IN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in +=3D num;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irq(vblk->disk->queue->queue_lock);
>> + =A0 =A0 if (virtqueue_add_buf(vblk->vq, vbr->sg, out, in, vbr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_ATOMIC) < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(vblk->disk->queue->queue_lock);
>
> Any implications of dropping lock like that?
> E.g. for suspend. like we are still discussing with
> unlocked kick?

Since we aquired the lock in this function there should be no problem.
 Whatever protects against vblk or vblk->disk disappearing upon
entering this function also protects after unlocking queue_lock.
Otherwise all .make_request_fn() functions would be broken.

I'd still like to understand the details though.

Stefan
