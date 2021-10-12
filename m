Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4EBC433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:46:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 910D96103D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 06:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 910D96103D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A13C80F75;
	Tue, 12 Oct 2021 06:46:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HtyXoCtGBTAg; Tue, 12 Oct 2021 06:46:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBE2980F71;
	Tue, 12 Oct 2021 06:46:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6BD2C000F;
	Tue, 12 Oct 2021 06:46:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B68F5C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9880540273
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ND7oY3rAWNPh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:46:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED837401B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=ch35Euih1D4ciiB3AVzymRFAuy
 nC4QrxOzS3GXGIjv2jekKYj93c5sAi16rI5uHSsqPG3ZEWpDnCFTw34RyJc+rzhRU6NbHboKesTaF
 ThoU4MFVqSSXpJWNJX9Jvur8gNAaX3gr21qiQjIhzMIVBZml85bTcTbzYQv9/zJPhz4jYp6wByaBI
 bh83aD2tpRv7A5MBqCHsbN0VMV1x7TKTBPDbtF8G9ur9R2bGLq/ILa/ZNfapQJN5Y5q6jkpfIhl54
 IjWydMjTF+xH28D5Gw22eRL5PHlSbIWE5VR/o+SbgtDrxqkD2BYlmqNVgjH4AEoiIdXoFI+jUcgHJ
 tI6uIvDg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1maBVd-006H2q-C2; Tue, 12 Oct 2021 06:43:55 +0000
Date: Tue, 12 Oct 2021 07:43:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V4 0/8] Use copy_process/create_io_thread in vhost layer
Message-ID: <YWUuld90s+MIsLkn@infradead.org>
References: <20211007214448.6282-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211007214448.6282-1-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, geert@linux-m68k.org,
 stefanha@redhat.com, christian.brauner@ubuntu.com
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

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
