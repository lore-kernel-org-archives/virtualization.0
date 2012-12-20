From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-blk: Don't free ida when disk is in use
Date: Thu, 20 Dec 2012 13:38:53 +0200
Message-ID: <20121220113853.GA3909@redhat.com>
References: <1355946015-25879-1-git-send-email-agraf@suse.de>
	<20121220105417.GA3789@redhat.com>
	<62D6A704-CB88-4A8C-A5F3-6BD3C267895F@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <62D6A704-CB88-4A8C-A5F3-6BD3C267895F@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 20, 2012 at 12:27:53PM +0100, Alexander Graf wrote:
> 
> On 20.12.2012, at 11:54, Michael S. Tsirkin wrote:
> 
> > On Wed, Dec 19, 2012 at 08:40:15PM +0100, Alexander Graf wrote:
> >> When a file system is mounted on a virtio-blk disk, we then remove it
> >> and then reattach it, the reattached disk gets the same disk name and
> >> ids as the hot removed one.
> >> 
> >> This leads to very nasty effects - mostly rendering the newly attached
> >> device completely unusable.
> >> 
> >> Trying what happens when I do the same thing with a USB device, I saw
> >> that the sd node simply doesn't get free'd when a device gets forcefully
> >> removed.
> >> 
> >> Imitate the same behavior for vd devices. This way broken vd devices
> >> simply are never free'd and newly attached ones keep working just fine.
> >> 
> >> Signed-off-by: Alexander Graf <agraf@suse.de>
> >> ---
> >> drivers/block/virtio_blk.c | 7 ++++++-
> >> 1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> >> index 0bdde8f..07a18e2 100644
> >> --- a/drivers/block/virtio_blk.c
> >> +++ b/drivers/block/virtio_blk.c
> >> @@ -889,6 +889,7 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
> >> {
> >> 	struct virtio_blk *vblk = vdev->priv;
> >> 	int index = vblk->index;
> >> +	int refc;
> >> 
> >> 	/* Prevent config work handler from accessing the device. */
> >> 	mutex_lock(&vblk->config_lock);
> >> @@ -903,11 +904,15 @@ static void __devexit virtblk_remove(struct virtio_device *vdev)
> >> 
> >> 	flush_work(&vblk->config_work);
> >> 
> >> +	refc = atomic_read(&disk_to_dev(vblk->disk)->kobj.kref.refcount);
> >> 	put_disk(vblk->disk);
> >> 	mempool_destroy(vblk->pool);
> >> 	vdev->config->del_vqs(vdev);
> >> 	kfree(vblk);
> >> -	ida_simple_remove(&vd_index_ida, index);
> >> +
> >> +	/* Only free device id if we don't have any users */
> >> +	if (refc == 1)
> >> +		ida_simple_remove(&vd_index_ida, index);
> >> }
> >> 
> >> #ifdef CONFIG_PM
> > 
> > Network devices take the approach of retrying every second.
> > Donnu if it makes sense here.
> 
> I would rather think the 100% right approach would be a recursive unrolling of all users bottom to top. Force unmount. Force close all fd's.
> I'm not sure why that doesn't happen today, but it doesn't :).
> 
> 
> Alex

Especially force close fd's won't be easy. A simpler alternative
would be preventing unplug by taking some reference count.

-- 
MST
