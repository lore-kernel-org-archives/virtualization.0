Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567804;
	b=deiTBvZK9cGV0uiRzcJHZuJZe+SXexY/TO1+FOErBPm2Zdul4yITh8xz8Iid2hFbds+W
	 6IM6MxDJoWZ43br0204UWNZKiDW5IwmTjninoor5I1C1KSUA1pYuqZsfRazD19XLl9u1v
	 FOecryCq31g2rbhrFi45JF8B65agqx/bxiCdqoCi7pEYrZJNXW9y23b/QbrYomdrtiHLn
	 1EcGGvFe4NR13CgOCpqcaiEEZTjMbYrrfnjNDfDTe6d86ME6fDGq8YWC933t0Bw20iw6r
	 +dC30w6e/GSn+Z+/egMBaNyBmp/CjVYYY/wO0B7MUos4Bs2TqrZDLo8+4ZcJVeWzkzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567804;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=XpghATf4nPQK85rjnGUS0Cq04MzqPmQkyTDyyJ/P3auGixO0g/2AiorimcnRenP8I4wc
	 tkLmdy/aQRgilk3TtjGQErBlf5RQXknIbgXl2/ib5P0BQulOl7xLtIOWoUwozBR77g9bd
	 +o7CkVl7Z/596pjrtEFqq4j2lZVHh9RS3ju1s9S/n+zwNYOXvd74saInti3tdR1mlDXUe
	 F8q3tgPz2bUiqxJP77GCEyj30w6m3ylIBpp5QaA3mAwDEETtZCj2HRLCEKFiBFLrhBDK+
	 uYz/k25ZM77Jwn8Bb3fT1FpG8LOKokHlcq7arUUzjP1OgeIwGeA/9Q657XohXh+7pPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgBsnKYF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821D606A324
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2821D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WgBsnKYF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792567803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
	b=WgBsnKYFB7p+xHBWbFrJUTTHZfF5FpHRuxc0h1KCoem1NPD1mavCWLOmnFwpTmi7z1YIcx
	X29E4J+nGwH5mfFPs2UwbHZVh3COeqtSfAAB6jtdEn0veTTouBrS6UwiWU1c8Gi2bCUyzw
	jagauKiw6iV86KOfigA8QCP7wB87I9g=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-MPS2syX1PkesDbHOCS_LkQ-1; Wed, 21 Oct 2026 07:29:59 +0000
X-MC-Unique: MPS2syX1PkesDbHOCS_LkQ-1
X-Mimecast-MFC-AGG-ID: MPS2syX1PkesDbHOCS_LkQ_1792567799
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-869553205a7so7297157b3.1
        for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 00:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567799; x=1793172599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruNbPegljZ2HSbDe2VgJL7losQAaVxHulyE93NG9OdQ=;
        b=TCzgRhhXbX/OdkWKrmlK1mCxN08JIVKFVqrTUXhk+aU9qFhTD6mm0G3Y4Fk3PF3OsM
         gQC1kFSEkZUx18vH1p4NAJnbsApSKfyRWvnVl/5k9bJPY3MktGdheV7C8RLQKiGF1/PL
         SGEGgbltAiG1aHXEFFoa9oiwCZNc/18Ok0SYvso3XQs0PeqdFbG0GtRtjaaXjPbqQpfb
         o7jMOWWbUvfxNbNHgCmJtLM5hd+Q7UIYsYf2pFHUvDs545dczVBtddmI1GCvaKvbleSt
         +Rxq/ScLGVawzw4jiOHinX0SLcG+4Cxxi8PU4Ew2A1CJZKxxhBl2yg6vunFZi1dChNZS
         w/9w==
X-Forwarded-Encrypted: i=1; AKwUvByoB0isRET7W/Xyj/ggNor8rl1v3KTIT/M3UMYgfpozAIbgkEeoI7Cnkj9JkAUPv7/WYeIaQs1h6NX9xa6fxQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIQ9nQZPFawtAnCYIrkeCEHGAr9QeEVX7jlh761gtLzLwRg49+1
	gEagAXCqxlZp2L2hWPYcdvU0qXQ7eW33IXvR3+LK7W8COG+z0x2YJX3orPKNKTEbBMTwMB5OUCb
	gVcRIUz5EHclxK7/l4sS7yXUHG4HDhFa6nuAfcYcmV8bbggAsLsyKaZagojXheJqFIGMtiyrSsT
	H9/JyK8xsKnTcok/zkOl0Sl1e9nkhMtfqQ9MnXxryY29E=
X-Gm-Gg: AYBFou2zJ9ebVdftoaKuPhqBzV4f2HZDKBtcs141Un955aWGXxA+J0bdp18MBguD5k8
	bKKDex37rWdwDpX6acWXf9n9kR5xA+/foRjsMrci2S9w0IzJtYF0WKx5oyPdqyoFUW4wzchhFGW
	p1oO6RMY+VY2hDMWXE8C25UB6MpmRBHIkmS8OD49ReZ5H8K9G6XvMgkzmcK4TLDVG8RaIgKnrb7
	JYFqxQnHkyjypyVyE2WUlFYUJL1mvL4yZUOwipl2/CgBQSY6ZFzGmlO4JI=
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id 00721157ae682-8b133fff1d6mr5006457b3.31.1792567798950;
        Wed, 21 Oct 2026 00:29:58 -0700 (PDT)
X-Received: by 2002:a05:690c:a909:10b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b133fff1d6mr5006297b3.31.1792567798485; Wed, 21 Oct 2026
 00:29:58 -0700 (PDT)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261020232956.99970-1-fangxy@xiaopeng.com>
In-Reply-To: <20261020232956.99970-1-fangxy@xiaopeng.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 21 Oct 2026 09:29:21 +0200
X-Gm-Features: AclHuK-PqFWCN8ST8zFxglfpmVJtYh8ceAExLMaLATIvJ8UfZfghlr_8jg8ahUM
Message-ID: <CAJaqyWdoQXHiWEh6aCGt7T+U4U4S8Z79hhp5=QYzzkODeDVyOw@mail.gmail.com>
Subject: Re: [PATCH] vhost: fix used ring index wrap in vhost_add_used_n_in_order
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@redhat.com>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Weibin Liu <liuwb@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQE8s3ZSunoYYXkUYwGRrRCKdso8_cDbEXm7bCaz-Lw_1792567799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:30=E2=80=AFAM Fang Xieyan <fangxy@xiaopeng.com> w=
rote:
>
> vhost_add_used_n_in_order() advances start by nheads[i] but wraps it
> with a single subtraction.  If start + nheads[i] >=3D 2 * vq->num, start
> can remain outside the ring.
>
> With used-ring logging enabled, start > vq->num makes (vq->num - start)
> underflow.  log_write() then sets bits beyond the dirty-log bitmap,
> potentially corrupting adjacent userspace memory.  This is reachable on
> the vhost-net TX path with VIRTIO_F_IN_ORDER: done_idx can reach
> VHOST_NET_BATCH (64), triggering the issue with a 32-entry ring.
>
> Wrap start with a mask to keep it within the ring.  VHOST_SET_VRING_NUM
> enforces a nonzero power-of-two ring size, allowing start to be wrapped
> using & (vq->num - 1).
>
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
> ---
> Reproducer (verified on a kernel containing commit 67a873df0c41 with a
> temporary WARN_ON_ONCE probe in log_used(); the probe is not part of
> this patch):
>
> With VIRTIO_F_IN_ORDER, num=3D32, and used-ring dirty logging enabled, th=
e
> TX batch reaches done_idx=3D64.

Can you send the reproducer? I'm very curious about how vhost_net
reaches to done_idx=3D64. It seems some bound needs to be added there
too, isn't it?

The patch itself looks good to me, even if we will need to modify it
for packed vqs, so

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

>  In the observed run, the initial index is
> 3, so the single subtraction leaves start=3D35.  The resulting length
> calculation wraps to 34359738344 bytes, as confirmed by the log_used()
> probe.
>
> A 64-byte canary immediately after the 512-byte log bitmap changes from
> 0xA5 to 0xFF, confirming the out-of-bounds write.  The used-ring canary
> remains intact because vhost_put_used() runs before start is advanced;
> the demonstrated corruption is in the dirty-log bitmap.
>
>  drivers/vhost/vhost.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2..0226c4c59709 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -3172,8 +3172,7 @@ static int vhost_add_used_n_in_order(struct vhost_v=
irtqueue *vq,
>                 }
>                 start +=3D nheads[i];
>                 new +=3D nheads[i];
> -               if (start >=3D vq->num)
> -                       start -=3D vq->num;
> +               start &=3D vq->num - 1;
>         }
>
>         if (unlikely(vq->log_used)) {
> --
> 2.50.1
>

