From: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 01/11] kexec: introduce kexec_ops struct
Date: Fri, 23 Nov 2012 10:53:18 +0000
Message-ID: <1353667998.13542.220.camel__22264.0916159891$1353668028$gmane$org@zakaz.uk.xensource.com>
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
	<1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
	<87lidwtego.fsf@xmission.com>
	<20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
	<87txshx28b.fsf@xmission.com> <50AE62E9.3000602@zytor.com>
	<50AF567402000078000AABF6@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50AF567402000078000AABF6@nat28.tlf.novell.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@suse.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2012-11-23 at 09:56 +0000, Jan Beulich wrote:
> >>> On 22.11.12 at 18:37, "H. Peter Anvin" <hpa@zytor.com> wrote:
> > I actually talked to Ian Jackson at LCE, and mentioned among other 

That was me actually (this happens surprisingly often ;-)).

> > things the bogosity of requiring a PUD page for three-level paging in 
> > Linux -- a bogosity which has spread from Xen into native.  It's a page 
> > wasted for no good reason, since it only contains 32 bytes worth of 
> > data, *inherently*.  Furthermore, contrary to popular belief, it is 
> > *not* pa page table per se.
> > 
> > Ian told me: "I didn't know we did that, and we shouldn't have to." 
> > Here we have suffered this overhead for at least six years, ...
> 
> Even the Xen kernel only needs the full page when running on a
> 64-bit hypervisor (now that we don't have a 32-bit hypervisor
> anymore, that of course basically means always).

I took an, admittedly very brief, look at it on the plane on the way
home and it seems like the requirement for a complete page on the
pvops-xen side comes from the !SHARED_KERNEL_PMD stuff (so still a Xen
related thing). This requires a struct page for the list_head it
contains (see pgd_list_add et al) rather than because of the use of the
page as a pgd as such.

>  But yes, I too
> never liked this enforced over-allocation for native kernels (and
> was surprised that it was allowed in at all).

Completely agreed.

I did wonder if just doing something like:
-	pgd = (pgd_t *)__get_free_page(PGALLOC_GFP);
+	if (SHARED_KERNEL_PMD)
+		pgd = some_appropriate_allocation_primitive(sizeof(*pgd));
+	else
+		pgd = (pgd_t *)__get_free_page(PGALLOC_GFP);

to pgd_alloc (+ the equivalent for the error path & free case, create
helper funcs as desired etc) would be sufficient to remove the over
allocation for the native case but haven't had time to properly
investigate.

Alternatively push the allocation down into paravirt_pgd_alloc to
taste :-/

Ian.
