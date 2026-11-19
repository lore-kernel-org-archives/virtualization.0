Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100612;
	b=u7KIaAAAMJY7pvo9TbkM0MR/Jo9eMGPBD5ucxEjQIKSyf3rWzgiNxZ0D4Wg7LCRk2wgk
	 72ithvNhvJ1JOM5+IH0CS1/KJpWzzllzdb8r1pqh9okFtFNYopsVJBdbaaDoysevHhvME
	 CKfyqtacV01hvnOmsy4d8hN0srukCgM7DxfDAD5jQXarJXkzrcWPQp8CmZyqZcNJjVCfH
	 w5LA1XS3eG/e7EBLIIZsS4WdcdepKWUed0JwlslwHhsxXUDvpXKWc/Eq2X78s8zGggvTp
	 QtDxNj1Nf+fhQDN84wCbiQy3r8+zy3cxaEhggGrbHZdf/Y6v2L7pAGzXydXOah2V+lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100612;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=wnQjVTvQ1FdNEd5V/022XTlNbc2cMP/Jpaz5K1hV8Gc=;
	b=qwV/axYQaZPt8FI+sODhD4cn1kqKPSpArThqSDSJRvFRk5oZnlkot1ISjf//b50n6efq
	 AV+YOK2RlsfoSNGijm02fiXfXWD9csz4aqUrV6Cvm+RMEAYI+RPEGORfwbXptjKaYpx8v
	 U+TKX/jdBISpVlcWA+XrkCCNpRS8G+H3PLk/iZQFJnkR/XGa6r9ZHDE0gMybIyZIcbvA/
	 NJERdEkjhJmzyhlEY1pSbl41ldcyo02VDw7pvXcLxaRAAu0rTo50gA4GwKQjBG4yNS/q0
	 gnCnDmu1qjVJSw/RTa5LogLgV92331C1edsbwAgCKC/1aHFOQSWJ41W3PWamudSS0Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=at5qqoR6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73E606A325
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 15:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C73E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=at5qqoR6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795100610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wnQjVTvQ1FdNEd5V/022XTlNbc2cMP/Jpaz5K1hV8Gc=;
	b=at5qqoR6I69hglBlYgi31of5sXx9okMa7e8Yl+SPft+2fLa1M/jwrGn51jZXe1+Rd/nvf/
	SoGoM/waox7yydx9+FJhv+SXLrjBRt0lFV4j9hdoYXj7IHmFqyB056Y0tSpZePl2Wxoyip
	KAzoes4Xv1XW7uHc4mWxtUV3Xw3vM88=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-w5mJayuyPJ-chKCeknIlbg-1; Thu, 19 Nov 2026 10:03:08 -0500
X-MC-Unique: w5mJayuyPJ-chKCeknIlbg-1
X-Mimecast-MFC-AGG-ID: w5mJayuyPJ-chKCeknIlbg_1795100588
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso20884725e9.3
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 07:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100587; x=1795705387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnQjVTvQ1FdNEd5V/022XTlNbc2cMP/Jpaz5K1hV8Gc=;
        b=LoxnlOrZ4ZUtLzYHrNhiXIlOXx6fvNq9YKU7W0fFA+7JaexG0sgY/Yrg9XMuRPEIs1
         8/QClnar5laIcLAffQ7lDnKor+jLbVxOpu3TlXw980VGd+aiW9unk0ZhczFeyKCT9D9i
         3uRMR9sksJRZoK2Ax5BMu2UTzzW9SETZ1zpoVFOUf/aLItjXs5RGTdi4RT4kQHdWmSgW
         kUD3I0qORyKJuHGgMxuFbJtyzbBs3mq0kEU3CM73I8K0ZqpiVzN0tAsW/6sogjq9vSVB
         8QyBim5kK2+noz+0B4hRPfvLk+y80n8IPbaAZiU4gZpJjNwPzEpC2A+MygHG8EqNdkIG
         6bSw==
X-Forwarded-Encrypted: i=1; AL+hErE469IZtD5gdRA4dJX9aM4PWLh2mbHAM9DjiJz6C/L2tDe/CksSvqnt3Mgp7xhRmtdFcDeiMgpetWD4D049Ug==@lists.linux.dev
X-Gm-Message-State: APuU4Z8x6zA+/CycnP/AcIR9vzquVLIpfuQqmmxnJJOgYmBZvTzB7L9o
	EKNKhY+5n5iWzpTp0Th1QZ2p370ESaT8iPfuydprtzF5A9mqnhe0UnGdZPnR+Png/MKqF4PCKfJ
	WIq+w8yIZxcZrLRvJrcnEhkI5JoWRktr/LBY41LjCdkHq82TZJSuw6vlQnPLNKLGNrtVQ
X-Gm-Gg: AYBFou0nhUUqCeN7FnRix9YEB2gf8FcValTb6p9jsgOGuo+4rOrdbtFhbvpeukjXYwh
	l4HgC7XUPnG9yLx/dgzzSS9Kg4c+i46iR8kduEC0c9Vr28lg+Zt4jD7Fl/u2P32qC0yKUe2SVVE
	a9feYj1FCHXZXZZavYvRa5SDX4OPPVjobHaw09zt9hNWoG1gACBX28pfWq3nhGoK9IbY/2n0IR2
	Eg+sJ7R3nR22qyvADMDWAO7qMq2P92yXz2Wo4G6Qwvy3nOJ3YyNpOeb4eLMlDK7e5YeXv9TsLSN
	9ab5fIPH8v+1hbuksTyawWyjfheAHkwaF2btO3GPyCQf1HgANwAmT4ANmUXnpqx5v4gIaCgOJW/
	8qDEw/6ydZ6HhnUUx0SQcV4Dq2ePQ0oNzaVgkLBPDAA==
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb7d6d1f21mr127466795e9.1.1795100584425;
        Thu, 19 Nov 2026 07:03:04 -0800 (PST)
X-Received: by 2002:a05:600c:34d2:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4bb7d6d1f21mr127465905e9.1.1795100583800;
        Thu, 19 Nov 2026 07:03:03 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm2590845e9.15.2026.11.19.07.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:03:02 -0800 (PST)
Date: Thu, 19 Nov 2026 10:03:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Xiong Weimin <xiongweimin@kylinos.cn>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vdpa: alibaba: fix typos in comment
Message-ID: <20261119100226-mutt-send-email-mst@kernel.org>
References: <20261102043526-mutt-send-email-mst@kernel.org>
 <cover.1793860522.git.hemanth.selam@gmail.com>
 <e68b7938e19affe2b18ba0ba9711e079fe1f7084.1793860522.git.hemanth.selam@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <e68b7938e19affe2b18ba0ba9711e079fe1f7084.1793860522.git.hemanth.selam@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RE7oVjGHa4-iZyTF4z6_jDGPmXYwQFMZk3WplcC9gCQ_1795100588
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2026 at 12:06:53PM +0530, Hemanth Selam wrote:
> The comment above eni_vdpa_set_vq_state() misspells "specification",
> and "ENI is build upon" should be "built".
> 
> Link: https://lore.kernel.org/all/20261102043526-mutt-send-email-mst@kernel.org/
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 1288402d3dd8..af163b4f9259 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -276,7 +276,7 @@ static int eni_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
>  	struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>  	const struct vdpa_vq_state_split *split = &state->split;
>  
> -	/* ENI is build upon virtio-pci specfication which not support
> +	/* ENI is built upon virtio-pci specification which not support
>  	 * to set state of virtqueue.


which does not support a way

> But if the state is equal to the
>  	 * device initial state by chance, we can let it go.
>  	 */
> -- 
> 2.48.1

