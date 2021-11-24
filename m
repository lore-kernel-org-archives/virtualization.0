Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461DEC433FE
	for <virtualization@archiver.kernel.org>; Wed, 24 Nov 2021 23:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C860A825E8;
	Wed, 24 Nov 2021 23:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3iNK4se4eJrO; Wed, 24 Nov 2021 23:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 823A582591;
	Wed, 24 Nov 2021 23:56:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 665BFC002F;
	Wed, 24 Nov 2021 23:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F23B2C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE8C240133
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBD6mFN6gPuq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6AE7F400BA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637798167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Aq2BDIOL1rOwQ9dBnbb+hwIKJaZN1tdzzbInSFnljw=;
 b=PsFShBzOCpfS6ocmYn6trsCj0ZBzYo9zgT8+QHqiPjeBdQhCaNaxauJW9fs5dN7rxUrJgD
 nbeeNsgVlo/bmXw0x8sbH4KmGL7RHmwKbwzg+Pcv8q2A9lhtELVwiu0kKgzBJJxgyYjyLC
 6XF912QN9MnIxo9MwPRz/av2EAaNjuw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-dslFyJD2O0elwnHyuaWuTA-1; Wed, 24 Nov 2021 18:56:06 -0500
X-MC-Unique: dslFyJD2O0elwnHyuaWuTA-1
Received: by mail-ed1-f72.google.com with SMTP id
 v1-20020aa7cd41000000b003e80973378aso3766973edw.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 15:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7Aq2BDIOL1rOwQ9dBnbb+hwIKJaZN1tdzzbInSFnljw=;
 b=aolcJiGf7gAuqZnIqBSPQUcR+b2FAdV+LAi9Bqv9hrHeRiDL1b4Ld9Z2P3AvV3dzAF
 MLjqT6IWQ/AYFtekdBavH5KQ17WkGfvLfHfnnrAMuf5NEq5ccLqbOv1+yXdM2cdjmuHr
 yYoo2pODOBfxFm4frx2XYRaLTAM1RGzj+MZRbvxygqU3BOI5GmOQ3X6A58Yzo0jWaaSa
 TToCdH+ApSE3s9qHeb3Av7Hx8lFA0DbI23sr2oZ3cjFmHVrfBItiYPtjP4CewpWQ/Si/
 AUl88tFMTrmN0bJHLoH/0css5oMwkmoPtJETaSeXaHAyLY/PMuAaVSiJ5gHYEPO5ifNa
 TC9w==
X-Gm-Message-State: AOAM532nixcX3QuTCNRaEJLG1nUUhXfyFw2vidnjt0OHUoueXy7elLET
 Kq81z2ABTvW2sYffh8Uz/OIS3BZNvFDm+PlXWeTk0Mm4zYfAxImrYmewzAPzs8JolH/amGL0CCW
 LdxrpJDAqi1HiKELhUGhzo9y4qklifoq4QxWfUudmLg==
X-Received: by 2002:a17:907:86a1:: with SMTP id
 qa33mr25976956ejc.142.1637798164841; 
 Wed, 24 Nov 2021 15:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/BeF/KE9jXz/y70P34AnKAccg8V9yjGfdr5JI7QmEdI6beBgERTWQTzGGy07CdiEexVs2GQ==
X-Received: by 2002:a17:907:86a1:: with SMTP id
 qa33mr25976932ejc.142.1637798164681; 
 Wed, 24 Nov 2021 15:56:04 -0800 (PST)
Received: from redhat.com ([2a0e:1c80:14::66])
 by smtp.gmail.com with ESMTPSA id q17sm863125edd.10.2021.11.24.15.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 15:56:03 -0800 (PST)
Date: Wed, 24 Nov 2021 18:55:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH v2 0/2] virtio-i2c: Fix buffer handling
Message-ID: <20211124185546-mutt-send-email-mst@kernel.org>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
In-Reply-To: <20211111160412.11980-1-vincent.whitchurch@axis.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org, kernel@axis.com,
 linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

On Thu, Nov 11, 2021 at 05:04:10PM +0100, Vincent Whitchurch wrote:
> This fixes a couple of bugs in the buffer handling in virtio-i2c which can
> result in incorrect data on the I2C bus or memory corruption in the guest.
> 
> I tested this on UML (virtio-uml needs a bug fix too, I will sent that out
> later) with the device implementation in rust-vmm/vhost-device.
> 
> Changes in v2:
> - Added Acked-by and Fixes tags


What are the plans for this patchset?

> Vincent Whitchurch (2):
>   i2c: virtio: disable timeout handling
>   i2c: virtio: fix completion handling
> 
>  drivers/i2c/busses/i2c-virtio.c | 46 ++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 27 deletions(-)
> 
> -- 
> 2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
