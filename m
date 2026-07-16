Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6822301;
	Thu, 16 Jul 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165141; cv=none; b=r5ByWOTOsM7BptZgi24Wbqpjx/U5SRW2kv3WA70ZlsWWHIFgTzzDIJOs9TASM43nZy3rKA9+CJTn/RdmhOmOSeoDDpe2S3bvuW1KLkMQIXvMFqOPgTbJoEJrvxjUxvzqTYR1QyVMOyTCJ2tyGoUiMynQIdyvE5JsCT4dCoHlECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165141; c=relaxed/simple;
	bh=o+2Etr9Yn40LIkKBZoSSZGteKeHuGTa1bIsdLdlAubU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qR2cKmZdBlRazVfIG7SsV6JJynko+lUOwaCJhgenhHYyJYIJ7S0X4EpZKkU75FTP5pQjEFeRiI6ibj5He7LzXy+fUe5iKvk9laCWk7G2VcLiJ5TTVpCMWhWgtT6sWED5nX7YLqu1013OPOVS/b4KbmfjSeuMgfYcvBwayvh9evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KldsCUs0; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KldsCUs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=o+
	2Etr9Yn40LIkKBZoSSZGteKeHuGTa1bIsdLdlAubU=; b=KldsCUs0OuTei3TFM3
	iX2b2lcrGHD5tLwLlSUCxcaUeh+fQ8dFv0idCwPnzCP3vkYEOozcOoZHnLDLSDTL
	+rySnESCvWaE5/lCG/wlgexZoTvPXH5iiHKpyd6h+FVJFhD9DG+Reh8xUBvL9Cw7
	xPyvcN0HkmPhcSKQfqd7n8eLo=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3V3r1MlhqRHIIJw--.18383S2;
	Thu, 16 Jul 2026 09:25:10 +0800 (CST)
From: Weimin Xiong <xiongwm2026@163.com>
To: virtualization@lists.linux.dev
Cc: iommu@lists.linux.dev,
	jpb@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Subject: Re: [PATCH 1/2] iommu/virtio: Set driver data before enabling virtqueues
Date: Thu, 16 Jul 2026 09:25:13 +0800
Message-ID: <20260716012513.89178-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V3r1MlhqRHIIJw--.18383S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVXTmDUUUU
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbC8BZ6CmpYMvb6fAAA3m

Sorry for the noise. The two patches are duplicates of what I already
sent earlier. Please ignore this series.

