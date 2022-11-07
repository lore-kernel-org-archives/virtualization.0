Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9F2C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 20:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5E488176B;
	Mon,  7 Nov 2022 20:42:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5E488176B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d4qGf+tX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id boXMBMwAao0n; Mon,  7 Nov 2022 20:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 83AB081778;
	Mon,  7 Nov 2022 20:42:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83AB081778
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC38C0033;
	Mon,  7 Nov 2022 20:42:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED257C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 20:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9D1260AB5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 20:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9D1260AB5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d4qGf+tX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qmkmknZTTjoR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 20:42:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F45B600BA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F45B600BA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667853731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=evzlFbUTnO3GwUjJoQCN6EwhyV6gOnjO3o6XcJLyk7g=;
 b=d4qGf+tXu3mowM5l/3r32ObykpmYRaA/ocwXsZMS4JxTlAoQbMQUOvLeFXB9sdZN0O36NK
 bOgoF+GrMAxCWYO3i9qOPdNOWuG0zfDgYxivkPB0hMkk9HWIf03O1zG5bMNGUH+9yUV+fM
 znSoiPfelq1V0/4i15iyhKthN0wteTA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-88WeBKhkOCq6NJcNQboG5Q-1; Mon, 07 Nov 2022 15:42:10 -0500
X-MC-Unique: 88WeBKhkOCq6NJcNQboG5Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 bg21-20020a05600c3c9500b003c2acbff422so43910wmb.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 12:42:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evzlFbUTnO3GwUjJoQCN6EwhyV6gOnjO3o6XcJLyk7g=;
 b=Rq5HY+U1MFrw9NzPGH5RDKxFK0Ss3c/+kmlRDJf7EkIKcjXd6hlpUsUxXrbawmdLxA
 d/Qz3d5u0hjsHrdCQnL2Lh9cHOLzGY9fbEH8UTM6aY1QYXyB6L0rO/ZXUHnlQc34uXwg
 FG8hpeC7su76AQZTi2fcTSfykm4/uQKWs0fwWZUaPzNKI6uN8mIiJQ5muZO6NdRJwe5U
 mGQ+rrLjPRR+5Bjok3E4FZXs/Xokzcfb+EGJeK25RVHavMHMGVY9Oc+4gs8cKXsaLD2F
 7B8MlqFbAHy4ww1/NYDEdesBDU9Ytd2Zxx6WR0Ib1RINQRSKui536LadO4RHdY+BWwBd
 endA==
X-Gm-Message-State: ACrzQf3M1HI4DlyAzRMAHliCyvff3TDxrUz7kFKmVZynAWBE2wzcwsHF
 Q86o28fZcCK+JkxUsCxqdbAYzI+AcV011KqxGw7mVxcOmSrraeMmeBU1f6c+48Elr47NcCNG/1p
 dFWTChfiVpbiEbd3mr7oJzf6zSlupv6pO5RcJqa5ebw==
X-Received: by 2002:a5d:4e88:0:b0:236:590:f5a9 with SMTP id
 e8-20020a5d4e88000000b002360590f5a9mr30678060wru.126.1667853729524; 
 Mon, 07 Nov 2022 12:42:09 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6WrUGrbJ5bDelW9gjzQbAoXk9wPLV0dNxhMA028zBS3d1N8r/SEQc4SPIPfwfT8tBzm7vyBA==
X-Received: by 2002:a5d:4e88:0:b0:236:590:f5a9 with SMTP id
 e8-20020a5d4e88000000b002360590f5a9mr30678048wru.126.1667853729282; 
 Mon, 07 Nov 2022 12:42:09 -0800 (PST)
Received: from redhat.com ([169.150.226.212]) by smtp.gmail.com with ESMTPSA id
 v14-20020adfedce000000b00236883f2f5csm8369250wro.94.2022.11.07.12.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Nov 2022 12:42:08 -0800 (PST)
Date: Mon, 7 Nov 2022 15:42:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
Message-ID: <20221107153924-mutt-send-email-mst@kernel.org>
References: <20221107203431.368306-1-eric.auger@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221107203431.368306-1-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger.pro@gmail.com
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

On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
> When the vhost iotlb is used along with a guest virtual iommu
> and the guest gets rebooted, some MISS messages may have been
> recorded just before the reboot and spuriously executed by
> the virtual iommu after the reboot. Despite the device iotlb gets
> re-initialized, the messages are not cleared. Fix that by calling
> vhost_clear_msg() at the end of vhost_init_device_iotlb().
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/vhost/vhost.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 40097826cff0..422a1fdee0ca 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>  	}
>  
>  	vhost_iotlb_free(oiotlb);
> +	vhost_clear_msg(d);
>  
>  	return 0;
>  }

Hmm.  Can't messages meanwhile get processes and affect the
new iotlb?


> -- 
> 2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
