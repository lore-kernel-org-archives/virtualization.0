From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 09:33:34 -0800
Message-ID: <5127ABEE.8080303@zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<5127AB34.8090406@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5127AB34.8090406@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, Fenghua Yu <fenghua.yu@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fu>
List-Id: virtualization@lists.linuxfoundation.org

On 02/22/2013 09:30 AM, Dave Hansen wrote:
>
> Do you have CONFIG_DEBUG_VIRTUAL on?
>
> You're probably hitting the new BUG_ON() in __phys_addr().  It's
> intended to detect places where someone is doing a __pa()/__phys_addr()
> on an address that's outside the kernel's identity mapping.
>
> There are a lot of __pa() calls around there, but from the looks of it,
> it's this code:
>
> static pgd_t *xen_get_user_pgd(pgd_t *pgd)
> {
> ...
>          if (offset < pgd_index(USER_LIMIT)) {
>                  struct page *page = virt_to_page(pgd_page);
>
> I'm a bit fuzzy on exactly what the code is trying to do here.  It could
> mean either that the identity mapping isn't set up enough yet, or that
> __pa() is getting called on a bogus address.
>
> I'm especially fuzzy on why we'd be calling anything that's looking at
> userspace pagetables (xen_get_user_pgd() ??) this early in boot.
>

Ah yes, of course.

This is unrelated to the early page table setups, which is why it didn't 
trip in Konrad's earlier testing.

This debugging bits has already found real bugs in the kernel, and this 
might be another.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
