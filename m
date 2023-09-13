Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDB9EDEC4D
	for <virtualization@archiver.kernel.org>; Wed, 13 Sep 2023 14:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D60404169B;
	Wed, 13 Sep 2023 14:00:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D60404169B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7uDJWXo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GxxM9zX4D4SL; Wed, 13 Sep 2023 14:00:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C246408FC;
	Wed, 13 Sep 2023 14:00:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C246408FC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11427C0071;
	Wed, 13 Sep 2023 14:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0AF32C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 14:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA4C9401D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 14:00:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA4C9401D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7uDJWXo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P17xPLWgIC3b
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 14:00:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D767540149
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 14:00:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D767540149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694613616;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
 b=f7uDJWXocdSdxSi01LBbpU9Gug9cJqjLhjQu7VUb4i18EyTP1zoQCoSyVVap4jc0r1LMRe
 7t4E+N3/5gF46ASoN0WP4+GWS13UDt+cAR7ZKo/cmvhCTAFTczmwCfly9fgUQ6NFgMrEp9
 aoA1EttclfYB9CylAcvMFc+khJ1/jOM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ytsKe7KXNfqywAPegXm07w-1; Wed, 13 Sep 2023 10:00:13 -0400
X-MC-Unique: ytsKe7KXNfqywAPegXm07w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76efd8bf515so66974085a.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694613613; x=1695218413;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1yK3xgmt1aeFdUkAxw9Y0+ZQFHP2f+qkDkwODsKtQl0=;
 b=Bjez6P0qLVCp0kOyiOi5xavhd2Es1D62MTNEB2yWdRoqxQ6Ece33oZPzYhJ/NnPzYi
 GnZN+JIA7k6CDCZeqI9WqQj97ueudHSOPrkO6+2vnmybsEdvWn/MJYmBpifSZFJsjarq
 vyW5dQ2qhXpFGY8gsC6dsPNoY96iIMDr0AAaOwiW461YDCo1ZfFrvE6pws4btqmKNfK4
 wMYJsaLtOstqO3Q2cqzn7PprvmjFBRyOW2vmEsX6lsKWPmmsnn1PXZP+pHLjdsbhPScZ
 jVvZZBPXWRGeKxR2sucxDn+KEMAiOzSxAtdR105MvWOYy2yye4TKizHpb7BYiKrT3YgX
 2z8w==
X-Gm-Message-State: AOJu0Yz28CVBObTWHRYKGphUt/JywS4fMi0sgGBuJ+OSQCg0asKpocHn
 EzvdlNipe0NHGi12tb7hlaBsaPnJVwOSwAy8Yg9zKF4aOJh/6zGyi7lwRTJpnR3j2gx6KQDo28j
 qndEOn5uBAZIy2Tsblon5SXrygmRuscEO2C/Lisu8VQ==
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id
 y3-20020a05620a44c300b0076ef686cad8mr7244558qkp.13.1694613613039; 
 Wed, 13 Sep 2023 07:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfk9vTwiioPzhJO0D1j6+0LQmPdk1mn8JxTGfaPUXi0LyXZ0YuCSf940L14zsRR6mW81HaUA==
X-Received: by 2002:a05:620a:44c3:b0:76e:f686:cad8 with SMTP id
 y3-20020a05620a44c300b0076ef686cad8mr7244535qkp.13.1694613612753; 
 Wed, 13 Sep 2023 07:00:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a0cf1c9000000b00653589babcbsm4456536qvl.87.2023.09.13.07.00.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 07:00:11 -0700 (PDT)
Message-ID: <bed381a8-7d3d-d596-bc88-6ff8a7a5a33b@redhat.com>
Date: Wed, 13 Sep 2023 16:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] vhost: Allow null msg.size on VHOST_IOTLB_INVALIDATE
To: eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
 jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
References: <20230824093722.249291-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230824093722.249291-1-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: stable@vger.kernel.org
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi,

On 8/24/23 11:37, Eric Auger wrote:
> Commit e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb
> entries") Forbade vhost iotlb msg with null size to prevent entries
> with size = start = 0 and last = ULONG_MAX to end up in the iotlb.
>
> Then commit 95932ab2ea07 ("vhost: allow batching hint without size")
> only applied the check for VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE
> message types to fix a regression observed with batching hit.
>
> Still, the introduction of that check introduced a regression for
> some users attempting to invalidate the whole ULONG_MAX range by
> setting the size to 0. This is the case with qemu/smmuv3/vhost
> integration which does not work anymore. It Looks safe to partially
> revert the original commit and allow VHOST_IOTLB_INVALIDATE messages
> with null size. vhost_iotlb_del_range() will compute a correct end
> iova. Same for vhost_vdpa_iotlb_unmap().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: e2ae38cf3d91 ("vhost: fix hung thread due to erroneous iotlb entries")
> Cc: stable@vger.kernel.org # v5.17+
> Acked-by: Jason Wang <jasowang@redhat.com>

Gentle ping for this fix? Any other comments besides Jason's A-b?

Best Regards

Eric
>
> ---
> v1 -> v2:
> - Added Cc stable and Jason's Acked-by
> ---
>  drivers/vhost/vhost.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c71d573f1c94..e0c181ad17e3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1458,9 +1458,7 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
>  
> -	if ((msg.type == VHOST_IOTLB_UPDATE ||
> -	     msg.type == VHOST_IOTLB_INVALIDATE) &&
> -	     msg.size == 0) {
> +	if (msg.type == VHOST_IOTLB_UPDATE && msg.size == 0) {
>  		ret = -EINVAL;
>  		goto done;
>  	}

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
