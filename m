Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308D1D5CFE
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713331; cv=none; b=saCAlGS1uWx5e8hcGch5BwZjPaW3mhbdgyt8xiEvLXncEcvp9D4Ug/Luis9XOm2cBT3VnYAxKM5TdyoTrGK8zTdVeEhlHm2h238G4z7ZD5Jcas5EvwrzsjQTR6f7ozot8/J0plSeF8VzCkbEimaN1gyNvIgRj6HBp5HS6yHnncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713331; c=relaxed/simple;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E3pcururK1KXb/vMT58IgWUYC5BIfi2zAI1DhTDkkIXK0+1/zdBNuk2xwvSvu/gxUhaO5ktGxV8Y6+ErYvMcDIDWviEU+QXSMRJUCT+a9HCYf3259RKBS5sbsn9C7VQ4V8MYHjDNHvM6mx5eJgxqtnhFCWDRFIkvObZWQ6rBnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRXYwaaA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRXYwaaA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779713328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
	b=bRXYwaaAa8s1JnjYJWcGQpJjcfn68eD38Phxp2dE1vKEJsWRd+UZgfwjVaUpoZFJVPZF7p
	jxmwo1AMehVcZ4ro+x/xo+njry/6zIEqa3nMoctY+PLZVN1C9Wp5lGtaDst77K2ECNW4Xs
	iOC9FPcmz74DniL/ZF6LkAGDUFMMRU8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-LcFV75TfN0-bMhD99O8GxQ-1; Mon, 25 May 2026 08:48:47 -0400
X-MC-Unique: LcFV75TfN0-bMhD99O8GxQ-1
X-Mimecast-MFC-AGG-ID: LcFV75TfN0-bMhD99O8GxQ_1779713326
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4518f777225so6884982f8f.1
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 05:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713326; x=1780318126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0X791ggz6n0BeIA9ombUGQUjMQuuLnyDFFrfuhS/ns=;
        b=H/1rQXy7HZ5BMOYCbGvK0MRF6c59mAScK7HmXR2Tr9TyWg/YWF6Gcka1r2UfvU8wRN
         NskqXJGV0Ev4RaA5zCr72GMWLG9qOvSWi3GD+dS7KuU7zkvHdbx06CTYfgy1xv15qC8T
         neRax1IHRXyIgQzDtzztsLnld5YKf68jsgmBN6+fgF8nb1X6Vflj7f58t024D5aYl3S5
         efR+JBX5CR7RfJFtLJx/b5wg1BnJL6aVOkj/zYYWakLzDqglFDLdNfN2suzsD7fvEB6r
         6fiAr5/e+PcEK2/Ph7k08ZJV/Ck4i4PWlSyIIP5LLNsknkcn1Y9VPeJcSY9VWMPTfCqB
         58/w==
X-Forwarded-Encrypted: i=1; AFNElJ8yv2IQScajGfbyG62ENUsto0aw0pB+l+A3uPTzxpEBj4jww+J14CYbbnF04XBa9dVnhSMEmRUQgY4d9ZHG7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy415fJk6A/xaqs2NzPDiB+B6Z+W3NOjttvlkEQHiV7ch7U/Vc7
	7Donz23NDYz/0if4spUkKxbHjxdY9TnCejariWgdPtx9EDyX4UqQNOLy6ItvI2GlGvubnzkC96V
	4Sny7XBZjmejGfeArmi0E1Xjfbgw7b4XQiiuvcOx/6FzS2fxwX6xv2v8s7/zmbjZcb/M3
X-Gm-Gg: Acq92OG5ebxaA/XV7Bb5AJ3ZMY+Gsrf/gRKwYHJ4/SopEF7+EU57DMjADp8udDq3tPU
	5KrzCwUBCtF2ijSixZOS8WoE42viweZ1UzfELBgiu/eCwrdInuag0JytXPmrESd667Wmy8//FjG
	67nNdzQJcNp+2rxxLfhzy4MVetcAmAp2UhfjB0vZLcKI+VDP5ucQ0H+SEyMh0/ampLpzi3aYj8n
	Saq4rmufkFmrUlbCe8f7fxkrzxvapqJVtBzoIMXsjEKnICvv8BKrD2PmVAw5smi5PxkNsoKFu2o
	ek/r7lndEeRV/ilLqLnfPsilGYsJAf39XMsBZaoh9C3TI3c3zOvTT/nzQJKCuiRPhC6jfPEm0zg
	vReH720YPNcyddYU0swYL1nVE30qxdgdpEYlggGHCxgGDOVRuUDDxF2Jg2+P/6zkMSBoAGJo=
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209950275e9.26.1779713326051;
        Mon, 25 May 2026 05:48:46 -0700 (PDT)
X-Received: by 2002:a05:600c:46cc:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-49048df2f57mr209949785e9.26.1779713325422;
        Mon, 25 May 2026 05:48:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904333146bsm143470125e9.0.2026.05.25.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:48:44 -0700 (PDT)
Date: Mon, 25 May 2026 14:48:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	tanjingguo <tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, Chenzhe <chenzhe@huawei.com>, 
	cenxianlong <cenxianlong@huawei.com>, cuirongzhen <cuirongzhen@huawei.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <ahRFCaqFwdEFA9CK@sgarzare-redhat>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0m0CQlXynSFo5zSdJF_GgpC8FEprb78GwxcmCXKQMwA_1779713326
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, May 25, 2026 at 11:15:12AM +0000, malin (R) wrote:
>From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
>From: Jingguo Tan <tanjingguo@huawei.com>
>Date: Fri, 22 May 2026 19:53:45 +0800
>Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
>
>virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
>before entering the send loop, but virtio_transport_alloc_skb() still
>fills the skb before it inherits that uarg. When fixed-buffer vectored
>zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
>managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
>to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
>skb_release_data() falls through to ordinary frag unref.
>
>Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
>before virtio_transport_fill_skb(). This keeps control or no-payload skbs
>untouched while ensuring success and rollback share one lifetime rule.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Lin Ma <malin89@huawei.com>
>Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
>Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>
>---
>
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

