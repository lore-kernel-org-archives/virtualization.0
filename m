From: "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Fri, 26 Aug 2016 08:27:23 -0400
Message-ID: <20160826122723.GA12514@redhat.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20160820080744.10344-3-namhyung@kernel.org>
	<20160824220051.GC18614@redhat.com>
	<20160826044840.GA8218@danjae.aot.lge.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160826044840.GA8218@danjae.aot.lge.com>
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
Cc: virtio-dev@lists.oasis-open.org, Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Tony Luck <tony.luck@intel.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 26, 2016 at 01:48:40PM +0900, Namhyung Kim wrote:
> Hi Daniel,
> 
> On Wed, Aug 24, 2016 at 06:00:51PM -0400, Daniel P. Berrange wrote:

> > > +    fd = open(filename, O_RDONLY);
> > > +    if (fd < 0) {
> > > +        error_report("cannot open %s", filename);
> > > +        goto out;
> > > +    }
> > > +
> > > +    if (fstat(fd, &stbuf) < 0) {
> > > +        goto out;
> > > +    }
> > > +
> > > +    rarg->vps            = s;
> > > +    rarg->elem           = elem;
> > > +    rarg->info.id        = cpu_to_le64(rarg->info.id);
> > > +    rarg->info.type      = cpu_to_le16(rarg->info.type);
> > > +    rarg->info.flags     = cpu_to_le32(rarg->info.flags);
> > > +    rarg->info.time_sec  = cpu_to_le64(stbuf.st_ctim.tv_sec);
> > > +    rarg->info.time_nsec = cpu_to_le32(stbuf.st_ctim.tv_nsec);
> > > +
> > > +    rarg->ioc = qio_channel_new_fd(fd, &err);
> > 
> > You should just use qio_channel_open_path() and avoid the earlier
> > call to open()
> 
> I did it because to call fstat() using the fd and wanted to keep the
> generic ioc pointer.

I'd suggest just using a cast inline, eg

  fstat(QIO_CHANNEL_FILE(ioc)->fd, &stbuf)


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
