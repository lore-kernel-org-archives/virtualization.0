From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 11:50:42 +1030
Message-ID: <87y4nllb85.fsf@rustcorp.com.au>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150225111318.0040536b@oc7435384737.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Huth <thuth@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Thomas Huth <thuth@linux.vnet.ibm.com> writes:
>  Hi all,
>
> with the recent kernel 3.19, I get a kernel warning when I start my
> KVM guest on s390 with virtio balloon enabled:

The deeper problem is that virtio_ccw_get_config just silently fails on
OOM.

Neither get_config nor set_config are expected to fail.

Cornelia, I think ccw and config_area should be allocated inside vcdev.
You could either use pointers, or simply allocate vcdev with GDP_DMA.

This would avoid the kmalloc inside these calls.

Thanks,
Rusty.

>
> [    0.839687] do not call blocking ops when !TASK_RUNNING; state=1 set at
>                [<0000000000174a1e>] prepare_to_wait_event+0x7e/0x108
> [    0.839694] ------------[ cut here ]------------
> [    0.839697] WARNING: at kernel/sched/core.c:7326
> [    0.839698] Modules linked in:
> [    0.839702] CPU: 0 PID: 46 Comm: vballoon Not tainted 3.19.0 #233
> [    0.839705] task: 00000000021d0000 ti: 00000000021d8000 task.ti: 00000000021d8000
> [    0.839707] Krnl PSW : 0704c00180000000 000000000015bf8e (__might_sleep+0x8e/0x98)
> [    0.839713]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 EA:3
> Krnl GPRS: 000000000000000d 00000000021d0000 0000000000000071 0000000000000001
> [    0.839718]            0000000000675ace 0000000001998c50 cccccccccccccccc cccccccccccccccc
> [    0.839720]            0000000000982134 000000000058f824 0000000000a008a8 0000000000000000
> [    0.839722]            00000000000004d9 00000000007ea992 000000000015bf8a 00000000021dbc28
> [    0.839731] Krnl Code: 000000000015bf7e: c0200033e838	larl	%r2,7d8fee
>            000000000015bf84: c0e50028cd62	brasl	%r14,675a48
>           #000000000015bf8a: a7f40001		brc	15,15bf8c
>           >000000000015bf8e: 9201a000		mvi	0(%r10),1
>            000000000015bf92: a7f4ffe2		brc	15,15bf56
>            000000000015bf96: 0707		bcr	0,%r7
>            000000000015bf98: ebdff0800024	stmg	%r13,%r15,128(%r15)
>            000000000015bf9e: a7f13fe0		tmll	%r15,16352
> [    0.839749] Call Trace:
> [    0.839751] ([<000000000015bf8a>] __might_sleep+0x8a/0x98)
> [    0.839756]  [<000000000028a562>] __kmalloc+0x272/0x350
> [    0.839759]  [<000000000058f824>] virtio_ccw_get_config+0x3c/0x100
> [    0.839762]  [<000000000049fcb0>] balloon+0x1b8/0x330
> [    0.839765]  [<00000000001529c8>] kthread+0x120/0x138
> [    0.839767]  [<0000000000683c22>] kernel_thread_starter+0x6/0xc
> [    0.839770]  [<0000000000683c1c>] kernel_thread_starter+0x0/0xc
> [    0.839772] no locks held by vballoon/46.
> [    0.839773] Last Breaking-Event-Address:
> [    0.839776]  [<000000000015bf8a>] __might_sleep+0x8a/0x98
> [    0.839778] ---[ end trace d27fcdfa27273d7c ]---
>
> The problem seems to be this code in balloon() in
> drivers/virtio/virtio_balloon.c:
>
> 	wait_event_interruptible(vb->config_change,
> 				 (diff = towards_target(vb)) != 0
> 				 || vb->need_stats_update
> 				 || kthread_should_stop()
> 				 || freezing(current));
>
> wait_event_interruptible() sets the state of the current task to
> TASK_INTERRUPTIBLE, then checks the condition. The condition contains
> towards_target() which reads the virtio config space via virtio_cread().
> On s390, this then triggers virtio_ccw_get_config() - and this function
> calls some other functions again that might sleep (e.g. kzalloc or
> wait_event in ccw_io_helper) ... and this causes the new kernel warning
> message with kernel 3.19.
>
> I think it would be quite difficult or at least ugly to rewrite
> virtio_ccw_get_config() so that it does not call sleepable functions
> anymore. So would it be feasible to rewrite the balloon() function that
> it does not call the towards_target() in its wait_event condition
> anymore? I am unfortunately not that familiar with the balloon code
> semantics, so any help is very appreciated here!
>
>  Thanks,
>   Thomas
