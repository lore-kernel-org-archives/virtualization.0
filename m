Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D4EB64D7
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 07:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C899240976;
	Mon, 26 Jun 2023 07:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C899240976
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OTrORPlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wOvt4Ob1Qx6G; Mon, 26 Jun 2023 07:54:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 469E040627;
	Mon, 26 Jun 2023 07:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 469E040627
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1866FC0037;
	Mon, 26 Jun 2023 07:54:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0947C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E17D60BA2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9E17D60BA2
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OTrORPlb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CTeH_Hx1bfnn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:54:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 18FE160B1F
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18FE160B1F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OTrORPlbKtaN3ARiMValJAU7k9
 IrlfG5KofT8GcgxXEnXhrNmWJXxJz9safI/qfz+J7XpF856oWnay8+ENcuP2fqCjqQePt7UF7Y5bu
 27Q89P80Sc5w5iUAX61bw4l40tLqGjZL71gELDXCgd18UmEhnqfSjDg75ot10RFXQftXS0SwCfb/D
 ayPfvK7kcc6nPa5ncv2LMGfg1EWuzDP8FCOQ+GTcqBs17YcSL7/4Mg/PEitoqTDgfFnzpsAty/P+T
 51oAWDKiYJaVKQiHVyAAuSiNEvOj+FQB6psDbQNzIKzVRjK+08MPayVLd9/+IA7DVoGq8M+1bbo1Q
 WSr0idlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qDh2t-009b7c-35; Mon, 26 Jun 2023 07:53:59 +0000
Date: Mon, 26 Jun 2023 00:53:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH v3] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
Message-ID: <ZJlEF6PJE5W2JoQ2@infradead.org>
References: <ZJL3+E5P+Yw5jDKy@infradead.org>
 <20230625022633.2753877-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230625022633.2753877-1-houtao@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, nvdimm@lists.linux.dev,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
 houtao1@huawei.com, Dan Williams <dan.j.williams@intel.com>
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
