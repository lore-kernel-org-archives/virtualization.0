Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB6C433F5
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 07:47:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2317D402C6;
	Wed, 19 Jan 2022 07:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R4BYGNwSLOK1; Wed, 19 Jan 2022 07:47:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C3F7D4025A;
	Wed, 19 Jan 2022 07:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9563AC0039;
	Wed, 19 Jan 2022 07:47:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0195C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5AB960EA0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZnvHiWiCy9l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:47:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E91160D51
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642578426;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paEg0PBs7iLtMrdDtLrjdBlDCpFPGAaqQrFZgy+DzH0=;
 b=Z5bsa9VIW27gT6l7cjCpaNgrz+6sPH4kf8+0qRfVgvkuJhYW04vMcSXGGYEfmzxoRcVqzH
 gYhlrv1XCr24L99DgkOKe4X6iKjlaJPr42vUgBTy4BFBD5QTSTKKpv6Va1J99H15Yom0ge
 lE2/44PiOga4KAgcw9oY73xKi7dBes4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-128-a9DXM-kjPMy0MvSH_RGiWQ-1; Wed, 19 Jan 2022 02:47:01 -0500
X-MC-Unique: a9DXM-kjPMy0MvSH_RGiWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 968E51091DA2;
 Wed, 19 Jan 2022 07:46:59 +0000 (UTC)
Received: from [10.72.13.249] (ovpn-13-249.pek2.redhat.com [10.72.13.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7072010589B5;
 Wed, 19 Jan 2022 07:46:28 +0000 (UTC)
Subject: Re: [PATCH v3] drivers/virtio: Enable virtio mem for ARM64
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220119010551.181405-1-gshan@redhat.com>
 <20220119022611-mutt-send-email-mst@kernel.org>
From: Gavin Shan <gshan@redhat.com>
Message-ID: <d8cedad1-bbb6-b7ea-57b2-f3832776fe1e@redhat.com>
Date: Wed, 19 Jan 2022 15:46:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20220119022611-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jonathan.Cameron@huawei.com, shan.gavin@gmail.com,
 linux-arm-kernel@lists.infradead.org,
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
Reply-To: Gavin Shan <gshan@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,

On 1/19/22 3:39 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 19, 2022 at 09:05:51AM +0800, Gavin Shan wrote:
>> This enables virtio-mem device support by allowing to enable the
>> corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
>> architecture.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v3: Pick ack-by tags from Jonathan and Michael
>> ---
>>   drivers/virtio/Kconfig | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index 34f80b7a8a64..74c8b0c7bc33 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -106,7 +106,7 @@ config VIRTIO_BALLOON
>>   config VIRTIO_MEM
>>   	tristate "Virtio mem driver"
>>   	default m
>> -	depends on X86_64
>> +	depends on X86_64 || ARM64
>>   	depends on VIRTIO
>>   	depends on MEMORY_HOTPLUG
>>   	depends on MEMORY_HOTREMOVE
>> @@ -116,8 +116,9 @@ config VIRTIO_MEM
>>   	 This driver provides access to virtio-mem paravirtualized memory
>>   	 devices, allowing to hotplug and hotunplug memory.
>>   
>> -	 This driver was only tested under x86-64, but should theoretically
>> -	 work on all architectures that support memory hotplug and hotremove.
>> +	 This driver was only tested under x86-64 and arm64, but should
>> +	 theoretically work on all architectures that support memory hotplug
>> +	 and hotremove.
>>   
> 
> BTW isn't there a symbol saying "memory hotplug" that we can depend on?
> 

You mean to change it like below? Actually, both looks good
to me :)

  +	 This driver was only tested under x86-64 and arm64, but should
  +	 theoretically work on all architectures.
  
>>   	 If unsure, say M.
>>   

Thanks,
Gavin

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
