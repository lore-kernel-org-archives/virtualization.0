From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Wed, 20 Jul 2016 09:29:06 +0100
Message-ID: <20160720082906.GB13233@stefanha-x1.localdomain>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
	<20160718100353.GA15163@stefanha-x1.localdomain>
	<20160718142118.GA16575@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3834588414575129560=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160718142118.GA16575@danjae.aot.lge.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3834588414575129560==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 18, 2016 at 11:21:18PM +0900, Namhyung Kim wrote:
> On Mon, Jul 18, 2016 at 11:03:53AM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> > > From: Namhyung Kim <namhyung@gmail.com>
> > >=20
> > > Add virtio pstore device to allow kernel log files saved on the host.
> > > It will save the log files on the directory given by pstore device
> > > option.
> > >=20
> > >   $ qemu-system-x86_64 -device virtio-pstore,directory=3Ddir-xx ...
> > >=20
> > >   (guest) # echo c > /proc/sysrq-trigger
> > >=20
> > >   $ ls dir-xx
> > >   dmesg-0.enc.z  dmesg-1.enc.z
> > >=20
> > > The log files are usually compressed using zlib.  Users can see the l=
og
> > > messages directly on the host or on the guest (using pstore filesyste=
m).
> >=20
> > The implementation is synchronous (i.e. can pause guest code execution),
> > does not handle write errors, and does not limit the amount of data the
> > guest can write.  This is sufficient for ad-hoc debugging and usage with
> > trusted guests.
> >=20
> > If you want this to be available in environments where the guest isn't
> > trusted then there must be a limit on how much the guest can write or
> > some kind of log rotation.
>=20
> Right.  The synchronous IO is required by the pstore subsystem
> implementation AFAIK (it uses a single psinfo->buf in the loop).

The pstore subsystem in Linux may be synchronous but the QEMU device
emulation does not have to be synchronous.

Synchronous device emulation means that no other vcpu or QEMU main loop
processing can occur while device emulation is blocked in a syscall.
This can make the QEMU monitor unavailable for libvirt and management
tools.  The guest can experience jitter since vcpus freeze if they
vmexit while device emulation is blocked (it holds the QEMU global
mutex and prevents other QEMU threads from making progress).

You could use include/io.h for asynchronous I/O (qio_channel_add_watch()).

Stefan

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXjzZSAAoJEJykq7OBq3PIdBYIAIwk0vwgrHJHa2b0GiTK+9Rm
+5Sj2RlLsX4w2WC91OFflFdNe6+TIeOnkvboQfw6EsiXEBjxHrnpp8O3waj9Usr5
sm91wdOrfDoj3EzrOmCxqKwBqyciI9k4iR7rRb+Lf8iUxEhjKaIBjA1GCKLZgUCQ
8mESiLaVrFz8JyjcqtO0XY7cupORQnwKPbXTB0cU1ItwUPYVyGRoWdrGoxQA+8Ol
P6oQNA2p8ZT2OME91O7zmQVeVB/wG9iwg9XtcrB1kqtNoi6Mn70REVILJYFXcNbH
dyYgrDIrCl6gEtlmKC0ZU1Tdlba/NzrbDN1Uh0ST3RqnK5btP5rg7zo4rkeJR8U=
=g1l6
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--

--===============3834588414575129560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3834588414575129560==--
