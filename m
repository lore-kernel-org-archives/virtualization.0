From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 02/13] x86/paravirt: Fix output constraint macro names
Date: Thu, 16 Nov 2017 14:50:42 -0600
Message-ID: <20171116205042.wyl6x2q5tjwmoyeg@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<f8aad6bc7bcdb606b89f3d5dc5fb2303019cb3d0.1507128293.git.jpoimboe@redhat.com>
	<5d2799f9-fb5d-381e-a576-15098626201f@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5d2799f9-fb5d-381e-a576-15098626201f@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 25, 2017 at 11:33:43AM +0200, Juergen Gross wrote:
> On 04/10/17 17:58, Josh Poimboeuf wrote:
> > Some of the paravirt '*_CLOBBERS' macros refer to output constraints
> > instead of clobbers, which makes the code extra confusing.  Rename the
> > output constraint related macros to '*_OUTPUTS'.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> I'm fine with the changes, but you might want to rename the "call_clbr"
> parameter of ____PVOP_[V]CALL, too, e.g. to "outputs".

Yeah, good catch.

> You could then drop the "CALL_" from the macros, too.

Hm, which macros are you referring to, and why?

-- 
Josh
