From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
Date: Tue, 21 Jul 2020 14:49:57 +0200
Message-ID: <20200721124957.GD6132@suse.de>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de>
 <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de>
 <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Erdem Aktas <erdemaktas@google.com>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On Mon, Jul 20, 2020 at 06:09:19PM -0700, Erdem Aktas wrote:
> It looks like there is an expectation that the bootloader will start
> from the 64bit entry point in header_64.S. With the current patch
> series, it will not boot up if the bootloader jumps to the startup_32
> entry, which might break some default distro images.
> What are supported bootloaders and configurations?
> I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
> this reason. I am not a grub expert, so I would appreciate any
> pointers on this.

This is right, the only supported boot path is via the 64bit EFI entry
point. The reason is that SEV-ES requires support in the firmware too,
and currently only OVMF is supported in that regard. The firmware needs
to setup the AP jump-table, for example.

Other boot-paths have not been implemented. Booting via startup_32 would
require exception handling in the 32bit-part of the boot-strap code,
because verify_cpu is called there. Also an AMD specific MSR can't be
accessed there because this would #GP on non-AMD/SEV-ES machines and,
as I said, there is no way yet to handle them.

How did you get into the startup_32 entry-point, do you have an SEV-ES
BIOS supporting this? If it is really needed it could be implemented at
a later point.

Regards,

	Joerg
