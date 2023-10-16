Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F6BCDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 07:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B00DE611D2;
	Mon, 16 Oct 2023 07:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B00DE611D2
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vyru7MUz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxmEGHqnwD54; Mon, 16 Oct 2023 07:18:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FAF8610A3;
	Mon, 16 Oct 2023 07:18:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FAF8610A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB22BC0039;
	Mon, 16 Oct 2023 07:18:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41CCDC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1776541523
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:18:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1776541523
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vyru7MUz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id czXM2_zBbjGN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:18:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BFD0B40942
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:18:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFD0B40942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697440691;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
 b=Vyru7MUzdBs0oCRtlD4H//QT/x3vDD9nRYtBJPzX1oStNSOFVCyIakzEpyfqY+L3kyRezA
 cZrFfPV/f3kTI2ERFlBccAez/igT3jiVC1KpKqDSp4KDKjjkmGuSIq3veAUeUrxaEl64aU
 gKa9KZcaWaMJ6q8trOK6KUvlIX0wxpI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Ev0hIxbvPVmNDwwKmScHwQ-1; Mon, 16 Oct 2023 03:18:10 -0400
X-MC-Unique: Ev0hIxbvPVmNDwwKmScHwQ-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-49e0cd82066so1600500e0c.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697440689; x=1698045489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZMH50QiNx/RpA27e+HDzQ/UaGOzrlDiikAqZXGGX460=;
 b=gSv7jyzJToHQ3I3LAkK64xnSZ1QveszhIVVmE53sF92HenIZBcUgnzLqUsRXDxYQaK
 ZmLE04DxlcJ/aLe7i+ZwTuIzuVcNBbmuB6G71mO3vCzdOB1vtm/SB5ZmR5U/aHIrm8kk
 /GNIXMFgr6altk+wnBcGBYcskXGqEEt2x5idm8W/dhwdmSRnWUzMZ51+XUJmoKHmTtHn
 cYu2NIv2080yJEwIYv8poRHwcKGMsLcJ7BNBe/BQ6S/CsTK2JMyDxc77jKyFjP0fMkRE
 xHgc1/wWHQaLvteNCwYmlZihSc3QaMKZHvk6YZPwGJBivDMUSbFuuRjrqYc6Vt/STtR6
 fNaw==
X-Gm-Message-State: AOJu0YyWEOoEbHYGaBolKFcqyvGEyPth3YK5+GlwvOc/yUbq2XuY4rbj
 zRQqE/qa1dli+jYvjNdxM/wZIZCqVgudQf1npylBBlCmtavNHO1LtBy+7s0RwygEWBCm9wdatfF
 0/Eu7oimbefYGoEWzltRwVYDVuHtnZda6gTJU7Naklw==
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id
 c8-20020a056102318800b00457b01c4a8emr8522097vsh.7.1697440689503; 
 Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrYKoQ8rnr5V8nFuKW8RRuaP7a7IwQbOXpJHv3bolS3RrOuy5SapWm+qgVLdmd8Y1bvVE4YA==
X-Received: by 2002:a05:6102:3188:b0:457:b01c:4a8e with SMTP id
 c8-20020a056102318800b00457b01c4a8emr8522084vsh.7.1697440689214; 
 Mon, 16 Oct 2023 00:18:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p17-20020ae9f311000000b00772662b7804sm2784186qkg.100.2023.10.16.00.18.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 00:18:08 -0700 (PDT)
Message-ID: <6b9b570c-8d73-eb64-40a7-fe7492e68be5@redhat.com>
Date: Mon, 16 Oct 2023 09:18:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] vhost: Allow null msg.size on
 VHOST_IOTLB_INVALIDATE
To: eric.auger.pro@gmail.com, elic@nvidia.com, mail@anirudhrb.com,
 jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kvmarm@lists.linux.dev
References: <20230927140544.205088-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230927140544.205088-1-eric.auger@redhat.com>
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

On 9/27/23 16:05, Eric Auger wrote:
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
Gentle Ping.

Thanks

Eric
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
