From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] paravirt.h
Date: Tue, 22 Aug 2006 16:08:32 +0200
Message-ID: <20060822140832.GW11651@stusta.de>
References: <1155202505.18420.5.camel@localhost.localdomain>
	<44DB7596.6010503@goop.org> <20060819012133.GH7813@stusta.de>
	<44E67B6E.10706@goop.org>
	<Pine.LNX.4.62.0608201047520.4809@pademelon.sonytel.be>
	<44EAFEE3.8080700@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44EAFEE3.8080700@goop.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Chris Wright <chrisw@sous-sol.org>, virtualization <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 22, 2006 at 05:56:03AM -0700, Jeremy Fitzhardinge wrote:
> Geert Uytterhoeven wrote:
> >>relicensing them.
> >>    =

> >
> >That's a pretty strong statement...
> >  =

> =

> Well, I'm not making any kind of legal statement.  I'm just pointing out =

> that from a technical perspective, there's a large visible functional =

> change from before if we use EXPORT_SYMBOL_GPL(paravirt_ops) vs =

> EXPORT_SYMBOL(paravirt_ops).  Given that the whole point of paravirt_ops =

> is to minimize visible changes, this seems counterproductive.

It only affects kernels with the new functionality PARAVIRT=3Dy, not =

kernels with the same functionality as today.

The alternative is to keep the EXPORT_SYMBOL_GPL(paravirt_ops) and make =

the functions using it out of line functions.

>    J

cu
Adrian

-- =


       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
