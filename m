Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADD74E33
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692364; cv=none; b=W1ZADbvOPfxBRMRubC6SfkBBV9PPLasH7qaLdGkPCY0O08IMOV0ronVP+JDT2SbIlAFl7A+vzCPNPcGCQZqsKAmjtiGewmxQ6kb2yLj6CH9F8Bpf/7WEfM8nkI5+FGA0rRl+wlG8eGFIVc4u0OT2C3kG6HI1j8uHQqTEV1q7kJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692364; c=relaxed/simple;
	bh=gmMgCA8pbsUZS3rqeteeTCbsa5nilPbRUQKyvYs5+t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcNi3ypEGYx5em/TXPKJihEvj5KylNd145f3Zn/jXfpvLRsC1hOWaEyjY85SZLYGNM8iHnBnU5XiN4eh9g15SrocXTlxlbjdeklspppniXYZsEHaXJ+emqrMcnkw4b+9BMZoLXsdRmYl1IAhZTHoDQgD1Dzx39xFBQPeuG4/2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUs55WT+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUs55WT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=;
	b=cUs55WT+WLi8nlwVNdWu57ygFgkk24stJm8mucjeAA8HuifLnCzttALoLCAzg58e/t3tsP
	zVaV61ugo1bUbFnJLmvUIDfny8ZnavQPmiGsOwrXIADZyowyefVcFWPzDgR/A4iwl+kvKm
	y20CCfhhOyp9itV0IsCWwsV8ctyuhy8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-t-zYmaqiOui1PlFNlJfctw-1; Wed, 31 Jan 2024 04:12:38 -0500
X-MC-Unique: t-zYmaqiOui1PlFNlJfctw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bd3b54e5c6so7559880b6e.1
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 01:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692358; x=1707297158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peGGQf3sjuZMqqhDGxYZpBNQpOww05kdciLu+8qQbKs=;
        b=UjrITTZxnKD/feRWPcBtHq2ZFB3fc0tkfBEcQlaqzxWX2do5E7iUCeawA0Zr5boNxx
         s3PNYAEgiq99yrQ6cmxtMds+rZ6CDY3w1p7/mzpbrj2vvRHEJuaxzdQWCWHIp5CmXUC3
         oYBUwLcSYqEMu6s0X9vPonCvy5WH4+Oxr1/3XIWUpa8PX4dXTt6Ysd8HXmP6Z6Z2oc/G
         KJPw6YRswOTsbCI6Vb4n12PXdOdLhiZ9SDpQt3v1/PPKk5ZImv5jyK+N/cD5f+YvrTN3
         xtvfgylqBhZ/g0tJEv67SXo3O52XD6v6MVkiEGCndMI/QL3USc4PX+GkcM9RGAWsoPHT
         Q5oQ==
X-Gm-Message-State: AOJu0YxGkNdvPD6vme6/DVF0w7/K5xDdU3Xu6jLnel9q2q1hv0X59ndo
	GgIKMhtZdqB8UwuzNTs2M2TB/5PKVAO5X+GHHQt9UKCy4kkDyQdXdO7S90nPphBwbY6ZTlqGrKF
	tmDbpSILDsYOfEqA9KVHa0GZAvgS/jQ2SYDm8FfekQreY2i3Abuid29yUirjUWUxvry6x8HS/dE
	s6LrfsJezxXsIPVpuoMv5yTjMa6lxn3e6Txx89FW4=
X-Received: by 2002:a05:6358:6e8b:b0:176:4aae:515c with SMTP id q11-20020a0563586e8b00b001764aae515cmr994105rwm.17.1706692357790;
        Wed, 31 Jan 2024 01:12:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7fIfH41RbzJ4uMQRVZeD0/FtypkpuMBhNalI0GgIXQr8L0GNwGZEMNsexvxgVEoc2spN+yWaoh5j46pvgQwg=
X-Received: by 2002:a05:6358:6e8b:b0:176:4aae:515c with SMTP id
 q11-20020a0563586e8b00b001764aae515cmr994071rwm.17.1706692357511; Wed, 31 Jan
 2024 01:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:25 +0800
Message-ID: <CACGkMEst-k1uOUA6diC2yB+=9ZYezuz=n3=kAzDFpXLxGE=etQ@mail.gmail.com>
Subject: Re: [PATCH vhost 05/17] virtio_ring: split: structure the indirect
 desc table
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> This commit structure the indirect desc table.
> Then we can get the desc num directly when doing unmap.
>
> And save the dma info to the struct, then the indirect
> will not use the dma fields of the desc_extra. The subsequent
> commits will make the dma fields are optional. But for
> the indirect case, we must record the dma info.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 86 ++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 2b41fdbce975..831667a57429 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -67,9 +67,16 @@
>  #define LAST_ADD_TIME_INVALID(vq)
>  #endif

[...]

> +               kfree(in_desc);
>                 vq->split.desc_state[head].indir_desc =3D NULL;
> -

Unnecessary changes.

Thanks


>         }
>
>         vq->split.desc_extra[i].next =3D vq->free_head;
> --
> 2.32.0.3.g01195cf9f
>

