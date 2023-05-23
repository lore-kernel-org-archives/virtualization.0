Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F638C77B7A
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 06:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2C2460FA1;
	Tue, 23 May 2023 06:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2C2460FA1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=palNgPOe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRCr9p1anOii; Tue, 23 May 2023 06:27:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B34560E76;
	Tue, 23 May 2023 06:27:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B34560E76
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53492C0035;
	Tue, 23 May 2023 06:27:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB42C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 06:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D472141DD6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 06:27:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D472141DD6
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=palNgPOe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eGJfyC2IWK6b
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 06:27:10 +0000 (UTC)
X-Greylist: delayed 00:07:22 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2E3041DCC
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2E3041DCC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 06:27:10 +0000 (UTC)
Received: from 8bytes.org
 (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de
 [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 73B1724819E;
 Tue, 23 May 2023 08:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1684822784;
 bh=kk/rFcdM8uF58TGv8EhNODC2C+pt9UnXaiEp3keQBfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=palNgPOeKPv3PXx6QZMklOulatBhRHQxs5jXZngY/YtcLVHszbcxq5C/iJ6TmHN2Q
 q/MBLKy5BSIlMsm861xR7QindUM9cASw3BaJtUrTNzfm2twD07Pou1BPHzk+P5gREe
 FPBH6lkebIpLRmnvt0MIGkg9QeV5MMDd4JMSPPxuISOJBe6T/Po/aImOyupkuEBP4h
 pOvPMWfTqujYlQK/7esSoE0aHcq3yg6FF2L5igVq16BpgFRJrI7CQ4yuWYo4hSJZlh
 MME1iV727/sAqz7drmziV/yaxg/SZDYBu8QiOJrMgLOuP2gQPtAA30NLXMwHZeOIi5
 /L9T6MXTddJbA==
Date: Tue, 23 May 2023 08:19:43 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 0/2] iommu/virtio: Fixes
Message-ID: <ZGxa_-jkf1olFYXK@8bytes.org>
References: <20230515113946.1017624-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230515113946.1017624-1-jean-philippe@linaro.org>
Cc: akihiko.odaki@daynix.com, will@kernel.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux.dev, robin.murphy@arm.com
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

On Mon, May 15, 2023 at 12:39:46PM +0100, Jean-Philippe Brucker wrote:
> One fix reported by Akihiko, and another found while going over the
> driver.
> 
> Jean-Philippe Brucker (2):
>   iommu/virtio: Detach domain on endpoint release
>   iommu/virtio: Return size mapped for a detached domain
> 
>  drivers/iommu/virtio-iommu.c | 57 ++++++++++++++++++++++++++----------
>  1 file changed, 41 insertions(+), 16 deletions(-)

Applied, thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
