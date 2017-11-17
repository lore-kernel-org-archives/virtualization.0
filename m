From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/13] x86/alternative: Support indirect call replacement
Date: Fri, 17 Nov 2017 11:52:10 -0800
Message-ID: <5993ab2e-c877-b566-c860-00a405a823e1@zytor.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<efabcfb022d29fb0a9ccb39380623573555c2bcb.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <efabcfb022d29fb0a9ccb39380623573555c2bcb.1507128293.git.jpoimboe@redhat.com>
Content-Language: en-US
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
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 10/04/17 08:58, Josh Poimboeuf wrote:
> Add alternative patching support for replacing an instruction with an
> indirect call.  This will be needed for the paravirt alternatives.

I have a patchset that generalizes the alternatives in what I think is a
more robust way.  I really, really want to get rid of these hacks.  Let
me clean it up an post it...

	-hpa
