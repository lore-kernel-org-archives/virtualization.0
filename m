Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2133A273FD
	for <virtualization@lists.linux.dev>; Tue, 22 Jul 2025 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753171008; cv=none; b=aSCofwQZrr6g5A9QR7E4NssecUDQShcdMr0XqHHYqWOjyyyulqGpy2mo5LNJdKoYug9Y60QN+AcsGAePe+5CWEYbr1SrlwJ3zYDAbzi66NObhVNR80FhP3+9C/6+ia3Ymj8SleLEjFVaBW8Bn2pah7VXhu01tpPrfX/0naQEjhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753171008; c=relaxed/simple;
	bh=sEi6Qc+0LMLSRWy4yxxZXRzpQLiDwl7qhwa3kf4qeBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irMoU92brEau+nOE4eeg9SwoQHzy58q2ytJ7eXf5nrEgCdk6gYMGQJddLWUXZ+X7t3ZM1XPwuc5zYg2+2kJK+havgGUSXJ0WofQ4eun0wamFQskN4j7XeItRds6lCHBwDq6q65De6lP1gU5AOA68KmcUazemqZI2Z5mdlj9wW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=IyBJDlZ/; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="IyBJDlZ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1753170976;
	bh=sEi6Qc+0LMLSRWy4yxxZXRzpQLiDwl7qhwa3kf4qeBE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IyBJDlZ/46kFPBbWehvroWoU9cTUfolUS5qddaAsKRZn80OHNHmJXL5SFicbDZ43U
	 sh+1rL2SBYiGrF4x6AsgQNw0sgJQRUNmAYRGP+5mzxgNm3XLGJuvOpYonGAWl7cHDT
	 kR2L1iNLPssExD0XV37gu8ZhIxeCv2cEuLyGM+6c=
X-QQ-mid: zesmtpip2t1753170967t5ee6ac39
X-QQ-Originating-IP: RjCZbseQq4oikT5GmR1Rbfwt8wXQmxJlvGsd6iZwE7U=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 15:56:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5626045234927739205
From: WangYuli <wangyuli@uniontech.com>
To: jiang.peng9@zte.com.cn
Cc: christian.koenig@amd.com,
	dri-devel@lists.freedesktop.org,
	eperezma@redhat.com,
	jasowang@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mst@redhat.com,
	sumit.semwal@linaro.org,
	virtualization@lists.linux.dev,
	xu.xin16@zte.com.cn,
	xuanzhuo@linux.alibaba.com,
	yang.yang29@zte.com.cn
Subject: Re: Re: [PATCH v3] virtio: Update kerneldoc in drivers/virtio/virtio_dma_buf.c
Date: Tue, 22 Jul 2025 15:56:05 +0800
Message-ID: <B54095728F89524F+20250722075605.24998-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250717160707018ilXWr01CnLXI8dTRDVKy4@zte.com.cn>
References: <20250717160707018ilXWr01CnLXI8dTRDVKy4@zte.com.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5znx2hx04lbAGhAtTpGT8TMqZAxGzKRNrEQKddeNz1di6XnjLJi+ZP8
	1PyOHEVqrJ0Mi7j9Sw5Cs/HRnL0Ie7HPuBQrTUrna+KUM5YGK8qBDDGNdIfeeRP1CVS3v4W
	b/ZQODKSPJpiShXBdy9z2RUMCJUkUoEAp4E1bMf9eLKDVl+v/dxYIHUVViBJlOR9E00E7la
	gA+sZYSWsUOda8Z3mxZgb5LvLgDzWuhX2Lm/Soh/uULxK1kxidGERc9+M/s7aOnHh3ONFPx
	3nkkQOm2wcYSWFPnRTRXIvgISlmGd+El90qdPzstqYKJ/rP2xr81zI3NXB+6ph/bnbDvrqI
	vkaXwqMVvjtYbtjmJ4NdZBd8/7dEmAe4dslbt42DQMoeHVnw9XE2akbEgA5tXEDL2afKWw+
	5xN7dFv+yg6OmDR1ZmbebaPmNvMxBghAwq1J3vDmFpq04u4dNEo1+3oYK+dLXWMG1NoTvly
	bFCdJxD2EMoMfC2LmuZ2+Gb8v3+fQGgdug9WE/oAhay6Eov78myJTv4xhDhfyMXnI1o1FtU
	FajytM7SwA8NVxAk/tfXWWMD5XzkIigtJmKlPpfB2hdvUjvP0u7HfeMRUHrF6brg1zWuFfJ
	jJ/t8KnTsx2h9UiFaF0Gg8dWfn5ZgNZPxiBcTJoD2cgJZ2CAPIC90VTdSZk5jI2COSh9O6O
	yNJBGUlrsfF63AnVN8n1E4X2mUIOcBHG3or5IBa8oh4cjwH0p/FJqn1J53i8IiDyeBfGHQ3
	+fm9QOuDVTdWtW20pYb4hRSCzOmNgknkJ+5EpWPaxcBoX/lYFtRudWcVcW/r/ZQO3D/u2KX
	hVk/2bz2q7KAUxp3p4QmbfwRN1Rz5/ADplFZVSZ0vutMJLCPKtSYWMxHd7fgS++fOQOCDJk
	6yF7fjZXQ2u50BFKUtwrEsfBAsPV+Th5+rnRn7OoJ9VlXA73mc/dxu0j9dYoW/eSVyIsGTl
	FVdCF4NLkXB5oH/xnSLkbIJs7ynIrd3EuRqfkECoAu4cnXVdkHCzXPg5mRJjE6Q12nSBR3z
	2E3Xa1vRDnJ/s4KC+c1bJ2t7wpIMZq4S20KMZ9Nw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi Peng Jiang,

Please feel free to add "Reviewed-by: WangYuli <wangyuli@uniontech.com>"
to your patch v4. [1]

[1]. https://lore.kernel.org/all/20250716094357-mutt-send-email-mst@kernel.org/

Thanks,
--
WangYuli
