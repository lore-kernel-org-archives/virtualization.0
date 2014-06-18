From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
Subject: Re: [Qemu-devel] Why I advise against using ivshmem
Date: Wed, 18 Jun 2014 17:01:45 +0200
Message-ID: <53A1A9D9.6010908__40762.2010483921$1403103727$gmane$org@suse.de>
References: <87vbs6qjhj.fsf_-_@blackfin.pond.sub.org>	<5399CF09.8030803@6wind.com>
	<87ppidnqmy.fsf@blackfin.pond.sub.org>	<539AC3E0.9090404@6wind.com>
	<539ACDE6.7020709@redhat.com>	<539AFF7C.7090702@6wind.com>
	<539B064D.2050501@redhat.com>	<CAJSP0QUcFGSGgQMjU=Ax3n6Gqx6h_ZZ1yXz6QgQiyYYe+e4K4w@mail.gmail.com>	<53A00464.8090609@6wind.com>
	<53A00DEB.8030400@redhat.com>
	<20140618104849.GH14030@stefanha-thinkpad.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140618104849.GH14030@stefanha-thinkpad.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Vincent JARDIN <vincent.jardin@6wind.com>
Cc: Henning Schild <henning.schild@siemens.com>, Olivier MATZ <olivier.matz@6wind.com>, kvm <kvm@vger.kernel.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, David Marchand <david.marchand@6wind.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, "thomas.monjalon@6wind.com" <thomas.monjalon@6wind.com>
List-Id: virtualization@lists.linuxfoundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 18.06.2014 12:48, schrieb Stefan Hajnoczi:
> On Tue, Jun 17, 2014 at 11:44:11AM +0200, Paolo Bonzini wrote:
>> Il 17/06/2014 11:03, David Marchand ha scritto:
>>>> Unless someone steps up and maintains ivshmem, I think it
>>>> should be deprecated and dropped from QEMU.
>>> =

>>> Then I can maintain ivshmem for QEMU. If this is ok, I will
>>> send a patch for MAINTAINERS file.
>> =

>> Typically, adding yourself to maintainers is done only after
>> having proved your ability to be a maintainer. :)
>> =

>> So, let's stop talking and go back to code!  You can start doing
>> what was suggested elsewhere in the thread: get the server and
>> uio driver merged into the QEMU tree, document the protocol in
>> docs/specs/ivshmem_device_spec.txt, and start fixing bugs such as
>> the ones that Markus reported.
> =

> One more thing to add to the list:
> =

> static void ivshmem_read(void *opaque, const uint8_t * buf, int
> flags)
> =

> The "flags" argument should be "size".  Size should be checked
> before accessing buf.
> =

> Please also see the bug fixes in the following unapplied patch: =

> "[PATCH] ivshmem: fix potential OOB r/w access (#2)" by Sebastian
> Krahmer =

> https://lists.gnu.org/archive/html/qemu-devel/2014-04/msg03538.html

Jumping
> =

late onto this thread: SUSE Security team has just recently
done a thorough review of QEMU ivshmem code because a customer has
requested this be supported in SLES12. Multiple security-related
patches were submitted by Stefan Hajnoczi and Sebastian Krahmer, and I
fear they are probably still not merged for lack of active
maintainer... In such cases, after review, I expect them to be picked
up by Peter as committer or via qemu-trivial.

So -1, against dropping it.

Vincent, you will find an RFC for an ivshmem-test in the qemu-devel
list archives or possibly on my qtest branch. The blocking issue that
I haven't worked on yet is that we can't unconditionally run the qtest
because it depends on KVM enabled at configure time (as opposed to
runtime) to have the device available.
http://patchwork.ozlabs.org/patch/336367/

As others have stated before, the nahanni server seems unmaintained,
thus not getting packaged by SUSE either and making testing the
interrupt parts of ivshmem difficult - unless we sort out and fill
with actual test code my proposed qtest.

Regards,
Andreas

- -- =

SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer; HRB 16746 AG N=FCrnberg
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJToanZAAoJEPou0S0+fgE/L6YP/jtPiwvz3YoW3+H/h/YzrnE7
xVP92jj5orzmbG3HMmEnx0l7YrtzYkwymgUO56dy2SrLFe0xVMnxuzcHLzHLsnm3
bYvMVq3eAx8sdx9c/O2B/rQbNo2p8PF/luTNewN7A+w5TX0XgxdI3TpLT2pVxf0b
kMaBnfivzUf2JY/zg6NaiGnwvVrA/0kXsCGKcTBiMQxOX2EdDgNak842SjlmS332
dPbqp5PIMdxwCxI/p+gpmu0cSy1bl2H6N2gkmKQZ63Z2tA7bWn/APdQeHyOcESZE
xRAfDz2Cs3/6EL7FLirJWdwT9EMNaFcM+eRgIqDamFzviQPZVuLKdDUteO1k9x1s
FlhL3ZRa3qHair9ByEJItqzneAeYmuwZ2DkKh4p/HQfbcxLzZlL8a1EEtYz5DTy0
8+Ax6IU5U5RZmwJ4/M/Ov5eT4t/fNe0MbG3mf5A8FJ6GWoF11ut/wyj70p/EmXua
QjUblK/eFemN4YvIi0ovD4DR9ZH2+bXOb44wKL7yFahKLldaP4y9DhJTap2J0mT1
b62FfFZ6hVIGP5n30OHLlhe39QY6SyIPc4JNc9VZ3GcpXtfOHPUOAD/ykt/As1P3
cPfL+jM0QSb6VNJHNbvUsSlJ6xI26qEWzyJ5R7ww4fyEoq4XiE2RCDUWJ2t9/jQb
+Bi/esBUDhAduc1Eh3FK
=3DMtPH
-----END PGP SIGNATURE-----
