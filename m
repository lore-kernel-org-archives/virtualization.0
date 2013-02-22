From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 09:30:28 -0800
Message-ID: <5127AB34.8090406@linux.vnet.ibm.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130222165531.GA29308@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, linux-pm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@j>
List-Id: virtualization@lists.linuxfoundation.org

On 02/22/2013 08:55 AM, Konrad Rzeszutek Wilk wrote:
> On Thu, Feb 21, 2013 at 04:34:06PM -0800, H. Peter Anvin wrote:
>> Hi Linus,
>>
>> This is a huge set of several partly interrelated (and concurrently
>> developed) changes, which is why the branch history is messier than
>> one would like.
>>
>> The *really* big items are two humonguous patchsets mostly developed
>> by Yinghai Lu at my request, which completely revamps the way we
>> create initial page tables.  In particular, rather than estimating how
>> much memory we will need for page tables and then build them into that
>> memory -- a calculation that has shown to be incredibly fragile -- we
>> now build them (on 64 bits) with the aid of a "pseudo-linear mode" --
>> a #PF handler which creates temporary page tables on demand.
>>
>> This has several advantages:
>>
>> 1. It makes it much easier to support things that need access to
>>    data very early (a followon patchset uses this to load microcode
>>    way early in the kernel startup).
>>
>> 2. It allows the kernel and all the kernel data objects to be invoked
>>    from above the 4 GB limit.  This allows kdump to work on very large
>>    systems.
>>
>> 3. It greatly reduces the difference between Xen and native (Xen's
>>    equivalent of the #PF handler are the temporary page tables created
>>    by the domain builder), eliminating a bunch of fragile hooks.
>>
>> The patch series also gets us a bit closer to W^X.
>>
>> Additional work in this pull is the 64-bit get_user() work which you
>> were also involved with, and a bunch of cleanups/speedups to
>> __phys_addr()/__pa().
> 
> Looking at figuring out which of the patches in the branch did this, but
> with this merge I am getting a crash with a very simple PV guest (booted with
> one 1G):
> 
> Call Trace:
>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a  <--
>   [<ffffffff8103feba>] xen_get_user_pgd+0x5a 
>   [<ffffffff81042d27>] xen_write_cr3+0x77 
>   [<ffffffff81ad2d21>] init_mem_mapping+0x1f9 
>   [<ffffffff81ac293f>] setup_arch+0x742 
>   [<ffffffff81666d71>] printk+0x48 
>   [<ffffffff81abcd62>] start_kernel+0x90 
>   [<ffffffff8109416b>] __add_preferred_console.clone.1+0x9b 
>   [<ffffffff81abc5f7>] x86_64_start_reservations+0x2a 
>   [<ffffffff81abf0c7>] xen_start_kernel+0x564 

Do you have CONFIG_DEBUG_VIRTUAL on?

You're probably hitting the new BUG_ON() in __phys_addr().  It's
intended to detect places where someone is doing a __pa()/__phys_addr()
on an address that's outside the kernel's identity mapping.

There are a lot of __pa() calls around there, but from the looks of it,
it's this code:

static pgd_t *xen_get_user_pgd(pgd_t *pgd)
{
...
        if (offset < pgd_index(USER_LIMIT)) {
                struct page *page = virt_to_page(pgd_page);

I'm a bit fuzzy on exactly what the code is trying to do here.  It could
mean either that the identity mapping isn't set up enough yet, or that
__pa() is getting called on a bogus address.

I'm especially fuzzy on why we'd be calling anything that's looking at
userspace pagetables (xen_get_user_pgd() ??) this early in boot.
