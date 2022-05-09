Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D58C433F5
	for <virtualization@archiver.kernel.org>; Mon,  9 May 2022 06:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5005660F32;
	Mon,  9 May 2022 06:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 44KJqZUSHZhg; Mon,  9 May 2022 06:31:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E392460F2F;
	Mon,  9 May 2022 06:31:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C069AC0032;
	Mon,  9 May 2022 06:31:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CA94C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1362F60F31
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:31:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MdBm84uZfGr8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:31:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A03460F2F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 May 2022 06:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=o+pQ2wGG2YVWS04fCC8y8+WAIR
 OMv/pg4hxMPTD5mPiCT91kL+mAyrLelwTcwQ07UY9WfUCxctEn/0fZ+K6CnVCzuGg3JC3G8zkg+Yl
 6WlVZyz4KU4W7nzIiD1myHbqCRByD7J59wpGzBohi7UMmJ5MPQjRWTNe9M1IHLbNSe1747n8AA4TF
 4bM6O/7hSbCgH42ZfLYGmyFALaHZvcqYXWJPWpwkU6r87XSNhTpH3vjhzuBCn/StFI5LgwFkUXzYV
 PQIFWOA940r35Nxv7DVXtr6tXAEI9VQfACQXdaRWXH0xCOPX4/txiFZADLOBqCBQf1F46BPDj/iQZ
 ZIIwvI6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nnwv5-00Cgzc-Gk; Mon, 09 May 2022 06:30:59 +0000
Date: Sun, 8 May 2022 23:30:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3 1/2] kernel: add platform_has() infrastructure
Message-ID: <Yni1IxTY5lxDj9aU@infradead.org>
References: <20220504155703.13336-1-jgross@suse.com>
 <20220504155703.13336-2-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220504155703.13336-2-jgross@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Vasily Gorbik <gor@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
