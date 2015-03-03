From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Tue, 3 Mar 2015 11:20:57 -0800
Message-ID: <CAB=NE6WWqP959DHN==XzrOhg5i8+xMZNmHcuBSbuyf-4tcRCtQ@mail.gmail.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
	<54F587BD.8010606@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <54F587BD.8010606@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>, Jan Beulich <JBeulich@suse.com>, Juergen Gross <jgross@suse.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 3, 2015 at 2:06 AM, David Vrabel <david.vrabel@citrix.com> wrote:
> On 03/03/15 09:40, Luis R. Rodriguez wrote:
>> Andrey,
>>
>> I believe that on Xen we should disable kasan, would like confirmation
>
> Why?  This is the first of heard of this.

Andrey chimed in here confirming this.

>> from someone on xen-devel though. Here's the thing though -- if true
>> -- I'd like to do it *properly*, where *properly* means addressing a
>> bit of architecture. A simple Kconfig slap seems rather reactive. I'd
>> like to address a way to properly ensure we don't run into this and
>> other similar issues in the future. The CR4 shadow issue was another
>> recent example issue, also introduced via v4.0 [0]. We can't keep
>> doing this reactively.
>>
>> Let's go down the rabbit hole for a bit. HAVE_ARCH_KASAN will be
>> selected on x86 when:
>>
>> if X86_64 && SPARSEMEM_VMEMMAP
>>
>> Now Xen should not have SPARSEMEM_VMEMMAP but PVOPs' goal is to enable
>
> Why?  Again, this is the first I've heard of this as well.  FWIW, all
> the Xen configs we use have SPARSEMEM_VMEMMAP enabled.

Interesting... we have config ARCH_SPARSEMEM_ENABLE depend on !XEN at
SUSE. Figured this was a generic issue. The SUSE kernels are based on
3.12 though, but anyway with it enabled I do get compile failures
because of redefinition of MAX_PHYSMEM_BITS which we provide on Xen
set to 43 for some reason (can't find that justification), so it
doesn't use the default 46 that would be used otherwise. But another
reason seems to be the lack of forward porting yet PAT support for PV
domains -- commit 47591df50 upstream which requires us to still have
the union on the pte_t, and I suppose we need ca15f20f as well...

If there is nothing else I suppose this just requires fixing up at
SUSE's end for SPARSEMEM_VMEMMAP...

--- ./arch/x86/include/asm/pgtable_64_types.h   2015-03-02
13:35:49.885257763 -0800
+++ ./arch/x86/include/mach-xen/asm/pgtable_64_types.h  2015-03-02
13:36:25.554259348 -0800
@@ -15,7 +15,7 @@
 typedef unsigned long  pgdval_t;
 typedef unsigned long  pgprotval_t;

-typedef struct { pteval_t pte; } pte_t;
+typedef union { pteval_t pte; unsigned int pte_low; } pte_t;

 #endif /* !__ASSEMBLY__ */

@@ -54,6 +54,7 @@
 #define PGDIR_MASK     (~(PGDIR_SIZE - 1))

 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
+#define MAX_PHYSMEM_BITS 43
 #define MAXMEM          _AC(__AC(1, UL) << MAX_PHYSMEM_BITS, UL)
 #define VMALLOC_START    _AC(0xffffc90000000000, UL)
 #define VMALLOC_END      _AC(0xffffe8ffffffffff, UL)

 Luis
