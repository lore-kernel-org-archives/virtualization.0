Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAC8C25B06
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 08:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 983D040C59;
	Thu, 11 Aug 2022 08:00:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 983D040C59
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mg805wI3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlOaKwPU7dUZ; Thu, 11 Aug 2022 08:00:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A830E40C64;
	Thu, 11 Aug 2022 08:00:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A830E40C64
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E0CC007C;
	Thu, 11 Aug 2022 08:00:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0821FC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C935860F34
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:00:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C935860F34
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Mg805wI3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O_DihEVimbjy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:00:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A427860FB9
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A427860FB9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 08:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660204810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lCmF/JYOXXlwKiezcK1qE0yFbX868q+mU1+AYkgPNXQ=;
 b=Mg805wI3ohD4iu6ysazQxVmmKku593EWcm6xndR3N9foHtAXJwU2Jc4WQblJVh7w2hFwo0
 bOtq2vmMCLB1km6OLwIRzSzsGZtC7erhYvMMf14SL9x6qKDmWZl9wR0cxlPCKGJ89OYvDv
 jXwIjsCiNVx/yYbWwSGi+0jDQIiubyc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-nIF1OiOFMYO20G-HX1dpOA-1; Thu, 11 Aug 2022 04:00:08 -0400
X-MC-Unique: nIF1OiOFMYO20G-HX1dpOA-1
Received: by mail-ej1-f69.google.com with SMTP id
 hr32-20020a1709073fa000b00730a39f36ddso5170941ejc.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 01:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=lCmF/JYOXXlwKiezcK1qE0yFbX868q+mU1+AYkgPNXQ=;
 b=xcrx33588lHGVy74hOQ39xekaOMCBVzJruaCLQ3vGBic5HZY7ph5v94cKlTgQg9wE4
 5kZ9ogpVZHR3sgC7N2XCsct69/iwDrFdE6a9FPAUxJpJw5PUuBVced2IEGjxfAsAHm5a
 +CdBehbJM2dx1bbLPcs7edTFbjQxJ85WZGTe3a+Ca0SQP7TKlE9tPiEO/gWXjuVbNd0K
 AGBrvEHv47j3N5f3LpX/DmmTy46WGNPR1uGQm7FssU4Bp6MiYRFLaRQZjxWhboVE2k6v
 v7M/9G+kTKtNePdlCzkW9BGNv/PrvrofKB7D83ZYrqMgIyQXQOG+no51MxQ0ZHugGjJO
 +V1w==
X-Gm-Message-State: ACgBeo2/2wwoHKYf8skB/s8WG4HxPnbuqH1s5FFPI4m7qTgziI9u3ROH
 5PUSR8ltisoRwqVQIgK1ZAUJGuhqx2QSfw1uA+jmtimXo7hvEDTCY99Bk3xSqQsaB/cDXcs902L
 dwfp/Fw5cTWKBKCTRmHlrjQEJ8CsSJh4y7EEApJDNvw==
X-Received: by 2002:a17:907:97d5:b0:733:1ce:9572 with SMTP id
 js21-20020a17090797d500b0073301ce9572mr6133099ejc.220.1660204807691; 
 Thu, 11 Aug 2022 01:00:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uItR6QO/ODHWGYMDEVxIdnBWORx5KiS1xBdSWWxcZ030e6s/uS5ChGYBLMNqOoTPv8T8n7g==
X-Received: by 2002:a17:907:97d5:b0:733:1ce:9572 with SMTP id
 js21-20020a17090797d500b0073301ce9572mr6133089ejc.220.1660204807494; 
 Thu, 11 Aug 2022 01:00:07 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 by23-20020a170906a2d700b00730979f568fsm3230336ejb.150.2022.08.11.01.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 01:00:06 -0700 (PDT)
Date: Thu, 11 Aug 2022 04:00:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Skalkin <igor.skalkin@opensynergy.com>
Subject: Re: [PATCH] virtio_bt: Fix alignment in configuration struct
Message-ID: <20220811035817-mutt-send-email-mst@kernel.org>
References: <20220807221152.38948-1-Igor.Skalkin@opensynergy.com>
 <20220807185846-mutt-send-email-mst@kernel.org>
 <02222fcb-eaba-617a-c51c-f939678e3d74@opensynergy.com>
 <20220808081054-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220808081054-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, mgo@opensynergy.com,
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

On Mon, Aug 08, 2022 at 08:16:11AM -0400, Michael S. Tsirkin wrote:
> On Mon, Aug 08, 2022 at 02:04:43PM +0200, Igor Skalkin wrote:
> > On 8/8/22 01:00, Michael S. Tsirkin wrote:
> > 
> >     On Mon, Aug 08, 2022 at 12:11:52AM +0200, Igor Skalkin wrote:
> > 
> >         According to specification [1], "For the device-specific configuration
> >         space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> >         16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> >         and aligned accesses for 32 and 64 bit wide fields.".
> > 
> >         Current version of the configuration structure:
> > 
> >             struct virtio_bt_config {
> >                 __u8  type;
> >                 __u16 vendor;
> >                 __u16 msft_opcode;
> >             } __attribute__((packed));
> > 
> >         has both 16bit fields non-aligned.
> > 
> >         This commit fixes it.
> > 
> >         [1] https://ddec1-0-en-ctp.trendmicro.com:443/wis/clicktime/v1/query?url=https%3a%2f%2fdocs.oasis%2dopen.org%2fvirtio%2fvirtio%2fv1.1%2fvirtio%2dv1.1.pdf&umid=d1786ace-e8ea-40e8-9665-96c0949174e5&auth=53c7c7de28b92dfd96e93d9dd61a23e634d2fbec-39b15885ceebe9fda9357320aec1ccbac416a470
> > 
> >         Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> > 
> >     This is all true enough, but the problem is
> >     1. changing uapi like this can't be done, will break userspace
> >     2. the driver has more issues and no one seems to want to
> >        maintain it.
> >     I posted a patch "Bluetooth: virtio_bt: mark broken" and intend
> >     to merge it for this release.
> > 
> > This is very sad. We already use this driver in our projects.
> 
> Really?  Can you step up to maintain it? Then we can fix the issues
> and it won't be broken.

Just a reminder that I'm waiting for a response on that.
I just don't know enough about bluetooth.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
