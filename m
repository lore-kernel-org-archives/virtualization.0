From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Clean up x86 control register and MSR macros
Date: Wed, 11 Apr 2007 14:11:06 +1000
Message-ID: <1176264666.26372.101.camel__28440.2022989982$1176282825$gmane$org@localhost.localdomain>
References: <200704101648.l3AGmT5e027601@tazenda.hos.anvin.org>
	<461BC350.4040403@goop.org>  <461BC9DE.5030009@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <461BC9DE.5030009@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-04-10 at 10:31 -0700, H. Peter Anvin wrote:
> Jeremy Fitzhardinge wrote:
> > =

> > Is having separate bit numbers and masks useful?  If so, is it worth
> > doing for the others?
> > =

> =

> I presume it's useful, or at least *used* in the current code, since =

> that was there already.  If deemed useful, it's something we could add =

> to the other bitmasks.

I don't think it needs to be done now, as long as it follows a clear
convention.  I'd prefer eg. X86_EFLAGS_IF_BIT =3D=3D 9, X86_EFLAGS_IF =3D=
=3D
512, but _X86_EFLAGS_IF seems to be the current practice.

Cheers,
Rusty.
