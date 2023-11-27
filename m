Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2551775A
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Nov 2023 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="fO+VvxuN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C04B04035F
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Nov 2023 10:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C04B04035F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=fO+VvxuN
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mCyzactOOvgj
	for <virtualization@lists.linux-foundation.org>;
	Mon, 27 Nov 2023 10:19:31 +0000 (UTC)
X-Greylist: delayed 1042 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 27 Nov 2023 10:19:30 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E03934035D
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp4.osuosl.org (Postfix) with ESMTP id E03934035D
	for <virtualization@lists.linux-foundation.org>; Mon, 27 Nov 2023 10:19:30 +0000 (UTC)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 8C6131A6D51;
	Mon, 27 Nov 2023 11:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079325;
	bh=ezz9eUC2caA+2Tdu14GIo+of2pGcK/lrliKHiFdso+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fO+VvxuN8Hc87mMNAmJ1SLGRNIT8mNfNtMdQujA6lKxhSPDmUNjsA7456rUF5hMdb
	 SPLicYIzXe4E71HxY59PpcGpQtAinF3B0gXUjJtWJrdnKPX/D6vTT/jvfjt5HxCbef
	 /Ny2i/+SecictrROp3kP+5mw3oqI+rlf3tnZXlrTVH/WSL/QIJmbvMbnk67KnIHEXj
	 c2+U7LF1FZ/dpKAnU8Gd4BtUaj0NSqOxkI/sziKS5/eAsumAEZWyTCPWPRzqqJyhPr
	 gSkwlCrUqH4qyAOLzF4A1NezGMJCzgjjzYAFp9F2sSy+IxJHZDDNJPYObJb0coNvdz
	 DHi2I3U0sn8Mw==
Date: Mon, 27 Nov 2023 11:02:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Message-ID: <ZWRpHGOwELiDRQIv@8bytes.org>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>

On Mon, Nov 20, 2023 at 03:51:55PM +0100, Niklas Schnelle wrote:
> Niklas Schnelle (2):
>       iommu/virtio: Make use of ops->iotlb_sync_map
>       iommu/virtio: Add ops->flush_iotlb_all and enable deferred flush
> 
>  drivers/iommu/virtio-iommu.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Applied, thanks.
