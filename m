Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6259C433F5
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 15:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D7F141671;
	Thu, 13 Jan 2022 15:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sPyNGxr5nZgK; Thu, 13 Jan 2022 15:45:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B1C134164E;
	Thu, 13 Jan 2022 15:45:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89E9FC0030;
	Thu, 13 Jan 2022 15:45:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E94EDC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:45:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D75184164E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lgXNRIgif7hT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:45:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42EF34164D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642088722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XOQmkcxnHsUnotvr77pJAq4wKyjZXJltLlB+w8uHbjI=;
 b=KK/gyAfe2hkZR59jS8uWZ5KkJGDPMQpTPZ1ak5G/oKNVFpWR2QsddcwSUKbJKfaqK13PcL
 40NexyEudGDxx+iKzHwUa4YDu8MwRWQbHDpSG2oOX7rz7xmuaGn+90bWCCa13ZNPifkqtW
 Q8m/uw+UQui4tcQMcageyvJaFiAzupM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-nPoGwuDIOCWcvkP0tmJzMw-1; Thu, 13 Jan 2022 10:45:20 -0500
X-MC-Unique: nPoGwuDIOCWcvkP0tmJzMw-1
Received: by mail-pj1-f72.google.com with SMTP id
 g12-20020a17090a4b0c00b001b313b7a676so6883691pjh.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XOQmkcxnHsUnotvr77pJAq4wKyjZXJltLlB+w8uHbjI=;
 b=NwDlIFJ8d0rTZiaIOWBB5DIZlJxXGDIqcUuOfqLKxEVgP9VoIacjwlTHlUC8b0HbCw
 sF1wD+TDY3pRepSWD5WqvpuzVInb84s2uB+X/6k8yZKhiuCus1gZsAK2Mrw72ORWvFVL
 +q4Gbpvp75B76mMVgxJBkrTit177iNgKmc5skkBNvw7r86wTWnK1g/rLQCDPcoZXqQmF
 WsV0rC+tj9K6DK8jxSFUaak0AGMmnWDlXU+rHHT1LFQNXCcksZbgtC7Tge9YH7aOUh2h
 TvEfpE984EzS3ZvYgUQ6CvCZJL8WFLjyV6Vrc0xMK9T8HeAik4bJtRoT0o/DSfwpkONy
 UU5g==
X-Gm-Message-State: AOAM532H8hsElVyjQPsn2w/6QeumT9KtILJ2bToAC4NrK8QmUj87uFrM
 DQzycj2vAg+qTHblg0TMhgu1tWphbH1Yc6c0PQpmcp3z3ule6ShIr0Kg7E18LBiO0ldJcxZSUC2
 rnToQEWWAPq4mlIoDPTjWmwLGCT7DD89ikBSuwNbaoA==
X-Received: by 2002:a63:4186:: with SMTP id o128mr4373784pga.450.1642088719907; 
 Thu, 13 Jan 2022 07:45:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoTVzJmaQMaCWyrTgeBzpvTXnZncov7SOddrWkGnSqiIzv5eZXOkdcIXRKCxNIrGEynwLc4Q==
X-Received: by 2002:a63:4186:: with SMTP id o128mr4373770pga.450.1642088719635; 
 Thu, 13 Jan 2022 07:45:19 -0800 (PST)
Received: from steredhat (host-79-51-11-180.retail.telecomitalia.it.
 [79.51.11.180])
 by smtp.gmail.com with ESMTPSA id n28sm2603973pgl.7.2022.01.13.07.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jan 2022 07:45:19 -0800 (PST)
Date: Thu, 13 Jan 2022 16:44:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] vhost: cache avail index in vhost_enable_notify()
Message-ID: <20220113154301.qd3ayuhrcjnsaim7@steredhat>
References: <20220113145642.205388-1-sgarzare@redhat.com>
 <20220113101922-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220113101922-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stefanha@redhat.com
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

On Thu, Jan 13, 2022 at 10:19:46AM -0500, Michael S. Tsirkin wrote:
>On Thu, Jan 13, 2022 at 03:56:42PM +0100, Stefano Garzarella wrote:
>> In vhost_enable_notify() we enable the notifications and we read
>> the avail index to check if new buffers have become available in
>> the meantime. In this case, the device would go to re-read avail
>> index to access the descriptor.
>>
>> As we already do in other place, we can cache the value in `avail_idx`
>> and compare it with `last_avail_idx` to check if there are new
>> buffers available.
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>I guess we can ... but what's the point?
>

That without this patch if avail index is new, then device when will 
call vhost_get_vq_desc() will find old value in cache and will read it 
again.

With this patch we also do the same path and update the cache every time 
we read avail index.

I marked it RFC because I don't know if it's worth it :-)

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
