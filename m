Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A6221710
	for <virtualization@lists.linux.dev>; Tue,  5 Aug 2025 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376942; cv=none; b=UspNZkzhVfFpllN/jBAjpPm9bO+so7MK4JSGZXX4EK9Vq4iqkQiQQNQn2Xm6pz/ujpfwSKbh8UmKQdTnCFxtfkRmm6Yq1qUi1WnmBDU+dqEE/Eij5mNcfMeJO3onYhRv1DFnmPugZq9bcRH/um9qvr1uDXfBD0h88Nk7+y68rDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376942; c=relaxed/simple;
	bh=FArsRfCOmBNuc3e584wfTFuUp9phIDbiTEt1k6FHVwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gKVkxyLYP4AamxUJP4BeNOljG5ZGtiuOHBUdQNQM++auFwslqNblgC77fq471ro+JyeHTrSZ2V6QKoJQUElfZ1tLt4hN/u/tmIxbAQz4If9jkIT8OMMVG0HkFy3F2XvuoGELfaHSwRgKvx/rlqcDi719Q8ggdlRN5WM+xZmZDo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bx3z233LRz2TT4T;
	Tue,  5 Aug 2025 14:53:02 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CE691A016C;
	Tue,  5 Aug 2025 14:55:32 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 14:55:30 +0800
Message-ID: <a841c987-5cd1-4105-94be-e0ea55068c5a@huawei.com>
Date: Tue, 5 Aug 2025 14:55:28 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] VSOCK: fix Information Leak in
 virtio_transport_shutdown()
To: <bsdhenrymartin@gmail.com>, <huntazhang@tencent.com>,
	<jitxie@tencent.com>, <landonsun@tencent.com>, <stefanha@redhat.com>,
	<sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
	<xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Henry Martin
	<bsdhenryma@tencent.com>, TCS Robot <tcs_robot@tencent.com>
References: <20250805051009.1766587-1-tcs_kernel@tencent.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250805051009.1766587-1-tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/5 13:10, bsdhenrymartin@gmail.com 写道:
> From: Henry Martin <bsdhenryma@tencent.com>
>
> The `struct virtio_vsock_pkt_info` is declared on the stack but only
> partially initialized (only `op`, `flags`, and `vsk` are set)
>
> The uninitialized fields (including `pkt_len`, `remote_cid`,
> `remote_port`, etc.) contain residual kernel stack data. This structure
> is passed to `virtio_transport_send_pkt_info()`, which uses the
> uninitialized fields.
>
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Reported-by: TCS Robot <tcs_robot@tencent.com>
> Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
> ---
>   net/vmw_vsock/virtio_transport_common.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index fe92e5fa95b4..cb391a98d025 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -1073,14 +1073,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_connect);
>   
>   int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
>   {
> -	struct virtio_vsock_pkt_info info = {
> -		.op = VIRTIO_VSOCK_OP_SHUTDOWN,
> -		.flags = (mode & RCV_SHUTDOWN ?
> -			  VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> -			 (mode & SEND_SHUTDOWN ?
> -			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> -		.vsk = vsk,
> -	};
> +	struct virtio_vsock_pkt_info info = {0};
> +
> +	info.op = VIRTIO_VSOCK_OP_SHUTDOWN;
> +	info.flags = (mode & RCV_SHUTDOWN ?
> +			VIRTIO_VSOCK_SHUTDOWN_RCV : 0) |
> +			(mode & SEND_SHUTDOWN ?
> +			VIRTIO_VSOCK_SHUTDOWN_SEND : 0);
> +	info.vsk = vsk;
>   
>   	return virtio_transport_send_pkt_info(vsk, &info);
>   }


No. The unassigned members (including `pkt_len`, `remote_cid`,
`remote_port`, etc.) will be automatically initialized to 0?

