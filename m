From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-blk: emit udev event when device is resized
Date: Wed, 27 Feb 2013 11:07:20 +1030
Message-ID: <87vc9eegn3.fsf@rustcorp.com.au>
References: <1361473348-7660-1-git-send-email-milos.vyletel@sde.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1361473348-7660-1-git-send-email-milos.vyletel@sde.cz>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Milos Vyletel <milos.vyletel@sde.cz>, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Milos Vyletel <milos.vyletel@sde.cz> writes:

> When virtio-blk device is resized from host (using block_resize from QEMU) emit
> KOBJ_CHANGE uevent to notify guest about such change. This allows user to have
> custom udev rules which would take whatever action if such event occurs. As a
> proof of concept I've created simple udev rule that automatically resize
> filesystem on virtio-blk device.
>
> ACTION=="change", KERNEL=="vd*", \
>         ENV{RESIZE}=="1", \
>         ENV{ID_FS_TYPE}=="ext[3-4]", \
>         RUN+="/sbin/resize2fs /dev/%k"
> ACTION=="change", KERNEL=="vd*", \
>         ENV{RESIZE}=="1", \
>         ENV{ID_FS_TYPE}=="LVM2_member", \
>         RUN+="/sbin/pvresize /dev/%k"
>
> Signed-off-by: Milos Vyletel <milos.vyletel@sde.cz>

OK, I collapsed the event[] line as suggested by Asias, and applied this.

Thanks,
Rusty.

From: Milos Vyletel <milos.vyletel@sde.cz>
Subject: virtio-blk: emit udev event when device is resized

When virtio-blk device is resized from host (using block_resize from QEMU) emit
KOBJ_CHANGE uevent to notify guest about such change. This allows user to have
custom udev rules which would take whatever action if such event occurs. As a
proof of concept I've created simple udev rule that automatically resize
filesystem on virtio-blk device.

ACTION=="change", KERNEL=="vd*", \
        ENV{RESIZE}=="1", \
        ENV{ID_FS_TYPE}=="ext[3-4]", \
        RUN+="/sbin/resize2fs /dev/%k"
ACTION=="change", KERNEL=="vd*", \
        ENV{RESIZE}=="1", \
        ENV{ID_FS_TYPE}=="LVM2_member", \
        RUN+="/sbin/pvresize /dev/%k"

Signed-off-by: Milos Vyletel <milos.vyletel@sde.cz>
Tested-by: Asias He <asias@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (minor simplification)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8ad21a2..922bcb9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -539,6 +539,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
 	struct virtio_device *vdev = vblk->vdev;
 	struct request_queue *q = vblk->disk->queue;
 	char cap_str_2[10], cap_str_10[10];
+	char *envp[] = { "RESIZE=1", NULL };
 	u64 capacity, size;
 
 	mutex_lock(&vblk->config_lock);
@@ -568,6 +569,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
 
 	set_capacity(vblk->disk, capacity);
 	revalidate_disk(vblk->disk);
+	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 done:
 	mutex_unlock(&vblk->config_lock);
 }
