From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Thu, 31 May 2007 11:02:27 +1000
Message-ID: <1180573347.30202.135.camel@localhost.localdomain>
References: <465D8F03.7000201@us.ibm.com>  <465D8FA7.9050600@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465D8FA7.9050600@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-05-30 at 09:52 -0500, Anthony Liguori wrote:
> This patch adds the basic infrastructure for paravirtualizing a KVM
> guest.

Hi Anthony!

	Nice patch, comments below.

> Discovery of running under KVM is done by sharing a page of memory
> between
> the guest and host (initially through an MSR write).

I missed the shared page in this patch?  If you are going to do that,
perhaps putting the hypercall magic in that page is a good idea?

> +extern unsigned char hypercall_addr[4];

Perhaps in a header?

> +asm (
> +       ".globl hypercall_addr\n"
> +       ".align 4\n"
> +       "hypercall_addr:\n"
> +       "movl $-38, %eax\n"
> +       "ret\n"
> +);

I don't think we want the hypercall returning Linux error numbers, and
magic numbers are bad too.  ud2 here I think.

> +       para_state->guest_version = KVM_PARA_API_VERSION;
> +       para_state->host_version = -1;
> +       para_state->size = sizeof(*para_state);
> +       para_state->ret = 0;
> +       para_state->hypercall_gpa = __pa(hypercall_addr);

Two versions, size *and* ret?  This seems like overkill...

> +       if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
> +               printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
> +               return -ENOENT;
> +       }

How about printk(KERN_INFO "I am not a KVM guest\n");?

> +static int __init kvm_guest_init(void)
> +{
> +       int rc;
> +
> +       rc = kvm_guest_register_para(smp_processor_id());
> +       if (rc) {
> +               printk(KERN_INFO "paravirt KVM unavailable\n");

Double-printk when KVM isn't detected seems overkill.  Perhaps you could
just fold this all into one function...

(Personal gripe: I consider a variable named "rc" to be an admission of
semantic defeat... "err" would be better here...)

Thanks!
Rusty.
