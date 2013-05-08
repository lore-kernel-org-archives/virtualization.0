From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v2] KVM: Fix kvm_irqfd_init initialization
Date: Wed, 8 May 2013 08:49:04 +0200
Message-ID: <20130508084904.69ffe433__39783.065513666$1367995767$gmane$org@gondolin>
References: <20130507160107.GB23915@redhat.com>
	<1367981849-32717-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367981849-32717-1-git-send-email-asias@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S.
	Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  8 May 2013 10:57:29 +0800
Asias He <asias@redhat.com> wrote:

> In commit a0f155e96 'KVM: Initialize irqfd from kvm_init()', when
> kvm_init() is called the second time (e.g kvm-amd.ko and kvm-intel.ko),
> kvm_arch_init() will fail with -EEXIST, then kvm_irqfd_exit() will be
> called on the error handling path. This way, the kvm_irqfd system will
> not be ready.
> 
> This patch fix the following:
> 
> BUG: unable to handle kernel NULL pointer dereference at           (null)
> IP: [<ffffffff81c0721e>] _raw_spin_lock+0xe/0x30
> PGD 0
> Oops: 0002 [#1] SMP
> Modules linked in: vhost_net
> CPU 6
> Pid: 4257, comm: qemu-system-x86 Not tainted 3.9.0-rc3+ #757 Dell Inc. OptiPlex 790/0V5HMK
> RIP: 0010:[<ffffffff81c0721e>]  [<ffffffff81c0721e>] _raw_spin_lock+0xe/0x30
> RSP: 0018:ffff880221721cc8  EFLAGS: 00010046
> RAX: 0000000000000100 RBX: ffff88022dcc003f RCX: ffff880221734950
> RDX: ffff8802208f6ca8 RSI: 000000007fffffff RDI: 0000000000000000
> RBP: ffff880221721cc8 R08: 0000000000000002 R09: 0000000000000002
> R10: 00007f7fd01087e0 R11: 0000000000000246 R12: ffff8802208f6ca8
> R13: 0000000000000080 R14: ffff880223e2a900 R15: 0000000000000000
> FS:  00007f7fd38488e0(0000) GS:ffff88022dcc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000022309f000 CR4: 00000000000427e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process qemu-system-x86 (pid: 4257, threadinfo ffff880221720000, task ffff880222bd5640)
> Stack:
>  ffff880221721d08 ffffffff810ac5c5 ffff88022431dc00 0000000000000086
>  0000000000000080 ffff880223e2a900 ffff8802208f6ca8 0000000000000000
>  ffff880221721d48 ffffffff810ac8fe 0000000000000000 ffff880221734000
> Call Trace:
>  [<ffffffff810ac5c5>] __queue_work+0x45/0x2d0
>  [<ffffffff810ac8fe>] queue_work_on+0x8e/0xa0
>  [<ffffffff810ac949>] queue_work+0x19/0x20
>  [<ffffffff81009b6b>] irqfd_deactivate+0x4b/0x60
>  [<ffffffff8100a69d>] kvm_irqfd+0x39d/0x580
>  [<ffffffff81007a27>] kvm_vm_ioctl+0x207/0x5b0
>  [<ffffffff810c9545>] ? update_curr+0xf5/0x180
>  [<ffffffff811b66e8>] do_vfs_ioctl+0x98/0x550
>  [<ffffffff810c1f5e>] ? finish_task_switch+0x4e/0xe0
>  [<ffffffff81c054aa>] ? __schedule+0x2ea/0x710
>  [<ffffffff811b6bf7>] sys_ioctl+0x57/0x90
>  [<ffffffff8140ae9e>] ? trace_hardirqs_on_thunk+0x3a/0x3c
>  [<ffffffff81c0f602>] system_call_fastpath+0x16/0x1b
> Code: c1 ea 08 38 c2 74 0f 66 0f 1f 44 00 00 f3 90 0f b6 03 38 c2 75 f7 48 83 c4 08 5b c9 c3 55 48 89 e5 66 66 66 66 90 b8 00 01 00 00 <f0> 66 0f c1 07 89 c2 66 c1 ea 08 38 c2 74 0c 0f 1f 00 f3 90 0f
> RIP  [<ffffffff81c0721e>] _raw_spin_lock+0xe/0x30
> RSP <ffff880221721cc8>
> CR2: 0000000000000000
> ---[ end trace 13fb1e4b6e5ab21f ]---
> 
> Signed-off-by: Asias He <asias@redhat.com>

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>

> ---
>  virt/kvm/kvm_main.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8fd325a..85b93d2 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3078,13 +3078,21 @@ int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
>  	int r;
>  	int cpu;
> 
> -	r = kvm_irqfd_init();
> -	if (r)
> -		goto out_irqfd;
>  	r = kvm_arch_init(opaque);
>  	if (r)
>  		goto out_fail;
> 
> +	/*
> +	 * kvm_arch_init makes sure there's at most one caller
> +	 * for architectures that support multiple implementations,
> +	 * like intel and amd on x86.
> +	 * kvm_arch_init must be called before kvm_irqfd_init to avoid creating
> +	 * conflicts in case kvm is already setup for another implementation.
> +	 */
> +	r = kvm_irqfd_init();
> +	if (r)
> +		goto out_irqfd;
> +
>  	if (!zalloc_cpumask_var(&cpus_hardware_enabled, GFP_KERNEL)) {
>  		r = -ENOMEM;
>  		goto out_free_0;
> @@ -3159,10 +3167,10 @@ out_free_1:
>  out_free_0a:
>  	free_cpumask_var(cpus_hardware_enabled);
>  out_free_0:
> -	kvm_arch_exit();
> -out_fail:
>  	kvm_irqfd_exit();
>  out_irqfd:
> +	kvm_arch_exit();
> +out_fail:
>  	return r;
>  }
>  EXPORT_SYMBOL_GPL(kvm_init);
