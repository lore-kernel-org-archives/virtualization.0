From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Wed, 15 Apr 2009 18:12:22 +0930
Message-ID: <200904151812.23318.rusty@rustcorp.com.au>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1239273165.5687.10.camel@odie.local>
	<1239639939.31741.8.camel@zetabook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <1239639939.31741.8.camel@zetabook>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 14 Apr 2009 01:55:39 am Matias Zabaljauregui wrote:
> > > BTW, shouldn't this also affect my test boxes if this were the case?
> > > 
> > Could be the timing differences between our boxes I guess?
> 
> I haven't read COW code, but I cannot figure out how CPU timing
> differences could affect a logic driven by faults. I will investigate
> further and let you know if I can yield any conclusion.

I first thought it was guest image layout, until I reproduced it completely
accidentally here.

Matias, can I have a Signed-off-by for your patch (enhanced with comment
below):

Subject: lguest: fix KVM-style hypercalls with vmlinux images
Date: Wed, 08 Apr 2009 17:58:39 -0300
From: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Impact: fix guest crash 'lguest: unhandled trap 6 at 0x418726 (0x0)'

The Launcher mmaps the kernel image.  The Guest executes and
immediately faults in the first text page (read-only).  Then it hits a
hypercall, and we rewrite that hypercall, causing a copy-on-write.
But the Guest pagetables still refer to the old page: we fault again,
but as Host we see the hypercall already rewritten, and pass the fault
back to the Guest.  The Guest hasn't set up an IDT yet, so we kill it.

This doesn't happen with bzImages: they unpack themselves and so the
text pages are already read-write.

Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Tested-by: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
---
 drivers/lguest/x86/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/lguest/x86/core.c b/drivers/lguest/x86/core.c
index a6b7176..b4747f7 100644
--- a/drivers/lguest/x86/core.c
+++ b/drivers/lguest/x86/core.c
@@ -324,6 +324,11 @@ static void rewrite_hypercall(struct lg_cpu *cpu)
 	u8 insn[3] = {0xcd, 0x1f, 0x90};
 
 	__lgwrite(cpu, guest_pa(cpu, cpu->regs->eip), insn, sizeof(insn));
+	/* The above write might have caused a copy of that page to be made
+	 * (if it was read-only).  We need to make sure the Guest has
+	 * up-to-date pagetables.  As this doesn't happen often, we can just
+	 * drop them all. */
+	guest_pagetable_clear_all(cpu);
 }
 
 static bool is_hypercall(struct lg_cpu *cpu)
