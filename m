From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Fri, 26 Aug 2016 13:48:40 +0900
Message-ID: <20160826044840.GA8218@danjae.aot.lge.com>
References: <20160820080744.10344-1-namhyung@kernel.org>
	<20160820080744.10344-3-namhyung@kernel.org>
	<20160824220051.GC18614@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160824220051.GC18614@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, Anton Vorontsov <anton@enomsg.org>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, qemu-devel@nongnu.org, Minchan Kim <minchan@kernel.org>, Tony Luck <tony.luck@intel.com>, Anthony Liguori <aliguori@amazon.com>, Colin Cross <ccross@android.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Daniel,

On Wed, Aug 24, 2016 at 06:00:51PM -0400, Daniel P. Berrange wrote:
> 
> > diff --git a/hw/virtio/virtio-pstore.c b/hw/virtio/virtio-pstore.c
> > new file mode 100644
> > index 0000000..b8fb4be
> > --- /dev/null
> > +++ b/hw/virtio/virtio-pstore.c
> > @@ -0,0 +1,699 @@
> > +/*
> > + * Virtio Pstore Device
> > + *
> > + * Copyright (C) 2016  LG Electronics
> > + *
> > + * Authors:
> > + *  Namhyung Kim  <namhyung@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > + * See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include <stdio.h>
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/iov.h"
> > +#include "qemu-common.h"
> > +#include "qemu/cutils.h"
> > +#include "qemu/error-report.h"
> > +#include "sysemu/kvm.h"
> > +#include "qapi/visitor.h"
> > +#include "qapi-event.h"
> > +#include "io/channel-util.h"
> > +#include "trace.h"
> > +
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/virtio/virtio-bus.h"
> > +#include "hw/virtio/virtio-access.h"
> > +#include "hw/virtio/virtio-pstore.h"
> > +
> > +#define PSTORE_DEFAULT_BUFSIZE   (16 * 1024)
> > +#define PSTORE_DEFAULT_FILE_MAX  5
> > +
> > +/* the index should match to the type value */
> > +static const char *virtio_pstore_file_prefix[] = {
> > +    "unknown-",		/* VIRTIO_PSTORE_TYPE_UNKNOWN */
> > +    "dmesg-",		/* VIRTIO_PSTORE_TYPE_DMESG */
> > +};
> > +
> > +static char *virtio_pstore_to_filename(VirtIOPstore *s,
> > +                                       struct virtio_pstore_req *req)
> > +{
> > +    const char *basename;
> > +    unsigned long long id;
> > +    unsigned int type = le16_to_cpu(req->type);
> > +    unsigned int flags = le32_to_cpu(req->flags);
> > +
> > +    if (type < ARRAY_SIZE(virtio_pstore_file_prefix)) {
> > +        basename = virtio_pstore_file_prefix[type];
> > +    } else {
> > +        basename = "unknown-";
> > +    }
> > +
> > +    id = s->id++;
> > +    return g_strdup_printf("%s/%s%llu%s", s->directory, basename, id,
> > +                            flags & VIRTIO_PSTORE_FL_COMPRESSED ? ".enc.z" : "");
> > +}
> > +
> > +static char *virtio_pstore_from_filename(VirtIOPstore *s, char *name,
> > +                                         struct virtio_pstore_fileinfo *info)
> > +{
> > +    char *filename;
> > +    unsigned int idx;
> > +
> > +    filename = g_strdup_printf("%s/%s", s->directory, name);
> > +    if (filename == NULL)
> > +        return NULL;
> > +
> > +    for (idx = 0; idx < ARRAY_SIZE(virtio_pstore_file_prefix); idx++) {
> > +        if (g_str_has_prefix(name, virtio_pstore_file_prefix[idx])) {
> > +            info->type = idx;
> > +            name += strlen(virtio_pstore_file_prefix[idx]);
> > +            break;
> > +        }
> > +    }
> > +
> > +    if (idx == ARRAY_SIZE(virtio_pstore_file_prefix)) {
> > +        g_free(filename);
> > +        return NULL;
> > +    }
> > +
> > +    qemu_strtoull(name, NULL, 0, &info->id);
> > +
> > +    info->flags = 0;
> > +    if (g_str_has_suffix(name, ".enc.z")) {
> > +        info->flags |= VIRTIO_PSTORE_FL_COMPRESSED;
> > +    }
> > +
> > +    return filename;
> > +}
> > +
> > +static int prefix_idx;
> > +static int prefix_count;
> > +static int prefix_len;
> > +
> > +static int filter_pstore(const struct dirent *de)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < prefix_count; i++) {
> > +        const char *prefix = virtio_pstore_file_prefix[prefix_idx + i];
> > +
> > +        if (g_str_has_prefix(de->d_name, prefix)) {
> > +            return 1;
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int sort_pstore(const struct dirent **a, const struct dirent **b)
> > +{
> > +    uint64_t id_a, id_b;
> > +
> > +    qemu_strtoull((*a)->d_name + prefix_len, NULL, 0, &id_a);
> > +    qemu_strtoull((*b)->d_name + prefix_len, NULL, 0, &id_b);
> > +
> > +    return id_a - id_b;
> > +}
> > +
> > +static int rotate_pstore_file(VirtIOPstore *s, unsigned short type)
> 
> AFAIK you're not actually doing file rotation here - that implies a
> fixed base filename, with .0, .1, .2, etc suffixes where we rename
> files each time. It looks like you are assuming separate filenames,
> and are merely deleting the oldest each time.

Ah, right.  It's not rotation and I think it's enough for my purpose.
I need to change the name.

> 
> > +{
> > +    int ret = 0;
> > +    int i, num;
> > +    char *filename;
> > +    struct dirent **files;
> > +
> > +    if (type >= ARRAY_SIZE(virtio_pstore_file_prefix)) {
> > +        type = VIRTIO_PSTORE_TYPE_UNKNOWN;
> > +    }
> > +
> > +    prefix_idx = type;
> > +    prefix_len = strlen(virtio_pstore_file_prefix[type]);
> > +    prefix_count = 1;  /* only scan current type */
> > +
> > +    /* delete the oldest file in the same type */
> > +    num = scandir(s->directory, &files, filter_pstore, sort_pstore);
> > +    if (num < 0)
> > +        return num;
> > +    if (num < (int)s->file_max)
> > +        goto out;
> > +
> > +    filename = g_strdup_printf("%s/%s", s->directory, files[0]->d_name);
> > +    if (filename == NULL) {
> > +        ret = -1;
> > +        goto out;
> > +    }
> > +
> > +    ret = unlink(filename);
> 
> 
> 
> 
> 
> > +static gboolean pstore_async_read_fn(QIOChannel *ioc, GIOCondition condition,
> > +                                     gpointer data)
> > +{
> > +    struct pstore_read_arg *rarg = data;
> > +    struct virtio_pstore_fileinfo *info = &rarg->info;
> > +    VirtIOPstore *vps = rarg->vps;
> > +    VirtQueueElement *elem = rarg->elem;
> > +    struct virtio_pstore_res res;
> > +    size_t offset = sizeof(res) + sizeof(*info);
> > +    struct iovec *sg = elem->in_sg;
> > +    unsigned int sg_num = elem->in_num;
> > +    Error *err = NULL;
> > +    ssize_t len;
> > +    int ret;
> > +
> > +    /* skip res and fileinfo */
> > +    iov_discard_front(&sg, &sg_num, sizeof(res) + sizeof(*info));
> > +
> > +    len = qio_channel_readv(rarg->ioc, sg, sg_num, &err);
> > +    if (len < 0) {
> > +        if (errno == EAGAIN) {
> > +            len = 0;
> > +        }
> > +        ret = -1;
> > +    } else {
> > +        info->len = cpu_to_le32(len);
> > +        ret = 0;
> > +    }
> > +
> > +    res.cmd  = cpu_to_le16(VIRTIO_PSTORE_CMD_READ);
> > +    res.type = cpu_to_le16(VIRTIO_PSTORE_TYPE_UNKNOWN);
> > +    res.ret  = cpu_to_le32(ret);
> > +
> > +    /* now copy res and fileinfo */
> > +    iov_from_buf(elem->in_sg, elem->in_num, 0, &res, sizeof(res));
> > +    iov_from_buf(elem->in_sg, elem->in_num, sizeof(res), info, sizeof(*info));
> > +
> > +    len += offset;
> > +    virtqueue_push(vps->rvq, elem, len);
> > +    virtio_notify(VIRTIO_DEVICE(vps), vps->rvq);
> > +
> > +    return G_SOURCE_REMOVE;
> 
> G_SOURCE_REMOVE was added in glib 2.32, but QEMU only permits
> stuff that is present in 2.22. Just use "FALSE" instead.

Didn't know that, will change.

> 
> > +static ssize_t virtio_pstore_do_read(VirtIOPstore *s, VirtQueueElement *elem)
> > +{
> > +    char *filename = NULL;
> > +    int fd, idx;
> > +    struct stat stbuf;
> > +    struct pstore_read_arg *rarg = NULL;
> > +    Error *err = NULL;
> > +    int ret = -1;
> > +
> > +    if (s->file_idx >= s->num_file) {
> > +        return 0;
> > +    }
> > +
> > +    rarg = g_malloc(sizeof(*rarg));
> > +    if (rarg == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    idx = s->file_idx++;
> > +    filename = virtio_pstore_from_filename(s, s->files[idx]->d_name,
> > +                                           &rarg->info);
> > +    if (filename == NULL) {
> > +        goto out;
> > +    }
> > +
> > +    fd = open(filename, O_RDONLY);
> > +    if (fd < 0) {
> > +        error_report("cannot open %s", filename);
> > +        goto out;
> > +    }
> > +
> > +    if (fstat(fd, &stbuf) < 0) {
> > +        goto out;
> > +    }
> > +
> > +    rarg->vps            = s;
> > +    rarg->elem           = elem;
> > +    rarg->info.id        = cpu_to_le64(rarg->info.id);
> > +    rarg->info.type      = cpu_to_le16(rarg->info.type);
> > +    rarg->info.flags     = cpu_to_le32(rarg->info.flags);
> > +    rarg->info.time_sec  = cpu_to_le64(stbuf.st_ctim.tv_sec);
> > +    rarg->info.time_nsec = cpu_to_le32(stbuf.st_ctim.tv_nsec);
> > +
> > +    rarg->ioc = qio_channel_new_fd(fd, &err);
> 
> You should just use qio_channel_open_path() and avoid the earlier
> call to open()

I did it because to call fstat() using the fd and wanted to keep the
generic ioc pointer.


> 
> > +    if (err) {
> > +        error_reportf_err(err, "cannot create io channel: ");
> > +        goto out;
> > +    }
> > +
> > +    qio_channel_set_blocking(rarg->ioc, false, &err);
> > +    qio_channel_add_watch(rarg->ioc, G_IO_IN, pstore_async_read_fn, rarg,
> > +                          free_rarg_fn);
> > +    g_free(filename);
> > +    return 1;
> > +
> > +out:
> > +    g_free(filename);
> > +    g_free(rarg);
> > +
> > +    return ret;
> > +}
> 
> 
> > +static ssize_t virtio_pstore_do_write(VirtIOPstore *s, VirtQueueElement *elem,
> > +                                      struct virtio_pstore_req *req)
> > +{
> > +    unsigned short type = le16_to_cpu(req->type);
> > +    char *filename = NULL;
> > +    int fd;
> > +    int flags = O_WRONLY | O_CREAT | O_TRUNC;
> > +    struct pstore_write_arg *warg = NULL;
> > +    Error *err = NULL;
> > +    int ret = -1;
> > +
> > +    /* do not keep same type of files more than 'file-max' */
> > +    rotate_pstore_file(s, type);
> > +
> > +    filename = virtio_pstore_to_filename(s, req);
> > +    if (filename == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    warg = g_malloc(sizeof(*warg));
> > +    if (warg == NULL) {
> > +        goto out;
> > +    }
> > +
> > +    fd = open(filename, flags, 0644);
> > +    if (fd < 0) {
> > +        error_report("cannot open %s", filename);
> > +        ret = fd;
> > +        goto out;
> > +    }
> > +
> > +    warg->vps            = s;
> > +    warg->elem           = elem;
> > +    warg->req            = req;
> > +
> > +    warg->ioc = qio_channel_new_fd(fd, &err);
> 
> Same point about using new_path() instead of new_fd()

OK.

> 
> > +    if (err) {
> > +        error_reportf_err(err, "cannot create io channel: ");
> > +        goto out;
> > +    }
> > +
> > +    qio_channel_set_blocking(warg->ioc, false, &err);
> > +    qio_channel_add_watch(warg->ioc, G_IO_OUT, pstore_async_write_fn, warg,
> > +                          free_warg_fn);
> > +    g_free(filename);
> > +    return 1;
> > +
> > +out:
> > +    g_free(filename);
> > +    g_free(warg);
> > +    return ret;
> > +}
> > +
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
> > +        }
> > +
> > +        if (elem->out_num > 2 || elem->in_num > 3) {
> > +            error_report("invalid number of input/output buffer");
> > +            exit(1);
> > +        }
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
> > +
> > +        iov_from_buf(elem->in_sg, elem->in_num, 0, &res, sizeof(res));
> > +        virtqueue_push(vq, elem, sizeof(res) + len);
> > +
> > +        virtio_notify(vdev, vq);
> > +        g_free(elem);
> > +
> > +        if (ret < 0) {
> > +            return;
> > +        }
> > +    }
> > +}
> 
> Regards,
> Daniel

As always, thanks for your review!

Thanks,
Namhyung
