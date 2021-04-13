Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A7C433B4
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 04:24:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A990613AB
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 04:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A990613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FA1D842F8;
	Tue, 13 Apr 2021 04:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hQZ7tYNhFjAa; Tue, 13 Apr 2021 04:24:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8043842F9;
	Tue, 13 Apr 2021 04:24:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92248C000B;
	Tue, 13 Apr 2021 04:24:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4651C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DAE3842F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:24:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G3H4B5RotCEA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6083842F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618287882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+1EoJgQHtcLO0TXGm3dZ+kuN9h3PKmHdMygVbCrH8A=;
 b=OY+/F/P4gSgUXOid2o2aHegndvqBe/6q9M0cpJrV7vxUzpuHBEYI9XlZ4OuQQnaO0JcLHZ
 GmIXy9u0Pg2SubZbjo5vXX8Jpg4J8HT7yQxELQXKG5O0TY/j/yA404R9OjYo2gDj7R3TKa
 l6yoyDNLMbnDPYe6JpxFJfGIWSWQ32Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-WPWs9l63OjyLncFwwkPD-g-1; Tue, 13 Apr 2021 00:24:40 -0400
X-MC-Unique: WPWs9l63OjyLncFwwkPD-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 o18-20020a05600c3792b0290128219cbc7bso595022wmr.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 21:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=q+1EoJgQHtcLO0TXGm3dZ+kuN9h3PKmHdMygVbCrH8A=;
 b=O4lg8N/QlOmGPNhHuSStxajqr1nXcFNk5dT2y3gpYGTcDzNI+SofaT9k6dzg7dVHwn
 hxn0V4fuXl5fl6V2JkghenndIRqN+MUKUouEn7CkcqPWzSS4UqJmF/8Juxm5P0SgqAbs
 aQ5vhzHZo1m9Bzr1agkDPkoHU3iP7sWtpL8i2SkMKXzN3sDvLW6BUnELING11qRBTnm+
 sq/w2nipW9QHTfxHIGcIbU6DuQ5ouam8mli5rYnrVUbQ74fPDcykOEZ+M5c6QOcrCk2P
 MK1ab6PFzgC/+wmaotcH6QpbeRt4bAzeqB+Hj65K0IkGKRIuqd1B0x5z5vQ1Rsx5C+N2
 Qxsw==
X-Gm-Message-State: AOAM532vKDfaVugKkRc7HXbwc6R7u3KtX43zaT35OAgqkE4HN63JJZVW
 fTd2+KbW5KR4pvfiEV9TgfwBH18/YrW9mlURUQv4jmikB9ujVSrK6cSGXM3OG0gnWpOrGiBfPPZ
 WyL91MY8bDXgah6wETzMlElPBM3zNfhlyf319ka6DBA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr18463113wrw.78.1618287879419; 
 Mon, 12 Apr 2021 21:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyodPDoN8x3GL83Cr9txbEz4M9Dd9UXgw0xTbFSIzIOWIhtoOQiLU8g9CAcs7gvxZ10oODxSA==
X-Received: by 2002:a5d:69ca:: with SMTP id s10mr18463104wrw.78.1618287879282; 
 Mon, 12 Apr 2021 21:24:39 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id b16sm1161845wmb.39.2021.04.12.21.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 21:24:38 -0700 (PDT)
Date: Tue, 13 Apr 2021 00:24:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
Message-ID: <20210413002340-mutt-send-email-mst@kernel.org>
References: <20210129002136.70865-1-weiwan@google.com>
 <20210412180353-mutt-send-email-mst@kernel.org>
 <20210412183141-mutt-send-email-mst@kernel.org>
 <20210412.161458.652699519749470159.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20210412.161458.652699519749470159.davem@davemloft.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, weiwan@google.com,
 virtualization@lists.linux-foundation.org, willemb@google.com, kuba@kernel.org
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

On Mon, Apr 12, 2021 at 04:14:58PM -0700, David Miller wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Mon, 12 Apr 2021 18:33:45 -0400
> 
> > On Mon, Apr 12, 2021 at 06:08:21PM -0400, Michael S. Tsirkin wrote:
> >> OK I started looking at this again. My idea is simple.
> >> A. disable callbacks before we try to drain skbs
> >> B. actually do disable callbacks even with event idx
> >> 
> >> To make B not regress, we need to
> >> C. detect the common case of disable after event triggering and skip the write then.
> >> 
> >> I added a new event_triggered flag for that.
> >> Completely untested - but then I could not see the warnings either.
> >> Would be very much interested to know whether this patch helps
> >> resolve the sruprious interrupt problem at all ...
> >> 
> >> 
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > Hmm a slightly cleaner alternative is to clear the flag when enabling interrupts ...
> > I wonder which cacheline it's best to use for this.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Please make a fresh new submission if you want to use this approach, thanks.

Absolutely. This is untested so I just sent this idea out for early feedback
and hopefully help with testing on real hardware.
Sorry about being unclear.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
