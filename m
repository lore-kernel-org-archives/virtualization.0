Return-Path: <SRS0=Tk04=OI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90AAC433EF
	for <virtualization@archiver.kernel.org>; Sat, 18 Sep 2021 12:40:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8165A61288
	for <virtualization@archiver.kernel.org>; Sat, 18 Sep 2021 12:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8165A61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46AAE40547;
	Sat, 18 Sep 2021 12:40:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V5ZfvBZKv7OF; Sat, 18 Sep 2021 12:40:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 165BC40521;
	Sat, 18 Sep 2021 12:40:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96D6C000F;
	Sat, 18 Sep 2021 12:40:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55DCCC000D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Sep 2021 12:40:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31E3540547
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Sep 2021 12:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OQdLRw5rIz3L
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Sep 2021 12:40:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1E9940521
 for <virtualization@lists.linux-foundation.org>;
 Sat, 18 Sep 2021 12:40:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA9486126A;
 Sat, 18 Sep 2021 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1631968844;
 bh=181rwogf0AnCsX8gVJgamab5c/PSOFVPKPlSNnoLpyU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mtlCwGHRBQ86hplSM0c4ckwq/W3X1XUL48cZ7GNLR2wjSd8fyeyRvRa/MNq8ewWxQ
 fYnXiCtyA4TlTYs4LIy3NEdAWe5DxJ5lpD3cEarnqDxe+1HQ3geqBTvC8D0t76GPGG
 dItGHrn9sqc92OcdXKs1olW0EZQlpRvhiOZiiwFk=
Date: Sat, 18 Sep 2021 14:40:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH v8 2/3] tty: hvc: pass DMA capable memory to put_chars()
Message-ID: <YUXeSUVQRDXzAqhf@kroah.com>
References: <20210818082122.166881-1-xianting.tian@linux.alibaba.com>
 <20210818082122.166881-3-xianting.tian@linux.alibaba.com>
 <87pmu8ehkk.fsf@linkitivity.dja.id.au>
 <6e36640d-b55f-ece4-4cab-437ecec0964a@linux.alibaba.com>
 <614b778b-8486-c20f-d5ed-37cc3b92ada1@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <614b778b-8486-c20f-d5ed-37cc3b92ada1@linux.alibaba.com>
Cc: arnd@arndb.de, amit@kernel.org, linuxppc-dev@lists.ozlabs.org,
 shile.zhang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, jirislaby@kernel.org,
 osandov@fb.com, Daniel Axtens <dja@axtens.net>
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

On Sat, Sep 18, 2021 at 08:32:01PM +0800, Xianting Tian wrote:
> hi
> 
> Will you consider to continue the disscussion of this patch? thanks

I do not see a newer version of this series.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
