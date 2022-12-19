Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA92BC4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 10:15:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5196B60625;
	Mon, 19 Dec 2022 10:15:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5196B60625
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N82UvykU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aVN-eYyW-Y4; Mon, 19 Dec 2022 10:15:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E58A060ADF;
	Mon, 19 Dec 2022 10:15:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E58A060ADF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D746C0032;
	Mon, 19 Dec 2022 10:15:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0679FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CAD3C4069B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:15:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAD3C4069B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N82UvykU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AU2lN7HnnYY4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:15:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD25440576
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BD25440576
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671444919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0F60KxR0W9IzjgTzMiPaONsb+3DC5K9NhR1i6GY+9bw=;
 b=N82UvykUTQbO8QBMf3KS79N1o4BqtF8FMLN8DudmNRAzvyAcvitAf9OFWrZbSfCI/9KhoI
 26/T+nzj2i4/PRYQwTcM3XeSc+fzkY2E3Oq40/UPHhh0gN9rW1lkqY5V7QiPsyRPIsCumb
 Qw05uuai8MVpVDRWYM4hLPoMCiErQUw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-660-0mY9NfpXOmOSo0pgzdAN7A-1; Mon, 19 Dec 2022 05:15:18 -0500
X-MC-Unique: 0mY9NfpXOmOSo0pgzdAN7A-1
Received: by mail-qk1-f197.google.com with SMTP id
 bq39-20020a05620a46a700b006ffd5db9fe9so6964324qkb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 02:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0F60KxR0W9IzjgTzMiPaONsb+3DC5K9NhR1i6GY+9bw=;
 b=PJhcD3MBInNlzVOUSasJFHm7wWAc9Z1Er1RozzECzAKuqNYnT1MdEiPeprf2KBz5k1
 BPUQZxbQDgmZmk1t58I9JP9YcRCzmupQpu3UNsh9rYM2Z9Z48DkiJDOb8zprs2k4oFMA
 EYOSEOM3uVmpMNwMn64kjN8iMGh/8ksAOBh12rEIYVhnKHz03upNP5zu03SOHR1xkjRH
 2o7/j7u8qh/udGYiqJ9qUhQc+iB2q2Cs1ni//WPQ3qsz3FRR8w47zQfQoI6H+O0vVA6F
 uLooCO6XbTtHt9j533DR9dEEI7riwANgjDdoxO6awj1ehp/aDFK+j+yRo8QcH++WY3oM
 ehew==
X-Gm-Message-State: ANoB5pnHVyxDZyf7WbKsvX52RWgnHz+UJJf38EXSnErU9Tleul4jQefq
 elxnVk26v0JItLDO/vric5iB03vLtWyBku9i62sXiEf+oGg8/0OzVKcQBSqsYsJQ0L0Gk4ciO9R
 hqEVeJbYzC5UeyT1rR33lGXud9089sQJy3f3UJmXmDw==
X-Received: by 2002:ac8:4e51:0:b0:3a5:2704:d4bd with SMTP id
 e17-20020ac84e51000000b003a52704d4bdmr74303339qtw.16.1671444918004; 
 Mon, 19 Dec 2022 02:15:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5bm5Qnb85eW38Qmkj26T6UAoQXiAZKZbsD/6lF6kYKtBjYMui2UsCvc851kAw1QZmfTvQTLw==
X-Received: by 2002:ac8:4e51:0:b0:3a5:2704:d4bd with SMTP id
 e17-20020ac84e51000000b003a52704d4bdmr74303318qtw.16.1671444917765; 
 Mon, 19 Dec 2022 02:15:17 -0800 (PST)
Received: from redhat.com ([45.144.113.29]) by smtp.gmail.com with ESMTPSA id
 r17-20020a05620a299100b006fb8239db65sm6819951qkp.43.2022.12.19.02.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 02:15:17 -0800 (PST)
Date: Mon, 19 Dec 2022 05:15:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20221219050716-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
 <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, rusty@rustcorp.com.au, ericvh@gmail.com,
 netdev@vger.kernel.org, linux_oss@crudebyte.com,
 Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pbonzini@redhat.com, pabeni@redhat.com, davem@davemloft.net
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

On Tue, Nov 29, 2022 at 11:37:09AM +0800, Jason Wang wrote:
> >
> >
> > Quite a lot of core work here. Jason are you still looking into
> > hardening?
> 
> Yes, last time we've discussed a solution that depends on the first
> kick to enable the interrupt handler. But after some thought, it seems
> risky since there's no guarantee that the device work in this way.
> 
> One example is the current vhost_net, it doesn't wait for the kick to
> process the rx packets. Any more thought on this?
> 
> Thanks

Specifically virtio net is careful to call virtio_device_ready
under rtnl lock so buffers are only added after DRIVER_OK.

However we do not need to tie this to kick, this is what I wrote:

> BTW Jason, I had the idea to disable callbacks until driver uses the
> virtio core for the first time (e.g. by calling virtqueue_add* family of
> APIs). Less aggressive than your ideas but I feel it will add security
> to the init path at least.

So not necessarily kick, we can make adding buffers allow the
interrupt.



-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
