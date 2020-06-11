From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v3 47/75] x86/sev-es: Add Runtime #VC Exception Handler
Date: Thu, 11 Jun 2020 10:38:48 -0700
Message-ID: <20200611173848.GK29918@linux.intel.com>
References: <20200428151725.31091-1-joro@8bytes.org>
 <20200428151725.31091-48-joro@8bytes.org>
 <20200523075924.GB27431@zn.tnic>
 <20200611114831.GA11924@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200611114831.GA11924@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, x86@kernel.org, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jun 11, 2020 at 01:48:31PM +0200, Joerg Roedel wrote:
> On Sat, May 23, 2020 at 09:59:24AM +0200, Borislav Petkov wrote:
> > On Tue, Apr 28, 2020 at 05:16:57PM +0200, Joerg Roedel wrote:
> > > +	/*
> > > +	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
> > > +	 * There is no need for it to be atomic, because nothing is written to
> > > +	 * the GHCB between the read and the write of ghcb_active. So it is safe
> > > +	 * to use it when a nested #VC exception happens before the write.
> > > +	 */
> > 
> > Looks liks that is that text... support for nested #VC exceptions.
> > I'm sure this has come up already but why do we even want to support
> > nested #VCs? IOW, can we do without them first or are they absolutely
> > necessary?
> > 
> > I'm guessing VC exceptions inside the VC handler but what are the
> > sensible use cases?
> 
> The most important use-case is #VC->NMI->#VC. When an NMI hits while the
> #VC handler uses the GHCB and the NMI handler causes another #VC, then
> the contents of the GHCB needs to be backed up, so that it doesn't
> destroy the GHCB contents of the first #VC handling path.

Isn't it possible for the #VC handler to hit a #PF, e.g. on copy_from_user()
in insn_fetch_from_user()?  If that happens, what prevents the #PF handler
from hitting a #VC?  AIUI, do_vmm_communication() panics if the backup GHCB
is already in use, e.g. #VC->#PF->#VC->NMI->#VC would be fatal.
