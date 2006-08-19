From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: proposed interface change for setting the ldt
Date: Sat, 19 Aug 2006 14:32:07 +1000
Message-ID: <1155961927.9203.19.camel@localhost.localdomain>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>
	<44E679ED.6010300@goop.org> <44E681B8.3020804@vmware.com>
	<20060819032249.GB10348@sequoia.sous-sol.org>
	<44E68857.6040806@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E68857.6040806@vmware.com>
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

On Fri, 2006-08-18 at 20:41 -0700, Zachary Amsden wrote:
> Chris Wright wrote:
> > * Zachary Amsden (zach@vmware.com) wrote:
> >   =

> >> The paravirt-op just got a lot harder to implement, so there is a cost =

> >> to the simpler interface.
> >>     =

> >
> > I'm missing why it's a lot harder.  Seems reasonably straight forward.
> > puzzled...
> >   =

> =

> Before it could be a direct call for us.  Now I am forced to write a =

> wrapper function around it which does exactly the same work as the =

> native code, them calls a ROM function.  It is straight forward, but =

> obviously undesirable.

It sounds fine to me, although I'd like to see the patch.  I don't have
anything against higher-level abstractions, if it helps any hypervisor,
as long as it doesn't warp the kernel code.  And if most hypervisors and
native break it down the same way, well, we can always create helpers.

Cheers,
Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
