From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Fri, 02 Mar 2007 23:58:22 -0800
Message-ID: <45E92A9E.6030108@vmware.com>
References: <200703020254.l222smBB009668@zach-dev.vmware.com>
	<45E79529.9000305@goop.org> <45E79C72.4000806@goop.org>
	<45E7C4DD.1040403@vmware.com> <45E7C80E.1020107@goop.org>
	<45E7F405.6020507@vmware.com> <45E8571F.1050509@goop.org>
	<45E920F6.7060806@vmware.com> <45E9273A.4040300@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E9273A.4040300@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>
> I can deal with the change going into -git, but it does seem awkward
> knowing that it is the wrong change and it will be replaced by something
> else almost immediately.
>   =


Well, it is not quite wrong - it is appropriate for -git.  That it will =

be replaced soon is a minor thing, as long as we can work together to =

make sure your patches are unaffected.

> My main concern is that the Xen patch queue is complex enough as-is, and
> I've been trying hard to remove dependencies on other uncommitted
> patches.   It's doubly complex because I'm not really sure if I'm
> targeting Andrew or Andi's tree as a base, though at the moment -git
> seems to work either way.
>
>     J
>   =


Believe me, I understand the complexities of dealing with -mm, -git, and =

-i386 trees.  It's not just doubly complex, its triply so.  I believe =

the best approach is to make it easiest on the maintainers.  So the =

patch stream I am uploading through -mm, -i386, to -git does not =

conflict with the Xen patch queue as long as we make sure the next =

bundle to those same trees applies clean.  Again, I broke the Xen patch =

queue in -mm, and for that I am sorry.  I will help you re-integrate =

against the VMI patches I sent out, as I broke your code, I will help =

fix it.  And we both have a tree to work off from, which makes it rather =

easy to work together ;)

Cheers,

Zach

----

Sutra I.2 - interruptah chittavritti nirodhah
