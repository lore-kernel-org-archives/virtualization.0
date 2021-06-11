Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D730C48BE0
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2401613DE
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 17:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2401613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92597415CD;
	Fri, 11 Jun 2021 17:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9V_USEqZFtX; Fri, 11 Jun 2021 17:55:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE1B1415C9;
	Fri, 11 Jun 2021 17:55:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3490C000E;
	Fri, 11 Jun 2021 17:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEC82C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 17:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D21FC60640
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 17:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AgsukQorKLPK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 17:55:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D63660658
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 17:55:11 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id e1so3201458plh.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
 b=SD6IZ6g/PQccK+DJj47BNWbjBcu51Hoxg75XX8W0NsqQBg0ABF+hnuOUc/UFnpm8im
 oNVX3uykvZuuO5Y8ikPd3y+WsvzDFhqLGs4yWHQFnc8RzIYufWCIOXqn3AApkjH4Q2eg
 xQaVfA+BsocsKdfD6NHf1Rfl2fMGnqoxNR3DdZP0eXDcQ/vjXZbD88x8d17C79EnssGA
 MaA3XiWo9+AFyaOrA1MdfYif3vi99movLQHJefeIj5rihTG1TSe1D2qp8+37dXVxo+jK
 juNRW5LpLgfCfOOUxjWz+2zHY1TAZQqD4FUpZkK9KYz4TPA/VoJTiiPZCp8OQM00GFzi
 g76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FiCqgV8kjys+3xuqiyCwJtcf1Wj53LQ5ch2SqyLytgY=;
 b=TL0fO789jQaEQl3H3V88fbS1EnWzai0rurcK4cS2Fm/NjSi1vmyZ0SKWYn6fCBSeJr
 bwPLM3+Jx4Wq/IZzxGSaYNdqLz2jC9DJJOA6tQGneSJNMA4b/5Kg0yGli8CWHM4f7CNg
 KtuPyaOtHxfZ3FAAJvPul9OxpnqLZq64XofCSBpglieUBgUdrHmIhuNu4DXMbNFQwtw+
 yIw4rC7DWL9atgB1x+4AjBKz/W3Dr3YUZhyg081UCuxTwCP1Y2DTOuhU6BHLxcfg0jly
 ywgFrSCNJg0a23QnKGfAuwuuarn5pOKsJiYwlRHsyzQt/D4svAWtjEUUjDMQfYFXALGg
 IvfA==
X-Gm-Message-State: AOAM531rbpES7CGHp1jhwBp+VOf1eCjvxPwJ50VDMoPZJUNNopj1amYZ
 fA/MMgO67qrjC61sk3IRPvHx7w==
X-Google-Smtp-Source: ABdhPJxMGSnZ9kJAsN6p7k0McSncvftPUJip5kVUuOxTF3REguFHe02Lgz4i9/8fJhn7M2nOfjp+aA==
X-Received: by 2002:a17:90a:9481:: with SMTP id
 s1mr5656508pjo.48.1623434110978; 
 Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 x3sm6384950pgx.8.2021.06.11.10.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 10:55:10 -0700 (PDT)
Subject: Re: simplify gendisk and request_queue allocation for blk-mq based
 drivers
To: Christoph Hellwig <hch@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa9590e3-20eb-5215-d2f7-6489169c232c@kernel.dk>
Date: Fri, 11 Jun 2021 11:55:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
Content-Language: en-US
Cc: Justin Sanders <justin@coraid.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jack Wang <jinpu.wang@ionos.com>,
 Tim Waugh <tim@cyberelk.net>, linux-s390@vger.kernel.org,
 Alex Dubov <oakad@yahoo.com>, Richard Weinberger <richard@nod.at>,
 Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
 Denis Efremov <efremov@linux.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
 Maxim Levitsky <maximlevitsky@gmail.com>, Geoff Levand <geoff@infradead.org>,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
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

On 6/2/21 12:53 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series is the scond part of cleaning up lifetimes and allocation of
> the gendisk and request_queue structure.  It adds a new interface to
> allocate the disk and queue together for blk based drivers, and uses that
> in all drivers that do not have any caveats in their gendisk and
> request_queue lifetime rules.

Applied, thanks.

-- 
Jens Axboe

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
