Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571182FFF88
	for <virtualization@lists.linux.dev>; Sun, 22 Mar 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774172604; cv=none; b=eUtDAMNeB73vpJOlUZoAJeuX7VFP/hKci++OZz+aZKNOVBxUwxzI+wb9qDtH3k2cmqw9KnxMsInnTDpMRNVLLYkQdU/FeW11KvV9h1NUqqqF4gxCS1X4ZMHsePCxUTU12xdIK9tpRJVKBdILSUE17tIBbhQWefuQ++WMbuWK6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774172604; c=relaxed/simple;
	bh=rgztf57Wkf3uNQrwjvwiUV1pJekdLenxeGJV/P9W4g0=;
	h=Date:Mime-Version:In-Reply-To:References:Message-Id:To:Cc:Subject:
	 From:Content-Type; b=hMGTyXa292cbIcQFXS6/8r14f20tD4rLsbqfurFZF4+JvmMLKCirxHLBx2VSvMHzATxbmnq87Mc15wrtyDLZ1LGo1d3SIU1M0/h2qpwA5h3wDKvm7LmVRpbH3NWi86bzg39ZqyxWbvZ1o0BvgCILSt6Z1xnEfjHZOr82FRQ7eog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc; spf=pass smtp.mailfrom=yunyoo.cc; dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b=D6PGJe4g; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunyoo.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunyoo.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunyoo-cc.20200929.dkim.larksuite.com header.i=@yunyoo-cc.20200929.dkim.larksuite.com header.b="D6PGJe4g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=yunyoo-cc.20200929.dkim.larksuite.com; t=1774172591;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rgztf57Wkf3uNQrwjvwiUV1pJekdLenxeGJV/P9W4g0=;
 b=D6PGJe4g/tUMFxxd/SMZc55KcRjPK9B12GGGjRxfNqaw8NsIOXsMYHZT4GHPTvlTwNrUyH
 qq1V3/vbXAizEGtVnWn9xQoXUl1uo/E07ut1VCp4EzG423vv/xT7Zq/xuDgEH45Dc8yPZY
 oCxC15bY6z+j9ErG/Hlk8nayppFOlMH8yHFHOupl9VjH2A269jONDdZvfuABNnIEHSSXAE
 QfcqVo+8kBMATtEpcD8HDC+mFb/xpna+QI7fFumGlS9OnkbA8ATw3L5m/130IqGb9z+x7Q
 JXTrwbXhEzrCfxSssu0c2lURNP/p+9lgY8kBx58Yt985QvW9NTi7+Up7cakHOA==
Date: Sun, 22 Mar 2026 09:43:10 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
In-Reply-To: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
References: <559b04ae6ce52973c535dc47e461638b7f4c3d63.1772441455.git.mst@redhat.com>
X-Lms-Return-Path: <lba+169bfb9ae+af835a+lists.linux.dev+shuangyu@yunyoo.cc>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.66fca736.e866.40b1.89bb.b04390067263@larksuite.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, 
	"Stefano Garzarella" <sgarzare@redhat.com>, 
	"Stefan Hajnoczi" <stefanha@redhat.com>, 
	"Jason Wang" <jasowang@redhat.com>, 
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>, 
	<netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty ring
From: "ShuangYu" <shuangyu@yunyoo.cc>
Content-Type: text/plain; charset=UTF-8


> From: "Michael S. Tsirkin"<mst@redhat.com>
> Date:=C2=A0 Mon, Mar 2, 2026, 16:52
> Subject:=C2=A0 [PATCH RFC] vhost: fix vhost_get_avail_idx for a non empty=
 ring
> To: <linux-kernel@vger.kernel.org>
> Cc: "ShuangYu"<shuangyu@yunyoo.cc>, "Stefano Garzarella"<sgarzare@redhat.=
com>, "Stefan Hajnoczi"<stefanha@redhat.com>, "Jason Wang"<jasowang@redhat.=
com>, "Eugenio P=C3=A9rez"<eperezma@redhat.com>, <kvm@vger.kernel.org>, <vi=
rtualization@lists.linux.dev>, <netdev@vger.kernel.org>
> vhost_get_avail_idx is supposed to report whether it has updated
> vq->avail_idx. Instead, it returns whether all entries have been
> consumed, which is usually the same. But not always - in
> drivers/vhost/net.c and when mergeable buffers have been enabled, the
> driver checks whether the combined entries are big enough to store an
> incoming packet. If not, the driver re-enables notifications with
> available entries still in the ring. The incorrect return value from
> vhost_get_avail_idx propagates through vhost_enable_notify and causes
> the host to livelock if the guest is not making progress, as vhost will
> immediately disable notifications and retry using the available entries.
>=C2=A0
> The obvious fix is to make vhost_get_avail_idx do what the comment
> says it does and report whether new entries have been added.
>=C2=A0
> Reported-by: ShuangYu <shuangyu@yunyoo.cc>
> Fixes: d3bb267bbdcb ("vhost: cache avail index in vhost_enable_notify()")
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>=C2=A0
> Lightly tested, posting early to simplify testing for the reporter.
>=C2=A0
> =C2=A0drivers/vhost/vhost.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=C2=A0
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2f2c45d20883..db329a6f6145 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *=
d)
> =C2=A0static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__virtio16 idx;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 avail_idx;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int r;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D vhost_get_avail(vq, idx, &vq->ava=
il->idx);
> @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhos=
t_virtqueue *vq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check it isn't doing very strange th=
ing with available indexes */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0vq->avail_idx =3D vhost16_to_cpu(vq, idx);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely((u16)(vq->avail_idx - vq->last_=
avail_idx) > vq->num)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0avail_idx =3D vhost16_to_cpu(vq, idx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely((u16)(avail_idx - vq->last_avai=
l_idx) > vq->num)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vq_err(vq, =
"Invalid available index change from %u to %u",
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vq->last_avail_idx, vq->avail_idx);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 vq->last_avail_idx, avail_idx);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We're done if there is nothing new *=
/
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vq->avail_idx =3D=3D vq->last_avail_idx)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (avail_idx =3D=3D vq->avail_idx)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0vq->avail_idx =3D avail_idx;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * We updated vq->avail_idx so we need =
a memory barrier between
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the index read above and the caller =
reading avail ring entries.
> --=C2=A0
> MST
>=C2=A0

Hi,

Sorry for the delay, it took me some time to build a reliable test environm=
ent.=C2=A0

I've verified the patch on 6.18.10. With 16 concurrent TCP flows over
virtio-net (TSO enabled, vCPU throttled to 1%, 300s duration):

=C2=A0 Before patch (bpftrace + CPU monitor):
=C2=A0=C2=A0=C2=A0 - vhost_discard_vq_desc: up to 3,716,272/3s
=C2=A0=C2=A0=C2=A0 - vhost_enable_notify false positives: up to 3,716,278/3=
s
=C2=A0=C2=A0 =C2=A0=C2=A0 (nearly 1:1 with discard =E2=80=94 every partial =
alloc triggers re-loop)
=C2=A0=C2=A0=C2=A0 - vhost worker CPU: 0~99%, frequently 50-99%
=C2=A0=C2=A0=C2=A0 - successful receives: as low as 137/3s

=C2=A0 After patch:
=C2=A0=C2=A0=C2=A0 - vhost_discard_vq_desc: 9~33/3s
=C2=A0=C2=A0=C2=A0 - vhost_enable_notify false positives: 0 (all 100 sample=
 windows)
=C2=A0=C2=A0=C2=A0 - vhost worker CPU: 0% (all 149 sample points)
=C2=A0=C2=A0=C2=A0 - successful receives: 873~2,667/3s

The partial allocations still occur under load, but after the fix
vhost_get_avail_idx correctly returns 0, so the worker sleeps
instead of spinning. Thanks.

Tested-by: ShuangYu <shuangyu@yunyoo.cc>

Best regards,
ShuangYu
