From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt
	kernels
Date: Thu, 2 Nov 2006 11:20:59 +0100
Message-ID: <20061102102059.GB1990@elf.ucw.cz>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024606.496399000@sous-sol.org>
	<20061101121753.GA2205@elf.ucw.cz> <45492CBC.8020501@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <45492CBC.8020501@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org, ak@muc.de, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi!

> >>Allow selected bug checks to be skipped by paravirt kernels.  The two m=
ost
> >>important are the F00F workaround (which is either done by the hypervis=
or,
> >>or not required), and the 'hlt' instruction check, which can break under
> >>some hypervisors.
> >>    =

> >
> >How can hlt check break? It is hlt;hlt;hlt, IIRC, that looks fairly
> >innocent to me.
> >  =

> =

> Not if you use tickless timers that don't generate interrupts to unhalt =

> you, or if you delay ticks until the next scheduled timeout and you =

> haven't yet scheduled any timeout.  Both are likely in a hypervisor.

Well.. but you are working around problem, instead of fixing it.

Tickless kernels are possible on normal machines, too.

Please fix it properly... probably by requesting timer 10msec in
advance or something.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
