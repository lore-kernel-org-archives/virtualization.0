Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C84C4332F
	for <virtualization@archiver.kernel.org>; Wed,  2 Nov 2022 09:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBD504098F;
	Wed,  2 Nov 2022 09:45:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBD504098F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OP9ZBS21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RGRFrmOWrQbt; Wed,  2 Nov 2022 09:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B5DC40994;
	Wed,  2 Nov 2022 09:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B5DC40994
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19106C0032;
	Wed,  2 Nov 2022 09:45:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30818C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03F1C400E4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03F1C400E4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OP9ZBS21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aRxFZcKgrppq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BD2E40186
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BD2E40186
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Nov 2022 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667382317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DW2a/80J8hDerpO8ayxyonD3c6E1iUdSbhWZlEaOu5c=;
 b=OP9ZBS21JauMiqj2jqv6a43yEvWdJ0McCa0JXokqbN5UX3iAAXyFAqtS09jmXco2Hi3qTw
 i0wwS7s6wl5itmVZRwiaeKNygX+nVp7gCLZjy31xf1ZxBLCLAiLgFWYGcUT8UxHBE9gId8
 L5a5cwgRe483yx43XIZQTw0nvjW+m/w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-kZm52FMUM3G071vYLKIgZQ-1; Wed, 02 Nov 2022 05:45:15 -0400
X-MC-Unique: kZm52FMUM3G071vYLKIgZQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 on28-20020a056214449c00b004bbf12d7976so4886217qvb.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Nov 2022 02:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DW2a/80J8hDerpO8ayxyonD3c6E1iUdSbhWZlEaOu5c=;
 b=mAjBLIEb5FEtORDe6CYxRP450XO+GlBGIlZ9sQQ9ULR/Eu0Z6Mhhmd1LgqSeSZmb+1
 RqIp7AsEFGNg9h1L9IVPiH+RNyaYHVZn5XR/YB85PX8xsVYyUIHfKloD11iPqwmZNw+t
 /5yDWKBWzDvKSRgXzgf7ChcyhZdO0uLPdY7MUb8cPBHdJdDXVfq4wvjHKIu5A9wtASol
 56/c7XiCE4FKP/5i+HowCjWlld7VJwLFxhr1WCMNr7fIJfSYPZxwJqS1rR0Y82rcCs91
 64vdpyRlZiwihWmJgN+dc4vytkLEK20wWJUdgUt78Hw5L0DnPWp3I9D+JwxxilrIi24M
 cPXQ==
X-Gm-Message-State: ACrzQf3TI3esBAmWLFqmSBcNisMxnTXWrcvj4SnliJt/7P0iuKwPpjf6
 N4GRjoq+cu9WXkTj9WmBQq8IzIqHBEISZOiPkv8cHSkn/vi/TiVvF07k9RT3YT7fIq0Hjn/a2Yw
 PotgGgS1rrZEab7MGA/0ShC2em1i0QQV1bDMDOSMSng==
X-Received: by 2002:a0c:906e:0:b0:4bb:e024:53b5 with SMTP id
 o101-20020a0c906e000000b004bbe02453b5mr16117822qvo.39.1667382315415; 
 Wed, 02 Nov 2022 02:45:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6DBLvfnyHa64NTohsQ2JJkSO3mLcgL9P+qhtcouJauIw3nBBLEsYTgOuVHQoDiDy+GcHZILg==
X-Received: by 2002:a0c:906e:0:b0:4bb:e024:53b5 with SMTP id
 o101-20020a0c906e000000b004bbe02453b5mr16117805qvo.39.1667382315054; 
 Wed, 02 Nov 2022 02:45:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 h4-20020a05620a400400b006cdd0939ffbsm8126852qko.86.2022.11.02.02.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Nov 2022 02:45:14 -0700 (PDT)
Date: Wed, 2 Nov 2022 10:45:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Frederic Dalleau <frederic.dalleau@docker.com>
Subject: Re: [PATCH 2/2] vsock: fix possible infinite sleep in
 vsock_connectible_wait_data()
Message-ID: <20221102094504.vhf6x2hgo6fqr7pi@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-3-decui@microsoft.com>
 <20221031084327.63vikvodhs7aowhe@sgarzare-redhat>
 <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CANWeT6gyKNRraJWzO=02gkqDwa-=tw7NmP2WYRGUyodUBLotkQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: wei.liu@kernel.org, netdev@vger.kernel.org, haiyangz@microsoft.com,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, stephen@networkplumber.org,
 edumazet@google.com, kuba@kernel.org, arseny.krasnov@kaspersky.com
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

On Tue, Nov 01, 2022 at 09:21:06PM +0100, Frederic Dalleau via Virtualization wrote:
>Hi Dexan, Stephano,
>
>This solution has been proposed here,
>https://lists.linuxfoundation.org/pipermail/virtualization/2022-August/062656.html

Ops, I missed it!

Did you use scripts/get_maintainer.pl?
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#select-the-recipients-for-your-patch

Since your patch should be reposted (hasn't been sent to 
netdev@vger.kernel.org, missing Fixes tag, etc.) and Dexuan's patch on 
the other hand is ready (I just reviewed it), can you test it and 
respond with your Tested-by?

I would like to give credit to both, so I asked to add your Reported-by 
to the Dexuan's patch.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
