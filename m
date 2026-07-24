Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2491369D60
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886717; cv=none; b=tCiac3BNPKQ70mt6d/uYiG8NsONxFfob1NTA9C92q2oibOdXIyUTuNg/sW1wOnjBH01RvX/mi/7bPcHBZUlnLDB2GC3I+8DDwXgYDWaj6GrpYZ8lTZMD0Nv7ATpkB/liO16E2GEZSobQ8Hxj2ddZERPnQdVL3WH3Ipc00C/IcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886717; c=relaxed/simple;
	bh=71q/0rYXFPSpeplIhq5Slk0GTs/WCHAUdOMUpC8hLg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WHuhjQEWqX/t9K6QorZvTt/08YBYMLX54cC57/fJeZ6FRIO0UATu/JOBwEfDw5KmWG7A+2vec7n8lPVXpJXgVoK+I6QY0InrjfOFpZqSIVAni0/8M7qHm/VXpjcfpjLoiqT0G0vaHEhx/jkQga9kF61oQ1+ZqDJ36GCisZ5xyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pqc23Kxv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pqc23Kxv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784886714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xJccMLa4FmRiVUO+x8NEGZ9FoH9xLMn2hB1XoGoPlM=;
	b=Pqc23Kxv6qcxHdGejUQJIwUDZkIvKmZS6CWWwOCNya9Q6Ix4fm4BAhr4e01KlJqxNaRG8O
	cl5iSZnUrGckKGTtaLesRsPGjwXzmRh+qPwrQ6kQoJzPryxWK1qHlVHm7x1qa67r7iXF82
	MVDaez6qd0jJ5NJOfT5W5PdeNIp/P18=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-pbSp6ac6PmiZUgHs2K9rOA-1; Fri, 24 Jul 2026 05:51:51 -0400
X-MC-Unique: pbSp6ac6PmiZUgHs2K9rOA-1
X-Mimecast-MFC-AGG-ID: pbSp6ac6PmiZUgHs2K9rOA_1784886710
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954a93c565so1460395e9.2
        for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 02:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784886710; x=1785491510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8xJccMLa4FmRiVUO+x8NEGZ9FoH9xLMn2hB1XoGoPlM=;
        b=HZPhLDSLvlF0BAdOnOaBczvvUsROFJiqUAyq0NkZ/1Th86n9peRH2mbKAetlp5wXxd
         cBgC0Neh7puGBp8OAuTGAnHPfW/7d09HskgtVI8ZIyIk8xGqiqV4u3uCQ7HM04Cnx2mQ
         grp0N8I/BWiNZV2nkfQ2h/KAJHoQLuV3Abdzno6CzLVBJ8/ZBAXSUO8jW+4cQftmAMNb
         no56R5IRwTtmW7rGssiC5R1E3DCM2o0g++qN7TtnV8JPSYYUqangq+4EJCzgm9lUIkEA
         0iWFJDkxNCSrAu2odxnQ5srgavxhhzWYpuxCq6zO0u1J3rSSrhnsnofdS6NvJqztLQVx
         ghPw==
X-Forwarded-Encrypted: i=1; AHgh+RoEdbYqXQ+hxbHoHPGmIH+kA/2Mg2FmvQyu3Se3gt00TizZdWygFsuLr5SuFnuz7/J9HnzXjipVfs2qGGUNCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFMAdY1KCgjBCZONT3tKcYa4EjoiGrzzwW7X2vYtbfIUsEncxJ
	F2XexBC1fGzxrJ/rImz3hZ8NTkvFacknetjKBIWQobu691fLWu6egcZ6WxAtW7yvRIXnupHBK+o
	wBMLwxiDvocBV/9tKt8FGaa8iBNhm4o/6Dm0ZCi0tvBEvC26pSVgZ/AJr+KIzc385SXqS
X-Gm-Gg: AR+sD10UK7tVUURwVgWMlczlUsQ1nMO9VDiHiHy+7jTgA09w3NG3Ny++3XOUmobWVyK
	4mxxK0W3bAZPpasu4VxAzd8EXzW6827n2vQh356KYzxiK4VlqwFLa2vLlDM0INjPS+pAPA80wAX
	z/Ub+57u2zMF5YMo1FNR+2UmgQE6vbELrLuqRx4VV9iby2SV/xEO5L3Pp26h4mnK16Ae4JRGyR8
	VCLGZp+1c+g/HOJc7xlNubP0m9AVzzVq8B19nLfcQ4F3ZIrKh7GPADxsD7Tkrk/+Row+GmEOhW1
	oC6KxzIi54lBA9OIfFK7W/wQltY/m9a3KdT9wcdQZTZTg7AFCfkEfDWqjIknM/Mn0PL8DRCTM4Z
	8iu6xtqQ7Nml1beXRSrhqRw==
X-Received: by 2002:a05:600c:4ed3:b0:495:7040:c7e9 with SMTP id 5b1f17b1804b1-49573cc2f21mr74763875e9.6.1784886710068;
        Fri, 24 Jul 2026 02:51:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed3:b0:495:7040:c7e9 with SMTP id 5b1f17b1804b1-49573cc2f21mr74763525e9.6.1784886709545;
        Fri, 24 Jul 2026 02:51:49 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f9b8b67sm19819915e9.4.2026.07.24.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:51:49 -0700 (PDT)
Date: Fri, 24 Jul 2026 05:51:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Weimin Xiong <xiongwm2026@163.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com,
	virtualization@lists.linux.dev,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH 3/3] hw/virtio: Add error handling for
 vhost_virtqueue_mask failure
Message-ID: <20260724054836-mutt-send-email-mst@kernel.org>
References: <20260724093759.810108-1-xiongwm2026@163.com>
 <20260724093759.810108-2-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260724093759.810108-2-xiongwm2026@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G4BS0LGxi62bU5VYbnml1lBnTC1N4Ygbbpu_QE7fX_c_1784886710
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2026 at 05:37:59PM +0800, Weimin Xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> In vhost_virtqueue_start(), the call to vhost_virtqueue_mask() has a
> TODO comment indicating errors are not handled. Add proper error
> checking and propagate errors to the caller.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>

why is this part of this patchset?

> ---
>  hw/virtio/vhost.c | 10 +++++++--
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 1234567890ab..fedcba098765 4321006
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1467,9 +1467,13 @@ static int vhost_virtqueue_start(struct VirtIODevice *vdev,
>       * will do it later.
>       */
>      if (!vdev->use_guest_notifier_mask) {
> -        /* TODO: check and handle errors. */
> -        vhost_virtqueue_mask(dev, vdev, idx, false);
> +        int r = vhost_virtqueue_mask(dev, vdev, idx, false);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "vhost_virtqueue_mask failed");
> +            r = -1;
> +            goto fail;
> +        }


and then what happens?

>      }
>  
>      if (k->query_guest_notifiers &&

