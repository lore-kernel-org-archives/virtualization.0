From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 6/7] qemu: Implement virtio-pstore device
Date: Thu, 28 Jul 2016 13:56:07 +0100
Message-ID: <20160728125607.GA31002__31191.605437971$1469710595$gmane$org@stefanha-x1.localdomain>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<1469632111-23260-7-git-send-email-namhyung@kernel.org>
	<20160728023254-mutt-send-email-mst@kernel.org>
	<20160728053953.GB4371@sejong>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3302773004094490327=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160728053953.GB4371@sejong>
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
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3302773004094490327==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2016 at 02:39:53PM +0900, Namhyung Kim wrote:
> On Thu, Jul 28, 2016 at 03:02:54AM +0300, Michael S. Tsirkin wrote:
> > On Thu, Jul 28, 2016 at 12:08:30AM +0900, Namhyung Kim wrote:
> > > +static ssize_t virtio_pstore_do_write(VirtIOPstore *s, struct iovec =
*out_sg,
> > > +                                      unsigned int out_num,
> > > +                                      struct virtio_pstore_req *req)
> > > +{
> > > +    char path[PATH_MAX];
> > > +    int fd;
> > > +    ssize_t len;
> > > +    unsigned short type;
> > > +    int flags =3D O_WRONLY | O_CREAT;
> > > +
> > > +    /* we already consume the req */
> > > +    iov_discard_front(&out_sg, &out_num, sizeof(*req));
> > > +
> > > +    virtio_pstore_to_filename(s, path, sizeof(path), req);
> > > +
> > > +    type =3D le16_to_cpu(req->type);
> > > +
> > > +    if (type =3D=3D VIRTIO_PSTORE_TYPE_DMESG) {
> > > +        flags |=3D O_TRUNC;
> > > +    } else if (type =3D=3D VIRTIO_PSTORE_TYPE_CONSOLE) {
> > > +        flags |=3D O_APPEND;
> > > +    }
> > > +
> > > +    fd =3D open(path, flags, 0644);
> > > +    if (fd < 0) {
> > > +        error_report("cannot open %s", path);
> > > +        return -1;
> > > +    }
> > > +    len =3D writev(fd, out_sg, out_num);
> > > +    close(fd);
> > > +
> > > +    return len;
> >=20
> > All this is blocking VM until host io completes.
>=20
> Hmm.. I don't know about the internals of qemu.  So does it make guest
> stop?  If so, that's what I want to do for _DMESG. :)  As it's called
> only on kernel oops I think it's admittable.  But for _CONSOLE, it
> needs to do asynchronously.  Maybe I can add a thread to do the work.

Please look at include/io/channel.h.  QEMU is event-driven and tends to
use asynchronous I/O instead of spawning threads.  The include/io/ APIs
allow you to do asynchronous I/O in the event loop.

Stefan

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXmgDnAAoJEJykq7OBq3PIQrgH/2X4oIoI5AVxOzaap01tI2Eb
sh2ZzPXuO+tLkqAPBaYhE8uNkF3W9mcfFONloUhi62fCCv24pQNi2lrt61YJ7aZ/
EYIHihzxWXE/Tjsxs9V05R0Vs6BVrogxbZnw10gA/V4CpnEcS0HrKnyJC310PWNu
r0IZuuF/39TTOGvP7G0RxLCQQYLwhP0FKlNjppQkIeIq+q3qPZBDxWoHBlaXCOcK
JuOggDqvy4ahaEZxe2SkcOzkDMwVhTzne6Bqjo/tbLgXcZVpGoOkxkdd87eeNyUk
j/GhmbXEdT2TN3hZiaRbVspVMh0PyvJH2qP8GKRvDfXFUla/AZJvRjTYpsg8wLc=
=9AlL
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--===============3302773004094490327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3302773004094490327==--
