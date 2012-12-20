From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] virtio-blk: Don't free ida when disk is in use
Date: Thu, 20 Dec 2012 10:41:56 +0100
Message-ID: <F122515D-83AE-4161-A014-61BA6EEBA9A6@suse.de>
References: <1355946015-25879-1-git-send-email-agraf@suse.de>
	<878v8t1hri.fsf@rustcorp.com.au> <50D2D078.2070408@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50D2D078.2070408@redhat.com>
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
Cc: "mst@redhat.com" <mst@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org



On 20.12.2012, at 09:46, Asias He <asias@redhat.com> wrote:

> On 12/20/2012 12:15 PM, Rusty Russell wrote:
>> Alexander Graf <agraf@suse.de> writes:
>> 
>>> When a file system is mounted on a virtio-blk disk, we then remove it
>>> and then reattach it, the reattached disk gets the same disk name and
>>> ids as the hot removed one.
>>> 
>>> This leads to very nasty effects - mostly rendering the newly attached
>>> device completely unusable.
>>> 
>>> Trying what happens when I do the same thing with a USB device, I saw
>>> that the sd node simply doesn't get free'd when a device gets forcefully
>>> removed.
>>> 
>>> Imitate the same behavior for vd devices. This way broken vd devices
>>> simply are never free'd and newly attached ones keep working just fine.
>>> 
>>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> 
>> I think deserves a CC:stable, no?

I wanted to make sure people can comment on it first. But yes, it should go into stable when accepted.

>> 
>> I've put it in my pending queue for *next* merge window for now...
> 
> Thanks for looking into this, Alexander!
> 
> I also noticed this problem. The problem is that, if you hot-unplug a
> mounted or opened disk, the disk is in opened state. Next time, when you
> hotplug the same disk. The kernel thought it was opened already. The
> driver will use the wrong gendisk data structure in bdev.

Exactly :)

> 
> blkdev_open
>   blkdev_get
>      __blkdev_get
>         if (!bdev->bd_openers) {    <-- Here, bd_disk not got updated
>                                         still points to old one
>           bdev->bd_disk = disk;
>           bdev->bd_queue = disk->queue;
>           ...
> 
> I tried something like this:
> 
> @@ -854,6 +862,19 @@ static int __devinit virtblk_probe(struct
> virtio_device *vdev)
>                blk_queue_io_opt(q, blk_size * opt_io_size);
> 
>        add_disk(vblk->disk);
> +
> +       for (i = 0; i < 1 << PART_BITS; i++) {
> +               bdev = bdget_disk(vblk->disk, i);
> +               if (bdev) {
> +                       bdev->bd_disk = vblk->disk;
> +                       bdev->bd_queue = q;
> +                       bdput(bdev);

Does this stack? What if the device was mounted twice? Or mounted and dd'ed at the same time? Then your refcount here is wrong.

Also this means that you're free'ing a bdev even though there's still a reference held to it. That means whoever holds it could later use that pointer and access bogus memory.


Alex

> +               }
> +       }
> 
> 
> 1) Before:
> ---> hot-plug
> [   35.730183] virtio_blk: virtblk_probe: vblk=ffff880078b0e000,
> disk=ffff880078d54c00, q=ffff88007f88b3d8
> [   35.735352] virtio_blk:    virtblk_ioctl: vblk=ffff880078b0e000,
> disk=ffff880078d54c00, bdev=ffff88007c45cc00, q=ffff88007f88b3d8
> ---> hot-unplug
> 
> ---> hot-plug
> [   83.570480] virtio_blk: virtblk_probe: vblk=ffff880078b0e000,
> disk=ffff880078d55800, q=ffff88007f88bb40
> [   83.575614] virtio_blk:   virtblk_ioctl: vblk=ffff880078b0e000,
> disk=ffff880078d54c00, bdev=ffff88007c45cc00, q=ffff88007f88b3d8
> 
> The disk points to old one ffff880078d54c00. The queue also points to
> old one ffff88007f88b3d8.
> 
> 2) After:
> ---> hot-plug
> [   68.035063] virtio_blk: virtblk_probe: vblk=ffff880079b20000,
> disk=ffff88007f9ebc00, q=ffff8800784d8ed0
> [   68.041140] virtio_blk:    virtblk_ioctl: vblk=ffff880079b20000,
> disk=ffff88007f9ebc00, bdev=ffff88007ab2c000, q=ffff8800784d8ed0
> ---> hot-unplug
> 
> ---> hot-plug
> [   86.317706] virtio_blk: virtblk_probe: vblk=ffff880079b20000,
> disk=ffff88007f9eb000, q=ffff8800784d9638
> [   86.322535] virtio_blk:   virtblk_ioctl: vblk=ffff880079b20000,
> disk=ffff88007f9eb000, bdev=ffff88007ab2c000, q=ffff8800784d9638
> 
> The disk and queue are updated correctly. The attached disk works and
> still uses the old name.
> 
> -- 
> Asias
