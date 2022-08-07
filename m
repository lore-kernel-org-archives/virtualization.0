Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677BDC19F2A
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 23:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E424C60BF9;
	Sun,  7 Aug 2022 23:01:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E424C60BF9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBGl4atG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q_GpOzt49YnO; Sun,  7 Aug 2022 23:01:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5CD7E60BFB;
	Sun,  7 Aug 2022 23:01:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5CD7E60BFB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F89C0032;
	Sun,  7 Aug 2022 23:01:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43638C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 23:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F270B828C5
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 23:01:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F270B828C5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBGl4atG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6zD2CGjcfmiD
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 23:01:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BFA4813EE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BFA4813EE
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 23:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659913260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
 b=YBGl4atGeiXVYsj2PNhGO0iKoQbq29/hPph7No4EOhp7La7XdA2KDv+sBAt0sG5EPIrbKG
 sGjt2BREDcesF6QW4Q3UOKOTZXhVKN14UlVcp65RLVYgkU64XH+Xo9GgZ0MNIpNznYeB+R
 FPgffwF9vaB32kKo0YMb3iyobikVXz4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125--E77AKzbNNiaViyvJnaeTQ-1; Sun, 07 Aug 2022 19:00:59 -0400
X-MC-Unique: -E77AKzbNNiaViyvJnaeTQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i10-20020a1c3b0a000000b003a537064611so1497024wma.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 Aug 2022 16:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Wk/43vXNo+gPgeJbUofxRngA+x+b00pdU9F/OSmIEJg=;
 b=iaatm8Ak+b4IbvqCBlR4LsmMD1M9//TCIC/fNrN4bkEAjTLkFwZgWLEgBnB+D5gXhW
 5/tEO66ab6kvNTee2owxrkwRSbFeKndvZF42003j/qGqoXwrssFBS9s9mQdHr1aXPF7G
 0srUA6JSGONd2YGpUd/DKXx2QInljtUEkXp5DcQ8ZRrebOOnUVp/dBSFaX5ggKA1DdfK
 tNrxCK5NxWhLgpsWbdYwE/NfmQ0itPEJ+tsyQnjmNpSp2P2UA36Uu3U+Otmbsxaa53az
 PxcopAe10mMDo5HhwGDxsa4kdJJ9RQ7SufXIpWSLYJWzQlG71FC6x2Ka4prRVh/ZC/yK
 fQ9w==
X-Gm-Message-State: ACgBeo1t6ogXcNjvRpcCNNXCC9R4kacvpJBsWbEkDwyh9hwnw5QN++pj
 zSQhsaClQe5VDOkKrrKfC28lSu2u9wUxzmUx8Nm7Miq8VK86OdSUMW001fNg/IQDks9dI90gd0I
 5AmV9dIvSXzCk1EEtYMqwRn2+KVO98+qhVCu/VboT6g==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id
 t17-20020adfe111000000b0021d665e2fa5mr10319211wrz.652.1659913258513; 
 Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR77jXqn3s6KfigLdRwFaDgPm/WuGZ/eUbqehSUKychxT4mkfEwdiEmUEE/nolidYa5kAcIEuw==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id
 t17-20020adfe111000000b0021d665e2fa5mr10319205wrz.652.1659913258316; 
 Sun, 07 Aug 2022 16:00:58 -0700 (PDT)
Received: from redhat.com ([2.52.21.123]) by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c210700b003a3561d4f3fsm916915wml.43.2022.08.07.16.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Aug 2022 16:00:57 -0700 (PDT)
Date: Sun, 7 Aug 2022 19:00:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220807185846-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
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

On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure:
> 
>     struct virtio_bt_config {
>         __u8  type;
>         __u16 vendor;
>         __u16 msft_opcode;
>     } __attribute__((packed));
> 
> has both 16bit fields non-aligned.
> 
> This commit fixes it.
> 
> [1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf
> 
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>

This is all true enough, but the problem is
1. changing uapi like this can't be done, will break userspace
2. the driver has more issues and no one seems to want to
   maintain it. 
I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
to merge it for this release.


> ---
>  include/uapi/linux/virtio_bt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/virtio_bt.h b/include/uapi/linux/virtio_bt.h
> index a7bd48daa9a9..adc03709cc4f 100644
> --- a/include/uapi/linux/virtio_bt.h
> +++ b/include/uapi/linux/virtio_bt.h
> @@ -23,9 +23,9 @@ enum virtio_bt_config_vendor {
>  };
>  
>  struct virtio_bt_config {
> -	__u8  type;
>  	__u16 vendor;
>  	__u16 msft_opcode;
> +	__u8  type;
>  } __attribute__((packed));
>  
>  #endif /* _UAPI_LINUX_VIRTIO_BT_H */
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
