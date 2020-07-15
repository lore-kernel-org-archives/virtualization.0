From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 45/75] x86/sev-es: Adjust #VC IST Stack on entering
 NMI handler
Date: Wed, 15 Jul 2020 12:56:29 +0200
Message-ID: <20200715105629.GK10769@hirez.programming.kicks-ass.net>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-46-joro@8bytes.org>
 <20200715094702.GF10769@hirez.programming.kicks-ass.net>
 <20200715102653.GN16200@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200715102653.GN16200@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, Mike Stunes <mstunes@vmware.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Cfir Cohen <cfir@google.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, virtualization@lists.linux-foundation.org, Martin Radev <martin.b.radev@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>, David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 15, 2020 at 12:26:53PM +0200, Joerg Roedel wrote:
> On Wed, Jul 15, 2020 at 11:47:02AM +0200, Peter Zijlstra wrote:

> > That's pretty disguisting :-(
> 
> Yeah, but its needed because ... IST :(
> I am open for suggestions on how to make it less disgusting. Or maybe
> you like it more if you think of it as a software implementation of what
> hardware should actually do to make IST less painful.

No bright ideas, sadly..
