Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192D22C027B
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779849748; cv=none; b=XYlwLhQD8ScSsyzr3LaWD+sD3TMhoA4HCOTCTQ8bHzD1ZMcGCSurhV/5En/X/a9B/5oaeDyH82PjwylnPDfR60o1jSS/UTRgk2QODvRLGhwq7tIhGKvvjoSeGCiZK6od1J2heot3O8WP0kRoUbYgj0D+LaTsj73sQG8Z+Mresvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779849748; c=relaxed/simple;
	bh=LWLxBWu0oUQRieiXt3Qx1lppTPdmdDzSyoQOZ1xnVnU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rZgl7fjjIi0D7fUccOx7/UuhlBVOBcC2ShxIF6NKogAlP8E04ulu9ggrY/XS+L+E4xV6Mdkg71fW7ijPle7xm8xOx1nGmqh+AZuQm0KIeP8A94lDwAMrxiEVfjIaz7Ez4qRokQ2ljb6RpqSofuhdd/SUvWZFBpOUYMvWdLZCdV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N81+mgxL; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N81+mgxL"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LWLxBWu0oUQRieiXt3Qx1lppTPdmdDzSyoQOZ1xnVnU=;
	b=N81+mgxLPtVXoU54AzsJhQF4Q8GJIAxAhJ0adTotEs6zdN5jLHxMCkN7uqGR9iHjt/UbC5KCl
	JhasNzuWfnr/gRtj5IfWjPyzBEFTiBgUv1kTQA+A0q6fsHfWJxw1HVxOuMF0S6VP4KYV8VNhk8K
	w5dnC/mCBdwEx0we81TjCi0=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gQDGj6V0pzcb43;
	Wed, 27 May 2026 10:34:37 +0800 (CST)
Received: from kwepemr100009.china.huawei.com (unknown [7.202.195.37])
	by mail.maildlp.com (Postfix) with ESMTPS id 1428A2025F;
	Wed, 27 May 2026 10:42:24 +0800 (CST)
Received: from kwepemr200017.china.huawei.com (7.202.195.7) by
 kwepemr100009.china.huawei.com (7.202.195.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 27 May 2026 10:42:23 +0800
Received: from kwepemr200017.china.huawei.com ([7.202.195.7]) by
 kwepemr200017.china.huawei.com ([7.202.195.7]) with mapi id 15.02.1544.011;
 Wed, 27 May 2026 10:42:23 +0800
From: "malin (R)" <malin89@huawei.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Arseniy Krasnov <avkrasnov@salutedevices.com>, tanjingguo
	<tanjingguo@huawei.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, Chenzhe
	<chenzhe@huawei.com>, cenxianlong <cenxianlong@huawei.com>, cuirongzhen
	<cuirongzhen@huawei.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Thread-Topic: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Thread-Index: Adztggm6M3GXlP0rSUS4BU76FCpiCg==
Date: Wed, 27 May 2026 02:42:23 +0000
Message-ID: <bd2b60d9ee5d4edfae4a7ce58ace71a4@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello Jakub,

> The email headers are duplicated on this patch.
> This appears to confuse git am into thinking the patch is empty:
>=20
> $ git am mbox
> Patch is empty.
>=20
> Please fix this and repost (please add the review tags you already
> received in the repost)

My bad. I have sent the right post with git command.
https://lore.kernel.org/netdev/20260527023301.1075581-1-malin89@huawei.com/=
T/#u

Please let me know if there is any other problem.

Thanks
Lin
