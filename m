From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/6] virtio interace
Date: Sat, 22 Sep 2007 12:01:33 +0200
Message-ID: <200709221201.33865.arnd__45837.3157460757$1190455918$gmane$org@arndb.de>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<200709211622.22005.arnd@arndb.de>
	<1190454934.27805.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190454934.27805.80.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 22 September 2007, Rusty Russell wrote:
> But now each virtio device has two "struct device"s, not one. =A0 And
> you've made up a fictional bus to do it.
>=20
> Yet for PCI systems, it really is a PCI device; exposing a second bus t=
o
> userspace just because we put a layer in our implementation is poor
> form.
>=20
> Perhaps this is the easiest way of doing it. =A0But it's still wrong.

I think it's just a matter of perspective. In the model I'm advocating,
the PCI device is not the same as the virtio device but rather a virtio
host bridge, very much like USB or SATA works.

We could easily have multiple virtio devices behind one PCI device, but
since virtual PCI devices are cheap, a one-to-one mapping makes sense
for simplicity.

Having two struct devices for an actual device is the price to pay for
this, but I do think that creating a bus_type for virtio is the logical
abstraction and not something we just make up to work around a
deficiency in our device reprentation.

	Arnd <><
