Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECE7C43217
	for <virtualization@archiver.kernel.org>; Thu,  1 Dec 2022 09:24:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 184B34081F;
	Thu,  1 Dec 2022 09:24:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 184B34081F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i79MeBNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCmEEtpY7x-C; Thu,  1 Dec 2022 09:24:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5454A40342;
	Thu,  1 Dec 2022 09:24:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5454A40342
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CC6C0032;
	Thu,  1 Dec 2022 09:24:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B1D6C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:24:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6ED4360E1A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:24:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6ED4360E1A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i79MeBNv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kPwG7TR5CaAN
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:24:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 328A460E02
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 328A460E02
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Dec 2022 09:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669886649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgJ+HDh8KhhTBQLgmfONT+YSYAYl+JCf9dmOxyoPJKY=;
 b=i79MeBNvI/JFdzPcfkO6kYw6msDYcUnbWbam7zlQt47fhSazMpKx40RrUmPO+uIhLZVcB8
 13yaFibwBLjNlTSYn/Pr3T1LQ5hSLYxMWg6K4KiWmFjBTlrES01fjmQGGF/CS2cdx2G0/7
 Njz4Gv2yI2o/gOlR2wKWGqBqXhZ28M0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-526-9xa3DJAiMC2d4M8kBfBfmA-1; Thu, 01 Dec 2022 04:24:06 -0500
X-MC-Unique: 9xa3DJAiMC2d4M8kBfBfmA-1
Received: by mail-wm1-f71.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso594398wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Dec 2022 01:24:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgJ+HDh8KhhTBQLgmfONT+YSYAYl+JCf9dmOxyoPJKY=;
 b=QwDcplszT90gGDoF8GIsAYHTy+pJRfDHbBks1MPTwUGCuUk39YUDl2cc1jyhUTh/58
 zUYsRqCkgpmlD3RuBqtoTnUYTks0csO4gB+C+MYAcDml68PMiGLHEPYJRns58LG4SWwr
 c9/mwp+iSBvSpA65G3HwAueKdn56zRACyl/lQekGHstEBBVdmyfcM+CaQhHkUMgXc7qQ
 /sCiJpv/QhjXqrJSNv6ltuXrcy0Ac7lJSmzbxSrJ2f2L52sqSUw8v+MomUGQgesM17oe
 wfeHZ+JZUc3VcMm8vxyLmBcMxgBefAimndZ53+17fZU6lZmw5mCJ4lE+/FdFw7s35tDD
 I/XQ==
X-Gm-Message-State: ANoB5plIYX6o0EOa44dYJOtpDOPm2WykLtqBHAwyAWbr0kmMR/FTVwV9
 o0faODGOGMario4G98+BSbGo6phUPLmi6aXE/R/cARDcXp44tsMJ6zqCrRlUZmEecE7Gnuau1Wv
 mvwaTUqkkRW0xe9pdVNwCal3kgumAUfH98RDfIh6Y6g==
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id
 c11-20020a5d4ccb000000b00236d6114fcfmr29574592wrt.192.1669886645079; 
 Thu, 01 Dec 2022 01:24:05 -0800 (PST)
X-Google-Smtp-Source: AA0mqf51AfiJW8ivh3gMCG70OBpMd9MsL8P1xJEHEG5W9Kg8EmdeOizi/C3u9PaCATJ6V1Bz8hc4Hw==
X-Received: by 2002:a5d:4ccb:0:b0:236:d611:4fcf with SMTP id
 c11-20020a5d4ccb000000b00236d6114fcfmr29574568wrt.192.1669886644807; 
 Thu, 01 Dec 2022 01:24:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 l5-20020a5d5605000000b002367ad808a9sm3868673wrv.30.2022.12.01.01.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Dec 2022 01:24:04 -0800 (PST)
Date: Thu, 1 Dec 2022 10:23:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [RFC PATCH v2 2/6] hv_sock: always return ENOMEM in case of error
Message-ID: <20221201092330.ia5addl4sgw7fhk2@sgarzare-redhat>
References: <9d96f6c6-1d4f-8197-b3bc-8957124c8933@sberdevices.ru>
 <a10ffbed-848d-df8c-ec4e-ba25c4c8e3e8@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <a10ffbed-848d-df8c-ec4e-ba25c4c8e3e8@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Nov 25, 2022 at 05:05:53PM +0000, Arseniy Krasnov wrote:
>From: Bobby Eshleman <bobby.eshleman@bytedance.com>
>
>This saves original behaviour from af_vsock.c - switch any error
>code returned from transport layer to ENOMEM.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/hyperv_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index 59c3e2697069..fbbe55133da2 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -687,7 +687,7 @@ static ssize_t hvs_stream_enqueue(struct vsock_sock *vsk, struct msghdr *msg,
> 	if (bytes_written)
> 		ret = bytes_written;
> 	kfree(send_buf);
>-	return ret;
>+	return ret < 0 ? -ENOMEM : ret;

I'm not sure for hyperv we want to preserve -ENOMEM. This transport was 
added after virtio-vsock, so I think we can return the error directly.

@Dexuan what do you think?

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
