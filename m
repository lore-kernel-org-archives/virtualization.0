From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [Fwd: [PATCH]: Fix crash in virtio_blk during modprobe ; rmmod ;
	modprobe]
Date: Thu, 22 May 2008 13:35:19 +0200
Message-ID: <20080522113517.GC7712__25005.0983777784$1211456256$gmane$org@kernel.dk>
References: <48341FC7.4060600@redhat.com>
	<200805222133.01686.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805222133.01686.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 22 2008, Rusty Russell wrote:
> On Wednesday 21 May 2008 23:12:39 Chris Lalancette wrote:
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4962e62..c678ac5 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -294,6 +294,7 @@ static void virtblk_remove(struct virtio_device *vd=
ev)
> > =A0=A0=A0=A0=A0=A0=A0=A0vdev->config->reset(vdev);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0blk_cleanup_queue(vblk->disk->queue);
> > +=A0=A0=A0=A0=A0=A0=A0del_gendisk(vblk->disk);
> > =A0=A0=A0=A0=A0=A0=A0=A0put_disk(vblk->disk);
> > =A0=A0=A0=A0=A0=A0=A0=A0unregister_blkdev(major, "virtblk");
> > =A0=A0=A0=A0=A0=A0=A0=A0mempool_destroy(vblk->pool);
> =

> Thanks Chris, it seems reasonable and I'm sure it works (kinda hard to
> test here, it's my root block dev).  Other drivers seem to do
> blk_cleanup_queue() *after* del_gendisk: does it matter?
> =

> Jens CC'd: he's gentle with my dumb questions...  Rusty.

del_gendisk() can generate IO, so it would seem safer to do that
_before_ putting the queue reference :-)

-- =

Jens Axboe
