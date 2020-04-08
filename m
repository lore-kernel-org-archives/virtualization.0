From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Wed, 08 Apr 2020 16:12:58 +0200
Message-ID: <87k12qawwl.fsf@nanos.tec.linutronix.de>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Ankur Arora <ankur.a.arora@oracle.com> writes:
> A KVM host (or another hypervisor) might advertise paravirtualized
> features and optimization hints (ex KVM_HINTS_REALTIME) which might
> become stale over the lifetime of the guest. For instance, the
> host might go from being undersubscribed to being oversubscribed
> (or the other way round) and it would make sense for the guest
> switch pv-ops based on that.

If your host changes his advertised behaviour then you want to fix the
host setup or find a competent admin.

> This lockorture splat that I saw on the guest while testing this is
> indicative of the problem:
>
>   [ 1136.461522] watchdog: BUG: soft lockup - CPU#8 stuck for 22s! [lock_torture_wr:12865]
>   [ 1136.461542] CPU: 8 PID: 12865 Comm: lock_torture_wr Tainted: G W L 5.4.0-rc7+ #77
>   [ 1136.461546] RIP: 0010:native_queued_spin_lock_slowpath+0x15/0x220
>
> (Caused by an oversubscribed host but using mismatched native pv_lock_ops
> on the gues.)

And this illustrates what? The fact that you used a misconfigured setup.

> This series addresses the problem by doing paravirt switching at
> runtime.

You're not addressing the problem. Your fixing the symptom, which is
wrong to begin with.

> The alternative use-case is a runtime version of apply_alternatives()
> (not posted with this patch-set) that can be used for some safe subset
> of X86_FEATUREs. This could be useful in conjunction with the ongoing
> late microcode loading work that Mihai Carabas and others have been
> working on.

This has been discussed to death before and there is no safe subset as
long as this hasn't been resolved:

  https://lore.kernel.org/lkml/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/

Thanks,

        tglx
