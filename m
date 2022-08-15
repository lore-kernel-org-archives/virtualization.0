Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F70C48BEA
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:28:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F1FED4032B;
	Mon, 15 Aug 2022 21:28:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1FED4032B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=anarazel.de header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=yvn6DXBf;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=aL+giPBM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpEkUuYVSiJl; Mon, 15 Aug 2022 21:28:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82B5F40012;
	Mon, 15 Aug 2022 21:28:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82B5F40012
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5648CC0033;
	Mon, 15 Aug 2022 21:28:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04EDBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7AD281364
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:28:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7AD281364
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=anarazel.de
 header.i=@anarazel.de header.a=rsa-sha256 header.s=fm1 header.b=yvn6DXBf; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=aL+giPBM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjoppYaH46YN
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:28:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 262DA81351
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 262DA81351
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:28:44 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.west.internal (Postfix) with ESMTP id CFB323200488;
 Mon, 15 Aug 2022 17:28:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Mon, 15 Aug 2022 17:28:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1660598921; x=1660685321; bh=TG6h01Br37
 C4F3jMCzgHNyxb/LAU3CF9cYEYzRCIsQI=; b=yvn6DXBfwxjXrtC+Te4D/kWHmC
 8tpQP1Oy6qo8wuY0MkPzKpaF7EClUYOUG59BtsYm9ZfRvBSquvXdy5mfZHcYhbmZ
 dP6H7EkjwhjI6HakI4aJmwyyc9vuDFCKPp3yQwLJbhvTR6BhjHIDdcIcNpxVbSyn
 0JNdwCzxF2sFLbKdcBtr/yHOSgOmVMVhE43sTlhYdEMAdz6Y3M03RmOJ2I1VUs3e
 oTWR8JQxIMFyIK5Ksn7hSfygYEwXjhcbrHkXQQ/n+IREXnT6LDfA6hqL3xuf8SHY
 +vHBwry8olWA8pGFxTPSq7htrRf4309y7TiZbBg5oqkJXhp1suGpdKndWyPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1660598921; x=1660685321; bh=TG6h01Br37C4F3jMCzgHNyxb/LAU
 3CF9cYEYzRCIsQI=; b=aL+giPBMZwPuKrh+P+nNenINh0up9FTNUwrC7DJ+9PoQ
 MY1M4lduN925t5IqjR1tllocqr3tgPgU2k8W1s//wroofSSjFq7moupvxizJ6R2k
 tZ+ZOSlm+Bb0E8xvjVx+FsicYw8+GtNNNpkKCfU/NSmxuvA0w/arFA8pMS5JZHZI
 FNG8FzBvE9Md5MJDSloBFcjrY7GSgttKQ01G4TLUNKtFFclR35+4LtvwLntizBb7
 PP3fWCE+T/x+JgvYCvWqdjY6NH/WLrNoQ2U8MD/J6cxUy7j2JJkzX67dCYURTtWc
 uYtxpCx6mvy2LSmxrsD5EZCCdFbQ69TD5nYgRhX5aQ==
X-ME-Sender: <xms:iLr6Yg2uEn8EOWZu5l2Bn_cu_LbsPMC8ffavd88zftdvJb_yoF5vxQ>
 <xme:iLr6YrHlReUxZmOT2ApQD-MciDV-BpW6pIASajOYBuLPd54kSv_-iBV91pYPjqU8B
 _w2mK2MBeI12BkWhA>
X-ME-Received: <xmr:iLr6Yo4qrJ88Us5p4mkQflTVPm7FxxgbW646IEXYOWWXCRq0rwTHc_yGYIfYaNnmdKKww-45Pfbgc7IsU3RtPf_p4_fbAxQx6iAWoxoW4JeB9HyCeEV58aiTCLuO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehvddgudeifecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgu
 rhgvshcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucggtf
 frrghtthgvrhhnpedvffefvefhteevffegieetfefhtddvffejvefhueetgeeludehteev
 udeitedtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:iLr6Yp0eVU7NJnUaOkwKOG7xyKFFsYMmfMCXZCuua0Az-YFL6n-8vw>
 <xmx:iLr6YjHbvm6TWLpU6LIOqcwtEt2dTTPvg5uBsCyjcQXJo6KmPEZagQ>
 <xmx:iLr6Yi_2Q7BtpolFX4o5wGQD6pwhUfS-dotaJo39PY8Ln9UfYRRKnQ>
 <xmx:ibr6YtECLURIjGEkwZ2IMpYCf9iR1YGYoQninic5ysNhbiJCLqT8Bg>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 17:28:40 -0400 (EDT)
Date: Mon, 15 Aug 2022 14:28:39 -0700
From: Andres Freund <andres@anarazel.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220815165608-mutt-send-email-mst@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

Hi,

On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> So virtio has a queue_size register. When read, it will give you
> originally the maximum queue size. Normally we just read it and
> use it as queue size.
> 
> However, when queue memory allocation fails, and unconditionally with a
> network device with the problematic patch, driver is asking the
> hypervisor to make the ring smaller by writing a smaller value into this
> register.
> 
> I suspect that what happens is hypervisor still uses the original value
> somewhere.

It looks more like the host is never told about the changed size for legacy
devices...

Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
5.19 + restricting queue sizes to 1024 boot again.  I'd bet that it also would
fix 6.0rc1, but I'm running out of time to test that.

Greetings,

Andres Freund
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
