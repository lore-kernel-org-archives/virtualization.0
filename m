Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAF651C21
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 07:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612603; cv=none; b=hGtyZJTtBhKNTQTJdR5jPf9RmBa7wdxKpskSNQUazpUvCnGhtbVpF7z7dp+eGfiA24nUDLupom+U4vnvWi+p+Dgn9EdV3BdWTSdg4Y9Z36dxfP75+MuA83UfSZKGrYC2zTjuV6EXVvz/M5Q/qVs8rlF/8UFZeaMPRFeO5mN9e0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612603; c=relaxed/simple;
	bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRD8TKYssSAHwFM9xszxeJQeYgqCB9eF6BOt3izff32IgEKLg+w1mA+2TAb4gOfvHixFfFdQoz9AlRkIy7raZskkehJc9tadDQhQH3WlBlKuF0C9d0VDUC12b0u8/R9EPkV8h5rDaCAO0dPQSP2JQDIPy8Mg8c0QHrb+HM4jIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERm8PTv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERm8PTv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711612600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
	b=ERm8PTv9KUbTgOLkrmAiZSbOoS5MQe5d2Py/MJGIbD3156DWDkPAdGvlufWtwUWoF3cbHh
	V0cpNQ/acHv8w1rZ6sjM7pqIcFdxZj5rnUBGJ/QwsGBOw+wLYHd+iE1Hc2nfYaIot756VB
	3xSULeB4Wd/p+kf2nBvDmKP3tx+E+5c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-D915Jt_KM_KUjnDFogVq6w-1; Thu, 28 Mar 2024 03:56:39 -0400
X-MC-Unique: D915Jt_KM_KUjnDFogVq6w-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a031e5bb29so600455a91.3
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 00:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612598; x=1712217398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMuY90RU06ldvXyUdfez/ncLT/9htamRUr37CGC5ACM=;
        b=mHkrFP2WYjfZD8+fmxT3I90/xRDxPKv9Q/PKGc3rok3/YcYwfw80rjbPAH2/ZsbV/g
         satV2bMKgJH4j+/MOiRp6g+WTVTBFji26wvDKpCdK7EZUlkbK/PLGKBkDwtVWPlAn2hG
         /IBuV7ZbmYNmo/KafeaJ+EeVTZKw69E7LKM3RjfAu93RpBWSxd38h74hxn7GoAvLYxP9
         dWYrp0nce0zNJTbp2EMQUeE8A+q6X0kB8WoAgBdoT+s5BBfxQkSZZIM6kFgOoeeyDNZ5
         rnb4gthCwsvHTgmN7T0+FqrkEBZ4vytybewYUHFttxSTTEr6MSFJFIL1NDhvoe619Eco
         615Q==
X-Gm-Message-State: AOJu0YzhP5fOSSxBmHkZRAVhVcMg3U81x4pfrpgQ6HOOTnA0hcbMUGEM
	J/o9bKGQ23NhSYBbPdLarkXDf845Fs8KDV1f61bGM6dkFQPd4YsAAHwieS1P4c0x/yy3VqJ9u8C
	2Cv+vpBXyo6lWRJAOornJh9iMuiwevAaevUACQ8ngRL3dUcMkcFz/EHjDDYGW/xwSE7pi33KkFw
	xdxXdb6gY6swyp1wX9B3k7uDWSFIw+GovDJ7CK9eE=
X-Received: by 2002:a17:90a:6d82:b0:2a0:99b9:dff0 with SMTP id a2-20020a17090a6d8200b002a099b9dff0mr1686998pjk.16.1711612598235;
        Thu, 28 Mar 2024 00:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdfM9f+Ys19JA8GILgDnNKXIhVRTVPRqVS/fiSFTFwJ5Vy6BwFi+yHd4p4PtmjI1CNMZWR4yIxHQSKosoLrTE=
X-Received: by 2002:a17:90a:6d82:b0:2a0:99b9:dff0 with SMTP id
 a2-20020a17090a6d8200b002a099b9dff0mr1686989pjk.16.1711612597940; Thu, 28 Mar
 2024 00:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 15:56:26 +0800
Message-ID: <CACGkMEszXC=B3U05OsbMwEFcvSvU7AwPEKasmQa=VgjCz+k2ww@mail.gmail.com>
Subject: Re: [PATCH vhost v6 07/10] virtio: find_vqs: add new parameter premapped
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the premapped mode is enabled, the dma array(struct vring_desc_dma) of
> virtio core will not be allocated. That is judged when find_vqs() is
> called. To avoid allocating dma array in find_vqs() and releasing it
> immediately by virtqueue_set_dma_premapped(). This patch introduces a
> new parameter to find_vqs(). Then we can judge should we allocate the
> dma array(struct vring_desc_dma) or not inside find_vqs().
>
> The driver must check the premapped mode of every vq after find_vqs().
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

