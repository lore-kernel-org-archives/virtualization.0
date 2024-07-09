Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8ED29CEA
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720500978; cv=none; b=ZFTF6NX7AMxQGif+QbeX4/OzI4oX21gaViSIjw0HnH/IemrB9XQdz5nxA7VTeCtJV8qN34Xj5S0OryRfLAReCjy4iK/UltMfKo9xWV2wAzrcp+FGTkrA/m0xtsTybKg7DhB7n2qzE6VxP5jSz3CXQ5BxzDHsKWWsI2HWmQVYuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720500978; c=relaxed/simple;
	bh=fE40NuZ4fShMCttqfdKrcE7vS4Ge14AIJu721WFgBlw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t9jnM06e1hDQCJWW0Tl8yTnWcgZ5zN0yc52+MaLbuC/7oLbezcBJxsnmMIVeIY7SZXSRxD0rI6DUo7r6QOaxTMcGlBmqzMRXp0ODN2LWBgOgaRIBXJZEA1tK54U/k4Idad2ZcG+bQuKiK3bU3pQ5+XFka22LTOBBxtqt0PLDIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cWa23xQh; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cWa23xQh"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAC7660A8F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 04:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.8
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GdwfMgqTTbII for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Jul 2024 04:56:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.148.174; helo=mx0b-0016f401.pphosted.com; envelope-from=prvs=4920f2143f=rkannoth@marvell.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2A04560A94
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=marvell.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A04560A94
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=cWa23xQh
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A04560A94
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Jul 2024 04:56:15 +0000 (UTC)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468HSdBN018575;
	Mon, 8 Jul 2024 21:56:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=TMKLR/0PKelWoujxJYU+fiWjMTu5eV4CiT1fo2IfKSM=; b=cWa
	23xQh70DYfsJN7ciSqYOnwK8u0RpONdJmpvM1ng6BUCA1fK0w8N4D3C6INV5Uumd
	ZMWfg4JTwgVAi0IBR+ghTtQbk+z883U0lK5yQnZ4BsnpXvfzxpxDf8y+kLXNcfwp
	8ui8SBHFSaaz9Q0uZMeNYDYp67Ww0/Q63BzgdTKhI9Wv5eXo9omTOWaZuAElgq6q
	50I2EW3QUcCjfM/bh9FcSJtqfr+TOrGvQHDM5elTACZ8yFHYYPMvyOw8JRZbxl6c
	KLKACddxRA3CqvMKYJeSt0+dmHT/iPq0NYkgcDgP3QWOyoiUj3tVfqjOgnJxzAJh
	S3bqIj/8C2s5ZXm2bQg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 408mhj9t05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 21:56:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 8 Jul 2024 21:56:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 21:56:13 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 659963F708C;
	Mon,  8 Jul 2024 21:56:10 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:26:09 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Cindy Lu <lulu@redhat.com>
CC: <dtatulea@nvidia.com>, <mst@redhat.com>, <jasowang@redhat.com>,
        <parav@nvidia.com>, <sgarzare@redhat.com>, <netdev@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Add the support of set mac address
Message-ID: <20240709045609.GA3082655@maili.marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-GUID: 6kD9ztUZzetUgUO0QDgZjLX08ELTRIsx
X-Proofpoint-ORIG-GUID: 6kD9ztUZzetUgUO0QDgZjLX08ELTRIsx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01

On 2024-07-08 at 12:25:49, Cindy Lu (lulu@redhat.com) wrote:
> +static int mlx5_vdpa_set_attr_mac(struct vdpa_mgmt_dev *v_mdev,
> +				  struct vdpa_device *dev,
> +				  const struct vdpa_dev_set_config *add_config)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	struct mlx5_core_dev *mdev = mvdev->mdev;
> +	struct virtio_net_config *config = &ndev->config;
> +	int err;
> +	struct mlx5_core_dev *pfmdev;
nit: reverse xmas tree; may be, split assigment and definition.

>
