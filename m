From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 6/7] qemu: Implement virtio-pstore device
Date: Tue, 2 Aug 2016 00:52:55 +0900
Message-ID: <20160801155255.GB24526@danjae.aot.lge.com>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<1469632111-23260-7-git-send-email-namhyung@kernel.org>
	<20160728132239.GM22677@redhat.com>
	<20160730085702.GB26275@danjae.aot.lge.com>
	<20160801092439.GF6455@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160801092439.GF6455@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim Kr??m???? <rkrcmar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Minchan Kim <minchan@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 01, 2016 at 10:24:39AM +0100, Daniel P. Berrange wrote:
> On Sat, Jul 30, 2016 at 05:57:02PM +0900, Namhyung Kim wrote:
> > On Thu, Jul 28, 2016 at 02:22:39PM +0100, Daniel P. Berrange wrote:
> > > > +static void virtio_pstore_from_filename(VirtIOPstore *s, char *name,
> > > > +                                        char *buf, size_t sz,
> > > > +                                        struct virtio_pstore_fileinfo *info)
> > > > +{
> > > > +    snprintf(buf, sz, "%s/%s", s->directory, name);
> > > > +
> > > > +    if (g_str_has_prefix(name, "dmesg-")) {
> > > > +        info->type = VIRTIO_PSTORE_TYPE_DMESG;
> > > > +        name += strlen("dmesg-");
> > > > +    } else if (g_str_has_prefix(name, "console-")) {
> > > > +        info->type = VIRTIO_PSTORE_TYPE_CONSOLE;
> > > > +        name += strlen("console-");
> > > > +    } else if (g_str_has_prefix(name, "unknown-")) {
> > > > +        info->type = VIRTIO_PSTORE_TYPE_UNKNOWN;
> > > > +        name += strlen("unknown-");
> > > > +    }
> 
> [snip]
> 
> > > > +    struct virtio_pstore_fileinfo info;
> > > > +    size_t offset = sizeof(*res) + sizeof(info);
> > > > +
> > > > +    if (s->dirp == NULL) {
> > > > +        return -1;
> > > > +    }
> > > > +
> > > > +    dent = readdir(s->dirp);
> > > > +    while (dent) {
> > > > +        if (dent->d_name[0] != '.') {
> > > > +            break;
> > > > +        }
> > > > +        dent = readdir(s->dirp);
> > > > +    }
> > > > +
> > > > +    if (dent == NULL) {
> > > > +        return 0;
> > > > +    }
> > > 
> > > So this seems to just be picking the first filename reported by
> > > readdir that isn't starting with '.'. Surely this can't the right
> > > logic when your corresponding do_write method can pick several
> > > different filenames, its potluck which do_read will give back.
> > 
> > Do you mean that it'd be better to check a list of known filenames and
> > fail if not?
> 
> No, I mean that you have several different VIRTIO_PSTORE_TYPE_nnn and
> use a different file for each constant. When reading this directory
> though you're not looking for the file corresponding to any given
> VIRTIO_PSTORE_TYPE_nnn - you're simply reading whichever file is found
> first. So you might have just read a TYPE_CONSOLE or have read a
> TYPE_DMESG - it surely doesn't make sense to randonly read either
> TYPE_CONSOLE or TYPE_DMESG based on whatever order readdir() lists
> the files.

In fact, each VIRTIO_PSTORE_TYPE_xxx can have more than one files and
I don't care about the ordering between them.  They will be fed to the
pstore filesystem on the guest.

But I also think it'd be better to scan files of known types only
rather than read out whatever readdir() gives.

Thanks,
Namhyung
