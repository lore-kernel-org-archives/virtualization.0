Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C0420479
	for <virtualization@lists.linux.dev>; Sun,  4 Oct 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115714; cv=none; b=rZEQYIIzlILJIQHKVRQqh1/fTMt5Jo/dXf4uqDCB2d2Kw5nheq3BXslk/ihkVxwo9dWzXg85ISYNHmvIXMs8yBbE8wUPNSR8MX0/b1GfmRv91qUKa1XAbDdxIi0LbgO/iCLgFJ0LTZO5wv1qxz0nxJqsTmSUo0qcxa8ijitJIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115714; c=relaxed/simple;
	bh=Z+bctg00y8LneUvMPkwx8FjNx/0aMs1JNz7C2dkqMUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lzRCxXZBvQUGt4rK1cv+zJcCRvOYtdqyVt0tDt8f7f/mPSqw28MNw+5TH2jnTOvc3zyr5UP0BH51MDxF9sQJKmZ0HCesob/hJGMTmQWah+pvg33RsYWh+yVr4oBE2XZkR7epYuR6EOTDFAdDsqHJROZZ+xCM+M/flTXLnzRoM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrgwnLF9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrgwnLF9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082DA1F000FF;
	Sun,  4 Oct 2026 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791115712;
	bh=K52WOCbSKPBsn2u1SmVDIBzv6RIWIUJPQBMTkVWiU4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrgwnLF9hn6F6kGIwI1cUduhYj/S1bKt3ZgB57EbdF0SdklrvWDcZyodSxoeJE9JS
	 tsPfLSw2uUTTM1gpyeYj6natz5YtNRD7HoO5q7z60RDdxZ5VRc7iE6xDjeJajU8aiQ
	 iuhP7Fnycg/7AROrBAOa2z2bjC5Sdo9VRHZo7HHyEw/UVFmmhrJgSkRZaFZdQQqVFk
	 47kyakHxEc0xoNJPxtfi0cB7a59WqfA2ylc2upqOs7l+BJ0Jw52UN/RkGigjfRXziS
	 leNgv48uU3GnjxTxThFRsYiI5mfvuoW7d+WnYQ0CDUhcxUsIJqoS0sztKfvZVhhVMc
	 2U08LFpCYmAmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] iommu/virtio: publish the endpoint before replaying
 it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anlai Lu" <agicy@qq.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <tencent_29D6A4329FFB6193FA18EF43C64A5057AA05@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
 <tencent_29D6A4329FFB6193FA18EF43C64A5057AA05@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 12:08:31 +0000
Message-Id: <20261004120832.082DA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/virtio: reverted domain lacks mappings on failed attach
--

commit 2adc3f48a11c16ff36ed27a26a044ebb6cd0e06f
Author: Anlai Lu <agicy@qq.com>

iommu/virtio: publish the endpoint before replaying it

The device drops a domain's mappings together with its last endpoint, so
the first endpoint attaching to a domain has to replay them. This commit
publishes the endpoint first, with the decision moved into
viommu_add_mapping() under mappings_lock so that it cannot race the insert,
and lets the replay pick up the rest.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
[ ... ]
> @@ -730,6 +787,96 @@ static struct iommu_domain *viommu_domain_alloc_iden=
tity(struct device *dev)
[ ... ]
> +/*
> + * Give the endpoint back to a domain a failed ATTACH had retired it fro=
m: the
> + * device never took the endpoint, so the count has to keep matching wha=
t it
> + * holds.  If retiring it had dropped the last endpoint, a replay is pen=
ding
> + * again - the device is not known to hold the domain's mappings, so a l=
ater
> + * attach replays instead of assuming they are there.
> + */
> +static void viommu_restore_endpoint(struct viommu_domain *vdomain)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vdomain->mappings_lock, flags);
> +	if (!vdomain->nr_endpoints)
> +		vdomain->replay_pending =3D true;
> +	vdomain->nr_endpoints++;

[Severity: High]
This function marks the domain as needing a replay for future endpoint
attaches by setting replay_pending to true.

Does this ignore the immediate need to restore mappings for the current
reverted endpoint?

[ ... ]
> @@ -762,20 +916,57 @@ static int viommu_attach_dev(struct iommu_domain *d=
omain, struct device *dev,
[ ... ]
> +			/*
> +			 * The ATTACH reached the device, so the endpoint has
> +			 * moved to the new domain even though its mappings did
> +			 * not all make it.  Report the failure and ask the
> +			 * device to take the endpoint back to the old domain,
> +			 * where the core believes it still is.  If it refuses,
> +			 * or there was no old domain, leave the endpoint where
> +			 * it is and record no domain for it: a domain the core
> +			 * does not keep for this endpoint must not be counted,
> +			 * and the endpoint is not left unattached either (a
> +			 * device that enables bypass would pass it through).
> +			 */
> +			if (old_vdomain &&
> +			    !viommu_revert_attach(vdev, old_vdomain))
> +				/* the old domain lost its mappings with it */
> +				viommu_restore_endpoint(old_vdomain);
> +			else
> +				vdev->vdomain =3D NULL;
> +			viommu_put_endpoint(vdomain);
>  			return ret;
> +		}
> +		viommu_replayed(vdomain);
>  	}

[Severity: High]
If viommu_replay_mappings() fails during viommu_attach_dev(), the endpoint =
is
reverted to its old domain on the hardware.=20

Since the old domain's mappings were dropped by the device when the endpoint
initially moved, does the reverted domain now lack all mappings on the
physical device?

The driver calls viommu_restore_endpoint() which sets replay_pending to tru=
e,
but does not actually issue a replay for the restored endpoint.=20

Could this cause all subsequent DMA from this device to fault silently, as
the OS assumes the old domain is still fully intact? This sequence appears
triggerable when device attachment fails due to memory pressure or
device-side rejection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_85AC6E749F6=
A912B7BB9FF360F8ECB3F5C09@qq.com?part=3D1
