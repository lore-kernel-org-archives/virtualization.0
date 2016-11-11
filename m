From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Fri, 11 Nov 2016 15:35:42 +0100
Message-ID: <5fb8bee4-c742-ac78-eaf4-a60c95ffeca8__13704.8351149589$1478874984$gmane$org@suse.cz>
References: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
	<20161108223153-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161108223153-mutt-send-email-mst@kernel.org>
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
Cc: David Airlie <airlied@linux.ie>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/08/2016, 09:37 PM, Michael S. Tsirkin wrote:
> On Mon, Nov 07, 2016 at 09:43:24AM +0100, Jiri Slaby wrote:
> The following might be helpful for debugging - if kernel still will
> not stop panicing, we are looking at some kind
> of memory corruption.
> 
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 5a0f8a7..d5e1e72 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -127,7 +127,11 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_vbuffer *vbuf;
>  
>  	spin_lock(&vgdev->free_vbufs_lock);
> -	BUG_ON(list_empty(&vgdev->free_vbufs));
> +	WARN_ON(list_empty(&vgdev->free_vbufs));
> +	if (list_empty(&vgdev->free_vbufs)) {
> +		spin_unlock(&vgdev->free_vbufs_lock);
> +		return ERR_PTR(-EINVAL);
> +	}

Yeah, I already tried that, but it dies immediately after that:

WARNING: '1' is true!
------------[ cut here ]------------
WARNING: CPU: 2 PID: 5019 at
/home/latest/linux/drivers/gpu/drm/virtio/virtgpu_vq.c:130
virtio_gpu_get_vbuf+0x415/0x6a0
Modules linked in:
CPU: 2 PID: 5019 Comm: kworker/2:3 Not tainted 4.9.0-rc2-next-20161028+ #33
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
Call Trace:
 dump_stack+0xcd/0x134
 ? _atomic_dec_and_lock+0xcc/0xcc
 ? vprintk_default+0x1f/0x30
 ? printk+0x99/0xb5
 __warn+0x19e/0x1d0
 warn_slowpath_null+0x1d/0x20
 virtio_gpu_get_vbuf+0x415/0x6a0
 ? lock_pin_lock+0x4a0/0x4a0
 ? virtio_gpu_cmd_capset_cb+0x460/0x460
 ? debug_check_no_locks_freed+0x350/0x350
 virtio_gpu_cmd_resource_flush+0x8d/0x2d0
 ? virtio_gpu_cmd_set_scanout+0x310/0x310
 virtio_gpu_surface_dirty+0x364/0x930
 ? mark_held_locks+0xff/0x290
 ? virtio_gpufb_create+0xab0/0xab0
 ? _raw_spin_unlock_irqrestore+0x53/0x70
 ? trace_hardirqs_on_caller+0x46c/0x6b0
 virtio_gpu_framebuffer_surface_dirty+0x14/0x20
 drm_fb_helper_dirty_work+0x27a/0x400
 ? drm_fb_helper_is_bound+0x300/0x300
 process_one_work+0x834/0x1c90
 ? process_one_work+0x7a5/0x1c90
 ? pwq_dec_nr_in_flight+0x3a0/0x3a0
 ? worker_thread+0x1b2/0x1540
 worker_thread+0x650/0x1540
 ? process_one_work+0x1c90/0x1c90
 ? process_one_work+0x1c90/0x1c90
 kthread+0x206/0x310
 ? kthread_create_on_node+0xa0/0xa0
 ? trace_hardirqs_on+0xd/0x10
 ? kthread_create_on_node+0xa0/0xa0
 ? kthread_create_on_node+0xa0/0xa0
 ret_from_fork+0x2a/0x40
---[ end trace c723c98d382423f4 ]---
BUG: unable to handle kernel paging request at fffffc0000000000
IP: check_memory_region+0x7f/0x1a0
PGD 0

Oops: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 2 PID: 5019 Comm: kworker/2:3 Tainted: G        W
4.9.0-rc2-next-20161028+ #33
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
task: ffff8800455f4980 task.stack: ffff88001fd78000
RIP: 0010:check_memory_region+0x7f/0x1a0
RSP: 0018:ffff88001fd7f938 EFLAGS: 00010282
RAX: fffffc0000000000 RBX: dffffc0000000001 RCX: ffffffff8260afb3
RDX: 0000000000000001 RSI: 0000000000000030 RDI: fffffffffffffff4
RBP: ffff88001fd7f948 R08: fffffc0000000001 R09: dffffc0000000004
R10: 0000000000000023 R11: dffffc0000000005 R12: 0000000000000030
R13: 0000000000000000 R14: 0000000000000050 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88007dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffc0000000000 CR3: 00000000773a0000 CR4: 00000000000006e0
Call Trace:
Code: 83 fb 10 7f 3f 4d 85 db 74 34 48 bb 01 00 00 00 00 fc ff df 49 01
c3 49 01 d8 80 38 00 75 13 4d 39 c3 4c 89 c0 74 17 49 83 c0 01 <41> 80
78 ff 00 74 ed 49 89 c0 4d 85 c0 0f 85 8f 00 00 00 5b 41
RIP: check_memory_region+0x7f/0x1a0 RSP: ffff88001fd7f938
CR2: fffffc0000000000

thanks,
-- 
js
suse labs
