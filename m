From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Should SEV-ES #VC use IST? (Re: [PATCH] Allow RDTSC and RDTSCP
 from userspace)
Date: Tue, 23 Jun 2020 18:13:45 +0200
Message-ID: <20200623161345.GQ4817@hirez.programming.kicks-ass.net>
References: <20200623120433.GB14101@suse.de>
 <20200623125201.GG4817@hirez.programming.kicks-ass.net>
 <20200623134003.GD14101@suse.de>
 <20200623135916.GI4817@hirez.programming.kicks-ass.net>
 <20200623145344.GA117543@hirez.programming.kicks-ass.net>
 <20200623145914.GF14101@suse.de>
 <20200623152326.GL4817@hirez.programming.kicks-ass.net>
 <56af2f70-a1c6-aa64-006e-23f2f3880887@citrix.com>
 <20200623155204.GO4817@hirez.programming.kicks-ass.net>
 <dae40b7b-e584-1ab4-2ebe-13526cdec946@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <dae40b7b-e584-1ab4-2ebe-13526cdec946@intel.com>
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
Cc: Juergen Gross <JGross@suse.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm list <kvm@vger.kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <sean.j.christopherson@intel.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>, X86 ML <x86@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 23, 2020 at 09:03:56AM -0700, Dave Hansen wrote:
> On 6/23/20 8:52 AM, Peter Zijlstra wrote:
> > Isn't current #MC unconditionally fatal from kernel? But yes, I was
> > sorta aware people want that changed.
> 
> Not unconditionally.  copy_to_iter_mcsafe() is a good example of one
> thing we _can_ handle.

Urgh, I thought that stuff was still pending.

Anyway, the important thing is that it is fatal if we hit early NMI.
Which I think still holds.
