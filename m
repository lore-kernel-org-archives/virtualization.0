Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB505CDB465
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 07:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5DD6581758;
	Mon, 16 Oct 2023 07:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DD6581758
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=tb5eKP64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VmHGD0pQzSJ4; Mon, 16 Oct 2023 07:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D384581756;
	Mon, 16 Oct 2023 07:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D384581756
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7D2C0039;
	Mon, 16 Oct 2023 07:47:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE377C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B2AD40494
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:47:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9B2AD40494
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=tb5eKP64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LoHwy5fHAl70
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:47:20 +0000 (UTC)
X-Greylist: delayed 563 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 16 Oct 2023 07:47:20 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 80F2F400DD
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80F2F400DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 07:47:20 +0000 (UTC)
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id A42BF1A45BC;
 Mon, 16 Oct 2023 09:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1697441874;
 bh=iFDKFS21j+PdzHEuBrJScpzUlh6ZN6wATcDa0c2Kovo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tb5eKP64ylz8V5E5bq3xJiABsjlgXYyijqKJnfE1NvMYLDD2BhZvoSIuDjDi5Rg2u
 uFcPmKn/3wNO2ld4If1K0I1YN+GKmSu1SGFjUqmQ/h5CAM12O48d5GPVSmAFpMqBh7
 VpcXxFgLWSt85q/RN7/fLtJ/nxKglm4rfXlq3Uy/erZ2NwbHPjwDQZVE8knNCzNEte
 hZ5hBVg+8E4uV3hYW1hUlX4Anvb/VzF2YMKsnyYTUAMVwi1d8ENgWItb2QNerFkCTk
 Dc2/l8DA4YIC5G28+VEgn9/rl7d8sSE+w0X7+TgsFeXwx8W6w+yvmXstzrWn6+2bOx
 Mn+FUAH8n8S4A==
Date: Mon, 16 Oct 2023 09:37:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSzoUVQINYrYSv8k@8bytes.org>
References: <ZSRFW0yDlDo8+at3@work>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>
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

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
