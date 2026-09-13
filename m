Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F839F18A;
	Sun, 13 Sep 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789290301; cv=none; b=fm2vsDXdc+59oIWlY65/9R7pCmVbGq4S5S4lOaaxQQqOAtpVesw7VJr5aVXfPDJTa0nMfgbFAN/8AgUbM2NQGfxJjJQusM1cG9LlNCFP0vQl81tUSgBP6GYx6FSu+CuG+EJXaSznZp8RVJ9f3ObV2Y/71oNhYld86F4YnqULTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789290301; c=relaxed/simple;
	bh=Dsndxo3+qVqKKZIUmlmab7L5vQJlLdAT5KEh3sPsFXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fqoZPH2m6UizW5jQRMSWgsYbUpB3nAjxjElA6klSyZakdQnSa1hfyN2oIISt+vuoCxq3GRD4/+WlcWP0SCx+tiSPWi1aU4674t/TM48p+n2MGsN4bXs+fbrhJBpJB3sVIY/CbE7TmsGPZILNb95yJooXCRNgJ8/8ALcVWXQO+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJecyfNy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJecyfNy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8221F00893;
	Sun, 13 Sep 2026 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789290292;
	bh=i3WTkn4ip9oDL3Xp9oedA5FdQRKAHjRR0cO6alLKD54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CJecyfNyVVpztAXh/kBo7gBouqBPpVWhazSda7nE2pOmsPAmykyXcAK7pqA1E5rWG
	 T5ZLv4Nlx8JfIQPCda51CTyvAGpLLROwMkFp3bpCLDq7RvH3OQ7A1FgGgYCUft3BFe
	 s8mdNorpzfxFJi+hy8UQjiyRlNlJLWEfhvnkkyGHsr8PFRWqC7vVtPIhOQgGf0OEXm
	 vEe8nX7SHw5IIMF7jf9rhTQ3LV9pLVVPao09RlXpHZkAgnmybjZWDo2JimGUllh4AF
	 dCqSH6DFV7sBYociifAZXq6a5CAYNa7cm3LgA9ZnOASmun/KFSgYXQncRQiYvcdYn9
	 QAHyeYS6MPJvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-scsi: do not relock event vq mutex on send_evt
 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20260912090420.47439-1-physicalmtea@gmail.com>
References: <20260912090420.47439-1-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 09:04:51 +0000
Message-Id: <20260913090452.2B8221F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] vhost_scsi_do_evt_work() accesses vq->iov[out] without verifyi=
ng that the guest actually provided an input buffer, leading to arbitrary u=
ser-space memory corruption.
- [High] Events are processed in LIFO order instead of FIFO, which can caus=
e state corruption for hotplug/hotunplug sequences.
--

commit 05830c30fc2e4dc682c270a9b487ae5abb66218b
Author: Jia Jia <physicalmtea@gmail.com>

vhost-scsi: do not relock event vq mutex on send_evt fallback
   =20
This commit resolves a deadlock during fallback event handling when the vho=
st
worker has disconnected. It splits event completion into an internal unlock=
ed
helper and a locked wrapper to safely reuse the completion path.
   =20
Link: https://lore.kernel.org/all/20260905005352.1E5B01F00A3D@smtp.kernel.o=
rg/

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 4f8c0260bc9e7..42abf18291b75 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -660,19 +660,26 @@ vhost_scsi_do_evt_work(struct vhost_scsi *vs, struc=
t vhost_scsi_evt *evt)
>  	vhost_scsi_log_write(vq, vq_log, log_num);
>  }
> =20
> -static void vhost_scsi_complete_events(struct vhost_scsi *vs, bool drop)
> +/* Caller must hold the event virtqueue mutex. */
> +static void __vhost_scsi_complete_events(struct vhost_scsi *vs, bool dro=
p)
>  {
> -	struct vhost_virtqueue *vq =3D &vs->vqs[VHOST_SCSI_VQ_EVT].vq;
>  	struct vhost_scsi_evt *evt, *t;
>  	struct llist_node *llnode;
> =20
> -	mutex_lock(&vq->mutex);
>  	llnode =3D llist_del_all(&vs->vs_event_list);
>  	llist_for_each_entry_safe(evt, t, llnode, list) {

[Severity: High]
This is a pre-existing issue, but does this loop deliver events to the guest
in reverse order?

The events are added to vs_event_list using llist_add(), which constructs a
last-in, first-out list. Because lnode is retrieved locklessly with
llist_del_all(), and the iteration happens without first calling
llist_reverse_order(), the events appear to be processed from newest to
oldest.

Could this cause state corruption for hotplug and hotunplug sequences? For
example, if a device is plugged and then rapidly unplugged, the guest might
receive the unplug event first and the plug event second, leaving it
erroneously believing the device is still present.

>  		if (!drop)
>  			vhost_scsi_do_evt_work(vs, evt);

[Severity: Critical]
This is a pre-existing issue, but can this function access out-of-bounds or
stale memory if the guest provides an empty input buffer?

Looking at vhost_scsi_do_evt_work() in drivers/vhost/scsi.c, the code uses
vhost_get_vq_desc() which populates vq->iov:

    head =3D vhost_get_vq_desc(vq, vq->iov,
            ARRAY_SIZE(vq->iov), &out, &in,
            vq_log, &log_num);
    ...
    if ((vq->iov[out].iov_len !=3D sizeof(struct virtio_scsi_event))) {
        vq_err(vq, "Expecting virtio_scsi_event, got %zu bytes\n",
                vq->iov[out].iov_len);

If a guest submits a descriptor chain with only read-only descriptors,
vhost_get_vq_desc() sets in =3D 0. The out variable holds the count of
read-only descriptors, meaning the first writable descriptor expected by the
host would be at index out.

Does the length check above access vq->iov[out].iov_len without verifying
that in > 0?

If in is 0, vq->iov[out] was not populated by vhost_get_vq_desc() and
contains stale data from a previous request. Could a malicious guest use
this to force the kernel to write the event structure to a previously
legitimate but now hot-unplugged host virtual address via the
__copy_to_user() call later in the function?

>  		vhost_scsi_free_evt(vs, evt);
>  	}
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912090420.4743=
9-1-physicalmtea@gmail.com?part=3D1
