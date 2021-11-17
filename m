Return-Path: <SRS0=9pi5=QE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D013C433F5
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:24:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16F6617E3
	for <virtualization@archiver.kernel.org>; Wed, 17 Nov 2021 17:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B16F6617E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7370860758;
	Wed, 17 Nov 2021 17:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJFhu9htxyMe; Wed, 17 Nov 2021 17:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CED8606BF;
	Wed, 17 Nov 2021 17:24:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12D7AC002E;
	Wed, 17 Nov 2021 17:24:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D53C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:23:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BEA44400E4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:23:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G6GsiYccBNJn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:23:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D28C8400E3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 17:23:57 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id
 j6-20020a17090a588600b001a78a5ce46aso5843194pji.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
 b=ugoMYNkhm/G9Ix/5oCvQZm0YAcysEe7w+8Ut7tdQ1MFfrFb++jT//Ye1Xif9z6ocKL
 upYEOlPYxRg426dSTkVWYqWTkYaINK0U1vjW0pz5KiVAdk24VzI9knnC+oq6VqBtR51R
 JsxZQwr6hfjAqg3NR5DXPnxzqFiDdVPzmokHwBWYbFcA7C4C1b/5vK2dlQpMEeU3BunN
 ptnIlMbRnCC/lX9LzDScYnrYijxgLzkCxo7ONiPawkK0khOy+cYFezVV1WUfTrdZx19A
 ia0nC0GD3aEx0ZtVWJVu5+3TyvxHmXgSem7quozm86z+iCZ04tmZvCRneUg4q76UfdBV
 iVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B1Ni0fagjZGByTTcZKwa1vZXhbm3ZKX3g7qTKHJy/9Y=;
 b=OSbB2w8RRvMKwasUQ2mIAfnPLQjcEp6C2TM5rvhaxMAJMGfLOIV9H3fJ7XPzhEl3CS
 QqkFWMrkgnpb5cFPEqOTW/7DXiPLNmrFfBC/XoT5n9QT/CDT8/c5OFt3ymXC73UxIEzo
 VmmzseI7TZ0bsXvfNl5NOv4Hc7OP7qZfekeyxQqWkJkm0EhkuWXuLOy60Ylzsn/lOUVe
 yF8JLMVZCodhFHrtxGeNj4ZMFotOsAwXmlEOVa87afm5KvsNFKMzWJnEa66xDp2dVq3R
 pjzT5tPun9N55ag2cc5DykaLh9h64+augBstEn+gfyReBJWK6kpKViMcVqMKNwLhtQJK
 pCDA==
X-Gm-Message-State: AOAM53176S9XjZ3qQXmgCHO2j5CwTxxH+cuaiayYTgcJ5WK/v2pxVvra
 OpXV2QLTKZd2c51ppEsHPRyu6HO+jdPf60AciiIV/Q==
X-Google-Smtp-Source: ABdhPJxkIf4IjyDIAL/AOyg+wZo8KXg00Li3POnr9FoL4MtTk7+2uk0M9RLmtvaFQhBaLJ5ZjvKGrbUA1Og0jd55rz0=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr56745818plb.4.1637169837229; Wed, 17
 Nov 2021 09:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de>
 <20211109083309.584081-3-hch@lst.de>
In-Reply-To: <20211109083309.584081-3-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 17 Nov 2021 09:23:44 -0800
Message-ID: <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
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
> The device mapper DAX support is all hanging off a block device and thus
> can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> be built under CONFIG_FS_DAX now.
>

Applied, fixed the spelling of 'dependent' in the subject and picked
up Mike's Ack from the previous send:

https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com

Christoph, any particular reason you did not pick up the tags from the
last posting?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
