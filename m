Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895CEC38145
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 13:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0887A414C8;
	Wed,  7 Sep 2022 13:45:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0887A414C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=GiCtPyNd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zWcKn3lwfVGR; Wed,  7 Sep 2022 13:45:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3978741295;
	Wed,  7 Sep 2022 13:45:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3978741295
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13A50C0032;
	Wed,  7 Sep 2022 13:45:33 +0000 (UTC)
Received: from smtp3.osuosl.org (unknown
 [IPv6:2605:bc80:3010:0:a800:ff:fe58:3b77])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94DF7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 13:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 700A560BEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 13:45:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 700A560BEF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=GiCtPyNd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PJonfhX7zDgx
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 13:45:31 +0000 (UTC)
X-Greylist: delayed 05:06:42 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4544F60BF5
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4544F60BF5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 13:45:31 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 9925F40793;
 Wed,  7 Sep 2022 15:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1662558328;
 bh=iFiaRZ7atn07KtTJA7EX1xTm4N7M+wbNCgbxCsXt6Ak=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GiCtPyNdqHxtBjuEcikhA6TYHpIaQ8bPP05J5GUs6etfMDU5/fh+/tAQEiWCD3/FM
 W1C4r/FZ5AAo9bF/QzBv6+1Rhp3LdH3aE7kxnw/hcSIhnI99R6EcVy/cylBBHUXSC1
 mx/+c26Hu8aIG3aVAbc7es7hp3tYgRCWywpbZs3FoCuZHmGY0QFCgESio3LKtGdWc1
 YCheiFy5UAybYr2J5c1+XeS5JHBq27r9oIPjf5F6r6sKHWmJ9WXVUs0cSgqlWzRDI5
 RT5HFx7gNd7EkPFG/nM+y9aWj0GU55rXpE77WTcZarorEyMrZc4gMzwx4Jx9QtDOMK
 gPhl4x0trSGcw==
Date: Wed, 7 Sep 2022 15:45:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3] iommu/virtio: Fix interaction with VFIO
Message-ID: <Yxigd/hKLp8g6UfJ@8bytes.org>
References: <20220825154622.86759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220825154622.86759-1-jean-philippe@linaro.org>
Cc: robin.murphy@arm.com, iommu@lists.linux.dev, will@kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Aug 25, 2022 at 04:46:24PM +0100, Jean-Philippe Brucker wrote:
> Cc: stable@vger.kernel.org
> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Since v2 [1], I tried to refine the commit message.
> This fix is needed for v5.19 and v6.0.

Applied for 6.0, thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
