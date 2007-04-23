From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 14:29:17 -0700
Message-ID: <462D252D.5090008@goop.org>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org> <462D1CBC.6050405@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D1CBC.6050405@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> There are two specific examples, both of which are real BUGs.  If
> there is not enough space to do generic patching to a direct function
> call, then it is a bug, since there would not have even been enough
> space to do an indirect call in the first place.  Obviously, with the
> i386 ISA, this is impossible as long as there was an indirect in the
> first place.  But an attempt to place native "cli" inline with no
> padding, to use as a patch point, would fire this BUG and rightly so.

Well, the BUG is if the patch-size is smaller than sizeof(indirect
call).  Or more generally, if the patch site contains bogus crud.  But I
don't think checking for that in the patcher makes a great deal of sense.

> The second BUG I added is also justified.  If the patch point has a
> smaller than normal clobber list, then the original indirect call is
> incorrect unless the code has taken care to save and restore clobbered
> registers around the patch point.  That is the case today, but there
> is nothing validating that in the patching code.

Well, yes, it assumes that the original unpatched code is OK, and makes
sure that it remains correct after patching.  The patcher could
disassemble the unpatched sequence to make sure its consistent with the
site and clobbers, but that seems like overkill.


Currently the invariants on pv_ops patch sites are initially:

   1. the sequence is always at least an indirect call to an
      implementation of the operations, and
   2. it will always have appropriate register save/restores which allow
      a call to C code to work at that site

As a result, it is always OK to execute without doing any patching.

The callsite clobbers may be smaller than those needed for a naked C
call, but that means the site will have push/pops around the indirect
call.  This gives the patcher more space to work with if it wants to
inline something; if it just wants to generate a call to C code, it must
also generate its own register saves.

The indirect->direct call converter does check the clobbers, and makes
sure that inserting a naked direct call is OK.

> We could make the patching code more intelligent and have it emit the
> proper push / pop sequence around the call, but it is difficult to do
> and does not work for more than 3 argument function calls.  Or we
> could record the EIP of the call instruction in the patch information,
> allowing the patcher to either overwrite the whole thing, or do
> indirect / direct conversion.

Could do.  It would be useful to know how many args the function has,
and then the indirect->direct converter could generate the appropriate
push/pops for itself.  We're currently using 16 bits for the clobbers
field, which is overkill, we could use one byte as the arg count.  Just
an "args on stack" flag would be sufficient.

> Yes, we still do late paravirtualization.  My point is that because of
> that, you can't just link once and be done with it - you must relink
> the paravirt-ops later, which is more complex than a one time
> pre-execution link.

It's semantically no different from updating the paravirt_ops structure
followed by patching.  If the kernel comes up with all the sites
prelinked to the native versions, then its the same as booting on the
current kernel, with paravirt_ops initialized to the native versions.

    J
