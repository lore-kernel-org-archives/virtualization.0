Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8713777E
	for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787542269; cv=none; b=WH+aZpQsGcVhPjroPD6OQTn68f0dybHvBDJeAEq7CkhtIySL00iTbmVzSlZ92aJhIRBpy4A3q+HlhdqzduzRIIE7iJXQeE0C8RK3BTYkAHEbtbAy2rcK6SXdSE/QV2rECdvkC61f7V21Dt/F3zJF72BxGVODvjP97dpaE7/C8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787542269; c=relaxed/simple;
	bh=jjyOmc2K8X0ppmoPKALpru79/0BCrfyz/m43wThbzoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRkqfntNXwi8mS4+Pb5cf3ZOo0eYIzEEbyXgYBGvt/MVIC0jnxHH7ADEV2CnQmhCx3AR9IYec36ZNbVy9Y7m36Bgm3nVyUSPayijS9uehynNZ7Qj36ZJQfSu+atCoBHq19wQI3DXj7HCtDd5zqGHJPKlN/H/0X0YxWLjqEn7cio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=V7hazroh; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=V7hazroh; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V7hazroh";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V7hazroh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jjyOmc2K8X0ppmoPKALpru79/0BCrfyz/m43wThbzoU=;
	b=V7hazroh1fKtCcWYtjhxleGaONrY89x2ZBES+112YfpwS4//KpEEq/ETsSTkbF+buk057OSwR
	mq9FJnRTvR7ZLk6/+dgcRTsa4DJvPEH0GhkdY7bsG6FyrwECaxVTwfhEUFxigrjMDY6nVLfh8gN
	d+J6/tMcptJ24Mdqe6OG1Po=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hSxHj31TBz126Lwq
	for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 11:30:09 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jjyOmc2K8X0ppmoPKALpru79/0BCrfyz/m43wThbzoU=;
	b=V7hazroh1fKtCcWYtjhxleGaONrY89x2ZBES+112YfpwS4//KpEEq/ETsSTkbF+buk057OSwR
	mq9FJnRTvR7ZLk6/+dgcRTsa4DJvPEH0GhkdY7bsG6FyrwECaxVTwfhEUFxigrjMDY6nVLfh8gN
	d+J6/tMcptJ24Mdqe6OG1Po=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hSx4j5VMbz1T4Fq;
	Mon, 24 Aug 2026 11:20:37 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id D04B54057F;
	Mon, 24 Aug 2026 11:30:44 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 11:30:44 +0800
From: Yao Kai <yaokai34@huawei.com>
To: <yaokai34@huawei.com>
CC: <airlied@redhat.com>, <dmitry.osipenko@collabora.com>,
	<dri-devel@lists.freedesktop.org>, <gurchetansingh@chromium.org>,
	<jifa@huawei.com>, <kraxel@redhat.com>, <liuyongqiang13@huawei.com>,
	<olvaffe@gmail.com>, <virtualization@lists.linux.dev>
Subject: Re: [PATCH 0/2] drm/virtio: fix control-buffer leaks on queueing errors
Date: Mon, 24 Aug 2026 11:50:17 +0800
Message-ID: <20260824035017.2725625-1-yaokai34@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731092236.2262403-1-yaokai34@huawei.com>
References: <20260731092236.2262403-1-yaokai34@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemr500006.china.huawei.com (7.185.36.185)

Gentle ping. Any comments on this series?

Thanks,
Yao
