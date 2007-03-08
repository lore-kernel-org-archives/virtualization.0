From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC/PATCH PV_OPS X86_64 05/17] pravirt_ops - segments
Date: Thu, 08 Mar 2007 08:06:53 -0500
Message-ID: <1173359213.25848.26.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
	<1173333727.25848.6.camel@localhost.localdomain>
	<20070308064942.GA10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070308064942.GA10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: virtualization@lists.osdl.org, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-03-07 at 22:49 -0800, Chris Wright wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > --- clean-start.orig/include/asm-x86_64/segment.h
> > +++ clean-start/include/asm-x86_64/segment.h
> > @@ -37,8 +37,14 @@
> >  #define GS_TLS_SEL ((GDT_ENTRY_TLS_MIN+GS_TLS)*8 + 3)
> >  #define FS_TLS_SEL ((GDT_ENTRY_TLS_MIN+FS_TLS)*8 + 3)
> >  =

> > +#define __HV_CS 0x80  /* 16*8 */
> > +#define __HV_DS 0x88  /* 17*8 */
> > +
> > +#define GDT_ENTRY_HV_CS 16
> > +#define GDT_ENTRY_HV_DS 17
> > +
> =

> Hmm, this one is not technically needed for pv_ops, looks like lguest
> bleeding in ;-)

I thought this could be HV agnostic, so I slipped it in.  But that's
questionable, and hence, its own separate patch.

-- Steve
