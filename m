From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Unified lguest launcher
Date: Fri, 06 Apr 2007 12:19:43 +1000
Message-ID: <1175825983.12230.666.camel@localhost.localdomain>
References: <5d6222a80704040903n49442679p2a6841de69d894c2@mail.gmail.com>
	<1175741082.12230.610.camel@localhost.localdomain>
	<5d6222a80704050743l3c387287kdbe7eb069b793d6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80704050743l3c387287kdbe7eb069b793d6e@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: virtualization@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-04-05 at 11:43 -0300, Glauber de Oliveira Costa wrote:
> and here's the new patch, merging rusty's suggestions and some more on my=
 own.
> =

> May I upload this, or does Rusty (or any other) has some more suggestions?

This looks excellent!

There are a couple of extra spaces floating around, but that's trivial.
You use "errno =3D ESRCH; err()" where you could use "errx()".

Please merge it straight in. No need for a separate patch in the tree
for this I think, unless you plan more work?

Thanks!
Rusty.
