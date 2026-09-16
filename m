Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F9044C662
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546738; cv=none; b=bKkD7bPxK9vPMTjqmDc1WhjUwrHZ3vYD5kOfD/MCcrBeydRz621m9Z/lirK8IAX1fRG+HWAQ3w08HwIAwVprx+jKO5YPf3naGAB9sPx898pHd9v9jAHBVAtpXe1SQPib7RyYp/WMQMF9jjTlkkX6yCSU1RyiGLq/Tj/QlTpk4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546738; c=relaxed/simple;
	bh=YqNgkMJsDR8dxQthE8qTdTAI1jWpt8pQzbwYa+L8wXE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiqO7GXNAE75AMygHM0TJh2wCKVjLpOxSZXd4GTGJfCaJtFFkAqK39qdRM5pXNu/8CXmS4nFNpaNKlENEkFa/T+2IX1LBJn8SZrZQaXPIIFA5pcKVl/41T+1HNwOyE/aAeNLNOieJU+JsMvvfGVGGjdYUaceMwA7I5YXofeVG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMQ3U0Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMQ3U0Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223451F000FF;
	Wed, 16 Sep 2026 08:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546732;
	bh=YfjH2pO37xZeCQWPRV24yBXGGb8Fx28ToVG+YqDAB64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMQ3U0Wzm2FEypZKOoXGnXsLz0lB20ulnr8JN+dbxQ32DptdqiWZvAqZil3FvCiFj
	 Zh5LvJBQbnH9nFhtZHi1afZrOLdyHuNvU9re3trxekAb0QL0YEKYbSxKxZDWmwmeT4
	 /JLHrBfR0g5ec2LHNFqNN+gIBVzDEQI63FJvNEegyQpzLU6UyYOtqcXae4suiLtU3i
	 C3Eyo2zPjXmsJAXCaxVJtYFKvCWnXvp5L84lwqBsFVdp1bzrtKR1H4gt1YNlsmpbVY
	 HyqyAadDx9xjmOo0Z/hv6V6Y0YUoeK32s3NUvdOb58RPCwIvPVULqJZHHltsnxCzjd
	 EkV//WqQDdMKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-scsi: initialize command pools for late I/O
 virtqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260916-fix-warning-in-sbitmap_get-v2-1-e61a09047089@gmail.com>
References: <20260916-fix-warning-in-sbitmap_get-v2-1-e61a09047089@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:18:51 +0000
Message-Id: <20260916081852.223451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vhost-scsi: double fetch of vq_index in SET_VRING_ADDR
--

commit 9fca211b81e6c842310a6804151d7dcf766af409
Author: Linfeng Sun <linfeng.sun.dev@gmail.com>

vhost-scsi: initialize command pools for late I/O virtqueues

This commit delays the allocation of command pools for skipped I/O
virtqueues during VHOST_SCSI_SET_ENDPOINT. When VHOST_SET_VRING_ADDR
subsequently completes their setup, it allocates the pools and activates
only the newly configured queue.

Link: https://patch.msgid.link/20260908-fix-warning-in-sbitmap_get-v1-1-767=
c2c211a2b@gmail.com

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 4f8c0260bc9e7..efca343626664 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c

[ ... ]

> @@ -2464,12 +2503,19 @@ vhost_scsi_ioctl(struct file *f,
>  		mutex_unlock(&vs->dev.mutex);
>  		return r;
>  	default:
> +		if (ioctl =3D=3D VHOST_SET_VRING_ADDR &&
> +		    get_user(vq_index, (u32 __user *)argp))
> +			return -EFAULT;
> +
>  		mutex_lock(&vs->dev.mutex);
>  		r =3D vhost_dev_ioctl(&vs->dev, ioctl, argp);
> -		if (r =3D=3D -ENOIOCTLCMD)
> +		if (r =3D=3D -ENOIOCTLCMD) {
>  			r =3D vhost_vring_ioctl(&vs->dev, ioctl, argp);
> -		else
> +			if (!r && ioctl =3D=3D VHOST_SET_VRING_ADDR)
> +				r =3D vhost_scsi_activate_vq(vs, vq_index);

[Severity: Medium]
Could this introduce a double fetch vulnerability?

The index is fetched first here in vhost_scsi_ioctl():
    get_user(vq_index, (u32 __user *)argp)

And then later in the call chain it fetches the index again from the
same user pointer:

vhost_vring_ioctl() -> vhost_get_vq_from_user():
    get_user(idx, idxp);

If a malicious userspace thread (such as a VMM) modifies the index in the
payload between these two fetches, could it decouple virtqueue configuration
from activation? This might lead to state confusion where one virtqueue gets
its addresses configured by vhost_vring_set_num_addr(), while a completely
different virtqueue index (vq_index from the first fetch) is unexpectedly
activated by vhost_scsi_activate_vq().

While array_index_nospec() in vhost_scsi_activate_vq() prevents out-of-boun=
ds
accesses, could activating a queue that wasn't actually targeted for address
configuration lead to unintended behavior?

> +		} else {
>  			vhost_scsi_flush(vs);
> +		}
>  		mutex_unlock(&vs->dev.mutex);
>  		return r;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-fix-warnin=
g-in-sbitmap_get-v2-1-e61a09047089@gmail.com?part=3D1
