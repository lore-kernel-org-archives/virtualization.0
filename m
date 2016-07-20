From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Wed, 20 Jul 2016 09:21:08 +0100
Message-ID: <20160720082108.GA13233@stefanha-x1.localdomain>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
	<20160718100353.GA15163@stefanha-x1.localdomain>
	<20160719154839.GB20047@danjae.aot.lge.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7996572212486196449=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160719154839.GB20047@danjae.aot.lge.com>
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


--===============7996572212486196449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2016 at 12:48:39AM +0900, Namhyung Kim wrote:
> Hello,
>=20
> On Mon, Jul 18, 2016 at 11:03:53AM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> > > +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *v=
q)
> > > +{
> > > +    VirtIOPstore *s =3D VIRTIO_PSTORE(vdev);
> > > +    VirtQueueElement *elem;
> > > +    struct virtio_pstore_hdr *hdr;
> > > +    ssize_t len;
> > > +
> > > +    for (;;) {
> > > +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > +        if (!elem) {
> > > +            return;
> > > +        }
> > > +
> > > +        hdr =3D elem->out_sg[0].iov_base;
> > > +        if (elem->out_sg[0].iov_len !=3D sizeof(*hdr)) {
> > > +            error_report("invalid header size: %u",
> > > +                         (unsigned)elem->out_sg[0].iov_len);
> > > +            exit(1);
> > > +        }
> >=20
> > Please use iov_to_buf() instead of directly accessing out_sg[].  Virtio
> > devices are not supposed to assume a particular iovec layout.  In other
> > words, virtio_pstore_hdr could be split across multiple out_sg[] iovecs.
> >=20
> > You must also copy in data (similar to Linux syscall implementations) to
> > prevent the guest from modifying data while the command is processed.
> > Such race conditions could lead to security bugs.
>=20
> By accessing elem->out_sg[0].iov_base directly, I abused it as an
> in-and-out buffer.  But it seems not allowed by the virtio spec, do I
> have to use separate buffers for request and response?

Yes, a virtqueue element has (host read-only) out buffers followed by
(host write-only) in buffers.

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJXjzR0AAoJEJykq7OBq3PIRZYH/A/fC1OAZbkPmx3q73/kipmD
FnIsKLz4TejkZngO4OusmP/Ct3t1ydUJKVkkh6dbMKggxRgOB4y3m4AbZ17Xjdz+
OCSmqhKyoO+t3dpfuxysOx4Nk7WDdKs1Cdm8sTRUHcOyeeUh7ae1AOgPU+4VmczZ
JK6Fok+HnUCszCp49D3EKkw8F3kqe3+uXc3x+bVS1qZWlEZHutGTJ0UoTXzdPItl
H2LV/uzSB9EXuzdsfmPwU0fetXQFoFrvKsexqmIsyD5ORvhgjg3OOIabuozCLhwi
6yF1AZByLmBB1b961yXvf4x1Jnw3kfiJlklthfHw+vG1y+MVtKA5PoSnLHTawvM=
=LvQu
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============7996572212486196449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7996572212486196449==--
