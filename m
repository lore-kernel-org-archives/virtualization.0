From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_blk: decrement index when blockdevice is removed
Date: Wed, 06 Apr 2011 11:02:08 +0930
Message-ID: <87hbacw4fb.fsf__15613.0099938766$1302057560$gmane$org@rustcorp.com.au>
References: <1969774563.659835.1301978981017.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<4D9AA3BC.6030907@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4D9AA3BC.6030907@fusionio.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jaxboe@fusionio.com>, Takuma Umeya <tumeya@redhat.com>
Cc: john cooper <john.cooper@redhat.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 05 Apr 2011 07:08:12 +0200, Jens Axboe <jaxboe@fusionio.com> wrote:
> On 2011-04-05 06:49, Takuma Umeya wrote:
> > When virtio block device is removed, index does not get decremented. When 
> > another virtio disk is attached it uses the next device letter to the 
> > one that is suppose to be available. 
> > 
> > Signed-off-by: Takuma Umeya <tumeya@redhat.com>
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 6ecf89c..730e7af 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -489,6 +489,7 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
> >         mempool_destroy(vblk->pool);
> >         vdev->config->del_vqs(vdev);
> >         kfree(vblk);
> > +       index--;
> >  }
> >  
> >  static const struct virtio_device_id id_table[] = {
> 
> What happens when you delete a device that isn't the last one?

Obviously we should do something cleverer for assigning drives.

It might be a cute if genhd gave us a function to get the next free
index for a given major number, and format it for us, like so:

      /* Return the next available minor for a given @major, at least
       * @spacing after the previous and, and append appropriate letters
       * to @name if it's not NULL.  -ve errno on fail (-ENOSPC?). */
      int disk_next_minor(int major, unsigned spacing, char *name);

A trivial optimization would be to remember the last major and max minor
(resetting that if any disks are removed).

This could clean up other code, too.

Cheers,
Rusty.
