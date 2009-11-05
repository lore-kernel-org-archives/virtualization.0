From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Thu, 5 Nov 2009 13:36:38 +0200
Message-ID: <20091105113637.GD5774__10754.5807412409$1257421210$gmane$org@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1257199759-2941-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, anthony@codemonkey.ws
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 02, 2009 at 11:09:19PM +0100, Alexander Graf wrote:
> When we want to create a full VirtIO based machine, we're still missing
> graphics output. Fortunately, Linux provides us with most of the frameworks
> to render text and everything, we only need to implement a transport.
> 
> So this is a frame buffer backend written for VirtIO. Using this and my
> patch to qemu, you can use paravirtualized graphics.
> 
> This is especially important on machines that can't do MMIO, as all current
> graphics implementations qemu emulates I'm aware of so far fail here.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>

Nice work.  I think you want to Cc
virtualization@lists.linux-foundation.org and Rusty. Cc added.  Some
comments below, some of them checkpatch.pl would find.  I do not know
much about framebuffer, so comments are from virtio usage perspective.
Generally, I think locking is missing here.  As far as I know, virtio
APIs do no locking internally.  So when you e.g. schedule_work and then
call add_buf, this can run on many CPUs in parallel, which will cause
memory corruption.

> ---
>  drivers/video/Kconfig      |   15 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/virtio-fb.c  |  799 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/virtio_ids.h |    1 +
>  4 files changed, 816 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/virtio-fb.c
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 9bbb285..f9be4c2 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2069,6 +2069,21 @@ config XEN_FBDEV_FRONTEND
>  	  frame buffer driver.  It communicates with a back-end
>  	  in another domain.
>  
> +config FB_VIRTIO
> +	tristate "Virtio virtual frame buffer support"
> +	depends on FB && VIRTIO
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	select FB_DEFERRED_IO
> +	help
> +	  This driver implements a driver for a Virtio based
> +	  frame buffer device.  It communicates to something that
> +	  can talk Virtio too, most probably a hypervisor.
> +
> +	  If unsure, say N.
> +


Most of virtio is marked experimental. Maybe this should be as well.


>  config FB_METRONOME
>  	tristate "E-Ink Metronome/8track controller support"
>  	depends on FB
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 80232e1..40802c8 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -125,6 +125,7 @@ obj-$(CONFIG_FB_XILINX)           += xilinxfb.o
>  obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
>  obj-$(CONFIG_FB_OMAP)             += omap/
>  obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
> +obj-$(CONFIG_FB_VIRTIO)           += virtio-fb.o
>  obj-$(CONFIG_FB_CARMINE)          += carminefb.o
>  obj-$(CONFIG_FB_MB862XX)	  += mb862xx/
>  obj-$(CONFIG_FB_MSM)              += msm/
> diff --git a/drivers/video/virtio-fb.c b/drivers/video/virtio-fb.c
> new file mode 100644
> index 0000000..2a73950
> --- /dev/null
> +++ b/drivers/video/virtio-fb.c
> @@ -0,0 +1,799 @@
> +/*
> + * VirtIO PV frame buffer device
> + *
> + * Copyright (C) 2009 Alexander Graf <agraf@suse.de>

Out of curiosity, are copyrights your own, or suse/novell's?
> + *
> + *  Based on linux/drivers/video/virtio-fbfront.c

Where is that? Maybe carry attribution from there as well.
There's also a lot of simularity with xen-fbfront.c
Is it accidental?

> + *
> + *  This file is subject to the terms and conditions of the GNU General Public
> + *  License. See the file COPYING in the main directory of this archive for
> + *  more details.
> + */
> +
> +#include <linux/console.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/fb.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/mm.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_ids.h>
> +#include <linux/virtio_config.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>

is interrupt.h needed? virito mostly
abstracts this for you.

> +
> +#define MAX_BUF			128
> +
> +struct virtio_fb_info {
> +	struct fb_info		*fb_info;
> +	unsigned char		*fb;
> +	char			*inbuf;
> +
> +	u16			width;
> +	u16			height;
> +
> +	int			nr_pages;
> +	int			size;
> +
> +	struct kmem_cache	*cmd_cache;
> +	struct virtqueue	*vq_in;
> +	struct virtqueue	*vq_out;
> +	struct virtio_device	*vdev;
> +
> +	void			*last_buf[MAX_BUF];
> +	int			last_buf_idx;
> +	spinlock_t		vfree_lock;
> +	struct work_struct	vfree_work;
> +	struct work_struct	refresh_work;
> +};
> +
> +/* guest -> Host commands */
> +#define VIRTIO_FB_CMD_RESIZE            0x01                                         
> +#define VIRTIO_FB_CMD_FILL              0x02                                         
> +#define VIRTIO_FB_CMD_BLIT              0x03                                         
> +#define VIRTIO_FB_CMD_COPY              0x04                                         
> +#define VIRTIO_FB_CMD_WRITE             0x05                                         
> +    
> +/* host -> guest commands */                                                         
> +#define VIRTIO_FB_CMD_REFRESH           0x81                                         


These constants and structures (also below) should go into linux/virtio-fb.h
which should be exported. You then won't have to
duplicate them in userspace. Just remember to convert uXX to __uXX.

> +
> +struct virtio_fb_cmd {
> +	u8			cmd;
> +	union {
> +		struct {
> +			u16	width;
> +			u16	height;
> +		} resize __attribute__ ((packed));
> +		struct {
> +			u16	x;
> +			u16	y;
> +			u16	width;
> +			u16	height;
> +		} blit __attribute__ ((packed));
> +		struct {
> +			u16	x1;
> +			u16	y1;
> +			u16	x2;
> +			u16	y2;
> +			u16	width;
> +			u16	height;
> +		} copy_area __attribute__ ((packed));
> +		struct {
> +			u8	rop;
> +			u16	x;
> +			u16	y;
> +			u16	width;
> +			u16	height;
> +			u32	color;
> +		} fill __attribute__ ((packed));
> +		struct {
> +			u64	offset;
> +			u64	count;
> +		} write __attribute__ ((packed));
> +		u8		pad[23];
> +	};
> +
> +	union {
> +		/* We remember the data pointer so we we can easily free
> +		   everything later by only knowing this structure */
> +		char		*send_buf;

I thought this structure is passed between guest and host?
If so you do not want to stick your pointers there,
add_buf has data pointer for this reason.

> +		u64		_pad;

This might create problems with 32 bit userspace on 64 bit kernels:
which bits does the pointer get packed into depends on architecture.
Better to just pass in __u64 and have userspace cast pointer to that
type, IMO.


> +	};
> +} __attribute__ ((packed));


Packed structures generate terrible code on some architectures.  Can you
just pad structures to multiples of 64 bit, or to full union size, instead?

> +
> +enum copy_type {
> +	COPY_KERNEL,
> +	COPY_USER,
> +	COPY_NOCOPY,
> +};
> +
> +#define DEFAULT_WIDTH		800
> +#define DEFAULT_HEIGHT		600
> +#define DEFAULT_DEPTH		32
> +#define DEFAULT_MEM		8
> +
> +#define DEFAULT_FB_LEN (DEFAULT_WIDTH * DEFAULT_HEIGHT * DEFAULT_DEPTH / 8)
> +
> +enum { KPARAM_MEM, KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
> +static int video[KPARAM_CNT] = { DEFAULT_MEM, DEFAULT_WIDTH, DEFAULT_HEIGHT };
> +module_param_array(video, int, NULL, 0);
> +MODULE_PARM_DESC(video,
> +	"Video size in M,width,height in pixels (default \""
> +	str(DEFAULT_MEM) ","
> +	str(DEFAULT_WIDTH) ","
> +	str(DEFAULT_HEIGHT) "\")");
> +
> +static void virtio_fb_output(struct virtqueue *vq);
> +
> +static void *rvmalloc(unsigned long size)

what exactly does this do?

> +{
> +	void *mem;
> +	unsigned long adr;
> +
> +	size = PAGE_ALIGN(size);
> +	mem = vmalloc_32(size);
> +	if (!mem)
> +		return NULL;
> +
> +	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
> +	adr = (unsigned long) mem;
> +	while (size > 0) {
> +		SetPageReserved(vmalloc_to_page((void *)adr));

Where is the bit cleared?

> +		adr += PAGE_SIZE;
> +		size -= PAGE_SIZE;
> +	}
> +
> +	return mem;
> +}
> +
> +/* This is videobuf_vmalloc_to_sg() from videobuf-dma-sg.c
> +   I modified it to take an extra sg entry for the cmd and work with non
> +   page-aligned pointers though */
> +static struct scatterlist* vmalloc_to_sg(unsigned char *virt, int length,
> +					 void *cmd, int cmd_len, int *sg_elem)
> +{
> +	struct scatterlist *sglist;
> +	struct page *pg;
> +	int nr_pages = (length+PAGE_SIZE-1)/PAGE_SIZE;

Spaces are needed around +, -

> +	int sg_entries;
> +	int i;
> +
> +	/* unaligned */
> +	if ((ulong)virt & ~PAGE_MASK) {

Use offset_in_page here and below?

> +		int tmp_len = length - (PAGE_SIZE - ((ulong)virt & ~PAGE_MASK));
> +		/* how long would it be without the first non-aligned chunk? */
> +		nr_pages = (tmp_len+PAGE_SIZE-1)/PAGE_SIZE;

Spaces are needed around +, -
Also, is this just PAGE_ALIGN?

> +		/* add the first chunk */
> +		nr_pages++;
> +	}

Is all the above just
	nr_pages = PAGE_ALIGN(length + offset_in_page(virt)) / PAGE_SIZE
?
if so, no need for if statements etc.

> +
> +	sg_entries = nr_pages + 1;
> +
> +	sglist = kcalloc(sg_entries, sizeof(struct scatterlist), GFP_KERNEL);
> +	if (!sglist)
> +		return NULL;
> +	sg_init_table(sglist, sg_entries);
> +
> +	/* Put cmd element in */
> +	sg_set_buf(&sglist[0], cmd, cmd_len);
> +
> +	/* Fill with elements for the data */
> +	for (i = 1; i < sg_entries; i++) {
> +		pg = vmalloc_to_page(virt);
> +		if (!pg)
> +			goto err;
> +
> +		if ((ulong)virt & ~PAGE_MASK) {
> +			int tmp_off = ((ulong)virt & ~PAGE_MASK);
> +
> +			sg_set_page(&sglist[i], pg, PAGE_SIZE - tmp_off, tmp_off);
> +			virt = (char*)((ulong)virt & PAGE_MASK);
> +		} else {
> +			sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
> +		}

You don't need an if statement, do you?
For aligned addresses tmp_off is 0, so it works out.

> +		virt += PAGE_SIZE;
> +	}
> +
> +	*sg_elem = sg_entries;
> +	return sglist;
> +
> + err:
> +	kfree(sglist);
> +	return NULL;
> +}
> +
> +
> +static void _virtio_fb_send(struct virtio_fb_info *info,

void? Don't we care that this might fail e.g. on OOM?

> +			    struct virtio_fb_cmd *cmd,
> +			    char *buf, int len, enum copy_type copy)
> +{
> +	char *send_buf = NULL;
> +	char *sg_buf = NULL;
> +	struct virtio_fb_cmd *send_cmd;
> +	struct scatterlist *sg;
> +	int len_cmd = sizeof(struct virtio_fb_cmd);

sizeof *cmd would be 

> +	int r, sg_elem;
> +
> +	send_cmd = kmem_cache_alloc(info->cmd_cache, GFP_KERNEL);
> +	if (!send_cmd) {
> +		printk(KERN_ERR "virtio-fb: couldn't allocate cmd\n");
> +		return;
> +	}
> +
> +	memcpy(send_cmd, cmd, len_cmd);
> +
> +	if (len) {
> +		sg_buf = send_buf = vmalloc(len);
> +		if (!send_buf) {
> +			printk(KERN_ERR "virtio-fb: couldn't allocate %d b\n",
> +					len);
> +			return;
> +		}
> +
> +		switch (copy) {
> +		case COPY_KERNEL:
> +			memcpy(send_buf, buf, len);
> +			break;
> +		case COPY_USER:
> +			r = copy_from_user(send_buf, (const __user char*)buf,
> +					   len);
> +			break;
> +		case COPY_NOCOPY:
> +			sg_buf = buf;

vmalloc is not really needed in this case, is it?

> +			break;
> +		}
> +	}
> +
> +	send_cmd->send_buf = send_buf;
> +
> +	sg = vmalloc_to_sg(sg_buf, len, send_cmd, len_cmd, &sg_elem);
> +	if (!sg) {
> +		printk(KERN_ERR "virtio-fb: couldn't gather scatter list\n");
> +		return;
> +	}
> +
> +add_again:
> +	r = info->vq_out->vq_ops->add_buf(info->vq_out, sg, sg_elem, 0, send_cmd);


This seems to be done without any locks.
Just making sure: what guarantees that multiple CPUs do
not do this in parallel? Note that virtio do no
locking internally, it's always up to the user.

> +	info->vq_out->vq_ops->kick(info->vq_out);
> +
> +	if ( r == -ENOSPC ) {

what about other errors?

> +		/* Queue was full, so try again */
> +		cpu_relax();
> +		virtio_fb_output(info->vq_out);
> +		goto add_again;

That's pretty evil. Is it possible to block for interrupt
until vq becomes empty, use a timer instead, or
avoid posting more than VQ size in some other way?

> +	}

Can this use for or while loop?

> +
> +	kfree(sg);
> +}
> +
> +static void virtio_fb_send_user(struct virtio_fb_info *info,
> +				struct virtio_fb_cmd *cmd,
> +				const __user char *buf, int len)
> +{
> +	_virtio_fb_send(info, cmd, (char *)buf, len, COPY_USER);


Casting __user pointer away in this way gives up type
safety. Maybe it would be a good idea to split the copy part
away from _virtio_fb_send? Then _nocopy won't do any vmalloc,
this function will do vmalloc+copy_from_user, and virtio_fb_send
below will do vmalloc + memcpy.

> +}
> +
> +static void virtio_fb_send_nocopy(struct virtio_fb_info *info,
> +				  struct virtio_fb_cmd *cmd,
> +				  char *buf, int len)
> +{
> +	_virtio_fb_send(info, cmd, buf, len, COPY_NOCOPY);
> +}
> +
> +static void virtio_fb_send(struct virtio_fb_info *info, struct virtio_fb_cmd *cmd,
> +			   char *buf, int len)
> +{
> +	_virtio_fb_send(info, cmd, buf, len, COPY_KERNEL);
> +}
> +
> +

2 empty lines

> +static int virtio_fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> +			   unsigned blue, unsigned transp,
> +			   struct fb_info *info)
> +{
> +	u32 v;
> +	if (regno >= 16)
> +		return 1;
> +
> +#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)

spaces are needed around <<, >>, -, +

> +	red = CNVT_TOHW(red, info->var.red.length);
> +	green = CNVT_TOHW(green, info->var.green.length);
> +	blue = CNVT_TOHW(blue, info->var.blue.length);
> +	transp = CNVT_TOHW(transp, info->var.transp.length);
> +#undef CNVT_TOHW

this is what xen does as well. Any chance to use symbolic
constants above?
Also, are var.XXXX.length values in fact constant?

> +
> +

extra empty line

> +	v = (red << info->var.red.offset) |
> +	    (green << info->var.green.offset) |
> +	    (blue << info->var.blue.offset) |
> +	    (transp << info->var.transp.offset);
> +
> +	((u32 *) (info->pseudo_palette))[regno] = v;

space between } and ( above is just confusing.

> +
> +	return 0;
> +}
> +
> +static void virtio_fb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
> +{
> +	struct virtio_fb_info *info = p->par;
> +	struct virtio_fb_cmd cmd;
> +
> +	sys_fillrect(p, rect);
> +
> +	cmd.cmd = VIRTIO_FB_CMD_FILL;
> +	cmd.fill.rop = rect->rop;
> +	cmd.fill.x = rect->dx;
> +	cmd.fill.y = rect->dy;
> +	cmd.fill.width = rect->width;
> +	cmd.fill.height = rect->height;
> +	cmd.fill.color = rect->color;
> +
> +	virtio_fb_send(info, &cmd, NULL, 0);
> +}
> +
> +static void virtio_fb_imageblit(struct fb_info *p, const struct fb_image *image)
> +{
> +	struct virtio_fb_info *info = p->par;
> +	struct virtio_fb_cmd cmd;

So this puts a large structure n stack, only to memcpy
it later into a kmalloced one. I think it would be
better just to allocate command from cache directly, for
kernel users. Same comment would apply to others below.

> +	char *_buf;
> +	char *buf;
> +	char *vfb;
> +	int i, w;
> +	int bpp = p->var.bits_per_pixel / 8;
> +	int len = image->width * image->height * bpp;
> +
> +	sys_imageblit(p, image);
> +
> +	cmd.cmd = VIRTIO_FB_CMD_BLIT;
> +	cmd.blit.x = image->dx;
> +	cmd.blit.y = image->dy;
> +	cmd.blit.height = image->height;
> +	cmd.blit.width = image->width;
> +
> +	if (image->depth == 32) {
> +		/* Send the image off directly */
> +
> +		virtio_fb_send(info, &cmd, (char*)image->data, len);

You cast constness away? that's usually not a good thing to do.

> +		return;
> +	}
> +
> +	/* Send the 32-bit translated image */
> +
> +	buf = _buf = vmalloc(len);
> +
> +	vfb = info->fb;
> +	vfb += (image->dy * p->fix.line_length) + image->dx * bpp;

() not needed around *.

> +
> +	w = image->width * bpp;
> +
> +	for (i = 0; i < image->height; i++) {
> +		memcpy(buf, vfb, w);
> +
> +		buf += w;
> +		vfb += p->fix.line_length;
> +	}
> +
> +	virtio_fb_send(info, &cmd, _buf, len);
> +
> +	vfree(_buf);

This would benefit from nocopy, right?
Just another arument why what I propose above is a good idea.

> +}
> +
> +static void virtio_fb_copyarea(struct fb_info *p, const struct fb_copyarea *area)
> +{
> +	struct virtio_fb_info *info = p->par;
> +	struct virtio_fb_cmd cmd;
> +
> +	sys_copyarea(p, area);
> +
> +	cmd.cmd = VIRTIO_FB_CMD_COPY;
> +	cmd.copy_area.x1 = area->sx;
> +	cmd.copy_area.y1 = area->sy;
> +	cmd.copy_area.x2 = area->dx;
> +	cmd.copy_area.y2 = area->dy;
> +	cmd.copy_area.width = area->width;
> +	cmd.copy_area.height = area->height;
> +
> +	virtio_fb_send(info, &cmd, NULL, 0);
> +}
> +
> +static ssize_t virtio_fb_write(struct fb_info *p, const char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct virtio_fb_info *info = p->par;
> +	struct virtio_fb_cmd cmd;
> +	loff_t pos = *ppos;
> +	ssize_t res;
> +
> +	res = fb_sys_write(p, buf, count, ppos);
> +
> +	cmd.cmd = VIRTIO_FB_CMD_WRITE;
> +	cmd.write.offset = pos;
> +	cmd.write.count = count;
> +
> +	virtio_fb_send_user(info, &cmd, buf, count);
> +	return res;
> +}
> +
> +static int
> +virtio_fb_check_var(struct fb_var_screeninfo *var, struct fb_info *p)
> +{
> +	struct virtio_fb_info *info = p->par;
> +
> +	if (var->bits_per_pixel != DEFAULT_DEPTH) {
> +		/* We only support 32 bpp */
> +		return -EINVAL;
> +	}
> +
> +	if ((var->xres * var->yres * DEFAULT_DEPTH / 8) > info->size) {

don't need () around math

> +		/* Doesn't fit in the frame buffer */
> +		return -EINVAL;
> +	}
> +
> +	var->xres_virtual = var->xres;
> +	var->yres_virtual = var->yres;
> +
> +	return 0;
> +}
> +
> +static int virtio_fb_set_par(struct fb_info *p)
> +{
> +	struct virtio_fb_info *info = p->par;
> +	struct virtio_fb_cmd cmd;
> +
> +	/* Do nothing if we're on that resolution already */
> +	if ((p->var.xres == info->width) &&
> +	    (p->var.yres == info->height))

don't need () around ===

> +		return 0;
> +
> +	info->width = p->var.xres;
> +	info->height = p->var.yres;
> +	p->fix.line_length = p->var.xres_virtual * 4;
> +
> +	/* Notify hypervisor */
> +
> +	cmd.cmd = VIRTIO_FB_CMD_RESIZE;
> +	cmd.resize.width = p->var.xres;
> +	cmd.resize.height = p->var.yres;
> +
> +	virtio_fb_send(info, &cmd, NULL, 0);
> +
> +	return 0;
> +}
> +
> +static struct fb_ops virtio_fb_ops = {
> +	.owner		= THIS_MODULE,
> +	.fb_read	= fb_sys_read,
> +	.fb_write	= virtio_fb_write,
> +	.fb_setcolreg	= virtio_fb_setcolreg,
> +	.fb_fillrect	= virtio_fb_fillrect,
> +	.fb_copyarea	= virtio_fb_copyarea,
> +	.fb_imageblit	= virtio_fb_imageblit,
> +	.fb_check_var	= virtio_fb_check_var,
> +	.fb_set_par     = virtio_fb_set_par,
> +};
> +
> +static __devinit void
> +virtio_fb_make_preferred_console(void)
> +{
> +	struct console *c;
> +
> +	if (console_set_on_cmdline)
> +		return;
> +
> +	acquire_console_sem();
> +	for (c = console_drivers; c; c = c->next) {
> +		if (!strcmp(c->name, "tty") && c->index == 0)
> +			break;
> +	}

{} not needed

> +	release_console_sem();

Just a thought: can console c go away at this point?

> +	if (c) {
> +		unregister_console(c);
> +		c->flags |= CON_CONSDEV;
> +		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
> +		register_console(c);
> +	}
> +}
> +
> +static void virtio_fb_deferred_io(struct fb_info *fb_info,
> +				  struct list_head *pagelist)
> +{
> +	struct virtio_fb_info *info = fb_info->par;
> +	struct page *page;
> +	unsigned long beg, end;
> +	int y1, y2, miny, maxy;
> +	struct virtio_fb_cmd cmd;
> +
> +	miny = INT_MAX;
> +	maxy = 0;
> +	list_for_each_entry(page, pagelist, lru) {
> +		beg = page->index << PAGE_SHIFT;

page_index()?

> +		end = beg + PAGE_SIZE - 1;
> +		y1 = beg / fb_info->fix.line_length;

You do all these divisions in a cycle, then end up multiplying
the result by line_length. Maybe do the math in bytes.

> +		y2 = end / fb_info->fix.line_length;

Is the result guaranteed to fit in int?

> +		if (y2 >= fb_info->var.yres)
> +			y2 = fb_info->var.yres - 1;
> +		if (miny > y1)
> +			miny = y1;
> +		if (maxy < y2)
> +			maxy = y2;

use min()/max() macros above.

> +	}
> +
> +	if (miny != INT_MAX) {

if (miny == INT_MAX)
	return;

will be neater

> +		cmd.cmd = VIRTIO_FB_CMD_WRITE;
> +		cmd.write.offset = miny * fb_info->fix.line_length;
> +		cmd.write.count = (maxy - miny + 1) * fb_info->fix.line_length;
> +
> +		virtio_fb_send_nocopy(info, &cmd, info->fb + cmd.write.offset,
> +				      cmd.write.count);
> +	}
> +}
> +
> +static struct fb_deferred_io virtio_fb_defio = {
> +	.delay		= HZ / 20,
> +	.deferred_io	= virtio_fb_deferred_io,
> +};
> +
> +/* Callback when the host kicks our input queue.
> + *
> + * This is to enable notifications from host to guest. */
> +static void virtio_fb_input(struct virtqueue *vq)
> +{
> +	struct virtio_fb_info *info = dev_get_drvdata(&vq->vdev->dev);
> +	int len, i;
> +	void *x;
> +	void *reinject[3];
> +	int reinject_count = 0;
> +
> +	while ((x = vq->vq_ops->get_buf(vq, &len)) != NULL)

&& reinject_count < 3?

> {

This looks unsafe: can this get triggered while another
routine does add_buf? If yes you must add locking to
prevent this.

> +		struct virtio_fb_cmd *cmd = x;
> +
> +		/* Make sure we're getting an inbuf page! */

What does this check, exactly? 

> +		BUG_ON((x != info->inbuf) &&
> +		       (x != (info->inbuf + PAGE_SIZE)) &&
> +		       (x != (info->inbuf + (PAGE_SIZE * 2))));
() not needed around math.

> +
> +		switch (cmd->cmd) {
> +		case VIRTIO_FB_CMD_REFRESH:
> +			schedule_work(&info->refresh_work);
> +			break;
> +		}
> +
> +		reinject[reinject_count++] = x;

This will overflow on a buggy host.  Better check and BUG(); Also, the
number of buffers is VQ size?
Make it a constant then.

> +	}
> +
> +
> +	for (i = 0; i < reinject_count; i++) {
> +		struct scatterlist sg;
> +		void *x = reinject[i];
> +
> +		sg_init_one(&sg, x, PAGE_SIZE);
> +		vq->vq_ops->add_buf(vq, &sg, 0, 1, x);
> +		vq->vq_ops->kick(vq);

won't it be easier to reinject wach buffer as you get it directly?

> +	}
> +}
> +
> +/* Asynchronous snippet to send all screen contents to the host */
> +static void deferred_refresh(struct work_struct *work)
> +{
> +	struct virtio_fb_info *info = container_of(work, struct virtio_fb_info,
> +						   refresh_work);
> +	struct virtio_fb_cmd cmd;
> +
> +	cmd.cmd = VIRTIO_FB_CMD_WRITE;
> +	cmd.write.offset = 0;
> +	cmd.write.count = info->width * info->height * 4;

why 4?

> +
> +	virtio_fb_send_nocopy(info, &cmd, info->fb, cmd.write.count);
> +}
> +
> +/* Asynchronous garbage collector :-) */
> +static void deferred_vfree(struct work_struct *work)
> +{
> +	struct virtio_fb_info *info = container_of(work, struct virtio_fb_info,
> +						   vfree_work);
> +	int i;
> +	unsigned long flags;
> +	void *last_buf[MAX_BUF];

Wow, that's a lot of stack.  Can't vfree be called on info->last_buf
directly?

> +	int idx;
> +
> +	spin_lock_irqsave(&info->vfree_lock, flags);


spin_lock_irq is enough

> +
> +	idx = info->last_buf_idx;
> +	memcpy(last_buf, info->last_buf, sizeof(void*) * MAX_BUF);

sizeof last_buf

> +	info->last_buf_idx = 0;
> +
> +	spin_unlock_irqrestore(&info->vfree_lock, flags);
> +
> +	for (i = 0; i < idx; i++) {
> +		vfree(last_buf[i]);
> +	}

{} not needed

> +}
> +
> +/* Callback when the host kicks our output queue. This can only mean it's done
> + * processing an item, so let's free up the memory occupied by the entries */


lines too long here and elsewhere

> +static void virtio_fb_output(struct virtqueue *vq)
> +{
> +	struct virtio_fb_info *info = dev_get_drvdata(&vq->vdev->dev);
> +	int len;
> +	void *x;
> +
> +	while ((x = vq->vq_ops->get_buf(vq, &len)) != NULL) {

!= NULL not needed.
Again, get_buf must be called under some
lock that prevents add_buf from being called.

> +		struct virtio_fb_cmd *cmd = x;
> +
> +		if (cmd->send_buf) {
> +			spin_lock(&info->vfree_lock);
> +			if (info->last_buf_idx != MAX_BUF) {
> +				info->last_buf[info->last_buf_idx++] =
> +					cmd->send_buf;
> +			}

{} not needed

> +			spin_unlock(&info->vfree_lock);
> +
> +			schedule_work(&info->vfree_work);

So this would be a good place to re-enable more output
instead of busy wait above? Also, can't we vfree
here directly?

> +		}
> +
> +		kmem_cache_free(info->cmd_cache, x);
> +	}
> +}
> +
> +static int __devinit virtio_fb_probe(struct virtio_device *dev)
> +{
> +	vq_callback_t *callbacks[] = { virtio_fb_input, virtio_fb_output };
> +	const char *names[] = { "input", "output" };
> +	struct virtio_fb_info *info;
> +	struct virtqueue *vqs[2];
> +	struct fb_info *fb_info = NULL;
> +	int fb_size, res_size;
> +	int ret, err, i;
> +	char *inbuf;
> +
> +	err = dev->config->find_vqs(dev, 2, vqs, callbacks, names);

2 -> ARRAY_SIZE(vqs).

> +	if (err) {
> +		printk(KERN_ERR "VirtIO FB: couldn't find VQs\n");
> +		return err;
> +	}

You probably want del_vqs on error as well?

> +
> +	info = kmalloc(sizeof(*info), GFP_KERNEL);

this seems to be leaked on errors?
() not needed around *info.

> +	if (info == NULL)

!info

> +		return -ENOMEM;
> +
> +	info->vq_in = vqs[0];
> +	info->vq_out = vqs[1];
> +
> +	res_size = video[KPARAM_WIDTH] * video[KPARAM_HEIGHT] * DEFAULT_DEPTH / 8;
> +	fb_size = video[KPARAM_MEM] * 1024 * 1024;
> +
> +	if (res_size > fb_size) {
> +		video[KPARAM_WIDTH] = DEFAULT_WIDTH;
> +		video[KPARAM_HEIGHT] = DEFAULT_HEIGHT;
> +	}
> +
> +	dev_set_drvdata(&dev->dev, info);
> +	info->vdev = dev;
> +
> +	info->fb = rvmalloc(fb_size);
> +	if (info->fb == NULL)

!info->fb

> +		goto error_nomem;
> +
> +	info->nr_pages = (fb_size + PAGE_SIZE - 1) >> PAGE_SHIFT;

PAGE_ALIGN?

> +	info->size = fb_size;
> +
> +	fb_info = framebuffer_alloc(sizeof(u32) * 256, NULL);

make 256 symbolic constant? it's used below as well.

> +	if (fb_info == NULL)
> +		goto error_nomem;
> +
> +	inbuf = kmalloc(PAGE_SIZE * 3, GFP_KERNEL);

replace 3 * PAGE_SIZE with symbolic constant?
Since this seems to be part of guest/host interface,
maybe even put it in header?

> +	info->inbuf = inbuf;
> +	for (i = 0; i < (3 * PAGE_SIZE); i += PAGE_SIZE) {

() not needed around math

> +		struct scatterlist sg;
> +
> +		sg_init_one(&sg, inbuf + i, PAGE_SIZE);
> +		info->vq_in->vq_ops->add_buf(info->vq_in, &sg, 0, 1, inbuf + i);

add_buf can fail.

> +	}
> +	info->vq_in->vq_ops->kick(info->vq_in);
> +
> +	fb_info->pseudo_palette = fb_info->par;
> +	fb_info->par = info;
> +
> +	fb_info->screen_base = info->fb;
> +
> +	fb_info->fbops = &virtio_fb_ops;
> +	fb_info->var.xres_virtual = fb_info->var.xres = video[KPARAM_WIDTH];
> +	fb_info->var.yres_virtual = fb_info->var.yres = video[KPARAM_HEIGHT];
> +	fb_info->var.bits_per_pixel = DEFAULT_DEPTH;
> +
> +	fb_info->var.transp = (struct fb_bitfield){24, 8, 0};
> +	fb_info->var.red    = (struct fb_bitfield){16, 8, 0};
> +	fb_info->var.green  = (struct fb_bitfield){8,  8, 0};
> +	fb_info->var.blue   = (struct fb_bitfield){0,  8, 0};
> +
> +	fb_info->var.activate = FB_ACTIVATE_NOW;
> +	fb_info->var.height = -1;
> +	fb_info->var.width = -1;
> +	fb_info->var.vmode = FB_VMODE_NONINTERLACED;
> +
> +	fb_info->fix.visual = FB_VISUAL_TRUECOLOR;
> +	fb_info->fix.line_length = fb_info->var.xres * DEFAULT_DEPTH / 8;
> +	fb_info->fix.smem_start = 0;
> +	fb_info->fix.smem_len = fb_size;
> +	strcpy(fb_info->fix.id, "virtio_fb");
> +	fb_info->fix.type = FB_TYPE_PACKED_PIXELS;
> +	fb_info->fix.accel = FB_ACCEL_NONE;
> +
> +	fb_info->flags = FBINFO_FLAG_DEFAULT | FBINFO_HWACCEL_COPYAREA |
> +			 FBINFO_READS_FAST;
> +
> +	ret = fb_alloc_cmap(&fb_info->cmap, 256, 0);
> +	if (ret < 0) {
> +		framebuffer_release(fb_info);
> +		goto error;
> +	}
> +
> +	info->cmd_cache = kmem_cache_create("virtio_fb_cmd",
> +					    sizeof(struct virtio_fb_cmd),
> +					    0, 0, NULL);

this allocation leaks on error?

> +

empty line above more confusing than helpful.

> +	if (!info->cmd_cache) {
> +		framebuffer_release(fb_info);
> +		goto error;
> +	}
> +
> +	fb_info->fbdefio = &virtio_fb_defio;
> +	fb_deferred_io_init(fb_info);
> +
> +	INIT_WORK(&info->refresh_work, deferred_refresh);
> +	INIT_WORK(&info->vfree_work, deferred_vfree);
> +	spin_lock_init(&info->vfree_lock);
> +
> +	ret = register_framebuffer(fb_info);
> +	if (ret) {
> +		fb_deferred_io_cleanup(fb_info);
> +		fb_dealloc_cmap(&fb_info->cmap);
> +		framebuffer_release(fb_info);
> +		goto error;

will be less code with a couple more labels to goto on error?

> +	}
> +	info->fb_info = fb_info;
> +
> +	virtio_fb_make_preferred_console();
> +	return 0;
> +
> + error_nomem:
> +	ret = -ENOMEM;
> + error:
> +	framebuffer_release(fb_info);
> +	return ret;
> +}
> +
> +static void virtio_fb_apply_config(struct virtio_device *dev)
> +{
> +}
> +
> +static struct virtio_device_id id_table[] = {
> +	{ VIRTIO_ID_FB, VIRTIO_DEV_ANY_ID },
> +	{ 0 },

0 not needed here.

> +};
> +
> +static unsigned int features[] = {
> +};
> +
> +static struct virtio_driver virtio_console = {
> +	.feature_table = features,
> +	.feature_table_size = ARRAY_SIZE(features),

I think you should just set to NULL and 0 here, and remove the empty
features array.

> +	.driver.name =  KBUILD_MODNAME,
> +	.driver.owner = THIS_MODULE,
> +	.id_table =     id_table,
> +	.probe =        virtio_fb_probe,
> +	.config_changed = virtio_fb_apply_config,

This alignment looks strange. right-align = or just avoid code
alignment.

> +};
> +
> +static int __init init(void)
> +{
> +	return register_virtio_driver(&virtio_console);
> +}
> +module_init(init);

I don't know much about framebuffer. Why do all fb modules
lack module_exit?

> +
> +

extra empty line

> +MODULE_DEVICE_TABLE(virtio, id_table);
> +MODULE_DESCRIPTION("Virtio framebuffer driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/virtio_ids.h b/include/linux/virtio_ids.h
> index 06660c0..72e39f7 100644
> --- a/include/linux/virtio_ids.h
> +++ b/include/linux/virtio_ids.h
> @@ -12,6 +12,7 @@
>  #define VIRTIO_ID_CONSOLE	3 /* virtio console */
>  #define VIRTIO_ID_RNG		4 /* virtio ring */
>  #define VIRTIO_ID_BALLOON	5 /* virtio balloon */
> +#define VIRTIO_ID_FB		6 /* virtio framebuffer */
>  #define VIRTIO_ID_9P		9 /* 9p virtio console */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> -- 
> 1.6.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
