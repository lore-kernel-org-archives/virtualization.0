Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFABC433EF
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 07:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5616940986;
	Tue,  5 Apr 2022 07:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kXu99buKreyV; Tue,  5 Apr 2022 07:01:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A8754408EC;
	Tue,  5 Apr 2022 07:01:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84393C002C;
	Tue,  5 Apr 2022 07:01:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA9CC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9674040951
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HHu3SYc4Bhgz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:01:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E060E408EC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mp3FkWfau1S2xgosNtCUIbLswXRyF5ZJmpSQNxIjOFE=; b=PceITjenUqvRPWFAG6YacvJf+N
 BsmuQX2njcZATW05zeEES/1ee8MArXUr7R6qqJwCDSTFPAT1Zk78SOOan1d9vu4cJOirnaXtA+WJX
 MKxURMhhS0wEyDQ0AuT0m8T3UsDgEX3so22MnTCf++9VWRjdNbT7Y318dAxRmpfkexBNYZLbLV1ms
 AyrG3GcQkTK/zHEf8faCUzZ5sattia6epZcg0hxU+HVLWBA6P4AOiyEX2dRta+u90l818EBP5JzhQ
 eAiPAGzhMrpvLYooUfhjaAXxSalShLj7i9+sF6Pe7nVtJbO9eCtJ/U1V8FWl4XSIbIYWJN1iPJYBL
 drGYOZfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbdC3-00HOXX-UA; Tue, 05 Apr 2022 07:01:35 +0000
Date: Tue, 5 Apr 2022 00:01:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/8] virtio_ring.h: do not include <stdint.h> from
 exported header
Message-ID: <YkvpT3PFcbgcMCWy@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-9-masahiroy@kernel.org>
 <Ykqh3mEy5uY8spe8@infradead.org>
 <CAK8P3a07ZdqA0UBC_qkqzMsZWLUK=Rti3AkFe2VVEWLivuZAqA@mail.gmail.com>
 <YkvVOLj/Rv4yPf5K@infradead.org>
 <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a0FjfSyUtv9a9dM7ixsK2oY9VF7WZPvDctn2JRi7A0YyQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-arch <linux-arch@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization list <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>
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

On Tue, Apr 05, 2022 at 08:29:36AM +0200, Arnd Bergmann wrote:
> I think the users all have their own copies, at least the ones I could
> find on codesearch.debian.org. However, there are 27 virtio_*.h
> files in include/uapi/linux that probably should stay together for
> the purpose of defining the virtio protocol, and some others might
> be uapi relevant.
> 
> I see that at least include/uapi/linux/vhost.h has ioctl() definitions
> in it, and includes the virtio_ring.h header indirectly.

Uhh.  We had a somilar mess (but at a smaller scale) in nvme, where
the uapi nvme.h contained both the UAPI and the protocol definition.
We took a hard break to only have a nvme_ioctl.h in the uapi header
and linux/nvme.h for the protocol.  This did break a bit of userspace
compilation (but not running obviously) at the time, but really made
the headers much easier to main.  Some userspace keeps on copying
nvme.h with the protocol definitions.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
