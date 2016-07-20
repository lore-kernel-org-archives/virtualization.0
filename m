From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Wed, 20 Jul 2016 21:30:17 +0900
Message-ID: <20160720123017.GA5682@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
	<20160718100353.GA15163@stefanha-x1.localdomain>
	<20160719154839.GB20047@danjae.aot.lge.com>
	<20160720082108.GA13233@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160720082108.GA13233@stefanha-x1.localdomain>
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
Cc: Tony Luck <tony.luck@intel.com>, Radim Kr??m???? <rkrcmar@redhat.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 20, 2016 at 09:21:08AM +0100, Stefan Hajnoczi wrote:
> On Wed, Jul 20, 2016 at 12:48:39AM +0900, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Jul 18, 2016 at 11:03:53AM +0100, Stefan Hajnoczi wrote:
> > > On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> > > > +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *vq)
> > > > +{
> > > > +    VirtIOPstore *s = VIRTIO_PSTORE(vdev);
> > > > +    VirtQueueElement *elem;
> > > > +    struct virtio_pstore_hdr *hdr;
> > > > +    ssize_t len;
> > > > +
> > > > +    for (;;) {
> > > > +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > > > +        if (!elem) {
> > > > +            return;
> > > > +        }
> > > > +
> > > > +        hdr = elem->out_sg[0].iov_base;
> > > > +        if (elem->out_sg[0].iov_len != sizeof(*hdr)) {
> > > > +            error_report("invalid header size: %u",
> > > > +                         (unsigned)elem->out_sg[0].iov_len);
> > > > +            exit(1);
> > > > +        }
> > > 
> > > Please use iov_to_buf() instead of directly accessing out_sg[].  Virtio
> > > devices are not supposed to assume a particular iovec layout.  In other
> > > words, virtio_pstore_hdr could be split across multiple out_sg[] iovecs.
> > > 
> > > You must also copy in data (similar to Linux syscall implementations) to
> > > prevent the guest from modifying data while the command is processed.
> > > Such race conditions could lead to security bugs.
> > 
> > By accessing elem->out_sg[0].iov_base directly, I abused it as an
> > in-and-out buffer.  But it seems not allowed by the virtio spec, do I
> > have to use separate buffers for request and response?
> 
> Yes, a virtqueue element has (host read-only) out buffers followed by
> (host write-only) in buffers.

Thanks for clarification.  I'll split them.

Thanks,
Namhyung
