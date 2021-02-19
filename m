Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA93C433E0
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 10:14:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C137064EAF
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 10:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C137064EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A1C5286BF1;
	Fri, 19 Feb 2021 10:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTNnsN1hKluP; Fri, 19 Feb 2021 10:14:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BA566869CB;
	Fri, 19 Feb 2021 10:14:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FE4BC000E;
	Fri, 19 Feb 2021 10:14:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52308C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 10:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4089686B70
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 10:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D2MV6nPZGCok
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 10:14:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8731C86B6A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RJkUgC/iQhNKeXe0maTV0ikvP4g9JnesDTSCL+skfaQ=; b=o2/K5PYzj8bZkoDS5ZSHljNFAF
 isafR5NuTHsOdce4HzE0xEF+QV9OE4ICObUtJuUzN3K+VUv7/jHqQGBMyTF1da2Ii89TgCH2VKhio
 CSFFJLhk/pNYgAnyW1yyS5L0BmZQVJbQX/PMEzczsK5O/xbeGaeALFd6Rf/WxbdaCkGdFjULf/MqB
 m5E/H0fekjK9KxKoElxE4VNkjlKJ7rggYDoDePzgPadrNJMA1CmDbyLb0jOsN7URaWjqUli48Dv3v
 lIQc5Wo02lUPp2yPXvRXb8VhqfjwYtDqVD6d+f+CoqMcIsZZiKN/m2hfkuuXrbkq26G3o4MEWljwN
 YuW6YTZw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lD2mn-002jqk-Vl; Fri, 19 Feb 2021 10:13:30 +0000
Date: Fri, 19 Feb 2021 10:13:21 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210219101321.GA651861@infradead.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219084509.48269-1-jasowang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>
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

On Fri, Feb 19, 2021 at 03:45:09AM -0500, Jason Wang wrote:
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
> 
> So this patch fixes this by hide the prompot and document the
> dependency.

Is there any good reason to keep the symbol at all?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
