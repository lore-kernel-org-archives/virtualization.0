From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 6/7] qemu: Implement virtio-pstore device
Date: Mon, 1 Aug 2016 10:21:30 +0100
Message-ID: <20160801092130.GE6455@redhat.com>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<1469632111-23260-7-git-send-email-namhyung@kernel.org>
	<20160728023254-mutt-send-email-mst@kernel.org>
	<20160728053953.GB4371@sejong>
	<20160728125607.GA31002@stefanha-x1.localdomain>
	<20160728130841.GL22677@redhat.com>
	<20160730083827.GA26275@danjae.aot.lge.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160730083827.GA26275@danjae.aot.lge.com>
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
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim Kr??m???? <rkrcmar@redhat.com>, Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 30, 2016 at 05:38:27PM +0900, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Jul 28, 2016 at 02:08:41PM +0100, Daniel P. Berrange wrote:
> > On Thu, Jul 28, 2016 at 01:56:07PM +0100, Stefan Hajnoczi wrote:
> > > On Thu, Jul 28, 2016 at 02:39:53PM +0900, Namhyung Kim wrote:
> > > > On Thu, Jul 28, 2016 at 03:02:54AM +0300, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 28, 2016 at 12:08:30AM +0900, Namhyung Kim wrote:
> > > > > > +static ssize_t virtio_pstore_do_write(VirtIOPstore *s, struct iovec *out_sg,
> > > > > > +                                      unsigned int out_num,
> > > > > > +                                      struct virtio_pstore_req *req)
> > > > > > +{
> > > > > > +    char path[PATH_MAX];
> > > > > > +    int fd;
> > > > > > +    ssize_t len;
> > > > > > +    unsigned short type;
> > > > > > +    int flags = O_WRONLY | O_CREAT;
> > > > > > +
> > > > > > +    /* we already consume the req */
> > > > > > +    iov_discard_front(&out_sg, &out_num, sizeof(*req));
> > > > > > +
> > > > > > +    virtio_pstore_to_filename(s, path, sizeof(path), req);
> > > > > > +
> > > > > > +    type = le16_to_cpu(req->type);
> > > > > > +
> > > > > > +    if (type == VIRTIO_PSTORE_TYPE_DMESG) {
> > > > > > +        flags |= O_TRUNC;
> > > > > > +    } else if (type == VIRTIO_PSTORE_TYPE_CONSOLE) {
> > > > > > +        flags |= O_APPEND;
> > > > > > +    }
> > > > > > +
> > > > > > +    fd = open(path, flags, 0644);
> > > > > > +    if (fd < 0) {
> > > > > > +        error_report("cannot open %s", path);
> > > > > > +        return -1;
> > > > > > +    }
> > > > > > +    len = writev(fd, out_sg, out_num);
> > > > > > +    close(fd);
> > > > > > +
> > > > > > +    return len;
> > > > > 
> > > > > All this is blocking VM until host io completes.
> > > > 
> > > > Hmm.. I don't know about the internals of qemu.  So does it make guest
> > > > stop?  If so, that's what I want to do for _DMESG. :)  As it's called
> > > > only on kernel oops I think it's admittable.  But for _CONSOLE, it
> > > > needs to do asynchronously.  Maybe I can add a thread to do the work.
> > > 
> > > Please look at include/io/channel.h.  QEMU is event-driven and tends to
> > > use asynchronous I/O instead of spawning threads.  The include/io/ APIs
> > > allow you to do asynchronous I/O in the event loop.
> > 
> > That is true, except for I/O to/from plain files - the QIOChannelFile
> > impl doesn't do anything special (yet) to make that work correctly in
> > non-blocking mode. Of course that could be fixed...
> 
> Yep, I don't know how I can use the QIOChannelFile for async IO.
> AFAICS it's just a wrapper for normal readv/writev.  Who is
> responsible to do these IO when I use the IO channel API?  Also does
> it guarantee that all IOs are processed in order?

I'd suggest just using QIOChannelFile regardless - we need to fix the
blocking behaviour already for sake of the qemu chardev code, and your
code just adds more pressure to fix it. I/O will be done in the order
in which you make the calls, as with regular POSIX I/O funcs you're
currently using.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
