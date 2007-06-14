From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [kvm-devel] More virtio users
Date: Thu, 14 Jun 2007 17:27:15 +0100
Message-ID: <200706141727.18463.mark.williamson__34691.4922040471$1181838541$gmane$org@cl.cam.ac.uk>
References: <466BA965.6050208@qumranet.com> <200706130001.21431.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200706130001.21431.arnd@arndb.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: kvm-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

I've not reviewed the virtio patches but think I've gathered the gist of =
what=20
they're doing (puppies would probably help here)...

> On Sunday 10 June 2007, Avi Kivity wrote:
> > There are probably more. =A0Any ideas?
>
> * watchdog timer

I recently knocked up a watchdog timer for Xen.  The Linux-side code is b=
ased=20
on the softdog implementation, but the actual timer implementation is wit=
hin=20
Xen itself.

It'd be fairly trivial to make something like this call out to a variety =
of=20
potential paravirt implementations - much of the code was effectively=20
boilerplate (setting up char device, dealing with magic close character,=20
etc).

Taking this further, it'd be quite easy to make a "null" implementation t=
hat=20
does what softdog did.

Watchdogs grow from puppies, so I'd think this would suit Rusty quite wel=
l ;-)

> * tty ports (not just console) to attach to via host socket
> * alsa
> * hostfs (UML like)

My XenFS project is somewhat like hostfs but it's a) a bit hairy and b) n=
ot=20
done yet :-)  A simpler hostfs-style filesystem would be useful and a bet=
ter=20
target for testing out virtio.

The main thing XenFS would want that I guess other virtio devices mightn'=
t=20
want is support for persistently sharing memory between virtual machines.=
.. =20
In the Xen case this is less trivial than the UML hostfs case.  It's not=20
*needed* yet, I just thought I'd throw it out there as a potential future=
=20
thing.  Presumably virtual block devices that do memory sharing might nee=
d=20
this sort of facility too.

Cheers,
Mark

--=20
Dave: Just a question. What use is a unicyle with no seat?  And no pedals=
!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
