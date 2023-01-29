Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4008C05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 17:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EAD681773;
	Sun, 29 Jan 2023 17:58:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EAD681773
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aF/YiOSo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kb2-g3ONDf2R; Sun, 29 Jan 2023 17:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B2D8181389;
	Sun, 29 Jan 2023 17:58:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2D8181389
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 803D3C0033;
	Sun, 29 Jan 2023 17:58:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D085C002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 17:58:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE29E60A77
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 17:58:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE29E60A77
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=aF/YiOSo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sUWsllKAzazN
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 17:58:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E01CC60A6B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E01CC60A6B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675015095;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZoRK9BZ3t2Wi1ix9FutdV7vK4dm+2rgUqjlwcOivCI=;
 b=aF/YiOSop+/Fee+t9t4hOrRj7QczYpN9w3FYcGdbIamqL1LnwGVsT/wXPxReqbXB+14uAl
 pvuK/ESRut2fMw11XMu+RcKNegx3s/gE1oBnLxcGfHqKTS6wSfiZ54fvG+4MG8hqwxfG6D
 juivDMGSxs8zXHV7L7TDcJBU1BLpUJA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-2QXVPaZgOFyfLcrs1HWaLQ-1; Sun, 29 Jan 2023 12:58:13 -0500
X-MC-Unique: 2QXVPaZgOFyfLcrs1HWaLQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 d3-20020a05620a140300b00710ab2b0a32so6157211qkj.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 09:58:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZoRK9BZ3t2Wi1ix9FutdV7vK4dm+2rgUqjlwcOivCI=;
 b=HM+x4fVN8Mr3Npgr1nqHsSqYKrZEfsBGE+trRZHd2SKfV6SAodChtXxdA60ExvA3r2
 ME2fCEAlgbEnra+JphULDx+Zc4nap/96QRc0kyiAv1dcCjw8CNlOnQtqHD8RkK4ysvRD
 n+gF8eHmpvybJklpgUToVIjmX4UqOKmy6XB8+huOnjXja+OnqkvZoaVqAhor9yvo4d0t
 ZZH1ggyD0tfXGTnmmymf/yWi8u+20NXjZZ/i9pFWxkebyxcFn1ksdTcKAWVkdrLwUYWZ
 D8BUiV+XAdc2nsbd+oMDeJiBU6lNNQKGDzABWmoMjYmwU5suyq2GWplIrqN/cyeK8uL2
 WycA==
X-Gm-Message-State: AO0yUKXN1UaXczsDYdSV7IUvci8GEOBY33CWoRIGwJFTUURdaLcvbvL6
 uWBbFB4juCVfSEQYdODkj/k0jmiqUiErhVdXEKHxCmVOhnkSmGea3FTtww4C9jE491PZFiJfLxu
 SuvMci0040WUc414EFMOGUCfYa9lz37GpwLQD2vpTpA==
X-Received: by 2002:ac8:5f50:0:b0:3b8:2a6c:d1e4 with SMTP id
 y16-20020ac85f50000000b003b82a6cd1e4mr14798117qta.23.1675015093414; 
 Sun, 29 Jan 2023 09:58:13 -0800 (PST)
X-Google-Smtp-Source: AK7set81mP2q7yHpiOp5TTYBWsJ3krnk4K3MhdR8gsDVQLP3L1zEgo8bkLBq0lFX+0cwwTn5XuracA==
X-Received: by 2002:ac8:5f50:0:b0:3b8:2a6c:d1e4 with SMTP id
 y16-20020ac85f50000000b003b82a6cd1e4mr14798091qta.23.1675015093057; 
 Sun, 29 Jan 2023 09:58:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t3-20020ac86a03000000b003a591194221sm4257080qtr.7.2023.01.29.09.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Jan 2023 09:58:12 -0800 (PST)
Message-ID: <3fe5971a-5991-488f-cef5-473c9faa1ba1@redhat.com>
Date: Sun, 29 Jan 2023 18:58:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 0/2] vhost/net: Clear the pending messages when the
 backend is removed
To: eric.auger.pro@gmail.com, mst@redhat.com, jasowang@redhat.com,
 kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org
References: <20230117151518.44725-1-eric.auger@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230117151518.44725-1-eric.auger@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: lvivier@redhat.com
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

On 1/17/23 16:15, Eric Auger wrote:
> When the vhost iotlb is used along with a guest virtual iommu
> and the guest gets rebooted, some MISS messages may have been
> recorded just before the reboot and spuriously executed by
> the virtual iommu after the reboot. This is due to the fact
> the pending messages are not cleared.
>
> As vhost does not have any explicit reset user API,
> VHOST_NET_SET_BACKEND looks a reasonable point where to clear
> the pending messages, in case the backend is removed (fd = -1).
>
> This version is a follow-up on the discussions held in [1].
>
> The first patch removes an unused 'enabled' parameter in
> vhost_init_device_iotlb().

Gentle Ping. Does it look a reasonable fix now?

Thanks

Eric
>
> Best Regards
>
> Eric
>
> History:
> [1] RFC: [RFC] vhost: Clear the pending messages on vhost_init_device_iotlb()
> https://lore.kernel.org/all/20221107203431.368306-1-eric.auger@redhat.com/
>
> Eric Auger (2):
>   vhost: Remove the enabled parameter from vhost_init_device_iotlb
>   vhost/net: Clear the pending messages when the backend is removed
>
>  drivers/vhost/net.c   | 5 ++++-
>  drivers/vhost/vhost.c | 5 +++--
>  drivers/vhost/vhost.h | 3 ++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
