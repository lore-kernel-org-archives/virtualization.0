From: Jaak Ristioja <jaak@ristioja.ee>
Subject: Xorg hangs in kernelspace with qxl
Date: Wed, 1 May 2019 00:47:48 +0300
Message-ID: <20e78e41-ed6a-a8ea-07e5-f83f353b8eaa@ristioja.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello!

I'm experiencing the following task hangs at least 2-3 times a day when
using a Kubuntu desktop in KVM via a SPICE client. This has occurred
with the stock kernels in Kubuntu since Kubuntu 18.04. This makes the VM
unusable as a graphical remote desktop and the hung task prevents
Kubuntu from gracefully rebooting (e.g. "reboot" via SSH). Any ideas?

INFO: task Xorg:879 blocked for more than 120 seconds.
      Not tainted 5.0.0-13-generic #14-Ubuntu
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Xorg            D    0   879    790 0x00400004
Call Trace:
 __schedule+0x2d0/0x840
 schedule+0x2c/0x70
 schedule_preempt_disabled+0xe/0x10
 __ww_mutex_lock.isra.11+0x3e0/0x750
 __ww_mutex_lock_slowpath+0x16/0x20
 ww_mutex_lock+0x34/0x50
 ttm_eu_reserve_buffers+0x1f9/0x2e0 [ttm]
 qxl_release_reserve_list+0x67/0x150 [qxl]
 ? qxl_bo_pin+0x11d/0x200 [qxl]
 qxl_cursor_atomic_update+0x1b0/0x2e0 [qxl]
 drm_atomic_helper_commit_planes+0xb9/0x220 [drm_kms_helper]
 drm_atomic_helper_commit_tail+0x2b/0x70 [drm_kms_helper]
 commit_tail+0x67/0x70 [drm_kms_helper]
 drm_atomic_helper_commit+0x113/0x120 [drm_kms_helper]
 drm_atomic_commit+0x4a/0x50 [drm]
 drm_atomic_helper_update_plane+0xe9/0x100 [drm_kms_helper]
 __setplane_atomic+0xd6/0x120 [drm]
 drm_mode_cursor_universal+0x145/0x270 [drm]
 drm_mode_cursor_common+0x18f/0x200 [drm]
 ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
 drm_mode_cursor2_ioctl+0xe/0x10 [drm]
 drm_ioctl_kernel+0xad/0xf0 [drm]
 ? ___sys_recvmsg+0x16c/0x200
 drm_ioctl+0x233/0x410 [drm]
 ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
 ? ep_scan_ready_list.constprop.23+0x1f0/0x200
 do_vfs_ioctl+0xa9/0x640
 ? __sys_recvmsg+0x88/0xa0
 ksys_ioctl+0x67/0x90
 __x64_sys_ioctl+0x1a/0x20
 do_syscall_64+0x5a/0x110
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f3a80734417
Code: Bad RIP value.
RSP: 002b:00007ffcae8e3488 EFLAGS: 00003246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000055aaa657c610 RCX: 00007f3a80734417
RDX: 00007ffcae8e34c0 RSI: 00000000c02464bb RDI: 000000000000000e
RBP: 00007ffcae8e34c0 R08: 0000000000000040 R09: 0000000000000010
R10: 000000000000003f R11: 0000000000003246 R12: 00000000c02464bb
R13: 000000000000000e R14: 0000000000000000 R15: 000055aaa657a450

I originally filed a bug-report with more details about this to
Launchpad, but it got no activity for months:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620

Please let me know if I can help to debug this further or if more
information is needed. I'm not subscribed to the virtualization mailing
list, so please add me to the address line if required.


Best regards,
Jaak Ristioja
