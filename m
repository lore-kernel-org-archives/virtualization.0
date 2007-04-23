From: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Mon, 23 Apr 2007 14:54:01 -0700
Message-ID: <462D2AF9.9010609@vmware.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>	
	<46284B40.5010106@goop.org>
	<m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
	<8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
	<462B9BE6.6040302@goop.org> <462D1CBC.6050405@vmware.com>
	<462D252D.5090008@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D252D.5090008@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zamsden@gmail.com>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>
> Well, the BUG is if the patch-size is smaller than sizeof(indirect
> call).  Or more generally, if the patch site contains bogus crud.  But I
> don't think checking for that in the patcher makes a great deal of sense.
>   

True, it may not make a lot of sense to check there.  But it is the only 
place where we can check it at runtime.  Unless you want some kind of 
compile time checking in the code which generates the patch data, say 
perhaps a .abort.  Still, that is not safe against modules which have 
broken paravirt-ops embedding.

> Currently the invariants on pv_ops patch sites are initially:
>
>    1. the sequence is always at least an indirect call to an
>       implementation of the operations, and
>    2. it will always have appropriate register save/restores which allow
>       a call to C code to work at that site
>
> As a result, it is always OK to execute without doing any patching.
>
> The callsite clobbers may be smaller than those needed for a naked C
> call, but that means the site will have push/pops around the indirect
> call.  This gives the patcher more space to work with if it wants to
> inline something; if it just wants to generate a call to C code, it must
> also generate its own register saves.
>   

Since there are so few of these sites, and they are performance 
critical, the placement of a BUG() here verifying the clobbers are ok 
effectively makes it the paravirt-op backend's responsibility to ensure 
that these sites get patched.  This is what would allow the removal of 
dependence on the paravirt_ops symbol for the most important interrupt 
control operations.

> It's semantically no different from updating the paravirt_ops structure
> followed by patching.  If the kernel comes up with all the sites
> prelinked to the native versions, then its the same as booting on the
> current kernel, with paravirt_ops initialized to the native versions.
>   

It's semantically the same, but the code needs to be re-usable later, 
which is where the problems arise - you can't simply cram the prelink 
code into head.S, but have to write it to be properly callable later on.

Zach
