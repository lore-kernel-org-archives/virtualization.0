From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 02/13] x86/paravirt: Fix output constraint macro names
Date: Fri, 17 Nov 2017 07:55:07 +0100
Message-ID: <edf5d220-26a1-997c-ee16-8e6607a3a013@suse.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
	<f8aad6bc7bcdb606b89f3d5dc5fb2303019cb3d0.1507128293.git.jpoimboe@redhat.com>
	<5d2799f9-fb5d-381e-a576-15098626201f@suse.com>
	<20171116205042.wyl6x2q5tjwmoyeg@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171116205042.wyl6x2q5tjwmoyeg@treble>
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
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, x86@kernel.org, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 16/11/17 21:50, Josh Poimboeuf wrote:
> On Wed, Oct 25, 2017 at 11:33:43AM +0200, Juergen Gross wrote:
>> On 04/10/17 17:58, Josh Poimboeuf wrote:
>>> Some of the paravirt '*_CLOBBERS' macros refer to output constraints
>>> instead of clobbers, which makes the code extra confusing.  Rename the
>>> output constraint related macros to '*_OUTPUTS'.
>>>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>>
>> I'm fine with the changes, but you might want to rename the "call_clbr"
>> parameter of ____PVOP_[V]CALL, too, e.g. to "outputs".
> 
> Yeah, good catch.
> 
>> You could then drop the "CALL_" from the macros, too.
> 
> Hm, which macros are you referring to, and why?

Good question. I think I didn't take the *CALLEE* macros into account.
So please ignore this remark.


Juergen
