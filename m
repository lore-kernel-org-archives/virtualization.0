Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C185C433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 09:38:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2449E818A1;
	Tue, 18 Jan 2022 09:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2MpIhVx6cHB; Tue, 18 Jan 2022 09:38:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D42BF813B2;
	Tue, 18 Jan 2022 09:38:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2D9AC0031;
	Tue, 18 Jan 2022 09:38:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 315ABC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1F97560AB8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUNWC6KPzLMM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C61E606B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642498729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Hg9pRmSj/sRh2rFN8E4oShOToWXhu26wpYjj72aAXc=;
 b=H91EdtTvSTv/tC7lkw3ktlSwGfMowl6uDz53l0YLUif+6L00iB1+t4MMJ205RxzpR0gg2t
 JZ7+k1joP9ETKzHFKXXpjJE0nS1P9Eo23gq0NycHkxmSbilCEAMDm6w4xtFLkpWnYrmsjW
 uKmRhubCvVAsB06WJG7ySYdk3Z6ky8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-AYsLUqlMP2-x9pnIn3ZMQg-1; Tue, 18 Jan 2022 04:38:46 -0500
X-MC-Unique: AYsLUqlMP2-x9pnIn3ZMQg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BE464157;
 Tue, 18 Jan 2022 09:38:44 +0000 (UTC)
Received: from [10.72.13.118] (ovpn-13-118.pek2.redhat.com [10.72.13.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 676F770D3E;
 Tue, 18 Jan 2022 09:38:23 +0000 (UTC)
Subject: Re: [PATCH v2] drivers/virtio: Enable virtio mem for ARM64
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
References: <20220118084858.175305-1-gshan@redhat.com>
Message-ID: <2f0d1a5f-7e75-04b1-f2a1-f52385dae3b5@redhat.com>
Date: Tue, 18 Jan 2022 17:38:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220118084858.175305-1-gshan@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shan Gavin <shan.gavin@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 1/18/22 4:48 PM, Gavin Shan wrote:
> This enables virtio-mem device support by allowing to enable the
> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
> architecture.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
> v2: Improved the comments about the kernel config option (David)
> ---
>   drivers/virtio/Kconfig | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

My git-sendemail should have been broken. A list of receivers are
dropped automatically though they were explicitly specified, but
linux-arm-kernel@lists.infradead.org was missed to be copied.
Fixing all of them through thunderbird :)

Thanks,
Gavin

> 
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 34f80b7a8a64..74c8b0c7bc33 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>   config VIRTIO_MEM
>   	tristate "Virtio mem driver"
>   	default m
> -	depends on X86_64
> +	depends on X86_64 || ARM64
>   	depends on VIRTIO
>   	depends on MEMORY_HOTPLUG
>   	depends on MEMORY_HOTREMOVE
> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>   	 This driver provides access to virtio-mem paravirtualized memory
>   	 devices, allowing to hotplug and hotunplug memory.
>   
> -	 This driver was only tested under x86-64, but should theoretically
> -	 work on all architectures that support memory hotplug and hotremove.
> +	 This driver was only tested under x86-64 and arm64, but should
> +	 theoretically work on all architectures that support memory hotplug
> +	 and hotremove.
>   
>   	 If unsure, say M.
>   
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
