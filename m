Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665B18032
	for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713841928; cv=none; b=AS+ndMsSKCYnccrP3gZm/BTcmHfQS0MPuDkuG6GPpFGUVGPtuxGtF9rbyeoBrERzzpx0PlSRVeTeQkiQgJZa9JfQLRE8MaSKM6DHGQ8mRkh+0CYXcs5TqNXcuCstIotQAYK4ElAcLfa/BEwupTNdBPbbZD+PO74Z9yBtHJ7jR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713841928; c=relaxed/simple;
	bh=T/ufC5uEstpX7JOyLrRfGUXFoGcTxcoqu+hG9uSdM3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTP5uha/vv6wLik5BJVnzI+MZfjVbbWhdlbO1pj1k/eqtGOY2YDwM3SzIN83YgMy84xDRfvcCUnATTczOUrJOU9peUL4EBlsKQAaEtETqDlDJTuIWAgmu90Ua1HeIIK90ktLdabI4h1d3csDf3aN9/hmVX0yqQogDdgzlGVdqEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnCzNk2s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnCzNk2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713841925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P6Hud8ZwYGV/pvpEAsvmgKYrOtwj2IKB6XpISxJlVG0=;
	b=HnCzNk2sIQXPVd1hAazhb3iOJ6KE+miEn6CqknmgGwFzb5M/Ky0PXQ6gYEYsdBwLdLwsvp
	hzUh2x7sSwUXMzmsFQ9JKA5RlG27hoFcn7tecFqz+D8F5qhdTUCgVRUOIy6Hn5/cwD4m1X
	WT9XoEC/cITuxlQrRQNcGUvW5ErA8Vk=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-AozW72w_OySy2p3m79qDkQ-1; Mon, 22 Apr 2024 23:12:04 -0400
X-MC-Unique: AozW72w_OySy2p3m79qDkQ-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5fff61c9444so1633043a12.2
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 20:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713841923; x=1714446723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6Hud8ZwYGV/pvpEAsvmgKYrOtwj2IKB6XpISxJlVG0=;
        b=v0IY2rv6pdnBG0xC/+F43f+jdSorfTJR0g4sgKYkYF37HC1CdDLmFhyu0hNqBE+O+P
         eIdiWsIgPaGsgJ3GxNABe7jAQf5+QJKcvnW7NOtScEvUAiaY057lYQUCce8Px9g1rbvJ
         0ecQOmpR17ni0WzXArbiZ21HnhUSW/fDsqklfzuKCbUsK8xZet+b2Znfq60sjkr+9FRd
         0ZulWx6BujtOkVoPmdu8L6LTCFHttj36+ef5Iba5Yb128LhYU0a3ZsXY1uEInd/P+5Al
         ZbN9ke+/5SSLqklQGrhN+WQhdUOQhiXzhDkiZBIaeBK5NKsgOpcKh5LCLMCfVjAnCFoT
         kWzA==
X-Gm-Message-State: AOJu0Yy3kBWZB+wBJy1sc9fc8oVPy4mB0CWuiOyjPSFF9oWU2J3rIgEV
	RflCVm/NkGGHee9dAtihhFwtXd1aF7r+kbuotGlJfoXC/gwZRxc7rNGCwlBjPXshycqaLalcPlO
	han538+R7sv6/QTf3qoChah4I4P8dxxNijXQwNY0keDhNobvSJbFze0M8F+lKkldBrS9guQ3F9z
	A6BlJCt5mAWg3IHmGXTLtV7nHWblDRR1NWi/EIOj8=
X-Received: by 2002:a05:6a20:3256:b0:1a7:5721:7011 with SMTP id hm22-20020a056a20325600b001a757217011mr11311678pzc.41.1713841923312;
        Mon, 22 Apr 2024 20:12:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL/9rAZIQKEhE2sGik3GY4VP6E6ML0Uuq+/eQz4r9cyQjK8L0BsWvQoRqid/ZT5JNaJAJMTO7IM8KdyetjUHA=
X-Received: by 2002:a05:6a20:3256:b0:1a7:5721:7011 with SMTP id
 hm22-20020a056a20325600b001a757217011mr11311674pzc.41.1713841923041; Mon, 22
 Apr 2024 20:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240422072408.126821-1-xuanzhuo@linux.alibaba.com> <20240422072408.126821-8-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240422072408.126821-8-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 23 Apr 2024 11:11:51 +0800
Message-ID: <CACGkMEubWOFq8Bj1Kk02Om8DnbhFyNtAD_Lk8mXL4c2GSZgabA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 7/7] virtio_net: remove the misleading comment
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:24=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> We call the build_skb() actually without copying data.
> The comment is misleading. So remove it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848e93ccf2ef..ae15254a673b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -690,7 +690,6 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o *vi,
>
>         shinfo_size =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>
> -       /* copy small packet so we can reuse these pages */
>         if (!NET_IP_ALIGN && len > GOOD_COPY_LEN && tailroom >=3D shinfo_=
size) {
>                 skb =3D virtnet_build_skb(buf, truesize, p - buf, len);
>                 if (unlikely(!skb))
> --
> 2.32.0.3.g01195cf9f
>

