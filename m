Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F6DC43334
	for <virtualization@archiver.kernel.org>; Wed,  6 Jul 2022 12:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6B8C60FCF;
	Wed,  6 Jul 2022 12:11:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6B8C60FCF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=e2hOt58q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mspHQOCgXBoZ; Wed,  6 Jul 2022 12:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7AB5A6074C;
	Wed,  6 Jul 2022 12:11:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7AB5A6074C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4923FC0033;
	Wed,  6 Jul 2022 12:11:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B96EEC002D;
 Wed,  6 Jul 2022 12:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D28541839;
 Wed,  6 Jul 2022 12:11:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D28541839
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=e2hOt58q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJthZlDn17jw; Wed,  6 Jul 2022 12:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 42F54417A1
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 42F54417A1;
 Wed,  6 Jul 2022 12:11:12 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 1B7EACE1F6F;
 Wed,  6 Jul 2022 12:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3170CC3411C;
 Wed,  6 Jul 2022 12:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657109467;
 bh=2CdrEErWvvgDIbUAWRkAn9JrX8b38GrwM68HdHXvssc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e2hOt58qeJS6fCVticXw4yTeuBWlWu3CG/wLEvQpxwYWciMwrI+LbKIJOFBwcx/3N
 1zDF8dkkBsL36piFRDcqZ9s2OGoEnF7n5AzzOrwO6f2CstMObJlJ2YB6kkvRIEFvYW
 MmXyN0iZ1p18q+GY8lDVpwXFX3VwnYeRYpyGr4m011ppQUF/JyTLcaV4vb+y9MjrKT
 Kb2gZr2RD8wRj/WqCZH4ExnlSuX+B+rBUKGNpTdnReiypBJJloiHYkXhsk/RPCvoyp
 QVWRnwk3Fdfv8nq2ihMCoR8+0+DEXz8ZWtxXPlIiH1HdMk3u9+aHeizJ6BQ1bPGtL+
 azJTkU8IJFXdw==
Date: Wed, 6 Jul 2022 13:10:58 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH RESEND v5 2/5] iova: Allow rcache range upper limit to be
 flexible
Message-ID: <20220706121057.GF2403@willie-the-truck>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
 <1649071634-188535-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1649071634-188535-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, mst@redhat.com, joro@8bytes.org,
 chenxiang66@hisilicon.com, linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 thunder.leizhen@huawei.com, robin.murphy@arm.com
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

On Mon, Apr 04, 2022 at 07:27:11PM +0800, John Garry wrote:
> Some low-level drivers may request DMA mappings whose IOVA length exceeds
> that of the current rcache upper limit.
> 
> This means that allocations for those IOVAs will never be cached, and
> always must be allocated and freed from the RB tree per DMA mapping cycle.
> This has a significant effect on performance, more so since commit
> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> fails"), as discussed at [0].
> 
> As a first step towards allowing the rcache range upper limit be
> configured, hold this value in the IOVA rcache structure, and allocate
> the rcaches separately.
> 
> Delete macro IOVA_RANGE_CACHE_MAX_SIZE in case it's reused by mistake.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iova.c | 20 ++++++++++----------
>  include/linux/iova.h |  3 +++
>  2 files changed, 13 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
