Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FEE3B27E7
	for <virtualization@lists.linux.dev>; Tue,  7 Apr 2026 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578602; cv=none; b=RP4T22lOlccsJi4nBlcXrQcx5znz7u/WEMFSp5+jJVI5v3LsD2x/9807/cJtIrS6kC7CdmtfFyoUcaaUNEN+H+MhMtbtmDFvQISgGG2RmuF6UjcsMAbDbz1L6bsWjAtgK/vPImD9g45/pB7t2FNBhe3pjCdd6rsHcG13OjQeKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578602; c=relaxed/simple;
	bh=gPuPGbXlWRSbfUAJ0+MAkkynvcl+h/eihdVzlKzViU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ge40ra68HYUlyWxzLTwvIWxcO1yW4Ba6knEGNZOwpQ3h3VeINboPynRfBCuIcdvNrSuDyH0WSF0iCDX1+AIoIA71okn9DNEJ2cRULQNmLJfuMUTEiQ91tQEpGp7uOpTwv9gNHfcyKBHPsPhE97JMVlHjnK8is9RYHOqfQJAWKj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=aGNRJyx1; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="aGNRJyx1"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 5701A240005;
	Tue,  7 Apr 2026 19:16:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 5701A240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775578591;
	bh=+TUhVTfumybTv8koMfwzlnqEYgENz9VCASf0iuvfRZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=aGNRJyx1YqKYp0w7BV/27gEzzVJa+WBVQb8dYkvfvL8wN3g2nLdHDifOyT26A8DRZ
	 K5s885rIBMFEKpkAgtwC4IBuYQd8yig9dJmNx8/TwhKB31hv+omRNU1Ie2JE93tJuZ
	 oa4JZxxSM+6+ox2HiA9mjt/c9H0kXf8s12N23zNElxF796YA0ubr3WCcdtIGgg/2Fy
	 +K56t0WjQMbZqrG8hog0QqW83YrwJk+pwmxtZsT36NWyF9iv1OwB/hfNLSeLnRg3Sk
	 zw3qvyJ7Dwn0K5k4Vm52W160oy/RSCxRe8dmE55ghCFhc7lZgX+aOK3EZtzi9Q4/aL
	 YbXgXYtk0Qjvw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  7 Apr 2026 19:16:30 +0300 (MSK)
Message-ID: <a236c546-3a0f-4690-8ff7-ff8934db0539@salutedevices.com>
Date: Tue, 7 Apr 2026 19:16:24 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Content-Language: ru
To: Luigi Leonardi <leonardi@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260407-remove_parameter-v1-1-e9729360a2be@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 97 0.3.97 7b9690cd8d60a5fe8bc749a93264ffd09810adc5, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202063 [Apr 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/07 08:50:00 #28379041
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5



07.04.2026 17:31, Luigi Leonardi wrote:

> `virtio_transport_send_pkt_info` gets all the transport information
> from the parameter `t_ops`. There is no need to call
> `virtio_transport_get_ops()`.

Hm, one more suggestion, but not in this patch: may be we can also remove 'struct vsock_sock *vsk' argument
from 'virtio_transport_send_pkt_info()', because it is also included in 'virtio_vsock_pkt_info *info' ?

Thanks

> 
> Remove it.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> I marked this as net-next material, but honsetly I'm not sure if I
> should have targeted net. It's not a bug after all, it's just a cleanup.
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e85..a152a9e208d0 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -60,8 +60,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  		return false;
>  
>  	/* Check that transport can send data in zerocopy mode. */
> -	t_ops = virtio_transport_get_ops(info->vsk);
> -
>  	if (t_ops->can_msgzerocopy) {
>  		int pages_to_send = iov_iter_npages(iov_iter, MAX_SKB_FRAGS);
>  
> 
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-remove_parameter-f61a3e40cf90
> 
> Best regards,


Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
