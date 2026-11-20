Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795213538;
	b=X3RJ5J/hk3x9Iq5tR5U4Rt9UhjqQAxODU/bkUe1gf+pjmBWBagBIGQgvP8wCnJPL7QTe
	 9k8cGLC7k9UErUiRKcxeK+7pYk3cui//YAY11cdpXnSyKauQDBqPBJpxZFS5e/gaGGU8H
	 Z4nDIthMAlSGiNgESftkgwYOsp0otB7Nn/BxlRg/IuFCjHfMXfjSSqlHIG9f3PcMkK9iX
	 AP5plaj2PDu6d2dURaRWdxb6yU9kMl1IqBRz1MBRWdUw7blNZzSEYk3ayCR80u8KHATwZ
	 xwksjL/E+6+VidiD9DAMOb2GOq0s6pxMPm+R6GHpS8EiJEaWQaSMhIjMhLz+NPmnqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l7LQ6P1Lppi1Rqc0ljFjs6CjKZi2eXAxADesxTEjfwM=;
	b=0ayb+TFDCmB5pruqIqlzWkl5xwXjzVaSArZuUmpfKU25hEoJMWiUJdWoPbfMqFsw2pF6
	 OeeO1iV7IMmIk1c+A9d3GKHFaQslCVCVQCEx/IvsHxKA40AqjdE0ywf332uWoMnmHUqi0
	 kWuKKz3rgTabXylq94B3gf0yuhFUo6WKechsRdhS23e/YqXphp71mw8rAtYRBmLHPqWav
	 405PERZYs8XiSDgqO3jN7DM3xGVwr01rGO+iZ/yhDpES4jGAMD4NelRAuf4h20wvFROp0
	 kEA2C2I11ysAhNZZUtLuq2OD7h67Cz9ixn2JqPTVomfo9XovbYI3OK/h6LRrJG0WCJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvJ6i1CD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65687606A68A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MvJ6i1CD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD311F000CA;
	Fri, 20 Nov 2026 22:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795213538;
	bh=l7LQ6P1Lppi1Rqc0ljFjs6CjKZi2eXAxADesxTEjfwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvJ6i1CDjyPdPhF0AFHtMS/mqaHQxxxVhnNOIVNf2Suu0IGTtgHixAfDLj2VniRRo
	 pOCDJ5M9RluWHb8SjexYvS6wkxDkbxEfYtIiEK8/nLDgVTTmWkuvKtpbHqrjNS0rui
	 OyyxEkUNup19EX3a+ZUKxREUQ2v4i5FaN+M4jn3BrVw+J2aflBvn85cvakTRr2WlXU
	 iJ+sFb3lUzlVIDST6xK/MTjVgLwIJQWdmMQh/GBVWygWL81/89IJLuM4ax6uNtE6FQ
	 BMrFa3Na+Ccnz9vXzT2VPL8N40NL3/41iGky9lHe26heJZamFoqTb9FOwZPqxqLOGQ
	 k5la7YrF6Mx2w==
Message-ID: <sashiko-outbox-226261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/6] media: virtio: Add V4L2 ioctl forwarding
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261120215916.3149345-3-briandaniels@google.com>
References: <20261120215916.3149345-1-briandaniels@google.com>
 <20261120215916.3149345-3-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:25:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] media: virtio: DMA mapping of kernel stack in
  scatterlist_builder_add_data()
- [High] media: virtio: pfn_to_kaddr() build and KASAN bug in
  retrieve_data()
- [High] media: virtio: session use-after-free on unbind in
  virtio_media_remove()
- [High] media: virtio: V4L2 core and compat bypass in
  virtio_media_device_ioctl()
- [Medium] media: virtio: unaligned shadow_buffer_pos in
  scatterlist_builder_add_data()
- [Medium] media: virtio: missing NUL-termination of cap->card in
  virtio_media_querycap()
- [Medium] media: virtio: uninitialized stack variables in
  virtio_media_g_input/output()
--

commit 2de20993548662c5f3f30aa219959343b41cbc39
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add V4L2 ioctl forwarding infrastructure

This commit introduces a scatterlist builder and synchronous V4L2 ioctl
forwarding via VIRTIO_MEDIA_CMD_IOCTL, implementing VIDIOC_QUERYCAP and
fixed-size V4L2 ioctls.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> new file mode 100644
> index 0000000000000..ae8ffee82fa6e
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c
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
Does scatterlist_builder_add_data() map kernel stack buffers directly for
DMA instead of falling back to builder->shadow_buffer?

Both video_usercopy() (for ioctl arguments up to 128 bytes) and handlers
such as virtio_media_g_input() and virtio_media_device_ioctl() pass
stack-allocated buffers here.  When CONFIG_VMAP_STACK=3Dy, stack addresses
satisfy is_vmalloc_addr(data); when CONFIG_VMAP_STACK=3Dn, they satisfy
virt_addr_valid(data).  Without checking !object_is_on_stack(data), stack
pages are placed directly into the virtqueue scatterlist, violating the DMA
API contract when DMA mapping is used (triggering CONFIG_DMA_API_DEBUG
check_for_stack() warnings and risking stack corruption on non-coherent
platforms).

Also, virt_addr_valid(data + len) checks one byte past the end of the
buffer rather than data + len - 1.

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
Can advancing builder->shadow_buffer_pos by an unaligned len pack separate
DMA_TO_DEVICE and DMA_FROM_DEVICE descriptors into the same DMA cacheline?

When multiple descriptors use the shadow buffer (for example, cmd_ioctl at
12 bytes followed by resp_ioctl at 8 bytes and the response payload),
packing them at unaligned offsets shares a single cacheline across
bidirectional DMA mappings and leaves subsequent shadow buffer entries
misaligned.  In addition, this path unconditionally runs
memcpy(shadow_buffer, data, len) even when staging device-writable (_IOR)
response buffers.

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

[Severity: High]
Should this use sg_virt(sg) instead of
pfn_to_kaddr(page_to_pfn(sg_page(sg))) + sg->offset?

On powerpc, pfn_to_kaddr() returns const void *, failing compilation with
-Werror=3Ddiscarded-qualifiers when assigned to void *kaddr, and on alpha a=
nd
x86_64 UML pfn_to_kaddr() is not defined.  On arm64 with tag-based KASAN
(CONFIG_KASAN_SW_TAGS or CONFIG_KASAN_HW_TAGS), pfn_to_kaddr() returns an
untagged linear address (top byte 0xff) while shadow_buf from kzalloc()
carries a KASAN tag, so the shadow_buf range check evaluates to false and
silently skips copying the device response back into data.

> diff --git a/drivers/media/virtio/virtio_media_driver.c b/drivers/media/v=
irtio/virtio_media_driver.c
> index 39c5a38d20b1b..0fe20cf508212 100644
> --- a/drivers/media/virtio/virtio_media_driver.c
> +++ b/drivers/media/virtio/virtio_media_driver.c
[ ... ]
> @@ -77,6 +94,9 @@ static void virtio_media_session_free(struct virtio_med=
ia_session *session)
>  	virtio_media_session_fh_del(session);
>  	v4l2_fh_exit(&session->fh);
> =20
> +	sg_free_table(&session->command_sgs);
> +
> +	kfree(session->shadow_buf);
>  	kfree(session);
>  }

[Severity: High]
Can session->command_sgs, session->shadow_buf, and session be used after
free and double freed if the device is removed while a file descriptor is
open?

virtio_media_remove() frees all sessions in vv->sessions via
virtio_media_session_free() while open struct file instances still reference
session->fh:

drivers/media/virtio/virtio_media_driver.c:virtio_media_remove() {
    ...
	list_for_each_safe(p, n, &vv->sessions) {
		struct virtio_media_session *s =3D
			list_entry(p, struct virtio_media_session, list);

		virtio_media_session_remove(vv, s);
		virtio_media_session_free(s);
	}
    ...
}

When userspace later closes the file descriptor, v4l2_release() invokes
virtio_media_device_close(), which accesses the freed session and calls
virtio_media_session_free(session) a second time:

CPU0                              CPU1
virtio_media_remove()
  video_unregister_device(...)
  ...
  virtio_media_session_free(s)
    sg_free_table(&s->command_sgs)
    kfree(s->shadow_buf)
    kfree(s)
                                  v4l2_release()
                                    virtio_media_device_close()
                                      virtio_media_session_close(vv, s)
                                        <-- use-after-free
                                      virtio_media_session_free(s)
                                        <-- double free

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 0000000000000..e92032bce7dbe
> --- /dev/null
> +++ b/drivers/media/virtio/virtio_media_ioctls.c
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
> +
> +	cap->capabilities =3D video_dev->device_caps | V4L2_CAP_DEVICE_CAPS;
> +	cap->device_caps =3D video_dev->device_caps;
> +
> +	return 0;
> +}

[Severity: Medium]
Can virtio_media_querycap() leave cap->card without a NUL terminator?

In include/uapi/linux/virtio_media.h, struct virtio_media_config documents
that card does not need to be NUL-terminated when all 32 bytes are used,
whereas V4L2 requires struct v4l2_capability.card to be a NUL-terminated
string.

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
> +	int ret =3D virtio_media_send_r_ioctl(file_to_v4l2_fh(file),
> +					 VIDIOC_G_INPUT, &input,
> +					 sizeof(input));
> +	if (ret)
> +		return ret;
> +
> +	*i =3D input;
> +
> +	return 0;
> +}

[Severity: Medium]
Does virtio_media_g_input() (and virtio_media_g_output() below) pass
uninitialized stack memory to scatterlist_builder_add_data()?

Because input and output are not initialized before calling
virtio_media_send_r_ioctl(), the shadow buffer fallback in
scatterlist_builder_add_data() reads 4 bytes of uninitialized stack memory
via memcpy(shadow_buffer, data, len), and an incomplete host write leaves
uninitialized stack bytes in *i or *o.

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
> +
> +	mutex_unlock(&vv->vlock);
> +
> +	return ret;
> +}

[Severity: High]
Does intercepting VIDIOC_S_STD, VIDIOC_ENUMSTD, and VIDIOC_QUERYSTD before
video_ioctl2() bypass V4L2 registration, priority, and 32-bit compat
handling?

Unlike __video_do_ioctl(), these three branches do not check
video_is_registered(video_dev) after acquiring vv->vlock.  If
virtio_media_device_ioctl() blocks on mutex_lock(&vv->vlock) while
virtio_media_remove() unregisters the device, deletes vv->commandq, and
frees all sessions, these branches proceed to dereference the freed session
and deleted virtqueue:

CPU0                              CPU1
v4l2_ioctl()
  video_is_registered(vdev)
  virtio_media_device_ioctl()
                                  virtio_media_remove()
                                    video_unregister_device(...)
                                    mutex_lock(&vv->vlock)
                                    ...
                                    virtio_dev->config->del_vqs(...)
                                    mutex_unlock(&vv->vlock)
                                    virtio_media_session_free(s)
    mutex_lock(&vv->vlock)
    virtio_media_querystd()
      ...                         <-- use-after-free of s and commandq

In addition, 32-bit compat userspace on x86_64 issues VIDIOC_ENUMSTD32,
which misses the VIDIOC_ENUMSTD case and falls through to video_ioctl2() ->
v4l_enumstd(), failing with -EINVAL because video_dev->tvnorms is 0.
Bypassing video_ioctl2() also skips is_valid_ioctl(), v4l2_prio_check() on
VIDIOC_S_STD, and INFO_FL_CLEAR zeroing of struct v4l2_standard fields
beyond index on VIDIOC_ENUMSTD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120215916.3149=
345-1-briandaniels@google.com?part=3D2
