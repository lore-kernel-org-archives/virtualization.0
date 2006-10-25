From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: RFC: const_udelay in 018-delay functions patch
Date: Thu, 26 Oct 2006 09:01:02 +1000
Message-ID: <1161817262.27354.3.camel@localhost.localdomain>
References: <453EF1EE.2000503@vmware.com>
	<1161756217.15099.52.camel@localhost.localdomain>
	<453F027E.2020704@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <453F027E.2020704@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-10-24 at 23:21 -0700, Zachary Amsden wrote:
> Rusty Russell wrote:
> > On Tue, 2006-10-24 at 22:11 -0700, Zachary Amsden wrote:
> >> +#if defined(CONFIG_PARAVIRT) && !defined(USE_REAL_IO)
> >> +#include <asm/paravirt.h>
> >> +#else =

> >>     =

> >
> > USE_REAL_IO? Is this defined anywhere?  Or just future-proofing?
> >   =

> =

> It has to be used for SMP bootstrapping - IPI acceptance requires real =

> time cross-processor delay, even in a VM

No, that's USE_REAL_TIME_DELAY: USE_REAL_IO is not currently defined
anywhere AFAICT.

>  - and also can be added by a =

> top-level define to kernel compiles for driver domains for Xen to give =

> real time device delays.

Makes sense...
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
