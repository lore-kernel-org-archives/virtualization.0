Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C6B41D20E
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162710; cv=none; b=ehz7uGEXyivUuzFEnkX8f4oC4z+J1j9aAU3tQpAwWaSSf1O1LvM3Ot9qtCQqt0gSecHz2+GLvxVpBzvQ22dER4CxMarzONjScC9kbfNWDZv16fN10beYfOVSmHLoBnlt1E5bYaDcQV75m/JWmc3o0JerA1QAGeeNa4A64AmPoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162710; c=relaxed/simple;
	bh=HpDBpdfkeQ8/uL2IhtUbl3XNqucIxjfWlBRhWShdSMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tPokQMXWC+OwLR/XugXLOIJy5BLhjB2uBjG1xrE6nry0N1xGY68cDxKg4djJ4MMt/qwgqeK78jLX2TULcWb1vckarhGTThp6ieyCdBcwcxjxmmi1Wt1jRrIUWhkIIlO7f6vpDW+rzql5GZMnGS2JY23O0yXUx1HTrWZ5iUodWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etipdGIJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etipdGIJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A211F000FF;
	Fri, 11 Sep 2026 21:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789162709;
	bh=Nq+i5Ft11Qio5mlBsW36zaVJqYtG6TXC+ktj+hRBpSE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etipdGIJiHBebqwzStMQkMwdCFP9O07igoOaG6tXqvcVcSF53O320pP3tljFAGzDR
	 DiYcBOEc2zdvkMvCDMdsFsTXscqkP79cApfo+z5IqYAS2jeArOBdju4A+NBgVppRa2
	 NuE9cP4ndOZVP5Y5CT14KsGsEsYUDMs60CIagSm+JdiH582VowyGuPmGauQPzCid2w
	 3YglwCs8Ju33U3h95TUkQ3Qnmms6pO3diqcvyJL34ZYV3+QPlM/37+YGWarbikM+KJ
	 BugVVBFCB15borgRUM5fgKXdAjSjq5fVqJJFNFvNzlMNZ6U0ddT4LEqJEwdQTlhanm
	 lm2n2YIbwOEiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] virtio_pci_modern: move avq cleanup from reset
 to del_vqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
 <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 21:38:28 +0000
Message-Id: <20260911213828.E9A211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Moving `vp_modern_avq_cleanup()` out of `vp_reset()` causes admin =
command waiters to hang indefinitely during system shutdown.
- [High] Use-After-Free in `vp_modern_avq_cleanup()` triggered during `find=
_vqs` error paths or virtio driver re-binds due to a dangling `admin_vq.inf=
o` pointer.
--

commit 9f596701bb244c686f63dc19e6844b130e778230
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_pci_modern: move avq cleanup from reset to del_vqs
   =20
vp_modern_avq_cleanup() detaches unused buffers from the admin
virtqueue and completes pending commands with -EIO. Calling it
from vp_reset() is incorrect because of a race condition. This
commit moves the call to vp_del_vqs() to eliminate the race.
   =20
Closes: https://lore.kernel.org/virtualization/20260911125745.E0A2F1F00899@=
smtp.kernel.org/

> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index b90c174450b20..28b254ee47266 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -270,6 +270,8 @@ void vp_del_vqs(struct virtio_device *vdev)
>  	struct virtqueue *vq, *n;
>  	int i;
> =20
> +	vp_modern_avq_cleanup(vdev);
> +

[Severity: High]
Could moving the cleanup here leave admin command waiters hanging
indefinitely during system shutdown?

If a device reset is initiated (e.g., via virtio_device_shutdown() or
power management freeze) while an admin command is executing, vp_reset()
is called. Previously, this safely aborted pending commands with -EIO.=20

With the cleanup moved to vp_del_vqs(), which is not called during system
shutdown or suspend, will any thread blocked on wait_for_completion() in
virtqueue_exec_admin_cmd() hang forever since the commands are never
aborted?

>  	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
>  		info =3D vp_is_avq(vdev, vq->index) ? vp_dev->admin_vq.info :

[ ... ]

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index 6d8ae2a6a8caf..ef76f35c6b2c0 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c

[ ... ]

> @@ -354,6 +354,9 @@ static void vp_modern_avq_cleanup(struct virtio_devic=
e *vdev)
>  	if (!virtio_has_feature(vdev, VIRTIO_F_ADMIN_VQ))
>  		return;
> =20
> +	if (!vp_dev->admin_vq.info)
> +		return;
> +

[Severity: High]
Does this check fail to prevent a use-after-free if the pointer is left
dangling?

When queue initialization fails (e.g., IRQ allocation in
vp_find_one_vq_msix()), the error path frees the info structure via
vp_del_vq() but fails to clear vp_dev->admin_vq.info.

Later, the error rollback path in vp_find_vqs_msix() calls vp_del_vqs(),
which immediately calls vp_modern_avq_cleanup():

vp_find_vqs_msix() error path:
error_find:
  vp_del_vqs()
    vp_modern_avq_cleanup()
      if (!vp_dev->admin_vq.info)

Will this result in dereferencing the freed pointer when accessing
vp_dev->admin_vq.info->vq on the next line?

>  	vq =3D vp_dev->admin_vq.info->vq;
>  	if (!vq)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789160982.gi=
t.mst@redhat.com?part=3D3
