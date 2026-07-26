Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F1D30FC1F
	for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785068844; cv=pass; b=YlBSri+4k7wslz3ErGuf+jjrfoh1JHkdfjFIf/KWJ/pX5HOqrGb3HnR3K10bug8E70wN210xPDThWNMIA/ZTUrt4KZl6hHsWLlegdqzMRWMzDxguukZ/TS9ULIwGl7GdMkoOqWPT0LbFsBe1TlPpXqLUxpX7bgzHLSndRAv8z7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785068844; c=relaxed/simple;
	bh=mXkz0AgBpkq7qVI/SL08TnVaEhv5pAVhp1igDWKjQko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+DCNSssP6PXtzUcLExLljrwxQxGvZ0MNceu37N5B07tabX2IBltyRZG8rXgJFkEy9GjXxUDDOP7Sze4AHWdmqLiZTDx4VkdqYeuQ2BpCHtinJBrvS238qvqf35TB9pWiZWiYuULLTEjAX/vwOO384rn6gF8mRSoQa9zJxmwYAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOo6btjP; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOo6btjP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15dd4b9132so278694266b.1
        for <virtualization@lists.linux.dev>; Sun, 26 Jul 2026 05:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785068840; cv=none;
        d=google.com; s=arc-20260327;
        b=T512H/+yFTqrrRewQKbp/ZaobeV64XwRA+KLctvJACm9ZG3SFHTuK0r9sjyzWy2bcO
         Hw72WXpxU/9LPf/HHAPzIacnWIqrznGhO9o6uqnplgIXIL/Hw+nmRIysVi92cY2wmIv1
         XZIpc9hIDCyv7WT5TOzbw6cr57MJCMOeqqWH5Jh6uB+7FZmyayepCnhCZi+ruSotqTaj
         2TG0RoYWG/yZldPs7Y1OvgfiWy+vpLfGADEB0dKrHE4IvVG/4mrgfw9W3SwnEpLXyUhm
         jIN0x0PNsej5D2UpsDitpinhPoFDciy/Nk45LhRWTjwZKHzGVzxzuYlCUOr/b1Q+JNGA
         E7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wyil4C1cCxXCXkVj+zHgoBrvuhi4HPmJDngO8ZhDz0c=;
        fh=NUiwm1nE8WhND5M/Xjhs/jqanhZ9N5S5+uI5RHwy1TU=;
        b=O3yLodjFTVpZ352Vc7lapmBW50sU6YhCbeKnmxq8fSC0iiCCUTXkZdRa6hhnZbcgO4
         LJTn996j50Wi50Z/1EsLuUqHpmNnRUuEmCs9olvZk2pvxqMBktFcFAm30ecCJcfxiV2f
         Jm+c2S5cEwoEUGrk21hNFItfZ0ryesLdzbNy3jJ3aVdaibpdbuQeedAhgkG+NahqcqwU
         4vl6DrNQZgsFOnY+BfK5fX2duAgLGDAdSkic2GUemvUWR+/3v0I6/fswri9JqJ4KImBk
         MpUTwBiN8CMKAKotzqGXYN6ZICnfTia3YqPHETmXRxgsTZC5UW4rtFdFJ3PEK8IsOJ45
         j4FA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785068840; x=1785673640; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wyil4C1cCxXCXkVj+zHgoBrvuhi4HPmJDngO8ZhDz0c=;
        b=bOo6btjP5SO23ipCPpp0d43gKJxOq7SANjkfArgXMfWixdyPSpasl/lB+AHJGsC8uF
         Rp1VtqWFauu/cj8aL66MNApuYD4E8uDPJEeQikOJ8xZdFqtQLwexuOQFka87rS7QmjSe
         bSy77cRJzT9PSAIe8t/T29+Y24b27zDxaSELnhKOCX0DU6Qm+6dKsTlwtYChaCaF4pnc
         wcqQyPHNl3mJkatXzxNVNxoYrdlCuPydojg7S31evf7/UwgY+97OG3jm4dr3phX+3IhE
         I54SxfKiK26pZHaubktdg//PnmdLnJJ1zbicR/7Fm7Wnvi7HB3kVACdxGp9pow4Ou5Qx
         Nkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068840; x=1785673640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wyil4C1cCxXCXkVj+zHgoBrvuhi4HPmJDngO8ZhDz0c=;
        b=NXhI9JnLdDnMWLIg1PowZeZxwEZCXf1FbhKvnHCSOf6S11aSQBZYa6bH4k0fElTlM0
         ZEWPDOJEdvULa4TgeL9eYxXJRnNQU6z2VYsuhKYNd4A0xnFehzV1MdjRkJM0nk4oUalS
         RcJlcM3W9Rx2uC+QWHk23rsdQPEMeMMleSXKmiY8s/2NZ7WjK2c+VgCmWHxYWcU1/v1z
         MXA1/PMlqRHXHRBobgneho65/p/RCzNpKTVbRVvh1qrFI0nt8XXBb3B4S7VwjXPEV6aA
         hEDCQO1IAeZWXsGBVxyMAYxwkIcuCRngumHn+zaqOHr9DLWUXJ5g9K2lJGv4xF3X4taG
         S10w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1bNyRt5n96LFHbfRFogHG9lm/qBoYrOYnudbshKgPd5kMqKQZ5pN6kFUxWwZca3vXZjMKirOFgas/jwOzTQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyC7jOcfOZjRiO+aYMj9bZxs7Mz1SMWFIdy9cVMN6/nU3hVNVSK
	0g4JeFMIpB8NUzHlxKOUn2LQ+EoskeJBWmmqPHnZMzE8AJpO6SXDWYE1lfbNik29UcI7uf5myPO
	6XeK7lhSKWytAdRyQ8gYzWVqb9EAa3Wk=
X-Gm-Gg: AR+sD139aG/ReC/zd4VRto8neG5lVVyIU7/s2nMjO4oEXkVG9p66lmMjQdtVacP7jNK
	mSOatlxWPH/hteX37FjF8wV+WlyYwZu7j9Xr7KxWfBPMrMcR0mXsPC+3t0tMWU4jnOUGbzmIV3D
	bYG1NL1/cB7B82AabumzE3+iwsX/UnuMT6S4uunqWKJ+c8OdCluA04S/mxBoIb96nW0jOPAfKVz
	AavJIKc7FJD9W/nnINq5HxqLg+XW4SwCQG5mkmSvaJUD1J7dTonCbGPzqsP633Jd3YOjivtYtCY
	1nNz+xbmMYenauAcn/I=
X-Received: by 2002:a17:907:3e28:b0:c12:34ed:da11 with SMTP id
 a640c23a62f3a-c1f1f194d2dmr206577266b.61.1785068840219; Sun, 26 Jul 2026
 05:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJSP0QXMamS2rGRr4MtDM3ymtoH_DAD01NGkt4CjEJzZ6qbR5w@mail.gmail.com>
 <20260724034355.1568036-1-physicalmtea@gmail.com>
In-Reply-To: <20260724034355.1568036-1-physicalmtea@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 26 Jul 2026 08:27:08 -0400
X-Gm-Features: AUfX_mwboETJLV27B7ugbvskkWXv5NHGQep0lkDZbniR2yMW8JQe4s-Q7uSjxfI
Message-ID: <CAJSP0QVQVp0r5cbVEQ60Z0PntfOkap5GtWxPxWVRwcatTP6Hew@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: reject feature changes after endpoint
To: Jia Jia <physicalmtea@gmail.com>
Cc: mst@redhat.com, jasowangio@gmail.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:44=E2=80=AFPM Jia Jia <physicalmtea@gmail.com> w=
rote:
>
> vhost_scsi_setup_vq_cmds() runs from VHOST_SCSI_SET_ENDPOINT and allocate=
s
> each command's protection scatterlist array (prot_sgl) according to the
> acknowledged VIRTIO_SCSI_F_T10_PI bit.  The command pools are not rebuilt
> when VHOST_SET_FEATURES changes that bit later.
>
> Although virtio feature bits must not change after feature negotiation,
> vhost_scsi_set_features() currently accepts such a request after the
> endpoint is active and updates acked_features.  Enabling T10-PI after
> endpoint setup therefore leaves prot_sgl NULL while the I/O path follows
> the new feature bit.
>
> For a 129-page protection payload, vhost_scsi_mapal() passes the missing
> first chunk to sg_alloc_table_chained():
>
>   sg_alloc_table_chained(table, 129, first_chunk=3DNULL,
>                          nents_first_chunk=3Dinline_sg_cnt)
>
> sg_pool_index() then hits:
>
>   BUG_ON(nents > SG_CHUNK_SIZE);   /* 129 > 128 */
>
> The kernel reported the following call trace and register state:
>
>   Call Trace:
>    <TASK>
>    ? __sg_alloc_table+0x1d8/0x250
>    ? __pfx_vhost_run_work_list+0x10/0x10 [vhost]
>    sg_alloc_table_chained+0x59/0xf0
>    ? __pfx_sg_pool_alloc+0x10/0x10
>    ? vhost_scsi_calc_sgls.constprop.0+0x43/0x60 [vhost_scsi]
>    vhost_scsi_handle_vq+0xf02/0x1700 [vhost_scsi]
>    ? __pfx_vhost_scsi_handle_vq+0x10/0x10 [vhost_scsi]
>    vhost_scsi_handle_kick+0x37/0x50 [vhost_scsi]
>    vhost_run_work_list+0x8e/0xd0 [vhost]
>    vhost_task_fn+0xe1/0x210
>    ret_from_fork+0x348/0x540
>    </TASK>
>
>   RIP: 0010:0x4
>   CR2 =3D 0x4
>   RSP: 0018:ffffc90000dbf940 EFLAGS: 00010202
>   RAX: ffffffff82396810 RBX: ffff88811dc28b80 RCX: 0000000000000000
>   RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000081
>
> VHOST_F_LOG_ALL is a vhost-specific runtime feature and remains the only
> exception.
>
> Reject changes to any feature other than VHOST_F_LOG_ALL while the
> endpoint is active.  This preserves the existing runtime log toggle while
> preventing feature-dependent command resources and data-path state from
> becoming inconsistent.  Userspace must clear the endpoint before changing
> any other negotiated feature and set the endpoint up again afterward.
>
> Fixes: bf2d650391be ("vhost-scsi: Allocate T10 PI structs only when enabl=
ed")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
> Changes in v2:
> - Reject changes to every feature except VHOST_F_LOG_ALL after endpoint
>   setup, following review feedback.
> - Keep the existing runtime VHOST_F_LOG_ALL cleanup path.
>  drivers/vhost/scsi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index 9a1253b9d8c5..000000000000 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2219,6 +2219,7 @@ static int vhost_scsi_set_features(struct vhost_scs=
i *vs, u64 features)
>  {
>         struct vhost_virtqueue *vq;
>         bool is_log, was_log;
> +       u64 old_features;
>         int i;
>
>         if (features & ~VHOST_SCSI_FEATURES)
> @@ -2234,6 +2235,14 @@ static int vhost_scsi_set_features(struct vhost_sc=
si *vs, u64 features)
>         if (!vs->dev.nvqs)
>                 goto out;
>
> +       old_features =3D vs->vqs[0].vq.acked_features;
> +       if (vs->vs_tpg &&
> +           ((features ^ old_features) &
> +            ~(1ULL << VHOST_F_LOG_ALL))) {
> +               mutex_unlock(&vs->dev.mutex);
> +               return -EBUSY;
> +       }
> +

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
