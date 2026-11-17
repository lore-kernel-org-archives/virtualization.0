Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880913;
	b=JeyhBEqQjtaecgMrfnzEuqsfC2hHWHcjzo/HnM7vBN3aWriS4PwSoG26/jZQKGpadrzl
	 uvYphSKy7IJAScXV+Aavf0hq/MQtXLvccmAFf9n3MxSuuBZZyOxUlVU3ejzTdKK6PoQbK
	 +HPQ0lgxiOaRaK6t38A5EbClrR/PnH+mW2kyLcbtJpa/mt98V4bJENzVwbzhPhdlQWs+a
	 v1LureOm5ahc2kWMeDQ59zlXUgWUHzW/dA3BAsGgYNIeuY1oEKT0KZtHXSpIkBgbMc2f3
	 RcZ16xgj61lp0wQGQI8nbRtttcFMSKP0+NWpv3iCHzOw68cbuS/DMTMT0MJbirzE+7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880913;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=Ku0j2RSSECTD5D5F5xIHoIOwMMHflp1GoH9WYHEowKI=;
	b=c6bYzJj+KUvxdFnrves9j9uWIgNjo66ETnccfnFCOspj7OBI/L5c4dtQrzXEKe10nb3K
	 21qi0e+VKMFBij0hAhuHfX+ZxQOLZVWd8Q+RpoODan3taft9CPYMFearqR0Z78yuTUcSF
	 AQEvZqQO64N69ANzykbNwTSpdX/Jqu+6W7kpoWSB0eyF/SA//Hcf5PMGtgUAxD/msdboW
	 OoGe0qO5dq4f7+xTN6S+7PoSr7ZMpPqgfXyPWYbGWIgxej8KE8WJk6I+CQ9ezOQqmlVgZ
	 D2zqpNMxsDp5DTv8qvYNW8RPyAw5HQhk0nsDBalcXojkTma4Dal2cOyzXWvGfXaBVVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gMgLOzw9;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75357606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 02:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75357606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=gMgLOzw9
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGNP9wq2501538;
	Mon, 16 Nov 2026 18:01:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=Ku0j2RSSECT
	D5D5F5xIHoIOwMMHflp1GoH9WYHEowKI=; b=gMgLOzw9LmZW/RuyYjOzGznNtyW
	BPovHIqvU89vqC1dxAvGlNO8uw32EhP78GI5Pfr6cxQOdsvv+x7UbS/PpjafVi8w
	JApvhOvR93mrpXJ/PMsy2AcdygKUacYfLDvpqJl8YNfB4SxL0pvEUJPavqwjfJAQ
	yJ05S64GGHDRBFm3cq4r+oZZn6ihwXuFegscoSLbAsNEsXTK0JP1P16/a27EKEmy
	A+SjsHZAJzJBnQXPTTYHGLkvBqyKyWPTRmVqfgHB8Za7Miw8FvPZlegYSt/uHc0L
	sht/gfA4Vytf5IXOHeyEWGEr6B2vLtf7gijgqtAjLcqj2qi7fBs6IzHpB6A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hy95pb7ek-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 16 Nov 2026 18:01:48 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Tue, 17 Nov
 2026 02:01:47 +0000
Date: Mon, 16 Nov 2026 18:01:46 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        George Zhang <georgezhang@vmware.com>, Andy King
	<acking@vmware.com>,
        Dmitry Torokhov <dtor@vmware.com>
CC: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kyle Zeng <kylebot@openai.com>,
        Michal Luczaj
	<mhal@rbox.co>
Subject: Re: [PATCH net] vsock: only undo SS_CONNECTING when connect() fails
Message-ID: <avu1igVm0ZpwRuWB@devvm29614.prn0.facebook.com>
References: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261116-vsock-connect-close-v1-1-43fb125973dd@meta.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDAwNyBTYWx0ZWRfX9UTifV07RlfW
 slr0AuCt/kRd2KZsuyTloN/zNF4zT3hqKGBGPer70FXnkQgEJptDU3x1sYhIwaOlDIXDxGSn8HR
 9r6/vHQaoeryzgv81wIV7P6ISfor3h78T4l9p2eM15CZZhaVqx2iaPPWAJvbQHMqjXFHrjz7Elg
 SLUaeDz3TSUW1h/Q3QSz1+rla1HPSKXH1Ng0IOCyjuz/J0AYNtsM4UuSg7DFtw8vvCnqvflDAk8
 Cu/AIfVPQhIobfiJEItUkzWGkQkcZZJrWGT/iTv3S/nXZEEoioy2mvowze0RQ/dOFzF7Gd1tngQ
 c4Xq+cj4P7JaxxktCfGH9MHaSHmbi8AN0Rn6XkzRxq+cl7nVF0WwVflMofOO9b5FKlygy/Axsgg
 nydTkYYYLjnNgmMW+7eht1RWdhsqkOylYAqS3xygI108uZl2uzlBRiNbW4YhK3EnppCsL5VDZpY
 4lH5ReWNbwGLMrXrnWA==
X-Proofpoint-GUID: 0JjRKIriMoQB9BLde1FIFIMcAIDj5FOg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDAwNyBTYWx0ZWRfX53Ayfa6u3Cnb
 xsgUk8LJMF183vp9ZXV96IRlF2CQnd+FQ6J9HiXqtMSjUvXNEHxk5zU10CTmHgRALRdlYdxNcLr
 4OySwOPDsNNyEv3cT5Hleuj9mWcobes=
X-Authority-Analysis: v=2.4 cv=Yuea1IYX c=1 sm=1 tr=0 ts=6afbb58c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22 a=VwQbUJbxAAAA:8
 a=LG5T7v2SAAAA:8 a=VabnemYjAAAA:8 a=X65phdXsX5pB4qzOv-sA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 0JjRKIriMoQB9BLde1FIFIMcAIDj5FOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_07,2026-11-16_01,2025-10-01_01

On Mon, Nov 16, 2026 at 05:57:53PM -0800, Bobby Eshleman wrote:
> vsock_connect() sleeps with the socket unlocked. Meanwhile the transport
> can complete the handshake, setting sock->state to SS_CONNECTED, and then
> reset the connection, e.g. in vhost_vsock_reset_orphans(),
> virtio_vsock_reset_sock() or vmci_transport_handle_detach(). When
> connect() gets the lock back, it finds sk_err set and moves the socket
> back to SS_UNCONNECTED. Userspace can then connect() the socket again,
> and a connect() to a CID on another transport makes
> vsock_assign_transport() release the transport the socket was connected
> on.
> 
> Only move the socket back to SS_UNCONNECTED if it is still
> SS_CONNECTING. A socket that got connected stays SS_CONNECTED, and
> another connect() fails with -EISCONN.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Link: https://lore.kernel.org/netdev/20260909-vsock-connect-reset-closing-v1-1-50298b9ccfbf@rbox.co/
> Suggested-by: Michal Luczaj <mhal@rbox.co>
> Reviewed-by: Michal Luczaj <mhal@rbox.co>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
>  net/vmw_vsock/af_vsock.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 1d7d53542724..6395c6a7b0b1 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -1704,6 +1704,16 @@ static void vsock_connect_timeout(struct work_struct *work)
>  	sock_put(sk);
>  }
>  
> +/* Avoid breaking the socket when another thread has changed its sock->state
> + * while we were asleep.
> + */
> +static void vsock_connect_close(struct socket *sock)
> +{
> +	sock->sk->sk_state = TCP_CLOSE;
> +	if (sock->state == SS_CONNECTING)
> +		sock->state = SS_UNCONNECTED;
> +}
> +

Actually there is an issue in the guest netns series that I think would
be fixed by moving TCP_CLOSE within the conditional block here. Will
respin tomorrow.

pw-bot: cr

Best,
Bobby


>  static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			 int addr_len, int flags)
>  {
> @@ -1862,8 +1872,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  			 * sk_state == TCP_SYN_SENT, which hereby we break.
>  			 * In such case VIRTIO_VSOCK_OP_RST will follow.
>  			 */
> -			sk->sk_state = TCP_CLOSE;
> -			sock->state = SS_UNCONNECTED;
> +			vsock_connect_close(sock);
>  
>  			/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>  			 * transport->connect().
> @@ -1877,10 +1886,8 @@ static int vsock_connect(struct socket *sock, struct sockaddr_unsized *addr,
>  	}
>  
>  	err = sock_error(sk);
> -	if (err) {
> -		sk->sk_state = TCP_CLOSE;
> -		sock->state = SS_UNCONNECTED;
> -	}
> +	if (err)
> +		vsock_connect_close(sock);
>  
>  out_wait:
>  	finish_wait(sk_sleep(sk), &wait);
> 
> ---
> base-commit: 533ec433efdc11196f438da90d683053a57257ff
> change-id: 20261116-vsock-connect-close-1beb7cb51e7a
> 
> Best regards,
> -- 
> Bobby Eshleman <bobbyeshleman@meta.com>
> 
