From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] custom virt-io support (in user-mode-linux)
Date: Thu, 23 May 2019 12:59:50 +0100
Message-ID: <20190523115950.GH26632@stefanha-x1.localdomain>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0662405066914852243=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============0662405066914852243==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 03:02:38PM +0200, Johannes Berg wrote:
> Hi,
>=20
> While my main interest is mostly in UML right now [1] I've CC'ed the
> qemu and virtualization lists because something similar might actually
> apply to other types of virtualization.
>=20
> I'm thinking about adding virt-io support to UML, but the tricky part is
> that while I want to use the virt-io basics (because it's a nice
> interface from the 'inside'), I don't actually want the stock drivers
> that are part of the kernel now (like virtio-net etc.) but rather
> something that integrates with wifi (probably building on hwsim).
>=20
> The 'inside' interfaces aren't really a problem - just have a specific
> device ID for this, and then write a normal virtio kernel driver for it.
>=20
> The 'outside' interfaces are where my thinking breaks down right now.
>=20
> Looking at lkl, the outside is just all implemented in lkl as code that
> gets linked to the library, so in UML terms it'd just be extra 'outside'
> code like the timer handling or other netdev stuff we have today.
> Looking at qemu, it's of course also implemented there, and then
> interfaces with the real network, console abstraction, etc.
>=20
> However, like I said above, I really need something very custom and not
> likely to make it upstream to any project (because what point is that if
> you cannot connect to the rest of the environment I'm building), so I'm
> thinking that perhaps it should be possible to write an abstract
> 'outside' that lets you interact with it really from out-of-process?
> Perhaps through some kind of shared memory segment? I think that gets
> tricky with virt-io doing DMA (I think it does?) though, so that part
> would have to be implemented directly and not out-of-process?
>=20
> But really that's why I'm asking - is there a better way than to just
> link the device-side virt-io code into the same binary (be it lkl lib,
> uml binary, qemu binary)?

Hi Johannes,
Check out vhost-user.  It's a protocol for running a subset of a VIRTIO
device's emulation in a separate process (usually just the data plane
with the PCI emulation and other configuration/setup still handled by
QEMU).

vhost-user uses a UNIX domain socket to pass file descriptors to shared
memory regions.  This way the vhost-user device backend process has
access to guest RAM.

This would be quite different for UML since my understanding is you
don't have guest RAM but actual host Linux processes, but vhost-user
might still give you ideas:
https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/interop/vhost-us=
er.rst;hb=3DHEAD

Stefan

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzmizYACgkQnKSrs4Gr
c8iyiQgAtcvNB/axTFWFW8B8Yja3ssAl/WQoNmZFkMVKrMmaRWNWwkZpLvFuijDm
hKISZpLqpwJLktRbr57OEBdVBGqyORDULJABoB+Tk4le6zQhgXARKoEetmjUQgEM
0CFEvYO5HrlTERLU0hFfudeH39yz8r3xMI+yZ3PWjCkqZC/KYu8Ny2s82Ltc4mnb
6OjybksHD4G5MDYC0BJO/lXeARjOO6/eLgxMGDPTWENAJTXOCeXg1ZvYtdvPsdOs
TFmzkvY63x8j8jKkgR1iJb1QjtGzpLjzhadfIPSl2MQN7hhBmOOsBzvBNJFAqOlo
ue1U9AT0+ZRt1HMcfWx59MyXofnM+Q==
=2T/5
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--

--===============0662405066914852243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============0662405066914852243==--
