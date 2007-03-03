From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 4/9] Vmi fix highpte
Date: Fri, 02 Mar 2007 23:43:54 -0800
Message-ID: <45E9273A.4040300@goop.org>
References: <200703020254.l222smBB009668@zach-dev.vmware.com>
	<45E79529.9000305@goop.org> <45E79C72.4000806@goop.org>
	<45E7C4DD.1040403@vmware.com> <45E7C80E.1020107@goop.org>
	<45E7F405.6020507@vmware.com> <45E8571F.1050509@goop.org>
	<45E920F6.7060806@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45E920F6.7060806@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Yes, but the hook point now happens before the page table mapping.

Did you change that since you posted the patch?  Sounds like a larger
change than the one I'm proposing.

>   Not that it should cause a problem.  But we've been testing things
> the original way for over a year now, and if we want to get the fix
> upstream for 2.6.21, it seems better to upstream a more tested fix
> rather than a new way of doing things, even if it is identical in theory.

Sure.

> That said, I have no problems with the approach you propose going
> forward.  I just don't think it is appropriate for an -rc release,
> because it provides no tangible benefit for any of the in-kernel code,
> and causes a lot of retesting.  I still believe there is almost zero
> risk to doing things the way you propose.  But I am also a firm
> believer in shipping what is tested and working unless there is a
> compelling reason to do otherwise.  And if Xen is not going to be in
> 2.6.21, the compelling reason becomes getting the code working for
> both of us for 2.6.22 - so let's do that, and keep the patches from
> Andrew's -mm tree around to make sure that we have a suitable patch
> base that can be applied to 2.6.21 for any distros that are willing to
> pick up the Xen paravirt-ops.
>
> Sound reasonable?

I can deal with the change going into -git, but it does seem awkward
knowing that it is the wrong change and it will be replaced by something
else almost immediately.

My main concern is that the Xen patch queue is complex enough as-is, and
I've been trying hard to remove dependencies on other uncommitted
patches.   It's doubly complex because I'm not really sure if I'm
targeting Andrew or Andi's tree as a base, though at the moment -git
seems to work either way.

    J
