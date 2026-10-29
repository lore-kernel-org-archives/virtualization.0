Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290513;
	b=Mz1rIk8jClJOndIk6LQSQmQ0OyCywscKzHnWA6wyVE7MiC6t9YsoKRA34tK6F9CCt9lQ
	 oX8YJP724Q2cmQTRjoGFEJn6KFxTqJ0RFX2KEWBnnSDWVF8LVgPGoIYNCB/kOghumu1KZ
	 aYcJAUK5kScNxSwKHCdggayTDwYwQeoj5KCqEFFAs0SKYuAtHwYjE6D7hzOWiXwzLNr0+
	 4WmZjCBtgpFtWFfrJOj2ovWL9i/Gn5b4e14LuX/vgRro2E45y9VUbdXCI+W0ozVJnuuB/
	 Z+purFgaxNQXMGD6mvjMeowFgTQiRs2AFughk+x6W2QgbRr2uUL2wlpBzsQqgXe7jJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290513;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bM37CGgfnEC2jvGALqvJN9E0i4J/GnGwzcXSDWkWwEk=;
	b=dkoSCjvyT7HscCokDF8F48laujh47lS92p/zOGXr3cwYiJwKgOonkeZ9IqgiTGGfHYYq
	 3E2fzGPftyIqTalEG2UKuKMi7kyhEe8RIA+fiwrkxh9PLiq7tHC00G2j1n8EfaW+8pofa
	 Vf8yAXjxXzE9CshG+lJQrzxu8uUT7nwZe39rH/hQPks3gP/9FhojjaKll6EytAzrZ8Blu
	 KOFsxYgr1fop73n8k0fmp7Ge3K2X63/A3RpupfPyXBmDhuXKj7NHQIehnAFI+NP+CUAg+
	 ZL7SOVC47D5PRBVxftFWJGiBQDQcblVWlp15IgYOXfNnck6JkofTp/pdAxtnJzB5t8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C30GP9EX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC97606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C30GP9EX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71CE1F01824;
	Thu, 29 Oct 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290512;
	bh=bM37CGgfnEC2jvGALqvJN9E0i4J/GnGwzcXSDWkWwEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C30GP9EXfUwm7JlCVd02efgccj7xSetyoa7eM2uadxIES7Oxi3lGVSeR7tbxno6OQ
	 zQe/h9iVYaJZYFKAwZ0ETUva3eRak5SmFvbW0hAVpAnHOIMfSF2gswcgEJe/0wwfsR
	 VVeMTZ2Cv3ZoeK3tAVE0Wze8a07Bv+yT/CqzGmn3dpm1a7YMxFYLYhsl9ShPxQSI2z
	 2ST5Ae5ot9AVSKHrLYjOsh6HQv7jmPU9WDIn4ohIKufw6Tx1NCm3Lp7j6dG5MAGCX7
	 KLaQatWZXMnc4xKXNuMQhxPgrkdVRn4otsqzno9pKAG3ertrj4QeAa9Zulch7i+M9U
	 I1L8xDD3PqQ+g==
Message-ID: <sashiko-outbox-189652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/5] media: virtio: Add V4L2 ioctl forwarding
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261029153038.3800747-3-briandaniels@google.com>
References: <20261029153038.3800747-1-briandaniels@google.com>
 <20261029153038.3800747-3-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:15:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] media: virtio: session and commandq UAF on device removal with=
 open fds
- [High] media: virtio: uninitialized stack leak and wrong dir in g_input/g=
_output
- [High] media: virtio: scatterlist_builder_add_data() maps stack memory fo=
r DMA
- [High] media: virtio: virtio_media_device_ioctl() bypasses V4L2 std valid=
ation
- [Medium] media: virtio: missing NUL termination of cap->card in virtio_me=
dia_querycap()
- [Medium] media: virtio: KASAN tag mismatch in scatterlist_builder_retriev=
e_data()
- [Medium] media: virtio: unaligned DMA allocations in scatterlist_builder_=
add_data()
- [Low] media: virtio: undocumented module_param always_use_shadow_buffer
- [Low] media: virtio: missing cpu_to_le32() in scatterlist_builder_add_ioc=
tl_cmd()
--

commit b04e2fc2518c3e0e5bfe29cd7359b457cc6bf7a3
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add V4L2 ioctl forwarding infrastructure

This commit introduces a scatterlist builder and synchronous V4L2 ioctl
forwarding via VIRTIO_MEDIA_CMD_IOCTL. It uses this infrastructure to
implement VIDIOC_QUERYCAP and fixed-size read, write, and read-write V4L2
ioctls.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> new file mode 100644
> index 0000000000000..ae8ffee82fa6e
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -0,0 +1,222 @@

[ ... ]

> +static bool always_use_shadow_buffer;
> +module_param(always_use_shadow_buffer, bool, 0660);

[Severity: Low]
Should the new always_use_shadow_buffer module parameter be documented in
Documentation/admin-guide/kernel-parameters.txt?

[ ... ]

> +int scatterlist_builder_add_data(struct scatterlist_builder *builder,
> +				 void *data, size_t len)
> +{
> +	const size_t cur_desc =3D builder->cur_desc;
> +
> +	if (len =3D=3D 0)
> +		return 0;
> +
> +	if (builder->cur_desc >=3D builder->num_descs)
> +		return -ENOSPC;
> +
> +	if (!always_use_shadow_buffer && virt_addr_valid(data) &&
> +	    virt_addr_valid(data + len)) {
> +		/*
> +		 * If "data" is in the 1:1 physical memory mapping then we can
> +		 * use a single SG entry and avoid copying.
> +		 */
> +		struct page *page =3D virt_to_page(data);
> +		size_t offset =3D (((size_t)data) & ~PAGE_MASK);
> +		struct scatterlist *next_desc =3D
> +			&builder->descs[builder->cur_desc];
> +
> +		memset(next_desc, 0, sizeof(*next_desc));
> +		sg_set_page(next_desc, page, len, offset);
> +		builder->cur_desc++;
> +	} else if (!always_use_shadow_buffer && is_vmalloc_addr(data)) {

[Severity: High]
Can scatterlist_builder_add_data() end up mapping kernel stack memory
directly into the virtqueue scatterlist for DMA when always_use_shadow_buff=
er
is false?

Most V4L2 ioctl payloads passed here reside on the kernel stack:
video_usercopy() in drivers/media/v4l2-core/v4l2-ioctl.c places any ioctl
argument with _IOC_SIZE(cmd) <=3D 128 into char sbuf[128] on the stack, and
virtio_media_g_input(), virtio_media_s_input(), virtio_media_g_output(),
virtio_media_s_output(), virtio_media_s_std(), and
virtio_media_device_ioctl() pass addresses of local stack variables (&input,
&output, &s, &standard, and &std_id).

When CONFIG_VMAP_STACK is disabled, stack addresses satisfy virt_addr_valid=
();
when CONFIG_VMAP_STACK is enabled, stack addresses satisfy is_vmalloc_addr(=
).
Without a !object_is_on_stack(data) check, stack buffers bypass
builder->shadow_buffer and are passed to virtqueue_add_sgs(), triggering
check_for_stack() warnings in kernel/dma/debug.c and risking stack corrupti=
on
on non-cache-coherent platforms while sleeping in wait_event().

Also, shouldn't the end-of-buffer check be virt_addr_valid(data + len - 1)
rather than virt_addr_valid(data + len), and doesn't reusing descriptor ind=
ex
1 in virtio_media_send_wr_ioctl() cause virtqueue_add_sgs() to DMA-map the
same scatterlist entry twice concurrently as both DMA_TO_DEVICE and
DMA_FROM_DEVICE?

[ ... ]

> +	} else {
> +		/*
> +		 * As a last resort, copy into the shadow buffer and reference
> +		 * it with a single SG entry. Calling
> +		 * scatterlist_builder_retrieve_data() will be necessary to copy
> +		 * the data written by the device back into @data.
> +		 */
> +		void *shadow_buffer =3D
> +			builder->shadow_buffer + builder->shadow_buffer_pos;
> +		struct page *page =3D virt_to_page(shadow_buffer);
> +		unsigned long offset =3D
> +			(((unsigned long)shadow_buffer) & ~PAGE_MASK);
> +		struct scatterlist *next_desc =3D
> +			&builder->descs[builder->cur_desc];
> +
> +		if (len >
> +		    builder->shadow_buffer_size - builder->shadow_buffer_pos)
> +			return -ENOSPC;
> +
> +		memcpy(shadow_buffer, data, len);
> +		memset(next_desc, 0, sizeof(*next_desc));
> +		sg_set_page(next_desc, page, len, offset);
> +		builder->cur_desc++;
> +		builder->shadow_buffer_pos +=3D len;
> +	}

[Severity: Medium]
When multiple descriptors are sub-allocated from builder->shadow_buffer (for
example when always_use_shadow_buffer is true during
virtio_media_send_r_ioctl() or virtio_media_send_wr_ioctl()), does advancing
builder->shadow_buffer_pos by the unaligned len cause adjacent
DMA_FROM_DEVICE and DMA_TO_DEVICE descriptors to share a CPU cache line?

virtio_media_send_r_ioctl() places the 16-byte virtio_media_cmd_ioctl at
offset 0, the 8-byte virtio_media_resp_ioctl at offset 16, and ioctl_data at
offset 24. When virtqueue_add_sgs() maps each scatterlist entry separately =
for
DMA, unaligned offsets within session->shadow_buf can trigger
CONFIG_DMA_API_DEBUG overlapping cacheline warnings and corrupt adjacent
response data during cache invalidation on non-coherent DMA platforms unless
shadow_buffer_pos is aligned to dma_get_cache_alignment() /
ARCH_DMA_MINALIGN.

[ ... ]

> +int scatterlist_builder_retrieve_data(struct scatterlist_builder *builde=
r,
> +				      size_t sg_index, void *data)
> +{
> +	void *shadow_buf =3D builder->shadow_buffer;
> +	struct scatterlist *sg;
> +	void *kaddr;
> +
> +	/* We can only retrieve from the range of sgs currently set. */
> +	if (sg_index >=3D builder->cur_sg)
> +		return -ERANGE;
> +
> +	sg =3D builder->sgs[sg_index];
> +	kaddr =3D pfn_to_kaddr(page_to_pfn(sg_page(sg))) + sg->offset;
> +
> +	if (kaddr >=3D shadow_buf &&
> +	    kaddr < shadow_buf + builder->shadow_buffer_size) {
> +		if (kaddr + sg->length >
> +		    shadow_buf + builder->shadow_buffer_size)
> +			return -EINVAL;
> +
> +		memcpy(data, kaddr, sg->length);
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
On arm64 with CONFIG_KASAN_SW_TAGS or CONFIG_KASAN_HW_TAGS enabled, will the
range check in scatterlist_builder_retrieve_data() fail to match shadow_buf?

In virtio_media_session_alloc(), session->shadow_buf is allocated with
kzalloc(VIRTIO_SHADOW_BUF_SIZE, GFP_KERNEL), which returns a pointer with a
KASAN tag in bits 63:56. Here, kaddr is computed via pfn_to_kaddr(), which
produces an untagged linear address with 0xff in bits 63:56.

Comparing kaddr < shadow_buf + builder->shadow_buffer_size compares an
0xff-tagged address against a tagged pointer, which evaluates to false and
silently skips copying the response payload out of the shadow buffer. Should
kasan_reset_tag() (or page_address(sg_page(sg)) / sg_virt(sg)) be used when
comparing and copying from shadow_buf?

> +
> +/**
> + * scatterlist_builder_add_ioctl_cmd() - Add an ioctl command to the des=
criptor
> + *                                       chain.
> + * @builder: builder to use.
> + * @session: session on behalf of which the ioctl command is added.
> + * @ioctl_code: code of the ioctl to add (i.e. ``VIDIOC_*``).
> + */
> +int scatterlist_builder_add_ioctl_cmd(struct scatterlist_builder *builde=
r,
> +				      struct virtio_media_session *session,
> +				      u32 ioctl_code)
> +{
> +	struct virtio_media_cmd_ioctl *cmd_ioctl =3D &session->cmd.ioctl;
> +
> +	cmd_ioctl->hdr.cmd =3D VIRTIO_MEDIA_CMD_IOCTL;
> +	cmd_ioctl->hdr.__reserved =3D 0;
> +	cmd_ioctl->session_id =3D session->id;
> +	cmd_ioctl->code =3D VIRTIO_MEDIA_IOCTL_CODE(ioctl_code);

[Severity: Low]
Since hdr.cmd, session_id, and code in struct virtio_media_cmd_ioctl are
declared as __le32 in include/uapi/linux/virtio_media.h, should these
assignments use cpu_to_le32() to avoid Sparse -Wbitwise warnings?

[ ... ]

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 0000000000000..656ecea8a44cc
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
> @@ -0,0 +1,606 @@

[ ... ]

> +static int virtio_media_querycap(struct file *file, void *fh,
> +				 struct v4l2_capability *cap)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +
> +	strscpy(cap->bus_info, "platform:virtio-media");
> +	strscpy(cap->driver, VIRTIO_MEDIA_DEFAULT_DRIVER_NAME);
> +
> +	virtio_cread_bytes(vv->virtio_dev, 8, cap->card, sizeof(cap->card));

[Severity: Medium]
Does virtio_media_querycap() need to ensure cap->card is NUL-terminated aft=
er
virtio_cread_bytes()?

In include/uapi/linux/virtio_media.h, the comment for
struct virtio_media_config states that if all 32 characters of card are used
by the device, it does not need to be NUL-terminated:

    * @card: name of the device, a NUL-terminated UTF-8 string. It correspo=
nds
    *        with the card field of the struct v4l2_capability. If all the
    *        characters of the field are used, it does not need to be
    *        NUL-terminated.

However, V4L2 requires struct v4l2_capability.card to always be NUL-termina=
ted
when returned to userspace by VIDIOC_QUERYCAP.

> +
> +	cap->capabilities =3D video_dev->device_caps | V4L2_CAP_DEVICE_CAPS;
> +	cap->device_caps =3D video_dev->device_caps;
> +
> +	return 0;
> +}
> +
> +/*
> + * s/g_input/output work with an unsigned int - recast this to a u32 so =
the
> + * size is unambiguous.
> + */
> +
> +static int virtio_media_g_input(struct file *file, void *fh, unsigned in=
t *i)
> +{
> +	u32 input;
> +
> +	int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +					 VIDIOC_G_INPUT, &input,
> +					 sizeof(input), sizeof(input));
> +	if (ret)
> +		return ret;
> +
> +	*i =3D input;
> +
> +	return 0;
> +}
> +
> +static int virtio_media_s_input(struct file *file, void *fh, unsigned in=
t i)
> +{
> +	u32 input =3D i;
> +
> +	return virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +					  VIDIOC_S_INPUT, &input,
> +					  sizeof(input), sizeof(input));
> +}
> +
> +static int virtio_media_g_output(struct file *file, void *fh, unsigned i=
nt *o)
> +{
> +	u32 output;
> +
> +	int ret =3D virtio_media_send_wr_ioctl(file_to_v4l2_fh(file),
> +					 VIDIOC_G_OUTPUT, &output,
> +					 sizeof(output), sizeof(output));

[Severity: High]
Should virtio_media_g_input() and virtio_media_g_output() call
virtio_media_send_r_ioctl() instead of virtio_media_send_wr_ioctl()?

Both VIDIOC_G_INPUT and VIDIOC_G_OUTPUT are defined with _IOR in
include/uapi/linux/videodev2.h. Per the VIRTIO_MEDIA_CMD_IOCTL documentation
in include/uapi/linux/virtio_media.h, _IOR ioctls should only be followed b=
y a
device-writable response descriptor.

Calling virtio_media_send_wr_ioctl() attaches a device-readable command
payload descriptor for an _IOR ioctl and sends 4 bytes of uninitialized sta=
ck
memory from input and output to the host (or copies uninitialized bytes into
session->shadow_buf via memcpy()).

[ ... ]

> +long virtio_media_device_ioctl(struct file *file, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	struct video_device *video_dev =3D video_devdata(file);
> +	struct virtio_media *vv =3D to_virtio_media(video_dev);
> +	struct v4l2_fh *vfh =3D NULL;
> +	struct v4l2_standard standard;
> +	v4l2_std_id std_id =3D 0;
> +	int ret;
> +
> +	if (test_bit(V4L2_FL_USES_V4L2_FH, &video_dev->flags))
> +		vfh =3D file_to_v4l2_fh(file);
> +
> +	mutex_lock(&vv->vlock);

[Severity: Critical]
What prevents a use-after-free of the session and vv->commandq if
virtio_media_remove() runs while a file descriptor is open or an ioctl is
waiting on vv->vlock?

In drivers/media/virtio/virtio_media_driver.c, virtio_media_remove() does:

	video_unregister_device(&vv->video_dev);
	mutex_lock(&vv->vlock);
	virtio_reset_device(virtio_dev);
	while (virtqueue_detach_unused_buf(vv->commandq))
		;
	virtio_dev->config->del_vqs(virtio_dev);
	mutex_unlock(&vv->vlock);

	list_for_each_safe(p, n, &vv->sessions) {
		struct virtio_media_session *s =3D
			list_entry(p, struct virtio_media_session, list);

		virtio_media_session_remove(vv, s);
		virtio_media_session_free(s);
	}

If a thread passes v4l2_ioctl()'s unlocked video_is_registered() check and
waits on mutex_lock(&vv->vlock) in virtio_media_device_ioctl() while
virtio_media_remove() runs, virtio_media_remove() deletes vv->commandq and
frees all sessions (including s->command_sgs and s->shadow_buf). Once
virtio_media_device_ioctl() acquires vv->vlock, it proceeds without checking
video_is_registered(video_dev), dereferencing the freed vfh / session and
submitting descriptors to the deleted vv->commandq.

Furthermore, when userspace later closes the open file descriptor,
v4l2_release() calls virtio_media_device_close(), which looks up the already
freed session from file->private_data, accesses vv->commandq in
virtio_media_session_close(), and calls virtio_media_session_remove() and
virtio_media_session_free() a second time.

> +
> +	/*
> +	 * We need to handle a few ioctls manually because their results
> +	 * rely on vfd->tvnorms, which is normally updated by the driver
> +	 * as S_INPUT is called. Since we want to just pass these ioctls
> +	 * through, we have to hijack them from here.
> +	 */
> +	switch (cmd) {
> +	case VIDIOC_S_STD:
> +		ret =3D copy_from_user(&std_id, (void __user *)arg,
> +				     sizeof(std_id));
> +		if (ret) {
> +			ret =3D -EFAULT;
> +			break;
> +		}
> +		ret =3D virtio_media_s_std(file, vfh, std_id);
> +		break;
> +	case VIDIOC_ENUMSTD:
> +		ret =3D copy_from_user(&standard, (void __user *)arg,
> +				     sizeof(standard));
> +		if (ret) {
> +			ret =3D -EFAULT;
> +			break;
> +		}
> +		ret =3D virtio_media_enumstd(file, vfh, &standard);
> +		if (ret)
> +			break;
> +		ret =3D copy_to_user((void __user *)arg, &standard,
> +				   sizeof(standard));
> +		if (ret)
> +			ret =3D -EFAULT;
> +		break;
> +	case VIDIOC_QUERYSTD:
> +		ret =3D virtio_media_querystd(file, vfh, &std_id);
> +		if (ret)
> +			break;
> +		ret =3D copy_to_user((void __user *)arg, &std_id, sizeof(std_id));
> +		if (ret)
> +			ret =3D -EFAULT;
> +		break;
> +	default:
> +		ret =3D video_ioctl2(file, cmd, arg);
> +		break;
> +	}

[Severity: High]
By intercepting VIDIOC_S_STD, VIDIOC_ENUMSTD, and VIDIOC_QUERYSTD before
video_ioctl2(), doesn't virtio_media_device_ioctl() bypass several V4L2 core
checks and 32-bit compat handling?

Specifically:
1. __video_do_ioctl() checks test_bit(_IOC_NR(cmd), video_dev->valid_ioctls)
   and calls v4l2_prio_check(video_dev->prio, vfh->prio) for VIDIOC_S_STD
   (which is marked INFO_FL_PRIO). Intercepting them here skips both device
   validity and priority checks.
2. For VIDIOC_ENUMSTD, v4l2_ioctls[] uses INFO_FL_CLEAR(v4l2_standard, inde=
x)
   so video_get_user() zeroes all output fields after index, whereas
   copy_from_user() here forwards unzeroed trailing fields from userspace to
   the host.
3. Under CONFIG_COMPAT on x86_64, 32-bit userspace issues VIDIOC_ENUMSTD32
   because struct v4l2_standard32 differs in size and alignment.
   v4l2_compat_ioctl32() passes VIDIOC_ENUMSTD32 to fops->unlocked_ioctl;
   because the switch statement only matches native VIDIOC_ENUMSTD,
   VIDIOC_ENUMSTD32 falls through to video_ioctl2() -> v4l_enumstd(), where
   video_dev->tvnorms is 0, failing with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029153038.3800=
747-1-briandaniels@google.com?part=3D2
