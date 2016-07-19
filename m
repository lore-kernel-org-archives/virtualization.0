From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] virtio: Basic implementation of virtio pstore driver
Date: Tue, 19 Jul 2016 22:43:03 +0900
Message-ID: <20160719134303.GA20047@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-2-git-send-email-namhyung@kernel.org>
	<CAGXu5jL8frrV99QXrw4touwnXAX0pesxKJnq4Bd_2QZDip7K6Q@mail.gmail.com>
	<20160718055037.GA8051@danjae.aot.lge.com>
	<CAGXu5jJBM6GLwR6B28US11v90pFsiU2yJddm4V6kx3CHdLcOqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAGXu5jJBM6GLwR6B28US11v90pFsiU2yJddm4V6kx3CHdLcOqQ@mail.gmail.com>
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

Hi Kees,

On Mon, Jul 18, 2016 at 10:50:06AM -0700, Kees Cook wrote:
> On Sun, Jul 17, 2016 at 10:50 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > Hello,
> >
> > On Sun, Jul 17, 2016 at 10:12:26PM -0700, Kees Cook wrote:
> >> On Sun, Jul 17, 2016 at 9:37 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> > [SNIP]
> >> > +static u16 to_virtio_type(struct virtio_pstore *vps, enum pstore_type_id type)
> >> > +{
> >> > +       u16 ret;
> >> > +
> >> > +       switch (type) {
> >> > +       case PSTORE_TYPE_DMESG:
> >> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_DMESG);
> >> > +               break;
> >> > +       default:
> >> > +               ret = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_TYPE_UNKNOWN);
> >> > +               break;
> >> > +       }
> >>
> >> I would love to see this support PSTORE_TYPE_CONSOLE too. It should be
> >> relatively easy to add: I think it'd just be another virtio command?
> >
> > Do you want to append the data to the host file as guest does
> > printk()?  I think it needs some kind of buffer management, but it's
> > not hard to add IMHO.
> 
> Well, with most pstore backends, the buffer size is limited, so it
> tends to be a circular buffer of some sort. I think whatever you
> choose to do is fine (I saw the various mentions of resource limits in
> the qemu part of this thread), as long as the last N bytes of console
> can be seen on the host side, where N is some portion of the memory
> set aside for the log. (I don't mind the idea of an unlimited console
> log either, but I suspect that will not be accepted on the qemu
> side...)

I think it needs two kinds of buffer management.

The first one is the psinfo->buf (or something similar).  IIUC the
PSTORE_TYPE_CONSOLE is different than PSTORE_TYPE_DMESG as it is
emitted every time printk() sends messages to console.  So I think the
it should remain in async mode due to performance reason.  To do that,
the message should be copied to psinfo->buf and then sent via virtio.
Then it needs to keep track of the available buffer position IMHO.

The other one is the file management on the host side.  I am thinking
of a simple way that the log file is splitted when it exceeds the half
of the allowed max size.  It would be configurable and might allow
unlimited logs if user requests it explicitly (if qemu guys say ok)..

Maybe we need to use 'part' or 'count' for filenames to identify
the splitted files.

> 
> > [SNIP]
> >> > +static int notrace virt_pstore_write(enum pstore_type_id type,
> >> > +                                    enum kmsg_dump_reason reason,
> >> > +                                    u64 *id, unsigned int part, int count,
> >> > +                                    bool compressed, size_t size,
> >> > +                                    struct pstore_info *psi)
> >> > +{
> >> > +       struct virtio_pstore *vps = psi->data;
> >> > +       struct virtio_pstore_hdr *hdr = &vps->hdr;
> >> > +       struct scatterlist sg[2];
> >> > +       unsigned int flags = compressed ? VIRTIO_PSTORE_FL_COMPRESSED : 0;
> >> > +
> >> > +       *id = vps->id++;
> >> > +
> >> > +       hdr->cmd   = cpu_to_virtio16(vps->vdev, VIRTIO_PSTORE_CMD_WRITE);
> >> > +       hdr->id    = cpu_to_virtio64(vps->vdev, *id);
> >> > +       hdr->flags = cpu_to_virtio32(vps->vdev, flags);
> >> > +       hdr->type  = to_virtio_type(vps, type);
> >> > +
> >> > +       sg_init_table(sg, 2);
> >> > +       sg_set_buf(&sg[0], hdr, sizeof(*hdr));
> >> > +       sg_set_buf(&sg[1], psi->buf, size);
> >> > +       virtqueue_add_outbuf(vps->vq, sg, 2, vps, GFP_ATOMIC);
> >> > +       virtqueue_kick(vps->vq);
> >> > +
> >> > +       /* TODO: make it synchronous */
> >> > +       return 0;
> >>
> >> The down side to this being asynchronous is the lack of error
> >> reporting. Perhaps this could check hdr->type before queuing and error
> >> for any VIRTIO_PSTORE_TYPE_UNKNOWN message instead of trying to send
> >> it?
> >
> > I cannot follow, sorry.  Could you please elaborate it more?
> 
> The mention you have here of "TODO: make it synchronous" made me think
> about what effects that could have. If a pstore_write() were issued
> for a type other than DMESG, the above code would send it through
> virtio anyway. No error reporting is possible unless this is
> synchronous, but the only error here would simply be "I don't know
> what anything except DMESG is", so maybe this code could refuse to
> forward anything with type UNKNOWN in the first place. (Just an idea:
> I don't think there's anything very wrong here. It just seemed like a
> potential improvement.)

Yep, that kind of error handling should be easy.  My concern is when
write operation is failed on the host side.  We need a way to report
it back to the guest and might disallow further writes at least for
the same type.

Thanks,
Namhyung
