From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 2/3] qemu: Implement virtio-pstore device
Date: Mon, 18 Jul 2016 23:21:18 +0900
Message-ID: <20160718142118.GA16575__14161.9147886106$1468853175$gmane$org@danjae.aot.lge.com>
References: <1468816661-6345-1-git-send-email-namhyung@kernel.org>
	<1468816661-6345-3-git-send-email-namhyung@kernel.org>
	<20160718100353.GA15163@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160718100353.GA15163@stefanha-x1.localdomain>
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

Hello,

On Mon, Jul 18, 2016 at 11:03:53AM +0100, Stefan Hajnoczi wrote:
> On Mon, Jul 18, 2016 at 01:37:40PM +0900, Namhyung Kim wrote:
> > From: Namhyung Kim <namhyung@gmail.com>
> > 
> > Add virtio pstore device to allow kernel log files saved on the host.
> > It will save the log files on the directory given by pstore device
> > option.
> > 
> >   $ qemu-system-x86_64 -device virtio-pstore,directory=dir-xx ...
> > 
> >   (guest) # echo c > /proc/sysrq-trigger
> > 
> >   $ ls dir-xx
> >   dmesg-0.enc.z  dmesg-1.enc.z
> > 
> > The log files are usually compressed using zlib.  Users can see the log
> > messages directly on the host or on the guest (using pstore filesystem).
> 
> The implementation is synchronous (i.e. can pause guest code execution),
> does not handle write errors, and does not limit the amount of data the
> guest can write.  This is sufficient for ad-hoc debugging and usage with
> trusted guests.
> 
> If you want this to be available in environments where the guest isn't
> trusted then there must be a limit on how much the guest can write or
> some kind of log rotation.

Right.  The synchronous IO is required by the pstore subsystem
implementation AFAIK (it uses a single psinfo->buf in the loop).  And
I agree that it should have a way to handle write errors and to limit
amount of data.

> 
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
> > Signed-off-by: Namhyung Kim <namhyung@gmail.com>
> > ---

[SNIP]
> > +
> > +static void virtio_pstore_to_filename(VirtIOPstore *s, char *buf, size_t sz,
> > +                                      struct virtio_pstore_hdr *hdr)
> > +{
> > +    const char *basename;
> > +
> > +    switch (hdr->type) {
> 
> Missing le16_to_cpu()?
> 
> > +    case VIRTIO_PSTORE_TYPE_DMESG:
> > +        basename = "dmesg";
> > +        break;
> > +    default:
> > +        basename = "unknown";
> > +        break;
> > +    }
> > +
> > +    snprintf(buf, sz, "%s/%s-%llu%s", s->directory, basename,
> > +             (unsigned long long) hdr->id,
> 
> Missing le64_to_cpu()?
> 
> > +             hdr->flags & VIRTIO_PSTORE_FL_COMPRESSED ? ".enc.z" : "");
> 
> Missing le32_to_cpu()?

Oops, will fix.

> 
> > +}
> > +
> > +static void virtio_pstore_from_filename(VirtIOPstore *s, char *name,
> > +                                        char *buf, size_t sz,
> > +                                        struct virtio_pstore_hdr *hdr)
> > +{
> > +    size_t len = strlen(name);
> > +
> > +    hdr->flags = 0;
> > +    if (!strncmp(name + len - 6, ".enc.z", 6)) {
> 
> Please use g_str_has_suffix(name, ".enc.z") to avoid accessing before
> the beginning of the string if the filename is shorter than 6
> characters.

Ah, ok.

> 
> > +        hdr->flags |= VIRTIO_PSTORE_FL_COMPRESSED;
> > +    }
> > +
> > +    snprintf(buf, sz, "%s/%s", s->directory, name);
> > +
> > +    if (!strncmp(name, "dmesg-", 6)) {
> 
> g_str_has_prefix(name, "dmesg-")
> 
> > +        hdr->type = cpu_to_le16(VIRTIO_PSTORE_TYPE_DMESG);
> > +        name += 6;
> > +    } else if (!strncmp(name, "unknown-", 8)) {
> 
> g_str_has_prefix(name, "unknown-")

Will change.

> 
> > +        hdr->type = cpu_to_le16(VIRTIO_PSTORE_TYPE_UNKNOWN);
> > +        name += 8;
> > +    }
> > +
> > +    qemu_strtoull(name, NULL, 0, &hdr->id);
> > +}
> > +
> > +static ssize_t virtio_pstore_do_open(VirtIOPstore *s)
> > +{
> > +    s->dir = opendir(s->directory);
> > +    if (s->dir == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> > +static ssize_t virtio_pstore_do_read(VirtIOPstore *s, void *buf, size_t sz,
> > +                                      struct virtio_pstore_hdr *hdr)
> > +{
> > +    char path[PATH_MAX];
> > +    FILE *fp;
> > +    ssize_t len;
> > +    struct stat stbuf;
> > +    struct dirent *dent;
> > +
> > +    if (s->dir == NULL) {
> > +        return -1;
> > +    }
> > +
> > +    dent = readdir(s->dir);
> > +    while (dent) {
> > +        if (dent->d_name[0] != '.') {
> > +            break;
> > +        }
> > +        dent = readdir(s->dir);
> > +    }
> > +
> > +    if (dent == NULL) {
> > +        return 0;
> > +    }
> > +
> > +    virtio_pstore_from_filename(s, dent->d_name, path, sizeof(path), hdr);
> > +    if (stat(path, &stbuf) < 0) {
> > +        return -1;
> > +    }
> 
> Please use fstat(fileno(fp), &stbuf) after opening the file instead.
> The race condition doesn't matter in this case but the race-free code is
> just as simple so it's one less thing someone reading the code has to
> worry about.

Fair enough.

> 
> > +
> > +    fp = fopen(path, "r");
> > +    if (fp == NULL) {
> > +        error_report("cannot open %s (%p %p)", path, s, s->directory);
> > +        return -1;
> > +    }
> > +
> > +    len = fread(buf, 1, sz, fp);
> > +    if (len < 0 && errno == EAGAIN) {
> > +        len = 0;
> > +    }
> > +
> > +    hdr->id = cpu_to_le64(hdr->id);
> > +    hdr->flags = cpu_to_le32(hdr->flags);
> > +    hdr->time_sec = cpu_to_le64(stbuf.st_ctim.tv_sec);
> > +    hdr->time_nsec = cpu_to_le32(stbuf.st_ctim.tv_nsec);
> > +
> > +    fclose(fp);
> > +    return len;
> > +}
> > +

[SNIP]
> > +static void virtio_pstore_handle_io(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VirtIOPstore *s = VIRTIO_PSTORE(vdev);
> > +    VirtQueueElement *elem;
> > +    struct virtio_pstore_hdr *hdr;
> > +    ssize_t len;
> > +
> > +    for (;;) {
> > +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> > +        if (!elem) {
> > +            return;
> > +        }
> > +
> > +        hdr = elem->out_sg[0].iov_base;
> > +        if (elem->out_sg[0].iov_len != sizeof(*hdr)) {
> > +            error_report("invalid header size: %u",
> > +                         (unsigned)elem->out_sg[0].iov_len);
> > +            exit(1);
> > +        }
> 
> Please use iov_to_buf() instead of directly accessing out_sg[].  Virtio
> devices are not supposed to assume a particular iovec layout.  In other
> words, virtio_pstore_hdr could be split across multiple out_sg[] iovecs.

I got it.

> 
> You must also copy in data (similar to Linux syscall implementations) to
> prevent the guest from modifying data while the command is processed.
> Such race conditions could lead to security bugs.

Ok, but this assumes the operation is synchronous.  I agree on your
opinion if I could make it async.

> 
> > +
> > +        switch (hdr->cmd) {
> > +        case VIRTIO_PSTORE_CMD_OPEN:
> > +            len = virtio_pstore_do_open(s);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_READ:
> > +            len = virtio_pstore_do_read(s, elem->in_sg[0].iov_base,
> > +                                        elem->in_sg[0].iov_len, hdr);
> 
> Same issue with iovec layout for in_sg[] here.  The guest driver must be
> able to submit any in_sg[] iovec array and the device cannot assume
> in_sg[0] is the only iovec to fill.

Ok.

> 
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_WRITE:
> > +            len = virtio_pstore_do_write(s, elem->out_sg[1].iov_base,
> > +                                         elem->out_sg[1].iov_len, hdr);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_CLOSE:
> > +            len = virtio_pstore_do_close(s);
> > +            break;
> > +        case VIRTIO_PSTORE_CMD_ERASE:
> > +            len = virtio_pstore_do_erase(s, hdr);
> > +            break;
> > +        default:
> > +            len = -1;
> > +            break;
> > +        }
> > +
> > +        if (len < 0) {
> > +            return;
> > +        }
> > +
> > +        virtqueue_push(vq, elem, len);
> > +
> > +        virtio_notify(vdev, vq);
> > +        g_free(elem);
> > +    }
> > +}
> > +
> > +static void virtio_pstore_device_realize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +    VirtIOPstore *s = VIRTIO_PSTORE(dev);
> > +
> > +    virtio_init(vdev, "virtio-pstore", VIRTIO_ID_PSTORE, 0);
> > +
> > +    s->vq = virtio_add_queue(vdev, 128, virtio_pstore_handle_io);
> > +}
> > +
> > +static void virtio_pstore_device_unrealize(DeviceState *dev, Error **errp)
> > +{
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> > +
> > +    virtio_cleanup(vdev);
> > +}
> > +
> > +static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
> > +{
> > +    return f;
> > +}
> > +
> > +static void pstore_get_directory(Object *obj, Visitor *v,
> > +                                 const char *name, void *opaque,
> > +                                 Error **errp)
> > +{
> > +    VirtIOPstore *s = opaque;
> > +
> > +    visit_type_str(v, name, &s->directory, errp);
> > +}
> > +
> > +static void pstore_set_directory(Object *obj, Visitor *v,
> > +                                 const char *name, void *opaque,
> > +                                 Error **errp)
> > +{
> > +    VirtIOPstore *s = opaque;
> > +    Error *local_err = NULL;
> > +    char *value;
> > +
> > +    visit_type_str(v, name, &value, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    g_free(s->directory);
> > +    s->directory = strdup(value);
> 
> Please use g_strdup() since this is paired with g_free().
> 
> Or even simpler would be s->directory = value and do not g_free(value)
> below.

Ok, I was not sure whether I could use it without alloc/free pair.
Will do it simpler way then. :)


> 
> > +
> > +    g_free(value);
> > +}
> > +
> > +static void pstore_release_directory(Object *obj, const char *name,
> > +                                     void *opaque)
> > +{
> > +    VirtIOPstore *s = opaque;
> > +
> > +    g_free(s->directory);
> > +    s->directory = NULL;
> > +}
> > +
> > +static Property virtio_pstore_properties[] = {
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void virtio_pstore_instance_init(Object *obj)
> > +{
> > +    VirtIOPstore *s = VIRTIO_PSTORE(obj);
> > +
> > +    object_property_add(obj, "directory", "str",
> > +                        pstore_get_directory, pstore_set_directory,
> > +                        pstore_release_directory, s, NULL);
> > +}
> > +
> > +static void virtio_pstore_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc = DEVICE_CLASS(klass);
> > +    VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
> > +
> > +    dc->props = virtio_pstore_properties;
> > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > +    vdc->realize = virtio_pstore_device_realize;
> > +    vdc->unrealize = virtio_pstore_device_unrealize;
> > +    vdc->get_features = get_features;
> > +}
> > +
> > +static const TypeInfo virtio_pstore_info = {
> > +    .name = TYPE_VIRTIO_PSTORE,
> > +    .parent = TYPE_VIRTIO_DEVICE,
> > +    .instance_size = sizeof(VirtIOPstore),
> > +    .instance_init = virtio_pstore_instance_init,
> > +    .class_init = virtio_pstore_class_init,
> > +};
> > +
> > +static void virtio_register_types(void)
> > +{
> > +    type_register_static(&virtio_pstore_info);
> > +}
> > +
> > +type_init(virtio_register_types)
> > diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> > index 9ed1624..5689c6f 100644
> > --- a/include/hw/pci/pci.h
> > +++ b/include/hw/pci/pci.h
> > @@ -79,6 +79,7 @@
> >  #define PCI_DEVICE_ID_VIRTIO_SCSI        0x1004
> >  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
> >  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
> > +#define PCI_DEVICE_ID_VIRTIO_PSTORE      0x100a
> >  
> >  #define PCI_VENDOR_ID_REDHAT             0x1b36
> >  #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
> > diff --git a/include/hw/virtio/virtio-pstore.h b/include/hw/virtio/virtio-pstore.h
> > new file mode 100644
> > index 0000000..74cd1f6
> > --- /dev/null
> > +++ b/include/hw/virtio/virtio-pstore.h
> > @@ -0,0 +1,30 @@
> > +/*
> > + * Virtio Pstore Support
> > + *
> > + * Authors:
> > + *  Namhyung Kim      <namhyung@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > + * the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#ifndef _QEMU_VIRTIO_PSTORE_H
> > +#define _QEMU_VIRTIO_PSTORE_H
> > +
> > +#include "standard-headers/linux/virtio_pstore.h"
> > +#include "hw/virtio/virtio.h"
> > +#include "hw/pci/pci.h"
> > +
> > +#define TYPE_VIRTIO_PSTORE "virtio-pstore-device"
> > +#define VIRTIO_PSTORE(obj) \
> > +        OBJECT_CHECK(VirtIOPstore, (obj), TYPE_VIRTIO_PSTORE)
> > +
> > +typedef struct VirtIOPstore {
> > +    VirtIODevice parent_obj;
> > +    VirtQueue *vq;
> > +    char *directory;
> > +    DIR *dir;
> > +} VirtIOPstore;
> > +
> > +#endif
> > diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> > index 77925f5..cba6322 100644
> > --- a/include/standard-headers/linux/virtio_ids.h
> > +++ b/include/standard-headers/linux/virtio_ids.h
> > @@ -41,5 +41,6 @@
> >  #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
> >  #define VIRTIO_ID_GPU          16 /* virtio GPU */
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> > +#define VIRTIO_ID_PSTORE       19 /* virtio pstore */
> 
> 19 has already been reserved.  22 is the next free ID (vsock, crypto,
> and sdm are currently under review and already use 19, 20, and 21).

I wasn't aware of the ongoing works but Cornelia already told me about
it.  Will update.

> 
> Please send a VIRTIO draft specification to
> virtio-dev@lists.oasis-open.org.  You can find information on the VIRTIO
> standards process here:
> https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=virtio

Thank you very much for this information and your detailed review!
I'll take a look at the virtio standards process too.

Thanks,
Namhyung
