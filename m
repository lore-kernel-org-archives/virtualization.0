From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [Qemu-devel] [PATCH 6/7] qemu: Implement virtio-pstore device
Date: Sat, 30 Jul 2016 17:57:02 +0900
Message-ID: <20160730085702.GB26275@danjae.aot.lge.com>
References: <1469632111-23260-1-git-send-email-namhyung@kernel.org>
	<1469632111-23260-7-git-send-email-namhyung@kernel.org>
	<20160728132239.GM22677@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160728132239.GM22677@redhat.com>
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

On Thu, Jul 28, 2016 at 02:22:39PM +0100, Daniel P. Berrange wrote:
> On Thu, Jul 28, 2016 at 12:08:30AM +0900, Namhyung Kim wrote:
> > Add virtio pstore device to allow kernel log files saved on the host.
> > It will save the log files on the directory given by pstore device
> > option.
> > 
> >   $ qemu-system-x86_64 -device virtio-pstore,directory=dir-xx ...
> > 
> >   (guest) # echo c > /proc/sysrq-trigger
> > 
> >   $ ls dir-xx
> >   dmesg-1.enc.z  dmesg-2.enc.z
> > 
> > The log files are usually compressed using zlib.  Users can see the log
> > messages directly on the host or on the guest (using pstore filesystem).
> > 
> > The 'directory' property is required for virtio-pstore device to work.
> > It also adds 'bufsize' and 'console' (boolean) properties.
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
> > ---

[SNIP]
> > +static void virtio_pstore_to_filename(VirtIOPstore *s, char *buf, size_t sz,
> > +                                      struct virtio_pstore_req *req)
> > +{
> > +    const char *basename;
> > +    unsigned long long id = 0;
> > +    unsigned int flags = le32_to_cpu(req->flags);
> > +
> > +    switch (le16_to_cpu(req->type)) {
> > +    case VIRTIO_PSTORE_TYPE_DMESG:
> > +        basename = "dmesg";
> > +        id = s->id++;
> > +        break;
> > +    case VIRTIO_PSTORE_TYPE_CONSOLE:
> > +        basename = "console";
> > +        if (s->console_id) {
> > +            id = s->console_id;
> > +        } else {
> > +            id = s->console_id = s->id++;
> > +        }
> > +        break;
> > +    default:
> > +        basename = "unknown";
> > +        break;
> > +    }
> > +
> > +    snprintf(buf, sz, "%s/%s-%llu%s", s->directory, basename, id,
> > +             flags & VIRTIO_PSTORE_FL_COMPRESSED ? ".enc.z" : "");
> 
> Please use g_strdup_printf() instead of splattering into a pre-allocated
> buffer than may or may not be large enough.

OK.

> 
> > +}
> > +
> > +static void virtio_pstore_from_filename(VirtIOPstore *s, char *name,
> > +                                        char *buf, size_t sz,
> > +                                        struct virtio_pstore_fileinfo *info)
> > +{
> > +    snprintf(buf, sz, "%s/%s", s->directory, name);
> > +
> > +    if (g_str_has_prefix(name, "dmesg-")) {
> > +        info->type = VIRTIO_PSTORE_TYPE_DMESG;
> > +        name += strlen("dmesg-");
> > +    } else if (g_str_has_prefix(name, "console-")) {
> > +        info->type = VIRTIO_PSTORE_TYPE_CONSOLE;
> > +        name += strlen("console-");
> > +    } else if (g_str_has_prefix(name, "unknown-")) {
> > +        info->type = VIRTIO_PSTORE_TYPE_UNKNOWN;
> > +        name += strlen("unknown-");
> > +    }
> > +
> > +    qemu_strtoull(name, NULL, 0, &info->id);
> > +
> > +    info->flags = 0;
> > +    if (g_str_has_suffix(name, ".enc.z")) {
> > +        info->flags |= VIRTIO_PSTORE_FL_COMPRESSED;
> > +    }
> > +}
> > +
> > +static ssize_t virtio_pstore_do_open(VirtIOPstore *s)
> > +{
> > +    s->dirp = opendir(s->directory);
> > +    if (s->dirp == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static ssize_t virtio_pstore_do_read(VirtIOPstore *s, struct iovec *in_sg,
> > +                                     unsigned int in_num,
> > +                                     struct virtio_pstore_res *res)
> > +{
> > +    char path[PATH_MAX];
> 
> Don't declare PATH_MAX sized variables

Will change to use g_strdup_printf() as you said.

> 
> > +    int fd;
> > +    ssize_t len;
> > +    struct stat stbuf;
> > +    struct dirent *dent;
> > +    int sg_num = in_num;
> > +    struct iovec sg[sg_num];
> 
> 'sg_num' is initialized from 'in_num' which comes from the
> guest, and I'm not seeing anything which is bounds-checking
> the 'in_num' value. So you've possibly got a security flaw here
> I think, if the guest can cause QEMU to allocate arbitrary stack
> memory & thus overflow by setting arbitrarily large in_num.

Will add a bound check then.

> 
> > +    struct virtio_pstore_fileinfo info;
> > +    size_t offset = sizeof(*res) + sizeof(info);
> > +
> > +    if (s->dirp == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    dent = readdir(s->dirp);
> > +    while (dent) {
> > +        if (dent->d_name[0] != '.') {
> > +            break;
> > +        }
> > +        dent = readdir(s->dirp);
> > +    }
> > +
> > +    if (dent == NULL) {
> > +        return 0;
> > +    }
> 
> So this seems to just be picking the first filename reported by
> readdir that isn't starting with '.'. Surely this can't the right
> logic when your corresponding do_write method can pick several
> different filenames, its potluck which do_read will give back.

Do you mean that it'd be better to check a list of known filenames and
fail if not?

> 
> > +
> > +    /* skip res and fileinfo */
> > +    sg_num = iov_copy(sg, sg_num, in_sg, in_num, offset,
> > +                      iov_size(in_sg, in_num) - offset);
> > +
> > +    virtio_pstore_from_filename(s, dent->d_name, path, sizeof(path), &info);
> > +    fd = open(path, O_RDONLY);
> > +    if (fd < 0) {
> > +        error_report("cannot open %s", path);
> > +        return -1;
> > +    }
> > +
> > +    if (fstat(fd, &stbuf) < 0) {
> > +        len = -1;
> > +        goto out;
> > +    }
> > +
> > +    len = readv(fd, sg, sg_num);
> > +    if (len < 0) {
> > +        if (errno == EAGAIN) {
> > +            len = 0;
> > +        }
> > +        goto out;
> > +    }
> > +
> > +    info.id        = cpu_to_le64(info.id);
> > +    info.type      = cpu_to_le16(info.type);
> > +    info.flags     = cpu_to_le32(info.flags);
> > +    info.len       = cpu_to_le32(len);
> > +    info.time_sec  = cpu_to_le64(stbuf.st_ctim.tv_sec);
> > +    info.time_nsec = cpu_to_le32(stbuf.st_ctim.tv_nsec);
> > +
> > +    iov_from_buf(in_sg, in_num, sizeof(*res), &info, sizeof(info));
> > +    len += sizeof(info);
> > +
> > + out:
> > +    close(fd);
> > +    return len;
> > +}
> > +
> > +static ssize_t virtio_pstore_do_write(VirtIOPstore *s, struct iovec *out_sg,
> > +                                      unsigned int out_num,
> > +                                      struct virtio_pstore_req *req)
> > +{
> > +    char path[PATH_MAX];
> > +    int fd;
> > +    ssize_t len;
> > +    unsigned short type;
> > +    int flags = O_WRONLY | O_CREAT;
> > +
> > +    /* we already consume the req */
> > +    iov_discard_front(&out_sg, &out_num, sizeof(*req));
> > +
> > +    virtio_pstore_to_filename(s, path, sizeof(path), req);
> > +
> > +    type = le16_to_cpu(req->type);
> > +
> > +    if (type == VIRTIO_PSTORE_TYPE_DMESG) {
> > +        flags |= O_TRUNC;
> > +    } else if (type == VIRTIO_PSTORE_TYPE_CONSOLE) {
> > +        flags |= O_APPEND;
> 
> Using O_APPEND will cause the file to grow without bound on the
> host, which is highly undesirable, aka a security flaw.

Right.  The plan is to add size checking and to split if it exceeds
some limit.  And we can keep some number of recent files only.

Thanks,
Namhyung


> 
> > +    }
> > +
> > +    fd = open(path, flags, 0644);
> > +    if (fd < 0) {
> > +        error_report("cannot open %s", path);
> > +        return -1;
> > +    }
> > +    len = writev(fd, out_sg, out_num);
> > +    close(fd);
> > +
> > +    return len;
> > +}
> 
> 
> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
> |: http://entangle-photo.org       -o-       http://live.gnome.org/gtk-vnc :|
