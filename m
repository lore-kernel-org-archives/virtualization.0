From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PATCH: Fix VMI and COMPAT_VDSO for 2.6.21
Date: Sat, 10 Mar 2007 09:47:50 +0100
Message-ID: <20070310084750.GA15647@elte.hu>
References: <45F2578E.3060907@vmware.com> <45F257C1.4070904@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45F257C1.4070904@vmware.com>
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
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


* Zachary Amsden <zach@vmware.com> wrote:

> Zachary Amsden wrote:
> >VMI is broken under COMPAT_VDSO, as Xen and other non hardware =

> >assisted hypervisors will be.  I have been working on a fix for this =

> >which works for older glibcs that panic when the new relocatable VDSO =

> >is used.  However, I believe at this time that the fix is going to be =

> >too radical to consider at this stage in the release of 2.6.21.  We =

> >don't expect this config option to be turned on by vendors for new =

> >distributions, so at this point we are willing to drop support for it =

> >when VMI is compiled in, and work on a patch for 2.6.22 which more =

> >fully addresses the problem.
> >
> >Please apply, thanks.

makes sense. We can do Jan's relocatable-COMPAT_VDSO thing in v2.6.22, =

but for v2.6.21 that's way too intrusive.

Acked-by: Ingo Molnar <mingo@elte.hu>

> I suppose it would be better if I attached the patch.

it certainly helps ;-)

	Ingo
