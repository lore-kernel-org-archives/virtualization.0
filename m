Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795099543;
	b=TvWhCmP6SZ0LuXAHFecDRa+04/fJu3KmOt2DLgucwrfh2DA1wlGo7mP2Pf/6n7w0D/Va
	 8Om4JKiscoj+e8142JaCBnYscb7sWPDbiiJZrrKtFmVEXAK6rqbpF/+lDh3nd+nFewBA1
	 NIA99g85lGqLDwR2T/CxQ/bDmATnMxKAUOBnqBHZDN/tMzLSKuybX5577gF4elsZ8ulRl
	 zQOSS+NE9HU1lx8wNYmaVsBq01MV5GBQPR/LB/MxycXDKMAqB7R5LuHmwsjghWU84Ih8g
	 UDN/ZqNkQ9eQx2Bm2Uat0BJmRUlPUk6Vn41fA/qAL/kf5gl1srTwyBMbI9hdqYF0q6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099543;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=mErUvWvSAMQID0KQkYNWkXS0wwrTWA1UHG2jXHEQYNo=;
	b=ydngWdqJhmdIvRhryjYgrYtfvHGZOA0K+yjAGTwYVqcnSp0tG0lmikuBWeUTvKIIo/QS
	 MxUru4Zyr21aZLZNcs1o8gj1ZZLfgTGpG3AE0Rer0vgEZO6IgsQbsJDrSnQJGF8LOLEwy
	 cnmPUM/aFadmHQzOGRx30mqij9n83c5q3pK+pUr1T1EGVoTCbvNv9MxRXdKHC5iLMfF8v
	 Vr2eO8QnV4aTgAp5sAp4frA1JTxO0cbyN1HsjDCd/ovIy7F8wJdkqDpScdKulubZYqzDx
	 eGI5hmVVn3JIAfM7mMG6kvYoOXBlzhf/If5kUmOHok0FMm6AluCFW0NVo/XJCq1fboA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="IGaCf0Z/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616C60A2608
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 14:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C616C60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IGaCf0Z/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795099542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mErUvWvSAMQID0KQkYNWkXS0wwrTWA1UHG2jXHEQYNo=;
	b=IGaCf0Z/gF0mLWnWul4Vd0VItMe3JBdl5FO9ahoRpLEJgB7OSzbi3KFZpPsS32WkgCnYLO
	QydY/X90FIwq44EMHwJBLUfZgQ9tlXhKP+sHbRVrk8qbTECtTaKPjtWzlhMA9eSP8QZc7J
	VUf3ucxHpPBANDb3VupOL97cJLXUrJY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-On3qvWq8OQmIhhwYJu_3-w-1; Thu, 19 Nov 2026 09:45:39 -0500
X-MC-Unique: On3qvWq8OQmIhhwYJu_3-w-1
X-Mimecast-MFC-AGG-ID: On3qvWq8OQmIhhwYJu_3-w_1795099538
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso5432585e9.1
        for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 06:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099538; x=1795704338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mErUvWvSAMQID0KQkYNWkXS0wwrTWA1UHG2jXHEQYNo=;
        b=qbDpnz6JWsE3j2kKb32v8DlFAVbSh7u/n2rCvET2hDI56iJnWzDvnWd+2iTYCJuVKK
         J2EzuwMqSiCSQskENJRHszhPo48OIq0fAzeOmaJ7YDOMrOanW11jmynIxC7B4KfwVbR5
         XxptsND2q8M9rm051v0r+THekfGQyhnztTykfScx3VFOKP5clrGxk34KCC+FoMeH5/zG
         T4tIILxjzNxY3SDMP2ZLsqobHE/j2wG7gntSXKhzd+K2tb0GFUcRPkJCWmtpfjrLntfI
         6ReLrh3oDfV9NhmxxxGqhfPt5ZxzIzhWo/+QxeJX2wj5YVq31J4HJIGXKbi93NXWvW31
         MVjQ==
X-Forwarded-Encrypted: i=1; AL+hErE11CQ1hiyLrldt4eZqxwPBwXg7eu7fzwwZPKpXV4YBElkCs8sD9tnzMQHF4UwU0n8XjnVUDFlo7Z5Sq5x0/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9I9l43uuSULYJBnDUSFZxnE6G5+CaU9qiaWSIjh3bdJJHj1mVc
	P026j2OjgBsTGnyZi6q0wTR2j55Ugq5/kuH2+nKRN5LzCx4O/JnGaDGkvOTH1D147AKoOHpW6ZC
	6pl7g1tEtCJ9rqFsTbzCSNLy0ryj4QsOjZJAbWRaU5LIfhsce9GtwhBDfoM1FNpk6/wCu
X-Gm-Gg: AYBFou0sUgw/UchI6Kl0M/o1UwVGZiBOnTD4vsNy78O59K4AcUI4VG5QL0vPcg+lBBw
	gV7KQlELqRxpXtMnUnbklz/Pcb8NaeuuCUOJ2xlo8El1dY5BuwZFUaieZT35ncqT3Sjw3x3R9H1
	mv19WVl+ii2NuKTxUpOV5wx+YeBIO4UFaXOdRc/tev+lJSXnG+OG7772R6kGJr+CH3xAgQMeiic
	1JbG3HDNK2hRK20YSfkjIv9JNIz03GjQkQI1W0T33hYvD5hOKBIwTV+bZ5funQMvaWtSbsfOQfo
	VLA2obqgOpxaJcDuPL7iganJjeXKBDb26TXjBvK8meo3786UBy0yjjbSNiz6zE2vutPr4rJbCSY
	FqiHlV1dxxIqOR/nqfGpYYXZAP0avCyewVGY4d/PSgQ==
X-Received: by 2002:a05:600c:674b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb860ffbaamr32242135e9.5.1795099537838;
        Thu, 19 Nov 2026 06:45:37 -0800 (PST)
X-Received: by 2002:a05:600c:674b:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4bb860ffbaamr32241545e9.5.1795099537283;
        Thu, 19 Nov 2026 06:45:37 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1522:6500:ac93:c62:f076:48c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e5f081sm34711455e9.4.2026.11.19.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:45:36 -0800 (PST)
Date: Thu, 19 Nov 2026 09:45:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jianlin Shi <shijianlin11@foxmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	jasowang@redhat.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, talgi@nvidia.com, hengqi@linux.alibaba.com,
	horms@kernel.org
Subject: Re: [PATCH v2 0/2] virtio-net/dim: fix irq moderation init failure
 unwind
Message-ID: <20261119094456-mutt-send-email-mst@kernel.org>
References: <cover.1790751008.git.shijianlin11@foxmail.com>
 <20261102155145.23144-1-shijianlin11@foxmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102155145.23144-1-shijianlin11@foxmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sli2vbw0od7n6OdzFW7mO3JcRYi-hB-VY78o-ZOaI5w_1795099538
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 02, 2026 at 11:51:43PM +0800, Jianlin Shi wrote:
> net_dim_init_irq_moder() leaves dev->irq_moder dangling when
> profile allocation fails.  virtio-net probe then skips the
> virtqueue teardown if that init fails after init_vqs(), leaking
> the virtqueues and their DMA mappings.
> 
> Patch 1 makes the dim init failure path clear dev->irq_moder, so
> net_dim_free_irq_moder() is a no-op afterwards.  Patch 2 sends the
> virtio-net failure through the existing free_irq_moder unwind
> (reset + del_vqs), matching the page-pool failure path.  Patch 2
> depends on patch 1.

this is not how u submit a patch to netdev:

1. start a new thread
2. put "net" in the prefix as in [PATCH net v2 ....]
> Changes since v1 [1]:
> 
> - Patch 1's commit message now documents the call sequence the
>   maintainer asked for: on current mainline the dangling pointer
>   is never dereferenced by the only in-tree caller (virtio-net
>   probe does "goto free", which only reaches free_netdev()).  It
>   becomes reachable once the caller unwinds through
>   free_irq_moder as patch 2 does, which makes patch 1 a hard
>   prerequisite rather than a standalone bug fix.
> 
> - No functional changes; both patches are identical to v1.
> 
> [1] https://lore.kernel.org/netdev/cover.1790751008.git.shijianlin11@foxmail.com/
> 
> Jianlin Shi (2):
>   dim: clear irq_moder on init failure
>   virtio-net: unwind VQs when irq moderation init fails
> 
>  drivers/net/virtio_net.c | 2 +-
>  lib/dim/net_dim.c        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> Signed-off-by: Jianlin Shi <shijianlin11@foxmail.com>
> 
> --
> 2.43.0

