Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F20C63705
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 20:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B5B3418DB;
	Wed,  7 Dec 2022 20:28:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B5B3418DB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AtX+7Lz+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LzXNCG6GhC0u; Wed,  7 Dec 2022 20:28:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45E96418E5;
	Wed,  7 Dec 2022 20:28:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45E96418E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14BBCC0032;
	Wed,  7 Dec 2022 20:28:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBC37C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 20:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89246408D3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 20:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89246408D3
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AtX+7Lz+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SrIWiNZ9PZJY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 20:28:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E15740220
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E15740220
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 20:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670444901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
 b=AtX+7Lz++31ArwoDnyz0cDBy4cD9ywXaW9N8t0xD20uLBiJn3Bh/1QCinj/4F2y3uNewVw
 PHXRVpdp+oGesWdevlBJLiuP3adm9/1oZ7o+JfaU7iKOney8QGPNhAu9tTuu5gcUZ7t9yg
 swfHob9nC/X/3ljx6+2uDUKzp6RoDME=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-1utV-ae4PhSTYSjnSiFL-Q-1; Wed, 07 Dec 2022 15:28:18 -0500
X-MC-Unique: 1utV-ae4PhSTYSjnSiFL-Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 b47-20020a05600c4aaf00b003d031aeb1b6so1263558wmp.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Dec 2022 12:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
 b=O3aadCFxsQnR61wFo0BBZZrOHrxxUN7ecuuwNq8ljM/Zb02bYhWiU2bYP7ydGrdVdl
 MtIt2hctxSs+x+uQnDNnQ8iWh0OzCrDzfr8McbHUp4pWsjzbE7if0oqvfXhbdF5NNjoW
 Xk1L/pOe90x9p0Ye2JztQILKZEDAgFLB7+xAAxKsVbSSsQqFHJ0N43R29hhVzn1BSalj
 BxxqaVQQB1ZIx1C8lvqkoq5akGeXJW7FcpADEFsNS094D/BsgTgH4uvHT44CE6aiPqNv
 YrQsaQPcbc232qhJ274lqPY0skUAyAzut+fzRu8OKpQ3fukzj1dfLIj+2vDeZXYsn7Bt
 aRbg==
X-Gm-Message-State: ANoB5pk67EXVVQIVJ2QnjfWi4EDIaekVAF/EmqsIUA8jFgIV48H4gGau
 cVf3O4QF7qBKQa/4K1CIzEjGQgK5MaMTpTGUKQjY4zjCidDHq7UEuVsWkjez8ImXfiqQoJjYgGp
 m3d7ibw7z/gQOKGd0I1k5TOXYKaSSASwmp8yVALy/iw==
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id
 f14-20020adff98e000000b002420324ff88mr35473839wrr.81.1670444897079; 
 Wed, 07 Dec 2022 12:28:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QOq0RAPymVdkyXnh7/V2ZIzFLtZtJ+dwe3UW02/93b8NTVphp6L78PZAaWRCEXF7iho9Mtw==
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id
 f14-20020adff98e000000b002420324ff88mr35473829wrr.81.1670444896831; 
 Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:1a4f:ce60:357c:370b:cc7e])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a5d634c000000b00241e8d00b79sm25007953wrw.54.2022.12.07.12.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Date: Wed, 7 Dec 2022 15:28:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221207152116-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Y5C/4H7Ettg/DcRz@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Dec 07, 2022 at 08:31:28AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> > Christoph you acked the spec patch adding this to virtio blk:
> > 
> > 	Still not a fan of the encoding, but at least it is properly documented
> > 	now:
> > 
> > 	Acked-by: Christoph Hellwig <hch@lst.de>
> > 
> > Did you change your mind then? Or do you prefer a different encoding for
> > the ioctl then? could you help sugesting what kind?
> 
> Well, it is good enough documented for a spec.  I don't think it is
> a useful feature for Linux where virtio-blk is our minimum viable
> paravirtualized block driver.

No idea what this means, sorry.  Now that's in the spec I expect (some)
devices to implement it and if they do I see no reason not to expose the
data to userspace.

Alvaro could you pls explain the use-case? Christoph has doubts that
it's useful. Do you have a device implementing this?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
