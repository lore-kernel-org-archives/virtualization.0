Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8741AC433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Jun 2022 05:05:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A7D641C0F;
	Thu,  9 Jun 2022 05:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PgBjMrg9j47e; Thu,  9 Jun 2022 05:05:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 58818415C4;
	Thu,  9 Jun 2022 05:05:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FB11C0039;
	Thu,  9 Jun 2022 05:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D562C002D;
 Thu,  9 Jun 2022 05:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3510C610C2;
 Thu,  9 Jun 2022 05:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CyRIPOS7Gpjf; Thu,  9 Jun 2022 05:04:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B194B610C1;
 Thu,  9 Jun 2022 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=wu8aFObH2hHSMKYcBRx522Iw5QK4xZIvlYeZFEP3Kk8=; b=AGFJ5yCS6ccyDZaWrHTtIENtg2
 ewgk3wbTcgyJwqkGBn/ECO0YkpnGr1nhlzroXQ0e44S3K0rloI9v7JC83sD3Y+DkscyzxXtRq6seC
 5BE4mdWoEqX0Vgn4MxsbbkI6XMr8CcpNWB7qMagiEN2yOqELMm7CRGAWlXy+QVLDeK0tjLXFZUb9J
 JzBYTt0lYEem70Oabsxdet520DwMot9ysqcapl0IQqwDDK88mt0arOXL0CrgBrBZzbntk0nnGmXJG
 u1dvlEEXt4AiKYNPte6f6uIgPw4n1FjwNUbg8QzgaLNbbJ2FvoFqCi6bB/hwjUaqIjVN/4DtjsKn3
 waLCjuCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nzALp-00Gmug-RP; Thu, 09 Jun 2022 05:04:57 +0000
Date: Wed, 8 Jun 2022 22:04:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH RFC v1 1/7] swiotlb: introduce the highmem swiotlb buffer
Message-ID: <YqF/eZE9eozDURWz@infradead.org>
References: <20220609005553.30954-1-dongli.zhang@oracle.com>
 <20220609005553.30954-2-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220609005553.30954-2-dongli.zhang@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jgross@suse.com, dave.hansen@linux.intel.com, mst@redhat.com,
 konrad.wilk@oracle.com, mpe@ellerman.id.au, x86@kernel.org, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, iommu@lists.linux-foundation.org, mingo@redhat.com,
 bp@alien8.de, sstabellini@kernel.org, xen-devel@lists.xenproject.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, m.szyprowski@samsung.com
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

On Wed, Jun 08, 2022 at 05:55:47PM -0700, Dongli Zhang wrote:
> @@ -109,6 +109,7 @@ struct io_tlb_mem {
>  	} *slots;
>  };
>  extern struct io_tlb_mem io_tlb_default_mem;
> +extern struct io_tlb_mem io_tlb_high_mem;

Tis should not be exposed.

> +extern bool swiotlb_high_active(void);

And this should not even exist.

> +static unsigned long high_nslabs;

And I don't think "high" is a good name here to start with.  That
suggests highmem, which we are not using here.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
