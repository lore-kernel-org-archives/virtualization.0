From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Thu, 22 Sep 2016 13:23:16 +0100
Message-ID: <20160922122316.GB8221@stefanha-x1.localdomain>
References: <20160904143900.14850-1-namhyung@kernel.org>
	<20160904143900.14850-3-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3454327237998688072=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160904143900.14850-3-namhyung@kernel.org>
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
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, "Daniel P . Berrange" <berrange@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Namhyung Kim <namhyung@gmail.com>, Anton Vorontsov <anton@enomsg.org>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


--===============3454327237998688072==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 04, 2016 at 11:38:59PM +0900, Namhyung Kim wrote:
> +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOPstore *s = VIRTIO_PSTORE(vdev);
> +    VirtQueueElement *elem;
> +    struct virtio_pstore_req req;
> +    struct virtio_pstore_res res;
> +    ssize_t len = 0;
> +    int ret;
> +
> +    for (;;) {
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            return;
> +        }
> +
> +        if (elem->out_num < 1 || elem->in_num < 1) {
> +            error_report("request or response buffer is missing");
> +            exit(1);

The new virtio_error() function might be available, depending on when
this patch series is merged.  virtio_error() should be used instead of
exit(1).  See "[PATCH v5 0/9] virtio: avoid exit() when device enters
invalid states" on qemu-devel.

> +        }
> +
> +        if (elem->out_num > 2 || elem->in_num > 3) {
> +            error_report("invalid number of input/output buffer");
> +            exit(1);
> +        }

The VIRTIO specification requires that flexible framing is supported.
The device cannot make assumptions about the scatter-gather list.  It
must support any layout (e.g. even multiple 1-byte iovecs making up the
buffer).

> +
> +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &req, sizeof(req));
> +        if (len != (ssize_t)sizeof(req)) {
> +            error_report("invalid request size: %ld", (long)len);
> +            exit(1);
> +        }
> +        res.cmd  = req.cmd;
> +        res.type = req.type;
> +
> +        switch (le16_to_cpu(req.cmd)) {
> +        case VIRTIO_PSTORE_CMD_OPEN:
> +            ret = virtio_pstore_do_open(s);
> +            break;
> +        case VIRTIO_PSTORE_CMD_CLOSE:
> +            ret = virtio_pstore_do_close(s);
> +            break;
> +        case VIRTIO_PSTORE_CMD_ERASE:
> +            ret = virtio_pstore_do_erase(s, &req);
> +            break;
> +        case VIRTIO_PSTORE_CMD_READ:
> +            ret = virtio_pstore_do_read(s, elem);
> +            if (ret == 1) {
> +                /* async channel io */
> +                continue;
> +            }
> +            break;
> +        case VIRTIO_PSTORE_CMD_WRITE:
> +            ret = virtio_pstore_do_write(s, elem, &req);
> +            if (ret == 1) {
> +                /* async channel io */
> +                continue;
> +            }
> +            break;
> +        default:
> +            ret = -1;
> +            break;
> +        }
> +
> +        res.ret = ret;

Missing cpu_to_le()?

> +static void pstore_set_bufsize(Object *obj, Visitor *v,
> +                               const char *name, void *opaque,
> +                               Error **errp)
> +{
> +    VirtIOPstore *s = opaque;
> +    Error *error = NULL;
> +    uint64_t value;
> +
> +    visit_type_size(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    if (value < 4096) {
> +        error_setg(&error, "Warning: too small buffer size: %"PRIu64, value);

This is an error, not a warning.  Please remove "Warning:" so it's clear
to the user that this message caused QEMU to fail.

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJX4800AAoJEJykq7OBq3PI56YH/RZyTlY9qokAxEoZ6Gys6cVX
s1wXJGIOhH3kjnnehO1a+ihZopW7kpNS8i0Mz1Alw5nQ4O8qEQa1lHbFwn1szgl0
0TGEfqcVX+pgxUI8K5ppiSA9zUssF5ihs00Y0SBumEUl1xKwi32GySIe+nvVRRHE
d28AbJ1Faq2nhc3M5xABAFEJp55EmTHraB7AouQQ1MZWo9w3SspSHKwGsevdHFEu
KAOOQgQ9vJDQFaN/eE5DP5AQfzyNTgK1rHk74q9OxlEjy4LxXMHbrt1+z1BrBtCx
3/4/HZCW9vnanUrPmVb+cL6Ld8OdEr2OyBDFgWcwz4UkaI8FEIFPSjGE6Tc2iUY=
=I0cq
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--

--===============3454327237998688072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3454327237998688072==--
