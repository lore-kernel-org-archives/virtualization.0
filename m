From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: hardwired VMI crap
Date: Thu, 8 Mar 2007 10:35:12 -0800
Message-ID: <20070308183512.GG10574@sequoia.sous-sol.org>
References: <45EEF966.6060902@goop.org>
	<Line.LNX.4.64.0703071304080.1851@d.namei>
	<45EF0CF5.5090305@goop.org> <45EF175D.6030609@vmware.com>
	<1173302503.24738.795.camel@localhost.localdomain>
	<45EF372E.7030600@goop.org>
	<1173308717.24738.898.camel@localhost.localdomain>
	<45EF49E9.7040509@vmware.com> <20070308091019.GA19460@elte.hu>
	<45EFE010.7080108@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45EFE010.7080108@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

* Zachary Amsden (zach@vmware.com) wrote:
> Our code is in the tree now, and any attempts to break it using such =

> justifications as easing maintenance for kernel developers in future =

> releases are flat out false and improper.

That's not quite accurate.  This is what Ingo was complaining about
earlier with VMI being an inhibitor to change.  Core kernel will change
and occassionally break VMI.  It's entirely reasonable, and in fact
normal, to make these changes, esp in the name of easing long term
maintenance.  There's some mutual responsibility to fix things up in
the fallout.  But, I really didn't think you disagreed with that, so
perhaps I've misunderstood the above.

> We are working to correct =

> flaws that we have and properly conform to the changing interfaces such =

> as the timer subsystem, and also to interoperate properly with the full =

> set of available configurations.

Right, so let's move on ;-)

thanks,
-chris
