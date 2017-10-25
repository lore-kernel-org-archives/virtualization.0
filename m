From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 04/13] x86/paravirt: Convert DEF_NATIVE macro to GCC
	extended asm syntax
Date: Wed, 25 Oct 2017 12:03:48 +0200
Message-ID: <b322ed01-c7d4-b14a-ac02-8c0778afb242__14629.8747313724$1508925866$gmane$org@suse.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<fc26aa39d00294fce9f669ea4757135ac02eae0a.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <fc26aa39d00294fce9f669ea4757135ac02eae0a.1507128293.git.jpoimboe@redhat.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 04/10/17 17:58, Josh Poimboeuf wrote:
> In a future patch, the NATIVE_* instruction string macros will be used
> in GCC extended inline asm, which requires registers to have two '%'
> instead of one in the asm template string.  Convert the DEF_NATIVE macro
> to the GCC extended asm syntax so the NATIVE_* macros can be shared more
> broadly.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
