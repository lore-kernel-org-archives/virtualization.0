Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6059BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 05:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF64C8138E;
	Tue, 10 May 2022 05:22:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkhjgQMHoOPn; Tue, 10 May 2022 05:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CDE5813A0;
	Tue, 10 May 2022 05:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51D65C0032;
	Tue, 10 May 2022 05:22:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 415B2C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 05:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A54560AB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 05:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yudVGnOWq07V
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 05:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0929F60A9E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 05:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652160160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSBUCgbnrXyS4xiqIulcu9NB35K8gsqks7zGiCMctnI=;
 b=eMvvOnxZVju0Qn/r4vabodhWw/ZaQUWPlheooLgW4Uq1uxgnqxIOgToaP+fJm2ivnrSVaw
 bKpcOF7G3sr9Q7yZXi/KiFROxmY5k3Xlopim1Pot1sZ7wC0vJvexaa1vro+iggkJ8qzTDi
 EF6obd0htx4l9Ck1LEbEGT84OgYHLpE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-Qg1q8J-wMK6vycSWr3J8Lg-1; Tue, 10 May 2022 01:22:39 -0400
X-MC-Unique: Qg1q8J-wMK6vycSWr3J8Lg-1
Received: by mail-wm1-f72.google.com with SMTP id
 k35-20020a05600c1ca300b003946a9764baso740563wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 May 2022 22:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dSBUCgbnrXyS4xiqIulcu9NB35K8gsqks7zGiCMctnI=;
 b=6NgSK7BzBwuhRFeSBiGi5MqlTzspDrmg6XrgE2yMtzeRcRST1uAQ4ehBc6WnrKb9LH
 mC7x5AUjHOQdo9c3PiMDWgA300w/GdGCUD2jTDg6oT8rMF8I1rfbzDAZHejTuopdLkiA
 Jt2oNTaKtj0cjcQ0LzjrDwlDGu5LSaTPNg88WsUEOs/YOkyQ12lRF/t3QBKbK7r1+yF4
 T528SpdzpZVL4y1HsS36pZ9y6MRR4bb+jvbJ4y7t133h0hnAezm1cC9mfmvQ9Z/pz/lZ
 o9Wxsqj3kcc1ScC8H5eZhM/sC2wVX9F/KEAQvDrzBzkGB90BWi/UkxUKu4OIGeXD2oO7
 lrCw==
X-Gm-Message-State: AOAM533wt+Gl0jf5lTu6BzM4e4K/rkwRUON59MhDNlIKr3SJkyN2kidU
 9783MvPatZ82vfVSkGEddQcF08vqZF5gOXrKL3dN4miQ5R15N3D1E8YdvluwAa0lP72YriD7L05
 BEXLYAUrhAB/q56JRFi4ZfGAP/DkNmtLYBlN6+yqJPA==
X-Received: by 2002:a05:600c:378b:b0:394:3894:3a65 with SMTP id
 o11-20020a05600c378b00b0039438943a65mr19610047wmr.18.1652160158254; 
 Mon, 09 May 2022 22:22:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhdbrn6t2cTRanVgLinK3hRXX7cC5Jz0nyau26pq9cmJz/uWA/9EYU3xUh3J1fN8kX9UjBNA==
X-Received: by 2002:a05:600c:378b:b0:394:3894:3a65 with SMTP id
 o11-20020a05600c378b00b0039438943a65mr19610035wmr.18.1652160158047; 
 Mon, 09 May 2022 22:22:38 -0700 (PDT)
Received: from redhat.com ([2.55.130.230]) by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0020c5253d8d9sm12974968wrx.37.2022.05.09.22.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 May 2022 22:22:37 -0700 (PDT)
Date: Tue, 10 May 2022 01:22:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tang Bin <tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] virtio_net: Remove unused case in virtio_skb_set_hash()
Message-ID: <20220510012221-mutt-send-email-mst@kernel.org>
References: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
In-Reply-To: <20220509131432.16568-1-tangbin@cmss.chinamobile.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
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

On Mon, May 09, 2022 at 09:14:32PM +0800, Tang Bin wrote:
> In this function, "VIRTIO_NET_HASH_REPORT_NONE" is included
> in "default", so it canbe removed.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

What's the point of this?

> ---
>  drivers/net/virtio_net.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 87838cbe3..b3e5d8637 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1172,7 +1172,6 @@ static void virtio_skb_set_hash(const struct virtio_net_hdr_v1_hash *hdr_hash,
>  	case VIRTIO_NET_HASH_REPORT_IPv6_EX:
>  		rss_hash_type = PKT_HASH_TYPE_L3;
>  		break;
> -	case VIRTIO_NET_HASH_REPORT_NONE:
>  	default:
>  		rss_hash_type = PKT_HASH_TYPE_NONE;
>  	}
> -- 
> 2.20.1.windows.1
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
