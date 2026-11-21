Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795230936;
	b=ZCsbAap7Japtvc2qoNT3dYrvsf1YQ97zAcucfbgv1GMDhTHprXQtRPr6LfLit5bBWoae
	 QKZB4o4XoENzreZ4esRlhmDbw51eRUR9ISF6vdVu6FWa+jZ/ppM7XaqwNB3/PsjYzEffF
	 B5sjJXIhMmlDpasA58kF8l0GqlCcae5KhmvBLY88Z/FxOKQ9VqDxUR+dio2NN5bia+ofo
	 3/DYnmEPOGMFtqQnzaJzEMKH7SggwW8ZM+oJHdJn98wNZc+pgE5GqKcgUm2KZmBl0W/YA
	 iWj8warASBUbROiZeUQYmOefC6nx0BICgSTjFGo9ieMlnFk1RtAxw3Flz+gf72LHX5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795230936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=47OIPdlKA7fDbYUH7/n8Mmc6p4KNvnwGAlX9pqcpvMU=;
	b=aC7jL6JF4r1pzQTRDS7vZxGUlj1hjC9MoGMvjGIhwtxiBcnUMlnyjYqYMD3Ic4a37K0v
	 pbtWGlYfOI55eJL0B9RSCFpQE8oSfJ/VzmTW2uVYasBMI/HJXt2/3gS3fMVVFnm9WSClt
	 oeaQjQ34lbhQR9texIWFo+bSBWKMgwCYuivC+60IanDG5sIGeNxtPZp7Zs8oSc3dXDt/P
	 vz6lfJ/2oG/Jmr0aggVgZFJE9nXIDV1rykZWl2kw36vmPPfs3wJidpGP5fbbxgigTJ5Fq
	 c2plhSAXgGCJK6b/EU/JtST5lL5Aq8LTAZXkG0KBSqYecxLAdZ68zV56dpledgVDZlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niovuZtX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9B606A6A9
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 03:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niovuZtX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B371F000C0;
	Sat, 21 Nov 2026 03:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795230935;
	bh=47OIPdlKA7fDbYUH7/n8Mmc6p4KNvnwGAlX9pqcpvMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niovuZtXBIUlZGSokFT+06yMN2ObinR7b+zEW+aVIUzpry+mbCvg0xTJUgIJOG67J
	 2vnQVPwaXdVBYW7Pz8DuJ1ouCqSKrviRHzeIFdEGGIkuADBZu/ihYxTc+fqg6PwrYV
	 oYLNaPukXmYw8DFegZEDi0s6U0UY9fr2w/Y2ySr1lK2BCAkQ+7eLmQFkeBB9Br8yzM
	 aXRnzPuWhQxgItzaNnlJz11Lhk+VxvwZVjKeE9rIjJQaTpvKLtoXCsZ/Lc0h71cINS
	 Mdicm5Nm7ibgDmEUwZpQOVlT3d3h0KcBedS6KI/91N+ErjKHX4pFTVXEKla8gBWsdT
	 j61qQntmBdVYg==
Message-ID: <sashiko-outbox-226565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 2/6] media: virtio: Add V4L2 ioctl forwarding
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Daniels" <briandaniels@google.com>
Cc: virtualization@lists.linux.dev, media-ci@linuxtv.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261121025007.3445723-3-briandaniels@google.com>
References: <20261121025007.3445723-1-briandaniels@google.com>
 <20261121025007.3445723-3-briandaniels@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:15:35 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] media: virtio: stack buffers mapped for DMA in
  scatterlist_builder_add_data()
- [High] media: virtio: V4L2 core and remove race bypass in
  virtio_media_device_ioctl()
- [Medium] media: virtio: const discard in
  scatterlist_builder_retrieve_data() on ppc64le
- [Medium] media: virtio: missing NUL-termination of card in
  virtio_media_querycap()
- [Medium] media: virtio: uninitialized stack payload in
  virtio_media_g_input()
--

commit 2bb3f66c322d534b371d016a0dfc9daa0878344f
Author: Alexandre Courbot <gnurou@gmail.com>

media: virtio: Add V4L2 ioctl forwarding infrastructure

This commit introduces a scatterlist builder and synchronous V4L2 ioctl
forwarding via VIRTIO_MEDIA_CMD_IOCTL, along with handlers for
VIDIOC_QUERYCAP and fixed-size V4L2 ioctls.

> diff --git a/drivers/media/virtio/scatterlist_builder.c b/drivers/media/v=
irtio/scatterlist_builder.c
> new file mode 100644
> index 0000000000000..ae8ffee82fa6e
> --- /dev/null
> +++ b/drivers/media/virtio/scatterlist_builder.c
> @@ -0,0 +1,222 @@

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
Does scatterlist_builder_add_data() map kernel stack buffers directly into
scatterlists for DMA instead of bouncing them through the shadow buffer?

Most ioctl payloads passed here live on the kernel stack: video_usercopy()
uses a 128-byte stack buffer (sbuf) for small ioctls, and handlers such as
virtio_media_g_input(), virtio_media_s_std(), and
virtio_media_device_ioctl() pass addresses of local stack variables.
Because neither branch checks !object_is_on_stack(data), stack buffers
match virt_addr_valid() when CONFIG_VMAP_STACK=3Dn and is_vmalloc_addr()
when CONFIG_VMAP_STACK=3Dy.  Mapping stack memory into virtio scatterlists
violates kernel DMA rules (triggering CONFIG_DMA_API_DEBUG warnings when
the virtqueue uses the DMA API) and risks corrupting adjacent stack frames
sharing a cache line on non-coherent DMA platforms while the caller sleeps
in wait_event().

Also, virt_addr_valid(data + len) checks one byte past the end of the
buffer instead of data + len - 1.

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

[Severity: Medium]
Does assigning pfn_to_kaddr() to void *kaddr fail to build on 64-bit
little-endian PowerPC with CONFIG_WERROR=3Dy?  On PowerPC, pfn_to_kaddr()
returns const void *, so this assignment triggers -Wdiscarded-qualifiers.
Using sg_virt(sg) avoids the qualifier mismatch.

> diff --git a/drivers/media/virtio/virtio_media_ioctls.c b/drivers/media/v=
irtio/virtio_media_ioctls.c
> new file mode 100644
> index 0000000000000..e92032bce7dbe
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
> +
> +	cap->capabilities =3D video_dev->device_caps | V4L2_CAP_DEVICE_CAPS;
> +	cap->device_caps =3D video_dev->device_caps;
> +
> +	return 0;
> +}

[Severity: Medium]
Can virtio_media_querycap() return a non-NUL-terminated cap->card string to
userspace?

In include/uapi/linux/virtio_media.h, struct virtio_media_config documents
that its 32-byte card field does not need to be NUL-terminated when all
characters are used, whereas V4L2 requires v4l2_capability.card to always
be NUL-terminated.  Ensuring cap->card[sizeof(cap->card) - 1] =3D '\0' (and
using offsetof(struct virtio_media_config, card) instead of the hardcoded
8) would prevent unterminated strings from reaching userspace.

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
Can virtio_media_g_input() and virtio_media_g_output() copy uninitialized
kernel stack memory into the DMA shadow buffer or back to userspace?

Both functions leave their local u32 variable uninitialized before calling
virtio_media_send_r_ioctl() -> scatterlist_builder_add_data().  When the
shadow buffer path is used, scatterlist_builder_add_data() unconditionally
runs memcpy(shadow_buffer, data, len) even for _IOR response buffers,
copying the uninitialized stack value into session->shadow_buf, and if the
host does not overwrite the buffer (or returns a status with bit 31 set,
which virtio_media_kick_command() negates as unsigned __le32 into a
positive value that virtio_media_send_command() treats as success), that
uninitialized value is returned to userspace.

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
Can intercepting VIDIOC_S_STD, VIDIOC_ENUMSTD, and VIDIOC_QUERYSTD before
video_ioctl2() cause a use-after-free or NULL pointer dereference when
racing with virtio_media_remove()?

CPU0                                  CPU1
v4l2_ioctl()
  video_is_registered(vdev) -> true
  virtio_media_device_ioctl()
                                      virtio_media_remove()
                                        video_unregister_device()
                                        mutex_lock(&vv->vlock)
                                        virtio_dev->config->del_vqs()
                                        mutex_unlock(&vv->vlock)
                                        virtio_media_session_free(s)
    mutex_lock(&vv->vlock)
    virtio_media_querystd()
      virtio_media_send_r_ioctl()     <-- NULL fh->vdev / UAF on session
                                          and deleted commandq

Unlike __video_do_ioctl(), which re-checks video_is_registered() after
taking the lock, these manual cases proceed directly into the handlers
after virtio_media_remove() has deleted vv->commandq and freed the
sessions.

Bypassing video_ioctl2() here also skips 32-bit compat translation for
VIDIOC_ENUMSTD32 (so 32-bit compat callers fall through to default and
fail because video_dev->tvnorms is 0), skips is_valid_ioctl() and
v4l2_prio_check() on VIDIOC_S_STD, and does not zero the output fields of
struct v4l2_standard after index on VIDIOC_ENUMSTD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121025007.3445=
723-1-briandaniels@google.com?part=3D2
