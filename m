Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A46C433C1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3F861932
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 09:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3F861932
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77083606DE;
	Mon, 29 Mar 2021 09:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4t6Br3-5Bt4v; Mon, 29 Mar 2021 09:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18460606CC;
	Mon, 29 Mar 2021 09:05:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDCC0C000B;
	Mon, 29 Mar 2021 09:05:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD2FC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43D8283521
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfkNoyqEWC4r
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:05:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3171783518
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617008700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRHZbctdvU5CldfExqqxh/W48hH/Hyg8pzA6KkszOzU=;
 b=Iy+e7Mvlk2WidXFs4eeK3wC0uOSx/8v73BkggVn073lX8b36xYTZNlWjP9LRY6b4vb/+2B
 iEnGTSwJIdcuSA2w/XOu4kW5SL5TAnVzme6rYqr/gAtUjPFmbbiTzDJM7XWSy7k46SwZTZ
 5BRTHM6tQi1/LgzenvUGI29Dw+FZ0M8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-QNjbounNOPK8-daY-yLZAw-1; Mon, 29 Mar 2021 05:04:55 -0400
X-MC-Unique: QNjbounNOPK8-daY-yLZAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3D28189C8;
 Mon, 29 Mar 2021 09:04:53 +0000 (UTC)
Received: from [10.36.114.205] (ovpn-114-205.ams2.redhat.com [10.36.114.205])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 751F960864;
 Mon, 29 Mar 2021 09:04:48 +0000 (UTC)
Subject: Re: [PATCH] virtio-balloon: fix a typo in comment of
 virtballoon_migratepage()
To: Liu Xiang <liu.xiang@zlingsmart.com>, mst@redhat.com
References: <20210327031710.16151-1-liu.xiang@zlingsmart.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <57a2d4ed-88d7-332b-6c3e-2f39b8902ace@redhat.com>
Date: Mon, 29 Mar 2021 11:04:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210327031710.16151-1-liu.xiang@zlingsmart.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: liuxiang_1999@126.com, liuxiang1999@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On 27.03.21 04:17, Liu Xiang wrote:
> Typo: compation --> compaction
> 
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> ---
>   drivers/virtio/virtio_balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7da25b87f..c25665802 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -734,7 +734,7 @@ static void report_free_page_func(struct work_struct *work)
>   #ifdef CONFIG_BALLOON_COMPACTION
>   /*
>    * virtballoon_migratepage - perform the balloon page migration on behalf of
> - *			     a compation thread.     (called under page lock)
> + *			     a compaction thread.     (called under page lock)
>    * @vb_dev_info: the balloon device
>    * @newpage: page that will replace the isolated page after migration finishes.
>    * @page   : the isolated (old) page that is about to be migrated to newpage.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
