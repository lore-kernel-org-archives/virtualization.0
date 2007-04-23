From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 15:15:40 -0700
Message-ID: <462D300C.8000700@goop.org>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org> <462D1CBC.6050405@vmware.com>
	<462D252D.5090008@goop.org> <462D2AF9.9010609@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D2AF9.9010609@vmware.com>
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
> Jeremy Fitzhardinge wrote:
>>
>> Well, the BUG is if the patch-size is smaller than sizeof(indirect
>> call).  Or more generally, if the patch site contains bogus crud.  But I
>> don't think checking for that in the patcher makes a great deal of
>> sense.
>>   
>
> True, it may not make a lot of sense to check there.  But it is the
> only place where we can check it at runtime.  Unless you want some
> kind of compile time checking in the code which generates the patch
> data, say perhaps a .abort.  Still, that is not safe against modules
> which have broken paravirt-ops embedding.

Well, they shouldn't be doing it for themselves; it will always be as a
result of some macro expansion from asm/paravirt.h.  And if they're
broken in a module, they'll be broken in the kernel too.

And you should be able to check for patch-site sanity by booting on
native with patching disabled.  That should fall over pretty quickly if
there's something wrong.

> Since there are so few of these sites, and they are performance
> critical, the placement of a BUG() here verifying the clobbers are ok
> effectively makes it the paravirt-op backend's responsibility to
> ensure that these sites get patched.  This is what would allow the
> removal of dependence on the paravirt_ops symbol for the most
> important interrupt control operations.

I'm not keen on *requiring* patching to occur, in general.  The
performance without patching is only a few percent worse than
native/patched, so its not like its a desperate problem to defer
implementing it.  (I.e, requiring patching just raises the
implementation barrier for a pv_ops backend.)

Overloading patching for dealing with module exports is interesting, but
well, I guess I don't see the problem in just exporting paravirt_ops. 
The two arguments I've seen against it are "security" and "GPL issues",
but neither seems particularly good.

> It's semantically the same, but the code needs to be re-usable later,
> which is where the problems arise - you can't simply cram the prelink
> code into head.S, but have to write it to be properly callable later on. 

I think that's OK.  It can just be plain C code, with very few
infrastructure dependencies.  It wouldn't need to allocate memory, for
example.  It should be fairly simple to make the code callable either
from early in the kernel's life or later on.

    J
