From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/13] x86/paravirt: Convert native patch assembly code
	strings to macros
Date: Thu, 16 Nov 2017 15:04:05 -0600
Message-ID: <20171116210405.xzagz5o5sphivldt@treble>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<e4cea2b8aa8ca23122d9c807784ca62ee6cbbff8.1507128293.git.jpoimboe@redhat.com>
	<a1c4f192-f141-7488-ae6e-ad07101ba8da@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a1c4f192-f141-7488-ae6e-ad07101ba8da@suse.com>
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

On Wed, Oct 25, 2017 at 11:46:18AM +0200, Juergen Gross wrote:
> On 04/10/17 17:58, Josh Poimboeuf wrote:
> > Convert the hard-coded native patch assembly code strings to macros to
> > facilitate sharing common code between 32-bit and 64-bit.
> > 
> > These macros will also be used by a future patch which requires the GCC
> > extended asm syntax of two '%' characters instead of one when specifying
> > a register name.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> 
> Mind adding another patch to merge the now nearly identical
> paravirt_patch_32.c and paravirt_patch_64.c either into paravirt.c
> or paravirt_patch.c? This would require only very few #ifdef.

Good idea, will do.

-- 
Josh
