From: Frediano Ziglio <fziglio@redhat.com>
Subject: Re: [Spice-devel] Xorg indefinitely hangs in kernelspace
Date: Mon, 30 Sep 2019 09:29:47 -0400 (EDT)
Message-ID: <1174991123.3693721.1569850187145.JavaMail.zimbra__43053.164000024$1569850209$gmane$org@redhat.com>
References: <92785039-0941-4626-610b-f4e3d9613069@ristioja.ee>
	<20190905071407.47iywqcqomizs3yr@sirius.home.kraxel.org>
	<e4b7d889-15f3-0c90-3b9f-d395344499c0@ristioja.ee>
	<ccafdbaf-7f8e-8616-5543-2a178bd63828@ristioja.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ccafdbaf-7f8e-8616-5543-2a178bd63828@ristioja.ee>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jaak Ristioja <jaak@ristioja.ee>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, spice-devel@lists.freedesktop.org
List-Id: virtualization@lists.linuxfoundation.org

> 
> On 05.09.19 15:34, Jaak Ristioja wrote:
> > On 05.09.19 10:14, Gerd Hoffmann wrote:
> >> On Tue, Aug 06, 2019 at 09:00:10PM +0300, Jaak Ristioja wrote:
> >>> Hello!
> >>>
> >>> I'm writing to report a crash in the QXL / DRM code in the Linux kernel.
> >>> I originally filed the issue on LaunchPad and more details can be found
> >>> there, although I doubt whether these details are useful.
> >>
> >> Any change with kernel 5.3-rc7 ?
> > 
> > Didn't try. Did you change something? I could try, but I've done so
> > before and every time this bug manifests itself with MAJOR.MINOR-rc# I
> > get asked to try version MAJOR.(MINOR+1)-rc# so I guess I could as well
> > give up?
> > 
> > Alright, I'll install 5.3-rc7, but once more it might take some time for
> > this bug to expose itself.
> 
> Just got the issue with 5.3.0-050300rc7-generic:
> 
> [124212.547403] INFO: task Xorg:797 blocked for more than 120 seconds.
> [124212.548639]       Not tainted 5.3.0-050300rc7-generic #201909021831
> [124212.549839] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [124212.547403] INFO: task Xorg:797 blocked for more than 120 seconds.
> [124212.548639]       Not tainted 5.3.0-050300rc7-generic #201909021831
> [124212.549839] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [124212.551329] Xorg            D    0   797    773 0x00404004
> [124212.551331] Call Trace:
> [124212.551336]  __schedule+0x2b9/0x6c0
> [124212.551337]  schedule+0x42/0xb0
> [124212.551338]  schedule_preempt_disabled+0xe/0x10
> [124212.551340]  __ww_mutex_lock.isra.0+0x261/0x7f0
> [124212.551345]  ? ttm_bo_init+0x6b/0x100 [ttm]
> [124212.551346]  __ww_mutex_lock_slowpath+0x16/0x20
> [124212.551347]  ww_mutex_lock+0x38/0x90
> [124212.551352]  ttm_eu_reserve_buffers+0x1cc/0x2f0 [ttm]
> [124212.551371]  qxl_release_reserve_list+0x6d/0x150 [qxl]
> [124212.551373]  ? qxl_bo_pin+0xf4/0x190 [qxl]
> [124212.551375]  qxl_cursor_atomic_update+0x1ab/0x2e0 [qxl]
> [124212.551376]  ? qxl_bo_pin+0xf4/0x190 [qxl]
> [124212.551384]  drm_atomic_helper_commit_planes+0xd5/0x220 [drm_kms_helper]
> [124212.551388]  drm_atomic_helper_commit_tail+0x2c/0x70 [drm_kms_helper]
> [124212.551392]  commit_tail+0x68/0x70 [drm_kms_helper]
> [124212.551395]  drm_atomic_helper_commit+0x118/0x120 [drm_kms_helper]
> [124212.551407]  drm_atomic_commit+0x4a/0x50 [drm]
> [124212.551411]  drm_atomic_helper_update_plane+0xea/0x100 [drm_kms_helper]
> [124212.551418]  __setplane_atomic+0xcb/0x110 [drm]
> [124212.551428]  drm_mode_cursor_universal+0x140/0x260 [drm]
> [124212.551435]  drm_mode_cursor_common+0xcc/0x220 [drm]
> [124212.551441]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> [124212.551447]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
> [124212.551452]  drm_ioctl_kernel+0xae/0xf0 [drm]
> [124212.551458]  drm_ioctl+0x234/0x3d0 [drm]
> [124212.551464]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> [124212.551466]  ? timerqueue_add+0x5f/0xa0
> [124212.551469]  ? enqueue_hrtimer+0x3d/0x90
> [124212.551471]  do_vfs_ioctl+0x407/0x670
> [124212.551473]  ? fput+0x13/0x20
> [124212.551475]  ? __sys_recvmsg+0x88/0xa0
> [124212.551476]  ksys_ioctl+0x67/0x90
> [124212.551477]  __x64_sys_ioctl+0x1a/0x20
> [124212.551479]  do_syscall_64+0x5a/0x130
> [124212.551480]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [124212.551481] RIP: 0033:0x7f07c79ee417
> [124212.551485] Code: Bad RIP value.
> [124212.551485] RSP: 002b:00007ffc6b1de1a8 EFLAGS: 00003246 ORIG_RAX:
> 0000000000000010
> [124212.551486] RAX: ffffffffffffffda RBX: 00005612f109a610 RCX:
> 00007f07c79ee417
> [124212.551487] RDX: 00007ffc6b1de1e0 RSI: 00000000c02464bb RDI:
> 000000000000000e
> [124212.551487] RBP: 00007ffc6b1de1e0 R08: 0000000000000040 R09:
> 0000000000000004
> [124212.551488] R10: 000000000000003f R11: 0000000000003246 R12:
> 00000000c02464bb
> [124212.551488] R13: 000000000000000e R14: 0000000000000000 R15:
> 00005612f10981d0
> [124333.376328] INFO: task Xorg:797 blocked for more than 241 seconds.
> [124333.377474]       Not tainted 5.3.0-050300rc7-generic #201909021831
> [124333.378609] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [124333.376328] INFO: task Xorg:797 blocked for more than 241 seconds.
> [124333.377474]       Not tainted 5.3.0-050300rc7-generic #201909021831
> [124333.378609] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [124333.380060] Xorg            D    0   797    773 0x00404004
> [124333.380062] Call Trace:
> [124333.380067]  __schedule+0x2b9/0x6c0
> [124333.380068]  schedule+0x42/0xb0
> [124333.380069]  schedule_preempt_disabled+0xe/0x10
> [124333.380070]  __ww_mutex_lock.isra.0+0x261/0x7f0
> [124333.380076]  ? ttm_bo_init+0x6b/0x100 [ttm]
> [124333.380077]  __ww_mutex_lock_slowpath+0x16/0x20
> [124333.380077]  ww_mutex_lock+0x38/0x90
> [124333.380080]  ttm_eu_reserve_buffers+0x1cc/0x2f0 [ttm]
> [124333.380083]  qxl_release_reserve_list+0x6d/0x150 [qxl]
> [124333.380085]  ? qxl_bo_pin+0xf4/0x190 [qxl]
> [124333.380087]  qxl_cursor_atomic_update+0x1ab/0x2e0 [qxl]
> [124333.380088]  ? qxl_bo_pin+0xf4/0x190 [qxl]
> [124333.380096]  drm_atomic_helper_commit_planes+0xd5/0x220 [drm_kms_helper]
> [124333.380101]  drm_atomic_helper_commit_tail+0x2c/0x70 [drm_kms_helper]
> [124333.380105]  commit_tail+0x68/0x70 [drm_kms_helper]
> [124333.380109]  drm_atomic_helper_commit+0x118/0x120 [drm_kms_helper]
> [124333.380128]  drm_atomic_commit+0x4a/0x50 [drm]
> [124333.380132]  drm_atomic_helper_update_plane+0xea/0x100 [drm_kms_helper]
> [124333.380140]  __setplane_atomic+0xcb/0x110 [drm]
> [124333.380147]  drm_mode_cursor_universal+0x140/0x260 [drm]
> [124333.380153]  drm_mode_cursor_common+0xcc/0x220 [drm]
> [124333.380160]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> [124333.380166]  drm_mode_cursor2_ioctl+0xe/0x10 [drm]
> [124333.380171]  drm_ioctl_kernel+0xae/0xf0 [drm]
> [124333.380176]  drm_ioctl+0x234/0x3d0 [drm]
> [124333.380182]  ? drm_mode_cursor_ioctl+0x60/0x60 [drm]
> [124333.380184]  ? timerqueue_add+0x5f/0xa0
> [124333.380186]  ? enqueue_hrtimer+0x3d/0x90
> [124333.380188]  do_vfs_ioctl+0x407/0x670
> [124333.380190]  ? fput+0x13/0x20
> [124333.380192]  ? __sys_recvmsg+0x88/0xa0
> [124333.380193]  ksys_ioctl+0x67/0x90
> [124333.380194]  __x64_sys_ioctl+0x1a/0x20
> [124333.380195]  do_syscall_64+0x5a/0x130
> [124333.380197]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [124333.380198] RIP: 0033:0x7f07c79ee417
> [124333.380202] Code: Bad RIP value.
> [124333.380203] RSP: 002b:00007ffc6b1de1a8 EFLAGS: 00003246 ORIG_RAX:
> 0000000000000010
> [124333.380204] RAX: ffffffffffffffda RBX: 00005612f109a610 RCX:
> 00007f07c79ee417
> [124333.380204] RDX: 00007ffc6b1de1e0 RSI: 00000000c02464bb RDI:
> 000000000000000e
> [124333.380205] RBP: 00007ffc6b1de1e0 R08: 0000000000000040 R09:
> 0000000000000004
> [124333.380205] R10: 000000000000003f R11: 0000000000003246 R12:
> 00000000c02464bb
> [124333.380206] R13: 000000000000000e R14: 0000000000000000 R15:
> 00005612f10981d0
> 
> 
> Best regards,
> J

Hi Jaak,
  Why didn't you update bug at https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1813620?
I know it can seem tedious but would help tracking it.
It seems you are having this issue since quite some time and with
multiple kernel versions.
Are you still using Kubuntu? Maybe it happens more with KDE.
From the Kernel log looks like a dead lock.

Frediano
