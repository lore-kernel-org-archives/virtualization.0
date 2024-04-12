Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEB79DC
	for <virtualization@lists.linux.dev>; Fri, 12 Apr 2024 04:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897294; cv=none; b=eoMBYi+cw8AE630ikS782ra61g8SCCI0s7MUXum3MgoeQ77OVj9YYS7RtD/uEvton0wDzBoe+8mPgvFe82VUK6yCzxBQiPfRa8ecBda/bBCV15ePIHju7UzpM70DNlkgGEkqn7/HeoTavyIcReiW/XMFBu8b9QzVxZGnt//au/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897294; c=relaxed/simple;
	bh=uw8Z855wH7YK9MlCNxEU1bYKZyaNxkchOp1vq3s0Kds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMMlWGuFVOd3d2lP9i7Ecat83mgWjrP5jMZO5ir+YYy2FbaVp8YJCYuNhcKHy+qriOywT4DKidMRYCYXlZonBjY9CcILBLuWcPXXaBxp6mqMXwAkbTrj0clUHqa0Cf755akHW1+7exciuGpUX61xSyGo8Bz0X7i6m0AZdeifQKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b6V8nW5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6V8nW5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712897291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vawxXXfazD0po5SWizFrmLAzOPEunL08S7b5tc+QC5o=;
	b=b6V8nW5AMx5oePWrJbd/qTBT+H1ZIKpWl58kyP0l04iSiwHOKSGp/nglfz0D26ppNO97fG
	xvI5WVWdGpK3lD2NYa161tqWjDFs84jZySUhL93/4YF9yzxvBY+1i3V0YDNvdLu5p8lfgk
	kTaOjyjO2YpTh0W7G9mrkVEqTTVZDcE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-iyGyM31BP4-80dbkuXD7zQ-1; Fri, 12 Apr 2024 00:48:10 -0400
X-MC-Unique: iyGyM31BP4-80dbkuXD7zQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ed25e9b34aso431172b3a.3
        for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 21:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712897288; x=1713502088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vawxXXfazD0po5SWizFrmLAzOPEunL08S7b5tc+QC5o=;
        b=acO+3VNj3Wli7ZSejS0yZcrm637mZFTX3s54/t2xmMKxJqGrivUdar/2CN1r4OlSa5
         3Au0bgbxXlfgZiCPej6iJ52kWZlcBoIZ1cKy2WFwg+6dIcrV3xNiaMPmTpFZOeypOTTf
         bU0cWMZa17sd9TA+WyirrIMTqNat+9pJtXGP/PJiGdF/ui9xy8/2C/a/0eSmHOZxtk9r
         QWyQKoPKz1DTtfrO9lsuspcUh6IfKiepKHxgDaPtfE9LtvPxtvgQZP7hyef/N2Ak0DKq
         bfqkQiUC+M+WJCCrCLWkV/Gh83eAIrbsaLEmF8ChUqgwmoBhQXXn+llOnRWZCfVDOb63
         Gylg==
X-Gm-Message-State: AOJu0YxojFfldc/ix/YVZKcKCS97TOF8jyvAWWGFB1VycZ4zSDKS8tmY
	UJKbgQcfyRgmLvpokfMAkDg3cPtp5v8I0LXUENpz6pqmvQEqfApT/TF7oX6woaCajt3RruSnJMg
	htyeABSPRfCpOhHtjM47MfPYct+uRoDc3zk1fIqP8DqcTVs3B0XVZX5jOV5VPX6gbJetNMyIbiE
	0lSClLFJ4zuzqCzmszya7RC3WRnIhaaPXEuezhtNaMQcSgIgBnoA==
X-Received: by 2002:a05:6a21:3d84:b0:1a7:aba5:7ce9 with SMTP id bj4-20020a056a213d8400b001a7aba57ce9mr1699462pzc.34.1712897288411;
        Thu, 11 Apr 2024 21:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfSLFM5jIoiGUfY84S2M/snhX63jxnw3EVQYhrxaQoP9DgsKjdQMOLTfpqB5nASOgcWhtpTm2lPTdzBQI2ZFY=
X-Received: by 2002:a05:6a21:3d84:b0:1a7:aba5:7ce9 with SMTP id
 bj4-20020a056a213d8400b001a7aba57ce9mr1699448pzc.34.1712897288079; Thu, 11
 Apr 2024 21:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 12:47:55 +0800
Message-ID: <CACGkMEsC7AEi2SOmqNOo6KJDpx92raGWYwYzxZ_MVhmnco_LYQ@mail.gmail.com>
Subject: Re: [PATCH vhost 3/6] virtio_net: replace private by pp struct inside page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> Now, we chain the pages of big mode by the page's private variable.
> But a subsequent patch aims to make the big mode to support
> premapped mode. This requires additional space to store the dma addr.
>
> Within the sub-struct that contains the 'private', there is no suitable
> variable for storing the DMA addr.
>
>                 struct {        /* Page cache and anonymous pages */
>                         /**
>                          * @lru: Pageout list, eg. active_list protected =
by
>                          * lruvec->lru_lock.  Sometimes used as a generic=
 list
>                          * by the page owner.
>                          */
>                         union {
>                                 struct list_head lru;
>
>                                 /* Or, for the Unevictable "LRU list" slo=
t */
>                                 struct {
>                                         /* Always even, to negate PageTai=
l */
>                                         void *__filler;
>                                         /* Count page's or folio's mlocks=
 */
>                                         unsigned int mlock_count;
>                                 };
>
>                                 /* Or, free page */
>                                 struct list_head buddy_list;
>                                 struct list_head pcp_list;
>                         };
>                         /* See page-flags.h for PAGE_MAPPING_FLAGS */
>                         struct address_space *mapping;
>                         union {
>                                 pgoff_t index;          /* Our offset wit=
hin mapping. */
>                                 unsigned long share;    /* share count fo=
r fsdax */
>                         };
>                         /**
>                          * @private: Mapping-private opaque data.
>                          * Usually used for buffer_heads if PagePrivate.
>                          * Used for swp_entry_t if PageSwapCache.
>                          * Indicates order in the buddy system if PageBud=
dy.
>                          */
>                         unsigned long private;
>                 };
>
> But within the page pool struct, we have a variable called
> dma_addr that is appropriate for storing dma addr.
> And that struct is used by netstack. That works to our advantage.
>
>                 struct {        /* page_pool used by netstack */
>                         /**
>                          * @pp_magic: magic value to avoid recycling non
>                          * page_pool allocated pages.
>                          */
>                         unsigned long pp_magic;
>                         struct page_pool *pp;
>                         unsigned long _pp_mapping_pad;
>                         unsigned long dma_addr;
>                         atomic_long_t pp_ref_count;
>                 };
>
> On the other side, we should use variables from the same sub-struct.
> So this patch replaces the "private" with "pp".
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Instead of doing a customized version of page pool, can we simply
switch to use page pool for big mode instead? Then we don't need to
bother the dma stuffs.

Thanks

