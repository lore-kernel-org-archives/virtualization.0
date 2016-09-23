From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Fri, 23 Sep 2016 14:52:05 +0900
Message-ID: <20160923055205.GC16119@danjae.aot.lge.com>
References: <20160904143900.14850-1-namhyung@kernel.org>
	<20160904143900.14850-3-namhyung@kernel.org>
	<20160922122316.GB8221@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160922122316.GB8221@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Tony Luck <tony.luck@intel.com>, "Daniel P . Berrange" <berrange@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, Minchan Kim <minchan@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 22, 2016 at 01:23:16PM +0100, Stefan Hajnoczi wrote:
> On Sun, Sep 04, 2016 at 11:38:59PM +0900, Namhyung Kim wrote:
> > +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtIOPstore *s = VIRTIO_PSTORE(vdev);
> > +    VirtQueueElement *elem;
> > +    struct virtio_pstore_req req;
> > +    struct virtio_pstore_res res;
> > +    ssize_t len = 0;
> > +    int ret;
> > +
> > +    for (;;) {
> > +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +        if (!elem) {
> > +            return;
> > +        }
> > +
> > +        if (elem->out_num < 1 || elem->in_num < 1) {
> > +            error_report("request or response buffer is missing");
> > +            exit(1);
> 
> The new virtio_error() function might be available, depending on when
> this patch series is merged.  virtio_error() should be used instead of
> exit(1).  See "[PATCH v5 0/9] virtio: avoid exit() when device enters
> invalid states" on qemu-devel.

Thanks for the info, will take a look.

> 
> > +        }
> > +
> > +        if (elem->out_num > 2 || elem->in_num > 3) {
> > +            error_report("invalid number of input/output buffer");
> > +            exit(1);
> > +        }
> 
> The VIRTIO specification requires that flexible framing is supported.
> The device cannot make assumptions about the scatter-gather list.  It
> must support any layout (e.g. even multiple 1-byte iovecs making up the
> buffer).

Ok.

> 
> > +
> > +        len = iov_to_buf(elem->out_sg, elem->out_num, 0, &req, sizeof(req));
> > +        if (len != (ssize_t)sizeof(req)) {
> > +            error_report("invalid request size: %ld", (long)len);
> > +            exit(1);
> > +        }
> > +        res.cmd  = req.cmd;
> > +        res.type = req.type;
> > +
> > +        switch (le16_to_cpu(req.cmd)) {
> > +        case VIRTIO_PSTORE_CMD_OPEN:
> > +            ret = virtio_pstore_do_open(s);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_CLOSE:
> > +            ret = virtio_pstore_do_close(s);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_ERASE:
> > +            ret = virtio_pstore_do_erase(s, &req);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_READ:
> > +            ret = virtio_pstore_do_read(s, elem);
> > +            if (ret == 1) {
> > +                /* async channel io */
> > +                continue;
> > +            }
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_WRITE:
> > +            ret = virtio_pstore_do_write(s, elem, &req);
> > +            if (ret == 1) {
> > +                /* async channel io */
> > +                continue;
> > +            }
> > +            break;
> > +        default:
> > +            ret = -1;
> > +            break;
> > +        }
> > +
> > +        res.ret = ret;
> 
> Missing cpu_to_le()?

Right!

> 
> > +static void pstore_set_bufsize(Object *obj, Visitor *v,
> > +                               const char *name, void *opaque,
> > +                               Error **errp)
> > +{
> > +    VirtIOPstore *s = opaque;
> > +    Error *error = NULL;
> > +    uint64_t value;
> > +
> > +    visit_type_size(v, name, &value, &error);
> > +    if (error) {
> > +        error_propagate(errp, error);
> > +        return;
> > +    }
> > +
> > +    if (value < 4096) {
> > +        error_setg(&error, "Warning: too small buffer size: %"PRIu64, value);
> 
> This is an error, not a warning.  Please remove "Warning:" so it's clear
> to the user that this message caused QEMU to fail.

Will do.

Thanks,
Namhyung
