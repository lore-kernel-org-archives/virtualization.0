Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19C5C433F5
	for <virtualization@archiver.kernel.org>; Fri, 14 Jan 2022 12:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BA9F60AA2;
	Fri, 14 Jan 2022 12:45:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SuHbKP-WifL5; Fri, 14 Jan 2022 12:45:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1591260675;
	Fri, 14 Jan 2022 12:45:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1FF9C0030;
	Fri, 14 Jan 2022 12:45:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2673AC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:45:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 154BF4168B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:45:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i73oe_8RtCov
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:45:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE0804166B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642164341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=er6MELR4/wo1rA6heNzWM5PKfCy/ueOscQvUYlmKOB0=;
 b=SRRI7AAKBrkfFswTc8O0WlgLlOAEa4hpUvypsMXz+vS8/x9xl2nZYKJaqwBw9Yt/cUfQW0
 mg91owSHNWQRDj2R0H6QDc4BzkDeAeQkAZzTsC6Gpx1orqIpQZZFsJxtSPYmQUBrGgzC9U
 H5Ys2D9aHduOAB+nCF56jsoIMTr6ohg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-I0cDlLX-PWuRrxSYDYMISA-1; Fri, 14 Jan 2022 07:45:40 -0500
X-MC-Unique: I0cDlLX-PWuRrxSYDYMISA-1
Received: by mail-ed1-f71.google.com with SMTP id
 x19-20020a05640226d300b003f8b80f5729so8204460edd.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jan 2022 04:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=er6MELR4/wo1rA6heNzWM5PKfCy/ueOscQvUYlmKOB0=;
 b=lb23AvqNpt+7hNjmaXqHkYqyumPwbjXOcX02dYd5oMsZC4PVJBKYc1zSFCjoHsZNZH
 BM7fE/6clpoiqY5XlLNKtABx2HTCbqLr34LpkrNxwufiJSB+sCeLLmB7eub7fgS2UEK7
 +BVZAPxwoVdHX4Ty+8EmeuKWYgFta9ePb3PCZ+Fi9qPouMbnRc3CM+etuRp7VoU0LSkG
 gU3YbotePsu7mmz/Mc8sjAn9mlYEVnTcC9pUdr2pkxqy9zjK1O8KRCv5NjmiHoyYoUoY
 RIRwHr8nfMqgQo2EbsFaC+0ozcrnuDGN/nHA+Ls2evoS742ZhwxM5WjsZuCLyIym/s5V
 /mpg==
X-Gm-Message-State: AOAM531BJFE9fBP7rjvcxUnkfUyUbHFzlxK55pxZuRhrkEI+NWh5rnLC
 AipH/zFX30tPI3lnP/u1WVB7xflKX3bvApe2TSKbbfNfL3WKyUKkmsdebSiNk0e43BJl1kxf+/E
 h4qM3TQpXPqkQrIUfPP9FoQyGStiGRUv2pMZzlAC9BQ==
X-Received: by 2002:a05:6402:40d0:: with SMTP id
 z16mr8908897edb.68.1642164339318; 
 Fri, 14 Jan 2022 04:45:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSRH3o6ei5Mw5iW6zgvruyjrCJ+sESmB6gyoqBksqi4jGepcg7bQdBJV7nxJYFL4y7oZRihw==
X-Received: by 2002:a05:6402:40d0:: with SMTP id
 z16mr8908884edb.68.1642164339134; 
 Fri, 14 Jan 2022 04:45:39 -0800 (PST)
Received: from redhat.com ([2.55.154.210])
 by smtp.gmail.com with ESMTPSA id j5sm1815651ejo.171.2022.01.14.04.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 04:45:38 -0800 (PST)
Date: Fri, 14 Jan 2022 07:45:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v1] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220114074454-mutt-send-email-mst@kernel.org>
References: <20220114090508.36416-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220114090508.36416-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Jan 14, 2022 at 10:05:08AM +0100, Stefano Garzarella wrote:
> In vhost_enable_notify() we enable the notifications and we read
> the avail index to check if new buffers have become available in
> the meantime.
> 
> We are not caching the avail index, so when the device will call
> vhost_get_vq_desc(), it will find the old value in the cache and
> it will read the avail index again.
> 
> It would be better to refresh the cache every time we read avail
> index, so let's change vhost_enable_notify() caching the value in
> `avail_idx` and compare it with `last_avail_idx` to check if there
> are new buffers available.
> 
> Anyway, we don't expect a significant performance boost because
> the above path is not very common, indeed vhost_enable_notify()
> is often called with unlikely(), expecting that avail index has
> not been updated.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

... and can in theory even hurt due to an extra memory write.
So ... performance test restults pls?

> ---
> v1:
> - improved the commit description [MST, Jason]
> ---
>  drivers/vhost/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..07363dff559e 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2543,8 +2543,9 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  		       &vq->avail->idx, r);
>  		return false;
>  	}
> +	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
>  
> -	return vhost16_to_cpu(vq, avail_idx) != vq->avail_idx;
> +	return vq->avail_idx != vq->last_avail_idx;
>  }
>  EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
