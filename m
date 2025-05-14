Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5FF1E5B68
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202912; cv=none; b=Qalz6g+PkNr8X2SN/kd/4X8CvxH+ypoBCTcnJlvZPtExeV49EbYiKf1MBXevaqY+4e/UPCQWxT9vk3g12FBx1gF2iUlbrchuk/1C+WZTrJiQE0LQjzUdnMOyUzqFEupXk2nb5tDaSapkr0R8DrYRcPddF/zya8XbXFt/LW4CD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202912; c=relaxed/simple;
	bh=clqW7NWTFiJ7YoR3lDVtuE7JolyoGieukxj9gWfyBjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLKdSDm8CEnfVL9mbzsYB140V0PTyPRTWnza+lxXAHkBDsTyWU4O59RT2oNH9AKTIlDsNMpRntocfeXETE2CBtLzzWpQzl84RqoImx79zNAMlSRJYM8Ae2Zlel7/sr6RZqMVLG7SFbprb3qWvEikZwHEc48lWE8kdPMjlEX5cqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hz2pfLdP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hz2pfLdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747202908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTiJAnWJjUYIhLrqKEbp6nIdZ7MIc80RxWcquMrGcF4=;
	b=Hz2pfLdP/rROvTSi9uoyWKxpMAGl7WUfEsxY8j22iPKzXaUPEMjt50MEDKdR29ihtGe7K/
	3ImSs8rRNjX0cRkm7MV1yGC9+luYsSbObacxBYyl1UK/Mlop56yrvOzjOEhAwXEqHLjXY7
	ALjRKjHWYMCoeqAy2Hj15fMxKdf6WZw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-JHGDAKLmO7O1A-tGmYX_hw-1; Wed, 14 May 2025 02:08:25 -0400
X-MC-Unique: JHGDAKLmO7O1A-tGmYX_hw-1
X-Mimecast-MFC-AGG-ID: JHGDAKLmO7O1A-tGmYX_hw_1747202905
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b269789425bso3680293a12.0
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 23:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747202904; x=1747807704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTiJAnWJjUYIhLrqKEbp6nIdZ7MIc80RxWcquMrGcF4=;
        b=wbvaCoi5fOa4ikMsooPOcTES6usAqp0IF5x3YueTZVIM7LD6DC+oRGXWWNE3mCvByi
         TkQ4lDdj/yUSrBov5lJdK3FScFQA9NyQXCAlWWaLS34AIDcbGg/95nr28RQDZGYS4FAa
         fUlHMxpJ9RA62IBpoWGO3Djl5LbzLM4+mLEYq/bHXt/UFSkgC4nQzZnLbdopiDmIb6Jm
         HgAJe+t4LMAToDQ3QjDLASv1YdwDWpA00CLeH+Wd/GgB3QCkbW487VHIJScRQ6URoZ+Z
         9MA+yg94GpM8ctMsiqgodLMLCq0Tn+K1rbjd6zrqIbhG+rznnWtif3yklCXFXKUKwDjN
         jEkw==
X-Forwarded-Encrypted: i=1; AJvYcCUAe+AgZRMPAdN4aRUwwMpDgxfuA3rx+tNvQInFlyOy8/dOR9rkkRnRACSgDDMzvqHYy+xsyonrQflZrS9Hhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYxNXmesdTT2Mxthv1iJ959b16JKfqBL5yLGQW0O73gNl/3IG7
	X4qUP5i6/O4WnUg4HKFCY8IOaDWvLzu4vODqnekO1nZ3yBuxOTRog4ExmJkQJJx5lEdzQKTXXLi
	wg0hJBoPYMLr3dxweT6V8zf1uipOeuUlpJzLwlC7IlwL+pqSan98qdF0rlSaPV2hY1tbJfaL4Gx
	S668RTIZyPWxsHrFMArvpSOqppSti6rew2zhq9YLM=
X-Gm-Gg: ASbGncttzm4Yy9vjReKyDcuFLwbfhOqy/pCVNGAxF+m37ITxA3bVv+jdTLs/hCkJIa9
	LaqL01aj2EvWWd0n1HxFKcVdcDH0G2reshudDDfBoSItWUuXFNVthPixqoyePBmEkpBbl
X-Received: by 2002:a17:90a:e188:b0:301:1c11:aa74 with SMTP id 98e67ed59e1d1-30e2e623b1cmr3638563a91.28.1747202904471;
        Tue, 13 May 2025 23:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhn6kqdMgQ6s4WnRHem1sYVRVuHeAiWgE6nRiMRHJ5QkKKuABSWLiPE/twiXG+1HU+576sx0nKCmDWB9E2sN4=
X-Received: by 2002:a17:90a:e188:b0:301:1c11:aa74 with SMTP id
 98e67ed59e1d1-30e2e623b1cmr3638535a91.28.1747202904089; Tue, 13 May 2025
 23:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250511222153.2332-1-sami.md.ko@gmail.com>
In-Reply-To: <20250511222153.2332-1-sami.md.ko@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 May 2025 14:08:12 +0800
X-Gm-Features: AX0GCFtz_D_3mYpYzBUGBYhubV1vNLsSLsRetmERaz5Lx-ANh9YkQtT84sru_W8
Message-ID: <CACGkMEvw7GB1UtZtNjw4TVD1nzr2JCgdsjFK7tiGC46CLV8hPw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio: reject shm region if length is zero
To: Sami Uddin <sami.md.ko@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: njh6PHGohJBfZEKgLnt3L2wkFRYpa-KFqR6ZWTwSVr0_1747202905
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:22=E2=80=AFAM Sami Uddin <sami.md.ko@gmail.com> w=
rote:
>
> From: Sami Uddin <sami.md.ko@gmail.com>
>
> Prevent usage of shared memory regions where the length is zero,
> as such configurations are not valid and may lead to unexpected behavior.
>
> Signed-off-by: Sami Uddin <sami.md.ko@gmail.com>
> ---
> v3:
> - Use idiomatic 'if (!region->len)' as suggested by reviewer
> v2:
> - Fixed coding style issue: added space after 'if' statement
>
>  include/linux/virtio_config.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index 169c7d367fac..b3e1d30c765b 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -329,6 +329,8 @@ static inline
>  bool virtio_get_shm_region(struct virtio_device *vdev,
>                            struct virtio_shm_region *region, u8 id)
>  {
> +       if (!region->len)
> +               return false;
>         if (!vdev->config->get_shm_region)
>                 return false;
>         return vdev->config->get_shm_region(vdev, region, id);
> --
> 2.34.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

