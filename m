Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0FE14F70
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722395490; cv=none; b=ALCVT32I2JzjxeC0taIEF8K+fxHYIfakCF5D/ZoJT7Mq+w0lDmBpKeih4/sULpG9ASn+8iHl7PWogCcni3SK4XMbLzjer7+11l8HTKZE1Z6NmZ3Bl5ba5s9pY5DF/4PIH6bBGTbG5ata2FE9RF74Db32jDmvQhdxAC8ogVZqJsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722395490; c=relaxed/simple;
	bh=DwQLvRUThF01vAGn1WxpvhmQL57pItU0ZwjmUKgEutU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ARjE98AWsSLUmmz2jr0yO78aoosT3mT5c7LnqdnCJU/i3Q/yNMbffar9qqQQL6yo9+guvBwHNt3Ht8FNqGPEMdWSqFrg5IsAfI+K9F9rmxMiYEAdJuoliPfCsMjFtQjVgjaZhMD/ZOqxmCf1R6t3MjWoCxVgdaAOkM1936C4WFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/V8oP3Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/V8oP3Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722395488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWwLp1Ih+u6gHfiUIAuOqbUDdnoH9hCbh7uBar0a72c=;
	b=B/V8oP3YyE324VbDZ63Ehe4M3Gh6sDWtUTJCFASh68JxBoX9wuRgQl196KCqFD55J3QVz8
	ou6h13Aatp8D8it3JPtD4DTyaD7R66SioYsQfSLytNnraufanvHPnBbXlkg3+jt3nWN+oW
	7Oxn6uUpHOo5lPhVOKi8llnwaM+zu/A=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-yIzvP_KaPqSiaWQeXwAPQg-1; Tue, 30 Jul 2024 23:11:26 -0400
X-MC-Unique: yIzvP_KaPqSiaWQeXwAPQg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2cb54eac976so5197082a91.0
        for <virtualization@lists.linux.dev>; Tue, 30 Jul 2024 20:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722395486; x=1723000286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWwLp1Ih+u6gHfiUIAuOqbUDdnoH9hCbh7uBar0a72c=;
        b=Gpv2ukjbXoBYR+96NppyI8+zVZSsxZgsZo9aDRsmsgMpQCAmnI7yRGbZv2GrB85Muh
         zzx53LfgyonKVAQnCErQm5pb3tZE4IfieMZ5dfl1G2eNs1R+m0BXi3M7tg0ruWRyxP/E
         oFmicrqggjCc2+wH1n5RR7Cc874NvRvtK/NzJhBAN+Ga8LwCkjyiN0FZBejTFnJdCYJs
         glABDrjhhtT8VqV8TsaZjHdbwUs5jFuu7rkdB2eQuNcKEL/8/KXozGNpSmohRP+BsDIC
         rDrT3cA6WGjiKwP5AqbO2ucSq8By51OiiRcpiS/CwLADeWQiuBJH51MekwCQONHSd36q
         85XA==
X-Forwarded-Encrypted: i=1; AJvYcCVlMCAN2t6hpNv3zCfz1ZPQBXV4+veAWhF4tD0rk8xIqeVhX/rcJ9kmKzSR3KXG6lNuSfXBvKmJmd02paW5EEo3R/xFudW0yihjETh4w1Y=
X-Gm-Message-State: AOJu0YwYW/U6UMuWUi6WpepB78kQ1nSGkSsBAOQBdBjo5JVk1v8SRTdf
	WKLDzC4OOy3+H2TaeNlXrHqtLTiWCMbGx2U2JUTREQROYP8DP/QR9bm9HVba94RHfF9ouvLHw13
	CUaY19zNew/XLI+lVuBVNZayvT/DVWJAxmlWK2aELIiCjU117dGs2jcDmlJk5iVzNgBS4AY2bGP
	5mjmxeTQfXb7KwHS1A7jTTP0tM/bZDs19NC7u7610=
X-Received: by 2002:a17:90a:8d02:b0:2c5:3dbd:58bc with SMTP id 98e67ed59e1d1-2cf7e1ff521mr11519136a91.25.1722395485796;
        Tue, 30 Jul 2024 20:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExASsgvEQCSJuoJ8g3UUDEN5BjkkKwxLgLE2D9X91t6mmIgyrqyRPAqowIGVUDuDM9ayTpLd7IIbn/CwV/4LA=
X-Received: by 2002:a17:90a:8d02:b0:2c5:3dbd:58bc with SMTP id
 98e67ed59e1d1-2cf7e1ff521mr11519113a91.25.1722395485350; Tue, 30 Jul 2024
 20:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jul 2024 11:11:13 +0800
Message-ID: <CACGkMEt9PoT4XDw1TKBaQ_GYihOAdnyzBosVYNVL62MTrYD0rg@mail.gmail.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:48=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> From the virtio spec:
>
>         The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
>         feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
>         and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
>
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
>
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq re=
size")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

