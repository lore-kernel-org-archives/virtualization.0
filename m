Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65344C433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 21:10:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3E214031D;
	Mon,  7 Nov 2022 21:10:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D3E214031D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bVinNVcv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wS1NVPl5K3B2; Mon,  7 Nov 2022 21:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 318D0402BA;
	Mon,  7 Nov 2022 21:10:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 318D0402BA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CF92C0032;
	Mon,  7 Nov 2022 21:10:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6323FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 21:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 292604031F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 21:10:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 292604031F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bVinNVcv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37JR6bhLol3U
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 21:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71F9040012
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71F9040012
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 21:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667855418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S5uHAm/YMaHSV2rOFAm9u7M75Iy7HbODE/InmExnaAE=;
 b=bVinNVcvFpV+7LwtIAjQkg9hvylVTstUCyMdxCPgTPV+MiqxzuWWVg+5Z/FwFQs+2k9Y0v
 qqb5qt0kVch9Z6TSw/7R5et54HQTMMQV+6IoyM4OVmiTwBneWY4zMHrs8r8Dv9+Y7fawxz
 pQjVUaLpltarRnoyvhDOKqtGmv7uS4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-14-8fwAiAN5NKKJ5oszU8opkg-1; Mon, 07 Nov 2022 16:10:09 -0500
X-MC-Unique: 8fwAiAN5NKKJ5oszU8opkg-1
Received: by mail-wm1-f71.google.com with SMTP id
 c10-20020a7bc84a000000b003cf81c2d3efso3440186wml.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Nov 2022 13:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S5uHAm/YMaHSV2rOFAm9u7M75Iy7HbODE/InmExnaAE=;
 b=ZHP+b+mv1hlp3eGXM6+ialEUmcnoKpoRk17kfg6xADVLrlD3lPdlZ+5kbOX1gukEAG
 5SBWWC0wRtlQUZwtsC0hRNTEGsfWGsKijoEwIDh7u+1T6l99HvWncYfYVtPreNX5/Cly
 W3+vl0OJ/LSCe9MSGxlbE5erDOhU8xkGRkZXhYKVDREQqstJPIKGfcHqYsejB5fCPOww
 MDnC/uZv+rvWszuHQ9VLBuN+AY5D/sxjxx/h3Ggu3zgglbe+hSg9FEq2orNXsXeLj7TK
 Pns+/ossy21c9M569wmSWNIXJy2EqQrSU1yASb8TPorJP0WiOg5OjLS2kwuzmw6lSWOx
 kPkg==
X-Gm-Message-State: ACrzQf0qESusT5YFbwxvK7Tz7ZkYiasCUuUIc5hrRKU6/9ikVV3D1XMA
 V7X+BeZGmut2tRFdIhkXuF/35uYfW/rUI2jXzBuG2iqJP9Ji/+wPzUwQBHyOzrAt8w3i6W1/RGv
 c7hFZJAa8kiKRs1AnNt6h2ydeE48xT2XyuO0+5Ct6aw==
X-Received: by 2002:a5d:4b45:0:b0:236:501f:7a41 with SMTP id
 w5-20020a5d4b45000000b00236501f7a41mr33248881wrs.516.1667855408485; 
 Mon, 07 Nov 2022 13:10:08 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7OiDI4F9MI4Y77S9G7vRAA8ji/J8GVqtN7aNFdugsfuItxHBGzX5veSqv7kZTArZsQcUceGA==
X-Received: by 2002:a5d:4b45:0:b0:236:501f:7a41 with SMTP id
 w5-20020a5d4b45000000b00236501f7a41mr33248873wrs.516.1667855408285; 
 Mon, 07 Nov 2022 13:10:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 i5-20020adffc05000000b0023660f6cecfsm8312230wrr.80.2022.11.07.13.10.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Nov 2022 13:10:07 -0800 (PST)
Message-ID: <b8487793-d7b8-0557-a4c2-b62754e14830@redhat.com>
Date: Mon, 7 Nov 2022 22:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] vhost: Clear the pending messages on
 vhost_init_device_iotlb()
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221107203431.368306-1-eric.auger@redhat.com>
 <20221107153924-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20221107153924-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Michael,
On 11/7/22 21:42, Michael S. Tsirkin wrote:
> On Mon, Nov 07, 2022 at 09:34:31PM +0100, Eric Auger wrote:
>> When the vhost iotlb is used along with a guest virtual iommu
>> and the guest gets rebooted, some MISS messages may have been
>> recorded just before the reboot and spuriously executed by
>> the virtual iommu after the reboot. Despite the device iotlb gets
>> re-initialized, the messages are not cleared. Fix that by calling
>> vhost_clear_msg() at the end of vhost_init_device_iotlb().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  drivers/vhost/vhost.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>> index 40097826cff0..422a1fdee0ca 100644
>> --- a/drivers/vhost/vhost.c
>> +++ b/drivers/vhost/vhost.c
>> @@ -1751,6 +1751,7 @@ int vhost_init_device_iotlb(struct vhost_dev *d, bool enabled)
>>  	}
>>  
>>  	vhost_iotlb_free(oiotlb);
>> +	vhost_clear_msg(d);
>>  
>>  	return 0;
>>  }
> Hmm.  Can't messages meanwhile get processes and affect the
> new iotlb?
Isn't the msg processing stopped at the moment this function is called
(VHOST_SET_FEATURES)?

Thanks

Eric
>
>
>> -- 
>> 2.37.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
