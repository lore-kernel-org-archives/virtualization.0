From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] kasan_map_early_shadow() on Xen
Date: Tue, 3 Mar 2015 10:06:53 +0000
Message-ID: <54F587BD.8010606__14372.2545625225$1425377241$gmane$org@citrix.com>
References: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAB=NE6Xs5fepzNtymzT4CueeJZ0KMPETpda114DpL4eMtDswtw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luis R. Rodriguez" <mcgrof@suse.com>, Andrey Ryabinin <a.ryabinin@samsung.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/03/15 09:40, Luis R. Rodriguez wrote:
> Andrey,
> 
> I believe that on Xen we should disable kasan, would like confirmation

Why?  This is the first of heard of this.

> from someone on xen-devel though. Here's the thing though -- if true
> -- I'd like to do it *properly*, where *properly* means addressing a
> bit of architecture. A simple Kconfig slap seems rather reactive. I'd
> like to address a way to properly ensure we don't run into this and
> other similar issues in the future. The CR4 shadow issue was another
> recent example issue, also introduced via v4.0 [0]. We can't keep
> doing this reactively.
> 
> Let's go down the rabbit hole for a bit. HAVE_ARCH_KASAN will be
> selected on x86 when:
> 
> if X86_64 && SPARSEMEM_VMEMMAP
> 
> Now Xen should not have SPARSEMEM_VMEMMAP but PVOPs' goal is to enable

Why?  Again, this is the first I've heard of this as well.  FWIW, all
the Xen configs we use have SPARSEMEM_VMEMMAP enabled.

David

> distributions to be able to have a single binary kernels and let the
> rest be figured out, so we can't just disable SPARSEMEM_VMEMMAP for
> Xen alone, we want to build Xen.. or part of Xen and perhaps keep
> SPARSEMEM_VMEMMAP, and only later figure things out.
> 
> How do we do this cleanly and avoid future reactive measures? If the
> answer is not upon us, I'd like to at least highlight the issue so
> that in case we do come up with something its no surprise PVOPs is
> falling short for that single binary pipe dream right now.
> 
> [0] https://lkml.org/lkml/2015/2/23/328
> 
>  Luis
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xen.org
> http://lists.xen.org/xen-devel
> 
