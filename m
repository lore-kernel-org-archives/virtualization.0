From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Sun, 22 Apr 2007 09:20:26 -0700
Message-ID: <462B8B4A.6060408@goop.org>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Yes.  Has anyone thought more about David Miller's suggesting of just
> using the linker and not doing the fancy binary replacement?
>
> Especially if you are beginning to reimplement the linker anyway.

I did spend some effort on it.  The first stumbling block was getting
the reloc info into the vmlinux itself, rather than putting it in the
bzImage wrapper.  It was getting into a complex kallsyms-like
arrangement, which I wasn't feeling equipped to solve.

But one of the objections to making paravirt_ops calls where there would
otherwise be small inline functions is that the calls significantly add
to the register pressure and therefore would result in worse code.  This
is particularly acute in the assember parts, since there are places in
entry.S where paravirt operations need to be performed, but there are no
available registers.

We currently deal with that by including push/pops around the actual
indirect callsite, which the patcher can either choose to overwrite (if
the inserted sequence doesn't clobber registers anyway), or replace with
a set which is appropriate for the callsite and the inserted code.

Also, in many cases we can usefully patch inline code and eliminate the
need for any call at all.  To do this, we need to know 1) the start and
size of the replacable code, 2) the register environment at that site,
and 3) what to actually put there.

The reloc info only gives us 3 (by looking at the call/jmp instruction's
target), and 1 to a limited extent (we get 5 bytes). Unfortunately, 5
bytes is too small for anything except patching in native versions, and
the surrounding generated code will still assume the patched code will
clobber all the normal C caller-save registers.

    J
