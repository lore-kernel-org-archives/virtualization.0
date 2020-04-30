From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Date: Thu, 30 Apr 2020 06:28:21 -0400
Message-ID: <20200430062549-mutt-send-email-mst@kernel.org>
References: <20200429165345.144702-1-stefanha@redhat.com>
 <20200430084323.qts2q5ql7rkclk2h@steredhat>
 <20200430101410.GA164094@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-block-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200430101410.GA164094@stefanha-x1.localdomain>
Sender: linux-block-owner@vger.kernel.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>, cohuck@redhat.com, Jason Wang <jasowang@redhat.com>, Lance Digby <ldigby@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 30, 2020 at 11:14:10AM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 30, 2020 at 10:43:23AM +0200, Stefano Garzarella wrote:
> > On Wed, Apr 29, 2020 at 05:53:45PM +0100, Stefan Hajnoczi wrote:
> > > A userspace process holding a file descriptor to a virtio_blk device can
> > > still invoke block_device_operations after hot unplug.  This leads to a
> > > use-after-free accessing vblk->vdev in virtblk_getgeo() when
> > > ioctl(HDIO_GETGEO) is invoked:
> > > 
> > >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000090
> > >   IP: [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
> > >   PGD 800000003a92f067 PUD 3a930067 PMD 0
> > >   Oops: 0000 [#1] SMP
> > >   CPU: 0 PID: 1310 Comm: hdio-getgeo Tainted: G           OE  ------------   3.10.0-1062.el7.x86_64 #1
> > >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > >   task: ffff9be5fbfb8000 ti: ffff9be5fa890000 task.ti: ffff9be5fa890000
> > >   RIP: 0010:[<ffffffffc00e5450>]  [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
> > >   RSP: 0018:ffff9be5fa893dc8  EFLAGS: 00010246
> > >   RAX: ffff9be5fc3f3400 RBX: ffff9be5fa893e30 RCX: 0000000000000000
> > >   RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff9be5fbc10b40
> > >   RBP: ffff9be5fa893dc8 R08: 0000000000000301 R09: 0000000000000301
> > >   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9be5fdc24680
> > >   R13: ffff9be5fbc10b40 R14: ffff9be5fbc10480 R15: 0000000000000000
> > >   FS:  00007f1bfb968740(0000) GS:ffff9be5ffc00000(0000) knlGS:0000000000000000
> > >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   CR2: 0000000000000090 CR3: 000000003a894000 CR4: 0000000000360ff0
> > >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >   Call Trace:
> > >    [<ffffffffc016ac37>] virtblk_getgeo+0x47/0x110 [virtio_blk]
> > >    [<ffffffff8d3f200d>] ? handle_mm_fault+0x39d/0x9b0
> > >    [<ffffffff8d561265>] blkdev_ioctl+0x1f5/0xa20
> > >    [<ffffffff8d488771>] block_ioctl+0x41/0x50
> > >    [<ffffffff8d45d9e0>] do_vfs_ioctl+0x3a0/0x5a0
> > >    [<ffffffff8d45dc81>] SyS_ioctl+0xa1/0xc0
> > > 
> > > A related problem is that virtblk_remove() leaks the vd_index_ida index
> > > when something still holds a reference to vblk->disk during hot unplug.
> > > This causes virtio-blk device names to be lost (vda, vdb, etc).
> > > 
> > > Fix these issues by protecting vblk->vdev with a mutex and reference
> > > counting vblk so the vd_index_ida index can be removed in all cases.
> > > 
> > > Fixes: 48e4043d4529523cbc7fa8dd745bd8e2c45ce1d3
> > >        ("virtio: add virtio disk geometry feature")
> > > Reported-by: Lance Digby <ldigby@redhat.com>
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 87 ++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 79 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index 93468b7c6701..6f7f277495f4 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -33,6 +33,16 @@ struct virtio_blk_vq {
> > >  } ____cacheline_aligned_in_smp;
> > >  
> > >  struct virtio_blk {
> > > +	/*
> > > +	 * vdev may be accessed without taking this mutex in blk-mq and
> > > +	 * virtqueue code paths because virtblk_remove() stops them before vdev
> > > +	 * is freed.
> > > +	 *
> > > +	 * Everything else must hold this mutex when accessing vdev and must
> > > +	 * handle the case where vdev is NULL after virtblk_remove() has been
> > > +	 * called.
> > > +	 */
> > > +	struct mutex vdev_mutex;
> > 
> > The patch LGTM, I'm just worried about cache_type_store() and
> > cache_type_show() because IIUC they aren't in blk-mq and virtqueue code
> > paths, but they use vdev.
> > 
> > Do we have to take the mutex there too?
> 
> No, because del_gendisk() in virtblk_remove() deletes the sysfs
> attributes before vblk->vdev is set to NULL.  kernfs deactivates the
> kernfs nodes so that further read()/write() operations fail with ENODEV
> (see fs/kernfs/dir.c and fs/kernfs/file.c).
> 
> I have tested that a userspace process with a sysfs attr file open
> cannot access the attribute after virtblk_remove().
> 
> Stefan

Sounds good, but pls update the comment adding something like
" .. or anything coming from block layer since del_gendisk()
  in virtblk_remove deletes the disk before vblk->vdev is set to NULL.
"

-- 
MST
