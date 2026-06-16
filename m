Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92BF3B42E0
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600657; cv=none; b=oaU8C8j3aUIrHyrRn9Y+S8KSlf8QFjvfnIb15RE878p9OirtTRteQbAQbuBsj5HnhSUxcRiWK/c0GOGbbqldV2odzU+tCw6ADxOu0fMI1iIfYqdJ4aFz9D58Kd8bg6a9Fsyb4sDam4Z5D4ahU/FehrUmicaJDEmAUSYjDAE661c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600657; c=relaxed/simple;
	bh=49w5pQXimTq2+rcz8HAdsxh2TDzJGYdv1MnREY0ukuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CA7yuMuR1VXH8kn8d+ciim2PsCiWqZktgx+QHlpB6xAMqs/xTGk2q4mJc1POruEpj/W/dzeSSEVRZTGmAYg7760zLem3eKepvA/ujQl1sc1umPuJtBC9T/U1t4LILjiO2X9zd7ahb29t0TmfwXltPn6Husycn//OnauOmax5BLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LWXn3Xit; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LWXn3Xit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=E7
	8rCGEndI8LmHgvYI64KGxmrptBpeFFszYQlWaMOcM=; b=LWXn3XitqQLYox9FZF
	uka70RynGoyaJ8LCdxttoKRYgReynewLPDlmL795qJlh9cH90XkVYfsJ1ojLSiiZ
	NeRcxTrsXkMiqZAGYkBtEjPtW1hnctKvgHxDp5UziFWRTFgX0HTH0svahYaXK3Je
	Pvi5Dc/mOxW3rwPa7R0MOvUVI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAHlAP0EDFqXkm_Cg--.9273S2;
	Tue, 16 Jun 2026 17:01:41 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: r4o5m6e8o@163.com
Cc: eperezma@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	wangyufeng@kylinos.cn
Subject: Re: [PATCH] vhost/net: fix clear_user start address in VHOST_GET_FEATURES_ARRAY
Date: Tue, 16 Jun 2026 17:01:40 +0800
Message-Id: <20260616090140.61347-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526080336.61296-1-r4o5m6e8o@163.com>
References: <20260526080336.61296-1-r4o5m6e8o@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAHlAP0EDFqXkm_Cg--.9273S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMlkIDUUUU
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzhUonWoxEPV1KAAA3N

Gentle ping. Any comments on this patch?

                                  Thanks
                             Yufeng Wang

