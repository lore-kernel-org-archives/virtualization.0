From: "Dor Laor" <dor.laor-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] KVM paravirt_ops core infrastructure
Date: Tue, 26 Jun 2007 01:04:27 -0700
Message-ID: <64F9B87B6B770947A9F8391472E032160C73025E@ehost011-8.exch011.intermedia.net>
References: <4675F462.1010708@codemonkey.ws> <4675F4C3.6050700@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4675F4C3.6050700-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>, kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

...
+static __init struct kvm_paravirt_state *paravirt_alloc_state(void)
+{
+	struct kvm_paravirt_state *state;
+
+	state = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state)
+		goto err;
+
+	state->vmca = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!state->vmca)
+		goto err;
+
+	/* FIXME: what do I need for this to be executable on 64 bit? */
+	state->hypercall = (void *)get_zeroed_page(GFP_KERNEL);

Why do you alloc a page for the hypercall instead of using Ingo's code
below? This way it can work for 64 bit too.

Ingo's code:
/*
 * This is the vm-syscall address - to be patched by the host to
 * VMCALL (Intel) or VMMCALL (AMD), depending on the CPU model:
 */
asm (
        "       .globl hypercall_addr                   \n"
        "       .align 4                                \n"
        "       hypercall_addr:                         \n"
	"               movl $-38, %eax                 \n"
        "               ret                             \n"
);
extern unsigned char hypercall_addr[6];


And use it this way: (I used vmalloc_to_page since its compiles as a
module)
hypercall_addr_page = vmalloc_to_page(hypercall_addr);
para_state->hypercall_gpa = page_to_pfn(hypercall_addr_page) <<
PAGE_SHIFT | 
				    offset_in_page(hypercall_addr);

Regards,
	Dor.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
