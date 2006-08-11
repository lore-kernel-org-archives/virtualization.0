From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] paravirt.h
Date: Thu, 10 Aug 2006 19:34:51 -0700
Message-ID: <44DBECCB.4070803@goop.org>
References: <1155202505.18420.5.camel@localhost.localdomain>	
	<1155204603.18420.9.camel@localhost.localdomain>	
	<20060810103012.GA2356@muc.de>	
	<1155207946.18420.18.camel@localhost.localdomain>	
	<44DB4D58.9010105@goop.org> <44DB54A5.50006@vmware.com>	
	<44DB6144.2080308@goop.org>
	<1155262867.27719.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1155262867.27719.2.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Well, I was thinking about this, and maybe it's better for the overrides
> to do explicit assignments in their probe fn, ie:
>
> 	paravirt_ops.irq_disable =3D my_irq_disable;
> 	paravirt_ops.irq_enable =3D my_irq_enable;
> 	paravirt_ops.cpuid =3D my_cpuid;
> 	...
>
> This makes partial overrides (eg Xen) really clear, is no more lines of
> code that the modern struct init style, and avoids making the native
> ones nonstatic...
>   =


I still like the extra information that:

    .clts =3D native_clts,

tells the reader.  It says "I am explicitly choosing to use the native =

version for the operation", vs having nothing which means "I'm =

implicitly falling back on the default, or maybe I forgot to implement it".

The implicit default fallbacks make sense for an interface which has =

been stable, has users, and is then updated in a way which makes sure =

that the old users of the interface can do nothing and still have a =

working system.  But at this stage of paravirt_ops, not implementing =

something almost certainly means that someone updated the interface, and =

that its probably not OK to not implement that update.

    J
