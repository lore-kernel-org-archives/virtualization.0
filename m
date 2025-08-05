Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F9422068A
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377667; cv=none; b=ozCrs3G+FAFfRi0Dlr6dS13lacX62Uj+SIeEmkvWtb8qHLQpgViJJpR2dFAF6GCDQoS3lbAa9tErTJmRN9Ej4DW6rupP2SJh2HT+/m5bX90TuAWIv+SRKWp3XbtkydTbsN93lv20WIM7bg0BaEuf/PUyi94C6gwj36kh/22z3/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377667; c=relaxed/simple;
	bh=Rb0r69XBJIOIgV7X/UXDvBsmqN2TD7w8ZYTo2uxLq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PKX2rLgfCOXiuwxabTOdvT4Kno8zKMA0mn7kQmqkDIb8fAaQpFz0kiNJ6OAbeEnLDwcj5ViaHhUnxXa3emilg2OrrGxoHOYfW/FtozVos5+vtefk7ZnnEdvPDaOxgCZICRd+fc6yXWrkHCYNnbsKJHuWAbeQiEP6AotB3K5c1oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bx4BG53YWz14MFB;
	Tue,  5 Aug 2025 15:02:46 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 739DD180B60;
	Tue,  5 Aug 2025 15:07:42 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 15:07:41 +0800
Message-ID: <ea9768e9-0427-4684-ad42-caad4b679639@huawei.com>
Date: Tue, 5 Aug 2025 15:07:38 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VSOCK: fix Integer Overflow in
 vmci_transport_recv_dgram_cb()
To: <bsdhenrymartin@gmail.com>, <huntazhang@tencent.com>,
	<jitxie@tencent.com>, <landonsun@tencent.com>, <bryan-bt.tan@broadcom.com>,
	<vishnu.dasa@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, Henry Martin <bsdhenryma@tencent.com>, TCS Robot
	<tcs_robot@tencent.com>
References: <20250805041748.1728098-1-tcs_kernel@tencent.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250805041748.1728098-1-tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/5 12:17, bsdhenrymartin@gmail.com 写道:
> From: Henry Martin <bsdhenryma@tencent.com>
>
> The vulnerability is triggered when processing a malicious VMCI datagram
> with an extremely large `payload_size` value. The attack path is:
>
> 1. Attacker crafts a malicious `vmci_datagram` with `payload_size` set
>     to a value near `SIZE_MAX` (e.g., `SIZE_MAX - offsetof(struct
>     vmci_datagram, payload) + 1`)
> 2. The function calculates: `size = VMCI_DG_SIZE(dg)` Where
>     `VMCI_DG_SIZE(dg)` expands to `offsetof(struct vmci_datagram,
>     payload) + dg->payload_size`
> 3. Integer overflow occurs during this addition, making `size` smaller
>     than the actual datagram size
>
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
> ---
>   net/vmw_vsock/vmci_transport.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 7eccd6708d66..07079669dd09 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -630,6 +630,10 @@ static int vmci_transport_recv_dgram_cb(void *data, struct vmci_datagram *dg)
>   	if (!vmci_transport_allow_dgram(vsk, dg->src.context))
>   		return VMCI_ERROR_NO_ACCESS;
>   
> +	/* Validate payload size to prevent integer overflow */
> +	if (dg->payload_size > SIZE_MAX - offsetof(struct vmci_datagram, payload))
> +		return VMCI_ERROR_INVALID_ARGS;
> +


The struct vmci_datagram has no member 'payload'. Your patch may trigger 
compile error.

>   	size = VMCI_DG_SIZE(dg);
>   
>   	/* Attach the packet to the socket's receive queue as an sk_buff. */
