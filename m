Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2257AC00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9BCD281770;
	Mon, 15 Aug 2022 20:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BCD281770
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OppNVZ0+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYmJRlx6rhm4; Mon, 15 Aug 2022 20:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 033038176B;
	Mon, 15 Aug 2022 20:43:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 033038176B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E8CAC0032;
	Mon, 15 Aug 2022 20:43:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CAE9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B7EA60B9E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B7EA60B9E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OppNVZ0+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jg3w5ozJKJck
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:43:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4732060B18
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4732060B18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660596179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1RagYWszqaSjhWpfjC6egbrOKZNG+z96AnlUoGxM5s=;
 b=OppNVZ0+96UeID/p0ojiE5t+bPilayA6ONyDPGUzM3xC8VR0eO+2GdOdgNm7EB5zvB8ueZ
 Ts/vBIoOyqtZ41EdOHJSzM1k+G67B5kAvjzA1fb0wETednwB02sQAlnkk7pVs93IHyxWR7
 BRY8EqF3FEJ47GbpiIjUkQ/zW5f56Sk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-jI62xAjTM7mdnVOnJwsq5w-1; Mon, 15 Aug 2022 16:42:57 -0400
X-MC-Unique: jI62xAjTM7mdnVOnJwsq5w-1
Received: by mail-ed1-f70.google.com with SMTP id
 c14-20020a05640227ce00b0043e5df12e2cso5412614ede.15
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=i1RagYWszqaSjhWpfjC6egbrOKZNG+z96AnlUoGxM5s=;
 b=r80XMz7Eaf4kcUEl7O8/stgI/P7fzvG7Za9xf4dE9W96UiMRxT50U5UWjGTs9dautp
 FQFkLUuMZEeir5rYgQjAJart+uE23Zn5McJPX6Uf8GQbRzB00r5k0BYb3S6y6yF2zidA
 Cihsy20x+evkHj+dspcnmei6xVEcnwFcEwCfNE3Ax3KdRwHKo20QBnq5+2cHBBR402Vb
 mIRnINBtcB3TZiF1uH6YXn4afchh/oRs1QDthLlva5eWxT9V/VRHvE8kHa8SJRYyLkw7
 KWTElHbzo+XZI7IXP7bJcqO2JZ8HbwVVyP+FNFZNPeCE9SAuDGcBYhMljyhNkOINq/5c
 j6+g==
X-Gm-Message-State: ACgBeo0eWpnJk4PhtKhHVMtvUAaxcUSsk5E3D5rfLFle/jjJ0L2B6Ibf
 iB5Ces/IwG8K4wAkvN8AvbV/pCYSrFrYGN3glmcji0GlUP0gTGAUQWmg70I2ps+vy/UVrdnW26K
 C6pBR1AenufCKnG0voZmsGH9WV9YVHyE5Gq1QJZbyjw==
X-Received: by 2002:aa7:cb83:0:b0:443:3f15:84fe with SMTP id
 r3-20020aa7cb83000000b004433f1584femr14740034edt.17.1660596176536; 
 Mon, 15 Aug 2022 13:42:56 -0700 (PDT)
X-Google-Smtp-Source: AA6agR67uibTwHp3zJpk5WxR1XmHZTPFlM/8VgduWGMLCUUk/aIaJaspiMaWyR27MrJMbnjfUjKX9g==
X-Received: by 2002:aa7:cb83:0:b0:443:3f15:84fe with SMTP id
 r3-20020aa7cb83000000b004433f1584femr14740015edt.17.1660596176355; 
 Mon, 15 Aug 2022 13:42:56 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 g1-20020a1709061e0100b00730a8190f54sm4421436ejj.102.2022.08.15.13.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:42:55 -0700 (PDT)
Date: Mon, 15 Aug 2022 16:42:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815164013-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <20220815203426.GA509309@roeck-us.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andres Freund <andres@anarazel.de>,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Aug 15, 2022 at 01:34:26PM -0700, Guenter Roeck wrote:
> On Mon, Aug 15, 2022 at 05:16:50AM -0400, Michael S. Tsirkin wrote:
> > This reverts commit 762faee5a2678559d3dc09d95f8f2c54cd0466a7.
> > 
> > This has been reported to trip up guests on GCP (Google Cloud).  Why is
> > not yet clear - to be debugged, but the patch itself has several other
> > issues:
> > 
> > - It treats unknown speed as < 10G
> > - It leaves userspace no way to find out the ring size set by hypervisor
> > - It tests speed when link is down
> > - It ignores the virtio spec advice:
> >         Both \field{speed} and \field{duplex} can change, thus the driver
> >         is expected to re-read these values after receiving a
> >         configuration change notification.
> > - It is not clear the performance impact has been tested properly
> > 
> > Revert the patch for now.
> > 
> > Link: https://lore.kernel.org/r/20220814212610.GA3690074%40roeck-us.net
> > Link: https://lore.kernel.org/r/20220815070203.plwjx7b3cyugpdt7%40awork3.anarazel.de
> > Link: https://lore.kernel.org/r/3df6bb82-1951-455d-a768-e9e1513eb667%40www.fastmail.com
> > Link: https://lore.kernel.org/r/FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE%40anarazel.de
> > Fixes: 762faee5a267 ("virtio_net: set the default max ring size by find_vqs()")
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Tested-by: Andres Freund <andres@anarazel.de>
> 
> I ran this patch through a total of 14 syskaller tests, 2 test runs each on
> 7 different crashes reported by syzkaller (as reported to the linux-kernel
> mailing list). No problems were reported. I also ran a single cross-check
> with one of the syzkaller runs on top of v6.0-rc1, without this patch.
> That test run failed.
> 
> Overall, I think we can call this fixed.
> 
> Guenter

It's more of a work around though since we don't yet have the root
cause for this. I suspect a GCP hypervisor bug at the moment.
This is excercising a path we previously only took on GFP_KERNEL
allocation failures during probe, I don't think that happens a lot.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
