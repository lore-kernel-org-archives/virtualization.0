From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Mon, 18 Jul 2016 14:50:37 +0900
Message-ID: <20160718055037.GA8051__36853.0652988285$1468853103$gmane$org@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<CAGXu5jL8frrV99QXrw4touwnXAX0pesxKJnq4Bd_2QZDip7K6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jL8frrV99QXrw4touwnXAX0pesxKJnq4Bd_2QZDip7K6Q@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, KVM <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel <qemu-devel@nongnu.org>, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

On Sun, Jul 17, 2016 at 10:12:26PM -0700, Kees Cook wrote:
> On Sun, Jul 17, 2016 at 9:37 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > The virtio pstore driver provides interface to the pstore subsystem so
> > that the guest kernel's log/dump message can be saved on the host
> > machine.  Users can access the log file directly on the host, or on the
> > guest at the next boot using pstore filesystem.  It currently deals with
> > kernel log (printk) buffer only, but we can extend it to have other
> > information (like ftrace dump) later.
> >
> > It supports legacy PCI device using single order-2 page buffer.  As all
> > operation of pstore is synchronous, it would be fine IMHO.  However I
> > don't know how to make write operation synchronous since it's called
> > with a spinlock held (from any context including NMI).
> >
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Kr??m???? <rkrcmar@redhat.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Anthony Liguori <aliguori@amazon.com>
> > Cc: Anton Vorontsov <anton@enomsg.org>
> > Cc: Colin Cross <ccross@android.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: kvm@vger.kernel.org
> > Cc: qemu-devel@nongnu.org
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> This looks great to me! I'd love to use this in qemu. (Right now I go
> through hoops to use the ramoops backend for testing.)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thank you!

> 
> Notes below...
>

[SNIP]
> > +static u16 to_virtio_type(struct virtio_pstore *vps, enum pstore_type_id type)
> > +{
> > +       u16 ret;
> > +
> > +       switch (type) {
> > +       case PSTORE_TYPE_DMESG:
> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_DMESG);
> > +               break;
> > +       default:
> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_UNKNOWN);
> > +               break;
> > +       }
> 
> I would love to see this support PSTORE_TYPE_CONSOLE too. It should be
> relatively easy to add: I think it'd just be another virtio command?

Do you want to append the data to the host file as guest does
printk()?  I think it needs some kind of buffer management, but it's
not hard to add IMHO.


> 
> > +
> > +       return ret;
> > +}
> > +

[SNIP]
> > +static int notrace virt_pstore_write(enum pstore_type_id type,
> > +                                    enum kmsg_dump_reason reason,
> > +                                    u64 *id, unsigned int part, int count,
> > +                                    bool compressed, size_t size,
> > +                                    struct pstore_info *psi)
> > +{
> > +       struct virtio_pstore *vps = psi->data;
> > +       struct virtio_pstore_hdr *hdr = &vps->hdr;
> > +       struct scatterlist sg[2];
> > +       unsigned int flags = compressed ? VIRTIO_PSTORE_FL_COMPRESSED : 0;
> > +
> > +       *id = vps->id++;
> > +
> > +       hdr->cmd   = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_CMD_WRITE);
> > +       hdr->id    = cpu_to_virtio64(vps->vdev, *id);
> > +       hdr->flags = cpu_to_virtio32(vps->vdev, flags);
> > +       hdr->type  = to_virtio_type(vps, type);
> > +
> > +       sg_init_table(sg, 2);
> > +       sg_set_buf(&sg[0], hdr, sizeof(*hdr));
> > +       sg_set_buf(&sg[1], psi->buf, size);
> > +       virtqueue_add_outbuf(vps->vq, sg, 2, vps, GFP_ATOMIC);
> > +       virtqueue_kick(vps->vq);
> > +
> > +       /* TODO: make it synchronous */
> > +       return 0;
> 
> The down side to this being asynchronous is the lack of error
> reporting. Perhaps this could check hdr->type before queuing and error
> for any VIRTIO_PSTORE_TYPE_UNKNOWN message instead of trying to send
> it?

I cannot follow, sorry.  Could you please elaborate it more?


> 
> > +}
> > +
> > +static int virt_pstore_erase(enum pstore_type_id type, u64 id, int count,
> > +                            struct timespec time, struct pstore_info *psi)
> > +{
> > +       struct virtio_pstore *vps = psi->data;
> > +       struct virtio_pstore_hdr *hdr = &vps->hdr;
> > +       struct scatterlist sg[1];
> > +       unsigned int len;
> > +
> > +       hdr->cmd   = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_CMD_ERASE);
> > +       hdr->id    = cpu_to_virtio64(vps->vdev, id);
> > +       hdr->type  = to_virtio_type(vps, type);
> > +
> > +       sg_init_one(sg, hdr, sizeof(*hdr));
> > +       virtqueue_add_outbuf(vps->vq, sg, 1, vps, GFP_KERNEL);
> > +       virtqueue_kick(vps->vq);
> > +
> > +       wait_event(vps->acked, virtqueue_get_buf(vps->vq, &len));
> > +       return 0;
> > +}
> > +
> > +static int virt_pstore_init(struct virtio_pstore *vps)
> > +{
> > +       struct pstore_info *psinfo = &vps->pstore;
> > +       int err;
> > +
> > +       vps->id = 0;
> > +       vps->buflen = 0;
> > +       psinfo->bufsize = VIRT_PSTORE_BUFSIZE;
> > +       psinfo->buf = (void *)__get_free_pages(GFP_KERNEL, VIRT_PSTORE_ORDER);
> > +       if (!psinfo->buf) {
> > +               pr_err("cannot allocate pstore buffer\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       psinfo->owner = THIS_MODULE;
> > +       psinfo->name  = "virtio";
> > +       psinfo->open  = virt_pstore_open;
> > +       psinfo->close = virt_pstore_close;
> > +       psinfo->read  = virt_pstore_read;
> > +       psinfo->erase = virt_pstore_erase;
> > +       psinfo->write = virt_pstore_write;
> > +       psinfo->flags = PSTORE_FLAGS_FRAGILE;
> 
> For console support, this flag would need to be dropped -- though I
> suspect you know that already.:)

Yep, I intentionally support DMESG type only in this patchset for
simplicity.  Others could be added later. :)


> 
> > +       psinfo->data  = vps;
> > +       spin_lock_init(&psinfo->buf_lock);
> > +
> > +       err = pstore_register(psinfo);
> > +       if (err)
> > +               kfree(psinfo->buf);
> > +
> > +       return err;
> > +}

[SNIP]
> 
> Awesome! Can't wait to use it. :)

Thanks for your review! :)

Thanks,
Namhyung

> 
> -Kees
> 
> -- 
> Kees Cook
> Chrome OS & Brillo Security
