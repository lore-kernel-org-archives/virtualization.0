From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 11/13] x86/paravirt: Add paravirt alternatives
	infrastructure
Date: Tue, 17 Oct 2017 10:05:47 -0400
Message-ID: <6f2a54e3-84f7-c04b-ae3c-cad6969d6652@oracle.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<39743c79546ede3073586403d0836a4f93519b0a.1507128293.git.jpoimboe@redhat.com>
	<3b9fd404-6912-3b58-db29-36202631b438@oracle.com>
	<20171006143259.rs3zh7k5tmsgesqy@treble>
	<5a49e43a-8d6b-512a-ec5a-641be7bae41d@oracle.com>
	<ed30216f-4b9e-2bc3-b1d2-36135b29d746@citrix.com>
	<a6c3be0b-35f4-8d23-4ea2-ead94a3fc69e@oracle.com>
	<b9fdc3ec-87cd-da0e-47b7-67cdae8ffb97@oracle.com>
	<CAMzpN2j_6KzT22nLmYMM3RDxF0UkSQXCisb6umBka0T2ZHwDpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMzpN2j_6KzT22nLmYMM3RDxF0UkSQXCisb6umBka0T2ZHwDpQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>, Mike Galbraith <efault@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Rusty Russell <rusty@rustcorp.com.au>, Linux Virtualization <virtualization@lists.linux-foundation.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, live-patching@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@kernel.org>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <alexander.levin@verizon.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/17/2017 09:10 AM, Brian Gerst wrote:
> On Mon, Oct 16, 2017 at 2:18 PM, Boris Ostrovsky
> <boris.ostrovsky@oracle.com> wrote:
>>
>> Replacing the macro with
>>
>> #define PV_INDIRECT(addr)       *addr  // well, it's not so much
>> indirect anymore
>>
>> makes things work. Or maybe it can be adjusted top be kept truly indirect.
> That is still an indirect call, just using absolute addressing for the
> pointer instead of RIP-relative. 

Oh, right, I've got my terminology all wrong.

-boris

>  Alternatives has very limited
> relocation capabilities.  It will only handle a single call or jmp
> replacement. Using absolute addressing is slightly less efficient
> (takes one extra byte to encode, and needs a relocation for KASLR),
> but it works just as well.  You could also relocate the instruction
> manually by adding the delta between the original and replacement code
> to the displacement.
