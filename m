From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 2/5] Paravirt cpu batching.patch
Date: Tue, 12 Dec 2006 14:54:30 -0800
Message-ID: <20061212225430.GC10475@sequoia.sous-sol.org>
References: <200612122234.kBCMYZD1023321@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200612122234.kBCMYZD1023321@zach-dev.vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, Chuck Ebbert <76306.1226@compuserve.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> The VMI ROM has a mode where hypercalls can be queued and batched.  This =
turns
> out to be a significant win during context switch, but must be done at a
> specific point before side effects to CPU state are visible to subsequent
> instructions.  This is similar to the MMU batching hooks already provided.
> The same hooks could be used by the Xen backend to implement a context sw=
itch
> multicall.
> =

> To explain a bit more about lazy modes in the paravirt patches, basically=
, the
> idea is that only one of lazy CPU or MMU mode can be active at any given =
time.
> Lazy MMU mode is similar to this lazy CPU mode, and allows for batching of
> multiple PTE updates (say, inside a remap loop), but to avoid keeping som=
e kind
> of state machine about when to flush cpu or mmu updates, we just allow on=
e or
> the other to be active.  Although there is no real reason a more comprehe=
nsive
> scheme could not be implemented, there is also no demonstrated need for t=
his
> extra complexity.
> =

> Signed-off-by: Zachary Amsden <zach@vmware.com>
> =

> --- a/arch/i386/kernel/process.c	Tue Dec 12 13:50:50 2006 -0800
> +++ b/arch/i386/kernel/process.c	Tue Dec 12 13:50:53 2006 -0800
> @@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
>  	load_TLS(next, cpu);
>  =

>  	/*
> +	 * Restore IOPL if needed.
> +	 */
> +	if (unlikely(prev->iopl !=3D next->iopl))
> +		set_iopl_mask(next->iopl);

Small sidenote that this bit undoes a recent change from Chuck Ebbert, which
killed iopl_mask update via hypervisor.

thanks,
-chris
