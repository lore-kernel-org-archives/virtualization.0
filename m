From: Jiri Slaby <jslaby@suse.cz>
Subject: BUG: 'list_empty(&vgdev->free_vbufs)' is true!
Date: Mon, 7 Nov 2016 09:43:24 +0100
Message-ID: <bfe29853-694b-6cb5-02e7-6986a9927438@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I can relatively easily reproduce this bug:
BUG: 'list_empty(&vgdev->free_vbufs)' is true!
------------[ cut here ]------------
kernel BUG at /home/latest/linux/drivers/gpu/drm/virtio/virtgpu_vq.c:130!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
Modules linked in:
CPU: 1 PID: 355 Comm: kworker/1:2 Not tainted 4.9.0-rc2-next-20161028+ #32
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
task: ffff88007b124980 task.stack: ffff88007b8a0000
RIP: 0010:virtio_gpu_get_vbuf+0x32e/0x630
RSP: 0018:ffff88007b8a78c0 EFLAGS: 00010286
RAX: 000000000000002e RBX: 1ffff1000f714f1d RCX: 0000000000000000
RDX: 000000000000002e RSI: 0000000000000001 RDI: ffffed000f714f0e
RBP: ffff88007b8a7970 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000001 R12: 0000000000000030
R13: ffff88007caeaba8 R14: 0000000000000018 R15: ffff88007cae0000
FS:  0000000000000000(0000) GS:ffff88007dc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000601028 CR3: 000000007740d000 CR4: 00000000000006e0
Call Trace:
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bb 01 00 00 4c 89 69 e8
eb 9e 48 c7 c6 e0 d2 d1 83 48 c7 c7 20 d3 d1 83 e8 6c fb 04 ff <0f> 0b
48 c7 c7 a0 fb b0 85 e8 09 95 86 ff 48 c7 c6 c0 d3 d1 83
RIP: virtio_gpu_get_vbuf+0x32e/0x630 RSP: ffff88007b8a78c0


There is no stacktrace, as the kernel starts panicing all over the place
during its generation. Any ideas?

thanks,
-- 
js
suse labs
