From: Zhi Yong Wu <zwu.kernel@gmail.com>
Subject: Re: [PATCH 2/2] tools/virtio: virtio_test tool
Date: Wed, 7 Sep 2011 11:34:19 +0800
Message-ID: <CAEH94Lhzcz207-F5r27_PNXnC52DnFPK-jjAj-ECEtpt643fBQ__30615.8517873429$1315366542$gmane$org@mail.gmail.com>
References: <20101129170431.GA4027@redhat.com>
	<20101129171637.GC4027@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20101129171637.GC4027@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Thanks. very good learning material.

On Tue, Nov 30, 2010 at 1:16 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> This is the userspace part of the tool: it includes a bunch of stubs for
> linux APIs, somewhat simular to linuxsched. This makes it possible to
> recompile the ring code in userspace.
>
> A small test example is implemented combining this with vhost_test
> module.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> new file mode 100644
> index 0000000..d1d442e
> --- /dev/null
> +++ b/tools/virtio/Makefile
> @@ -0,0 +1,12 @@
> +all: test mod
> +test: virtio_test
> +virtio_test: virtio_ring.o virtio_test.o
> +CFLAGS +=3D -g -O2 -Wall -I. -I ../../usr/include/ -Wno-pointer-sign -fn=
o-strict-overflow =A0-MMD
> +vpath %.c ../../drivers/virtio
> +mod:
> + =A0 =A0 =A0 ${MAKE} -C `pwd`/../.. M=3D`pwd`/vhost_test
> +.PHONY: all test mod clean
> +clean:
> + =A0 =A0 =A0 ${RM} *.o vhost_test/*.o vhost_test/.*.cmd \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0vhost_test/Module.symvers vhost_test/modules=
.order *.d
> +-include *.d
> diff --git a/tools/virtio/linux/device.h b/tools/virtio/linux/device.h
> new file mode 100644
> index 0000000..4ad7e1d
> --- /dev/null
> +++ b/tools/virtio/linux/device.h
> @@ -0,0 +1,2 @@
> +#ifndef LINUX_DEVICE_H
> +#endif
> diff --git a/tools/virtio/linux/slab.h b/tools/virtio/linux/slab.h
> new file mode 100644
> index 0000000..81baeac
> --- /dev/null
> +++ b/tools/virtio/linux/slab.h
> @@ -0,0 +1,2 @@
> +#ifndef LINUX_SLAB_H
> +#endif
> diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
> new file mode 100644
> index 0000000..669bcdd
> --- /dev/null
> +++ b/tools/virtio/linux/virtio.h
> @@ -0,0 +1,223 @@
> +#ifndef LINUX_VIRTIO_H
> +#define LINUX_VIRTIO_H
> +
> +#include <stdbool.h>
> +#include <stdlib.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <assert.h>
> +
> +#include <linux/types.h>
> +#include <errno.h>
> +
> +typedef unsigned long long dma_addr_t;
> +
> +struct scatterlist {
> + =A0 =A0 =A0 unsigned long =A0 page_link;
> + =A0 =A0 =A0 unsigned int =A0 =A0offset;
> + =A0 =A0 =A0 unsigned int =A0 =A0length;
> + =A0 =A0 =A0 dma_addr_t =A0 =A0 =A0dma_address;
> +};
> +
> +struct page {
> + =A0 =A0 =A0 unsigned long long dummy;
> +};
> +
> +#define BUG_ON(__BUG_ON_cond) assert(!(__BUG_ON_cond))
> +
> +/* Physical =3D=3D Virtual */
> +#define virt_to_phys(p) ((unsigned long)p)
> +#define phys_to_virt(a) ((void *)(unsigned long)(a))
> +/* Page address: Virtual / 4K */
> +#define virt_to_page(p) ((struct page*)((virt_to_phys(p) / 4096) * \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 sizeof(struct page)))
> +#define offset_in_page(p) (((unsigned long)p) % 4096)
> +#define sg_phys(sg) ((sg->page_link & ~0x3) / sizeof(struct page) * 4096=
 + \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sg->offset)
> +static inline void sg_mark_end(struct scatterlist *sg)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Set termination bit, clear potential chain bit
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 sg->page_link |=3D 0x02;
> + =A0 =A0 =A0 sg->page_link &=3D ~0x01;
> +}
> +static inline void sg_init_table(struct scatterlist *sgl, unsigned int n=
ents)
> +{
> + =A0 =A0 =A0 memset(sgl, 0, sizeof(*sgl) * nents);
> + =A0 =A0 =A0 sg_mark_end(&sgl[nents - 1]);
> +}
> +static inline void sg_assign_page(struct scatterlist *sg, struct page *p=
age)
> +{
> + =A0 =A0 =A0 unsigned long page_link =3D sg->page_link & 0x3;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In order for the low bit stealing approach to work, pa=
ges
> + =A0 =A0 =A0 =A0* must be aligned at a 32-bit boundary as a minimum.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 BUG_ON((unsigned long) page & 0x03);
> + =A0 =A0 =A0 sg->page_link =3D page_link | (unsigned long) page;
> +}
> +
> +static inline void sg_set_page(struct scatterlist *sg, struct page *page,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int=
 len, unsigned int offset)
> +{
> + =A0 =A0 =A0 sg_assign_page(sg, page);
> + =A0 =A0 =A0 sg->offset =3D offset;
> + =A0 =A0 =A0 sg->length =3D len;
> +}
> +
> +static inline void sg_set_buf(struct scatterlist *sg, const void *buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int bu=
flen)
> +{
> + =A0 =A0 =A0 sg_set_page(sg, virt_to_page(buf), buflen, offset_in_page(b=
uf));
> +}
> +
> +static inline void sg_init_one(struct scatterlist *sg, const void *buf, =
unsigned int buflen)
> +{
> + =A0 =A0 =A0 sg_init_table(sg, 1);
> + =A0 =A0 =A0 sg_set_buf(sg, buf, buflen);
> +}
> +
> +typedef __u16 u16;
> +
> +typedef enum {
> + =A0 =A0 =A0 GFP_KERNEL,
> + =A0 =A0 =A0 GFP_ATOMIC,
> +} gfp_t;
> +typedef enum {
> + =A0 =A0 =A0 IRQ_NONE,
> + =A0 =A0 =A0 IRQ_HANDLED
> +} irqreturn_t;
> +
> +static inline void *kmalloc(size_t s, gfp_t gfp)
> +{
> + =A0 =A0 =A0 return malloc(s);
> +}
> +
> +static inline void kfree(void *p)
> +{
> + =A0 =A0 =A0 free(p);
> +}
> +
> +#define container_of(ptr, type, member) ({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 \
> + =A0 =A0 =A0 const typeof( ((type *)0)->member ) *__mptr =3D (ptr); =A0 =
=A0\
> + =A0 =A0 =A0 (type *)( (char *)__mptr - offsetof(type,member) );})
> +
> +#define uninitialized_var(x) x =3D x
> +
> +# ifndef likely
> +# =A0define likely(x) =A0 =A0(__builtin_expect(!!(x), 1))
> +# endif
> +# ifndef unlikely
> +# =A0define unlikely(x) =A0(__builtin_expect(!!(x), 0))
> +# endif
> +
> +#define pr_err(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
> +#ifdef DEBUG
> +#define pr_debug(format, ...) fprintf (stderr, format, ## __VA_ARGS__)
> +#else
> +#define pr_debug(format, ...) do {} while (0)
> +#endif
> +#define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS_=
_)
> +#define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS=
__)
> +
> +/* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
> +#define list_add_tail(a, b) do {} while (0)
> +#define list_del(a) do {} while (0)
> +
> +#define BIT_WORD(nr) =A0 =A0 =A0 =A0 =A0 ((nr) / BITS_PER_LONG)
> +#define BITS_PER_BYTE =A0 =A0 =A0 =A0 =A08
> +#define BITS_PER_LONG (sizeof(long) * BITS_PER_BYTE)
> +#define BIT_MASK(nr) =A0 =A0 =A0 =A0 =A0 (1UL << ((nr) % BITS_PER_LONG))
> +/* TODO: Not atomic as it should be:
> + * we don't use this for anything important. */
> +static inline void clear_bit(int nr, volatile unsigned long *addr)
> +{
> + =A0 =A0 =A0 unsigned long mask =3D BIT_MASK(nr);
> + =A0 =A0 =A0 unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
> +
> + =A0 =A0 =A0 *p &=3D ~mask;
> +}
> +
> +static inline int test_bit(int nr, const volatile unsigned long *addr)
> +{
> + =A0 =A0 =A0 =A0return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG=
-1)));
> +}
> +
> +/* The only feature we care to support */
> +#define virtio_has_feature(dev, feature) \
> + =A0 =A0 =A0 test_bit((feature), (dev)->features)
> +/* end of stubs */
> +
> +struct virtio_device {
> + =A0 =A0 =A0 void *dev;
> + =A0 =A0 =A0 unsigned long features[1];
> +};
> +
> +struct virtqueue {
> + =A0 =A0 =A0 /* TODO: commented as list macros are empty stubs for now.
> + =A0 =A0 =A0 =A0* Broken but enough for virtio_ring.c
> + =A0 =A0 =A0 =A0* struct list_head list; */
> + =A0 =A0 =A0 void (*callback)(struct virtqueue *vq);
> + =A0 =A0 =A0 const char *name;
> + =A0 =A0 =A0 struct virtio_device *vdev;
> + =A0 =A0 =A0 void *priv;
> +};
> +
> +#define EXPORT_SYMBOL_GPL(__EXPORT_SYMBOL_GPL_name) \
> + =A0 =A0 =A0 void __EXPORT_SYMBOL_GPL##__EXPORT_SYMBOL_GPL_name() { \
> +}
> +#define MODULE_LICENSE(__MODULE_LICENSE_value) \
> + =A0 =A0 =A0 const char *__MODULE_LICENSE_name =3D __MODULE_LICENSE_value
> +
> +#define CONFIG_SMP
> +
> +#if defined(__i386__) || defined(__x86_64__)
> +#define barrier() asm volatile("" ::: "memory")
> +#define mb() __sync_synchronize()
> +
> +#define smp_mb() =A0 =A0 =A0 mb()
> +# define smp_rmb() =A0 =A0 barrier()
> +# define smp_wmb() =A0 =A0 barrier()
> +#else
> +#error Please fill in barrier macros
> +#endif
> +
> +/* Interfaces exported by virtio_ring. */
> +int virtqueue_add_buf_gfp(struct virtqueue *vq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct scatterlist sg[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int out_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int in_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gfp_t gfp);
> +
> +static inline int virtqueue_add_buf(struct virtqueue *vq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct scatterlist sg[],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned int out_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned int in_num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voi=
d *data)
> +{
> + =A0 =A0 =A0 return virtqueue_add_buf_gfp(vq, sg, out_num, in_num, data,=
 GFP_ATOMIC);
> +}
> +
> +void virtqueue_kick(struct virtqueue *vq);
> +
> +void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
> +
> +void virtqueue_disable_cb(struct virtqueue *vq);
> +
> +bool virtqueue_enable_cb(struct virtqueue *vq);
> +
> +void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> +struct virtqueue *vring_new_virtqueue(unsigned int num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned int vring_align,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct virtio_device *vdev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 void *pages,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 void (*notify)(struct virtqueue *vq),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 void (*callback)(struct virtqueue *vq),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 const char *name);
> +void vring_del_virtqueue(struct virtqueue *vq);
> +
> +#endif
> diff --git a/tools/virtio/vhost_test/Makefile b/tools/virtio/vhost_test/M=
akefile
> new file mode 100644
> index 0000000..a1d35b8
> --- /dev/null
> +++ b/tools/virtio/vhost_test/Makefile
> @@ -0,0 +1,2 @@
> +obj-m +=3D vhost_test.o
> +EXTRA_CFLAGS +=3D -Idrivers/vhost
> diff --git a/tools/virtio/vhost_test/vhost_test.c b/tools/virtio/vhost_te=
st/vhost_test.c
> new file mode 100644
> index 0000000..1873518
> --- /dev/null
> +++ b/tools/virtio/vhost_test/vhost_test.c
> @@ -0,0 +1 @@
> +#include "test.c"
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> new file mode 100644
> index 0000000..808ae86
> --- /dev/null
> +++ b/tools/virtio/virtio_test.c
> @@ -0,0 +1,248 @@
> +#define _GNU_SOURCE
> +#include <getopt.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <sys/eventfd.h>
> +#include <stdlib.h>
> +#include <assert.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <linux/vhost.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ring.h>
> +#include "../../drivers/vhost/test.h"
> +
> +struct vq_info {
> + =A0 =A0 =A0 int kick;
> + =A0 =A0 =A0 int call;
> + =A0 =A0 =A0 int num;
> + =A0 =A0 =A0 int idx;
> + =A0 =A0 =A0 void *ring;
> + =A0 =A0 =A0 /* copy used for control */
> + =A0 =A0 =A0 struct vring vring;
> + =A0 =A0 =A0 struct virtqueue *vq;
> +};
> +
> +struct vdev_info {
> + =A0 =A0 =A0 struct virtio_device vdev;
> + =A0 =A0 =A0 int control;
> + =A0 =A0 =A0 struct pollfd fds[1];
> + =A0 =A0 =A0 struct vq_info vqs[1];
> + =A0 =A0 =A0 int nvqs;
> + =A0 =A0 =A0 void *buf;
> + =A0 =A0 =A0 size_t buf_size;
> + =A0 =A0 =A0 struct vhost_memory *mem;
> +};
> +
> +void vq_notify(struct virtqueue *vq)
> +{
> + =A0 =A0 =A0 struct vq_info *info =3D vq->priv;
> + =A0 =A0 =A0 unsigned long long v =3D 1;
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 r =3D write(info->kick, &v, sizeof v);
> + =A0 =A0 =A0 assert(r =3D=3D sizeof v);
> +}
> +
> +void vq_callback(struct virtqueue *vq)
> +{
> +}
> +
> +
> +void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
> +{
> + =A0 =A0 =A0 struct vhost_vring_state state =3D { .index =3D info->idx };
> + =A0 =A0 =A0 struct vhost_vring_file file =3D { .index =3D info->idx };
> + =A0 =A0 =A0 unsigned long long features =3D dev->vdev.features[0];
> + =A0 =A0 =A0 struct vhost_vring_addr addr =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .index =3D info->idx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc_user_addr =3D (uint64_t)(unsigned lon=
g)info->vring.desc,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .avail_user_addr =3D (uint64_t)(unsigned lo=
ng)info->vring.avail,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .used_user_addr =3D (uint64_t)(unsigned lon=
g)info->vring.used,
> + =A0 =A0 =A0 };
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_FEATURES, &features);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 state.num =3D info->vring.num;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_VRING_NUM, &state);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 state.num =3D 0;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_VRING_BASE, &state);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_VRING_ADDR, &addr);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 file.fd =3D info->kick;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_VRING_KICK, &file);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 file.fd =3D info->call;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_VRING_CALL, &file);
> + =A0 =A0 =A0 assert(r >=3D 0);
> +}
> +
> +static void vq_info_add(struct vdev_info *dev, int num)
> +{
> + =A0 =A0 =A0 struct vq_info *info =3D &dev->vqs[dev->nvqs];
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 info->idx =3D dev->nvqs;
> + =A0 =A0 =A0 info->kick =3D eventfd(0, EFD_NONBLOCK);
> + =A0 =A0 =A0 info->call =3D eventfd(0, EFD_NONBLOCK);
> + =A0 =A0 =A0 r =3D posix_memalign(&info->ring, 4096, vring_size(num, 409=
6));
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 memset(info->ring, 0, vring_size(num, 4096));
> + =A0 =A0 =A0 vring_init(&info->vring, num, info->ring, 4096);
> + =A0 =A0 =A0 info->vq =3D vring_new_virtqueue(info->vring.num, 4096, &de=
v->vdev, info->ring,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0vq_notify, vq_callback, "test");
> + =A0 =A0 =A0 assert(info->vq);
> + =A0 =A0 =A0 info->vq->priv =3D info;
> + =A0 =A0 =A0 vhost_vq_setup(dev, info);
> + =A0 =A0 =A0 dev->fds[info->idx].fd =3D info->call;
> + =A0 =A0 =A0 dev->fds[info->idx].events =3D POLLIN;
> + =A0 =A0 =A0 dev->nvqs++;
> +}
> +
> +static void vdev_info_init(struct vdev_info* dev, unsigned long long fea=
tures)
> +{
> + =A0 =A0 =A0 int r;
> + =A0 =A0 =A0 memset(dev, 0, sizeof *dev);
> + =A0 =A0 =A0 dev->vdev.features[0] =3D features;
> + =A0 =A0 =A0 dev->vdev.features[1] =3D features >> 32;
> + =A0 =A0 =A0 dev->buf_size =3D 1024;
> + =A0 =A0 =A0 dev->buf =3D malloc(dev->buf_size);
> + =A0 =A0 =A0 assert(dev->buf);
> + =A0 =A0 =A0 =A0dev->control =3D open("/dev/vhost-test", O_RDWR);
> + =A0 =A0 =A0 assert(dev->control >=3D 0);
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_OWNER, NULL);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 dev->mem =3D malloc(offsetof(struct vhost_memory, regions) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof dev->mem->region=
s[0]);
> + =A0 =A0 =A0 assert(dev->mem);
> + =A0 =A0 =A0 memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof dev->mem->reg=
ions[0]);
> + =A0 =A0 =A0 dev->mem->nregions =3D 1;
> + =A0 =A0 =A0 dev->mem->regions[0].guest_phys_addr =3D (long)dev->buf;
> + =A0 =A0 =A0 dev->mem->regions[0].userspace_addr =3D (long)dev->buf;
> + =A0 =A0 =A0 dev->mem->regions[0].memory_size =3D dev->buf_size;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
> + =A0 =A0 =A0 assert(r >=3D 0);
> +}
> +
> +/* TODO: this is pretty bad: we get a cache line bounce
> + * for the wait queue on poll and another one on read,
> + * plus the read which is there just to clear the
> + * current state. */
> +static void wait_for_interrupt(struct vdev_info *dev)
> +{
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 unsigned long long val;
> + =A0 =A0 =A0 poll(dev->fds, dev->nvqs, -1);
> + =A0 =A0 =A0 for (i =3D 0; i < dev->nvqs; ++i)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dev->fds[i].revents & POLLIN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read(dev->fds[i].fd, &val, =
sizeof val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +}
> +
> +static void run_test(struct vdev_info *dev, struct vq_info *vq, int bufs)
> +{
> + =A0 =A0 =A0 struct scatterlist sl;
> + =A0 =A0 =A0 long started =3D 0, completed =3D 0;
> + =A0 =A0 =A0 long completed_before;
> + =A0 =A0 =A0 int r, test =3D 1;
> + =A0 =A0 =A0 unsigned len;
> + =A0 =A0 =A0 long long spurious =3D 0;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 virtqueue_disable_cb(vq->vq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 completed_before =3D completed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (started < bufs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sg_init_one=
(&sl, dev->buf, dev->buf_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D virtq=
ueue_add_buf(vq->vq, &sl, 1, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->buf + started);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (likely(=
r >=3D 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ++started;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 virtqueue_kick(vq->vq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D -1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Flush out completed bufs=
 if any */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (virtqueue_get_buf(vq->v=
q, &len)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++completed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 r =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (r >=3D 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (completed =3D=3D completed_before)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++spurious;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert(completed <=3D bufs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert(started <=3D bufs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (completed =3D=3D bufs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (virtqueue_enable_cb(vq->vq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_interrupt(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 test =3D 0;
> + =A0 =A0 =A0 r =3D ioctl(dev->control, VHOST_TEST_RUN, &test);
> + =A0 =A0 =A0 assert(r >=3D 0);
> + =A0 =A0 =A0 fprintf(stderr, "spurious wakeus: 0x%llx\n", spurious);
> +}
> +
> +const char optstring[] =3D "h";
> +const struct option longopts[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "help",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .val =3D 'h',
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "indirect",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .val =3D 'I',
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "no-indirect",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .val =3D 'i',
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 }
> +};
> +
> +static void help()
> +{
> + =A0 =A0 =A0 fprintf(stderr, "Usage: virtio_test [--help] [--no-indirect=
]\n");
> +}
> +
> +int main(int argc, char **argv)
> +{
> + =A0 =A0 =A0 struct vdev_info dev;
> + =A0 =A0 =A0 unsigned long long features =3D 1ULL << VIRTIO_RING_F_INDIR=
ECT_DESC;
> + =A0 =A0 =A0 int o;
> +
> + =A0 =A0 =A0 for (;;) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 o =3D getopt_long(argc, argv, optstring, lo=
ngopts, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (o) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case -1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case '?':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 help();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'h':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 help();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'i':
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features &=3D ~(1ULL << VIR=
TIO_RING_F_INDIRECT_DESC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 assert(0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> +done:
> + =A0 =A0 =A0 vdev_info_init(&dev, features);
> + =A0 =A0 =A0 vq_info_add(&dev, 256);
> + =A0 =A0 =A0 run_test(&dev, &dev.vqs[0], 0x100000);
> + =A0 =A0 =A0 return 0;
> +}
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



-- =

Regards,

Zhi Yong Wu
