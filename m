From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 21/70] x86/boot/compressed/64: Add function to map a page
 unencrypted
Date: Sat, 21 Mar 2020 16:40:31 +0100
Message-ID: <20200321154031.GN5122@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
 <20200319091407.1481-22-joro@8bytes.org>
 <alpine.DEB.2.21.2003201350300.205664@chino.kir.corp.google.com>
 <8a50c19f-aaf8-90bd-a415-0e3b71e5a010@intel.com>
 <20200320221213.GK5122@8bytes.org>
 <9b69d49f-969c-5720-5723-f89ff0e000c0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9b69d49f-969c-5720-5723-f89ff0e000c0@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, x86@kernel.org, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Mar 20, 2020 at 03:26:09PM -0700, Dave Hansen wrote:
> In any case, I thought this all came through initialize_identity_maps(),
> which does, for instance:
> 
>         mapping_info.page_flag = __PAGE_KERNEL_LARGE_EXEC | sme_me_mask;
> 
> Where:
> 
> #define __PAGE_KERNEL_LARGE_EXEC (__PP|__RW|   0|___A|   0|___D|_PSE|___G)
> 
> That looks like it has the Global bit set.  Does that not apply here
> somehow?

No, as the value of %cr4 at boot is 0x00000020, so PGE is not set and
global pages are not enabled. It wouldn't make sense anyhow, as global
pages only make sense when there are more than one address space, which
is not the case that early in boot.

Regards,

	Joerg
