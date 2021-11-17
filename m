Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95251C433FE
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456CA613A1
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 456CA613A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ADD8403D6;
	Wed, 17 Nov 2021 17:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U8cr9irC_PZ3; Wed, 17 Nov 2021 17:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C19D0402EA;
	Wed, 17 Nov 2021 17:44:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA831C002E;
	Wed, 17 Nov 2021 17:44:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C485C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F276E40327
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zG8PLfK24WAy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4271C402EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:44:39 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id b68so3325675pfg.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
 b=AhgC+2wjkr5d9yDLbCved4jaDjwAVOHHegPWWTmEA1k+UoMOMYjm4jdejJ0FNzHR6s
 c5CZZTpF5RcDbQWqOsFLQ+5n3WzHTDlujVf/JCPu7XZBET18Z8qLE0BanPT0rnfK5Zu9
 KyIvCY0B/udnAqmbfZZUOtpDWwYOaZvFxMVOaWJLK5nqRMnfBvKrqK4xPQYQJSiLOVa8
 0rlfBALzCZrz1lMqwQv6qq3GRi5Jd7hsx8WgDG14wOcf8TDRiDnZ6oCTTfiQ53aT4YRB
 Vf3FTTZZnWUbXVIHLEPwTQXniddBnZWJsqT6SgaoHFJDwC1BLNE6VpCGlp3JGhptmlcC
 V9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+uFdsysPKBJg8+GUKCjjrR+fu42d0RKVIlJ5p5O3Gqw=;
 b=pWLrsgYjkqm3iqzeQxT7b9wUmmCOU769FwVx6Twa62R5YUNDHsW7aGVRCfjtbg7MO8
 PzQUz9A/mTmJW9fNvKX2KdWjy7sl4tKmdTwwBm94IJYwnUQK3hX4vRZld82X6G1RSAb9
 0wyH+2Zq/xAlAkeVOX1K7pm1tn3M0982qxk9rioL3EMv2itXNldlH9TtBcCy54Ulld3n
 wxUoQw53AbFkwETfRlTK6tUdZrMbt3Waiq6PFQpnYLnv2SjFgHB2QKZBJwKC/bHZWtMN
 vnuwDEK+F3WvRY2oPFoYx3E2/BYh9wJL75YzcXyHTybb/BGPkiSTp3RFmSBTwIfjLU0J
 6/Aw==
X-Gm-Message-State: AOAM533CtxBVyjDs4VxjVbZolX/uHJeYYqh+6qyQFdZoxtH7jIqRhpKF
 OfG1ccDb7b9UMB5j3L0FwJR/Ar3059UBfjixJUvhxw==
X-Google-Smtp-Source: ABdhPJxiiB8Ak1RjXFinVMdC+8Tb3rrtEkfJ8k6NlxRhm42dcgWCdDR0kkUYUFwrF8G9DBBrfo1Xmvo4+uUGPt+QmE4=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr37260918pfe.86.1637171078758; Wed, 17
 Nov 2021 09:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-2-hch@lst.de>
In-Reply-To: <20211109083309.584081-2-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Nov 2021 09:44:25 -0800
Message-ID: <CAPcyv4ijKTcABMs2tZEuPWo1WDOux+4XWN=DNF5v8SrQRSbfDg@mail.gmail.com>
Subject: Re: [PATCH 01/29] nvdimm/pmem: move dax_attribute_group from dax to
 pmem
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Mike Snitzer <snitzer@redhat.com>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-xfs <linux-xfs@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
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

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> dax_attribute_group is only used by the pmem driver, and can avoid the
> completely pointless lookup by the disk name if moved there.  This
> leaves just a single caller of dax_get_by_host, so move dax_get_by_host
> into the same ifdef block as that caller.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://lore.kernel.org/r/20210922173431.2454024-3-hch@lst.de
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This one already made v5.16-rc1.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
