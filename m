Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E6C3659EA
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382726; cv=none; b=bCn9gk2NZ7cniDptRsQCYME/+07+SXzifGAgPJw2zFNml4KH2VRESt2eU7IccpqiXRzISFb3E5egt5YPZm3TmK5VeeEau9nwicxlUK2iaick4XqI/m2E/3f1Valk7U7pnOWzinCwx4Pv40BhkWxvwr8ob0xUktBgc/NCsg6Ce9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382726; c=relaxed/simple;
	bh=GhaJom9Vi7tpxXr7oDaVKbjVC897hRfBqfGeSiwaBuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiOb+cEmyBKJjvMesg3YQF8rI/Xt4Q0aQ4NaBcFFCdStvCRJc6t2xDrPKd8RGn1DrBwDRidpri9QweaNXa+J0OVMPjn3zjPVabZpP1FLAvPHhZJ7u5+KNmcTa7VBKWBj2iWPYUBNyn6UXeT6s82lcwkWrG8zzD22Ti0CcTZoagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9cUvAFl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9cUvAFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773382724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhaJom9Vi7tpxXr7oDaVKbjVC897hRfBqfGeSiwaBuI=;
	b=P9cUvAFl92NzIQrz61yC4k7RvWwpFDsEm2boc7xuTwUbx7JiPU/0M+UHhg+mOnMHJ/d32b
	qhKGsmW4+FYUTdmeyLIGJ6WBRAWTtAe5JNf8SYOrjc9ih+UrCfc2VBrkA2EL4EkMBUCRw2
	PFtZy5Ne0J4gYkmgaD2r6agPhox6MWM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-37myazehMzSgjN37zqeAbw-1; Fri, 13 Mar 2026 02:18:43 -0400
X-MC-Unique: 37myazehMzSgjN37zqeAbw-1
X-Mimecast-MFC-AGG-ID: 37myazehMzSgjN37zqeAbw_1773382722
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a0b51eb23so1241015a91.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382722; x=1773987522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhaJom9Vi7tpxXr7oDaVKbjVC897hRfBqfGeSiwaBuI=;
        b=sdRj/+8claQtxPy1ZeJYMU9dcy73oIIXB9Z0qGvPBtdoGS20wDNLKW8n8v4ur+Irik
         E0G4/OOekRjQurwirN5KJHbWWdKfFdmzOBF3QRMNimafgisCxdNGAYucYSiUYe2zhyZp
         bb+YweW1Nhy3cNA4VT8BKa6Cty5wwWnmeIff5fyj+toUIvi6lZi2SovgWfLFXlA1XYIT
         kiJLAoQfIVW3JLQ72jOFuSXM992jCBHJv028aem2mRYXKDGHqhswnfeRBnb5RKR2Emu/
         rQy5FcFJFzq1lPfROamsIQredSHdGrJKZC7QCb3VgNkMiscADKO4NLTZAU3OQF9eDJB2
         6M6g==
X-Forwarded-Encrypted: i=1; AJvYcCWghNzevaC8jn1Owm2PEJBBIEX64djlBmRPOIbKV6rXMDpHHV/xjyJZWEgGB5Nf6XWoylGB3QDXMEq9GUIZ4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2/zz4vdv6/mGCmF4uJnvtGVJc+sn4kwZMIEnHTrC8/tbEz6Gr
	cyEj+oWdgj4EkJM8lHfcFizsGmgTN8tpFfscX/lYgg5ha4eqfKXM6RkAKVuwftPTighrFTPDcgy
	dsuilftP/R9YcAgRxrKbmNzr+YQePimT4KfXZg6eUPIxb2o/PyrJJjGq4x24M1h+0r1/q9wqIFS
	jMKcTfNMI/xlm4PhijyGcc9b+2NfTZvuwlbqCoxlK7Iz8=
X-Gm-Gg: ATEYQzyUUmtAVS6s8A59lIGJ21+Cct+3dh9Bi9veVv6kvreDgNPWUkKPnIkdHJVh353
	bnzIDHjxClXQrwrkIKcbVdFO4bOWz0yX24F+iSk3rRr0wZgMFv7yp3LumKRbF0FOEEFl0Y6FpS5
	ZHu2/3CiBG2uyqC478mwh0vgM25GUczTztYfD7wq5H3epEV0mNwtYAHM8EKpuYIVofmQBwghnvG
	yA=
X-Received: by 2002:a05:6a20:cc0b:b0:398:b61e:ff49 with SMTP id adf61e73a8af0-398ecd396b6mr1762967637.49.1773382722032;
        Thu, 12 Mar 2026 23:18:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:cc0b:b0:398:b61e:ff49 with SMTP id
 adf61e73a8af0-398ecd396b6mr1762951637.49.1773382721627; Thu, 12 Mar 2026
 23:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAZVx999y-DvB7Dp2ekoHk6s8aqqScd2gKSY4ySGAK6NNXeH5g@mail.gmail.com>
In-Reply-To: <CAAZVx999y-DvB7Dp2ekoHk6s8aqqScd2gKSY4ySGAK6NNXeH5g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 14:18:30 +0800
X-Gm-Features: AaiRm50ufnhualN_GPqqA8VArNbrVUugmk7--xHwxcWqjvMX3sr4KWxvuUQv5M0
Message-ID: <CACGkMEtY8UobTG9mj2geiNWcp1RtxzNAYvhXuLdVW0is4AFonA@mail.gmail.com>
Subject: Re: [PATCH] virtio: document the map API in the driver writing guide
To: John S <xaum.io@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, virtualization@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dKF61BP-Ygvlsd3o8s2enTgBrbNx5CUx-8HWZDop6eg_1773382722
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 5:58=E2=80=AFAM John S <xaum.io@gmail.com> wrote:
>
> Add a new "Buffer mapping" section to the virtio driver writing guide
> documenting the virtio map API (struct virtio_map_ops). This API was
> introduced in commit bee8c7c24b73 ("virtio: introduce map ops in virtio
> core") to allow transports and devices that do not perform DMA (such
> as VDUSE) to provide their own buffer mapping logic instead of abusing
> the DMA API.
>
> The new section explains when and why custom map ops are used, documents
> the virtio_map_ops structure and the union virtio_map token, and
> references the driver-facing mapping helpers with their kernel-doc.
>
> Signed-off-by: Kit Dallege <xaum.io@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

