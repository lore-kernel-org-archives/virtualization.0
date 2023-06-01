Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0F1C7EE29
	for <virtualization@archiver.kernel.org>; Thu,  1 Jun 2023 07:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 45927416B6;
	Thu,  1 Jun 2023 07:59:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 45927416B6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tk9TUpgF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnGJLAvUNfUb; Thu,  1 Jun 2023 07:59:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5CC440A07;
	Thu,  1 Jun 2023 07:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5CC440A07
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 904E3C007A;
	Thu,  1 Jun 2023 07:59:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2459EC0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2CA96115C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2CA96115C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Tk9TUpgF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 16MK1io9nk22
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:59:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 396D9610BE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 396D9610BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  1 Jun 2023 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685606341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TS9b3RiFkUpCZDdrYBHho5/2B8BOEzYrjzr41mSr/Ds=;
 b=Tk9TUpgFU4s4XX74/8LqbRcAAdKt3s2qbMDVbGpk9WTuJ0Huk3XPE+FMK8n2huk8E1QESB
 lkuEmLDrD8hmtChSILX1MK3sLApJ2JgX02jBePbQ2JEgFleOtJgSh6M8NQFd8uB6nFfdOS
 7sfIW3qI+4HQpnx5LAqzWjzYo0JMASU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-WEJdG81IOtG16zwSVnCqcg-1; Thu, 01 Jun 2023 03:58:57 -0400
X-MC-Unique: WEJdG81IOtG16zwSVnCqcg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f4f1bb838so31664066b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jun 2023 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685606336; x=1688198336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TS9b3RiFkUpCZDdrYBHho5/2B8BOEzYrjzr41mSr/Ds=;
 b=GHv2RvJQNkJTZKhC73539QvV9FlZS06nK/Ss0j3r29aTpYhoIkop7V2v0ckCM3yzyl
 SOKgH1A6G1lnrWnX090NOXxHuBrNBhA6veMu5xdq0yJFjPcaAaAaScwLYd8fe/mfFYd9
 kNdWSnJsKZ1PACvUT1NZhfsliylIWktaCQqx84cX4pLqxZkOiGjXd6GvmhrQXH8Hmn3a
 0ZPbQrKAZzeyGT04hJrztJbau9xKMIpkImE8T8FD/ha2IZKjsZlYqir6gHuIM3soC8Et
 x9PjFshFIOC/OJ8oJcusX9hsk4bXTnUodj0STHaaTEYTayoKTURq7W7PuI0NO416xPX2
 ZY2A==
X-Gm-Message-State: AC+VfDy8sycWuLcjUEDxulwUbp/Ler3xNg5bNa+q6g74wa3cb/Zur0bL
 JKOwZ+GeMHQqOsAEJ303pTZiE2w1iiF9qcm0rZc/yakiyXru9tfoNYtQ9Q75GN3nGF4ne0uhxic
 xda3121iu1LJ91xR69eKheiVH1AnsC1XwTLh1R+HJ5A==
X-Received: by 2002:a17:907:6d1d:b0:96a:1c2a:5a38 with SMTP id
 sa29-20020a1709076d1d00b0096a1c2a5a38mr7615764ejc.11.1685606335954; 
 Thu, 01 Jun 2023 00:58:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ie3v5LmwvGb/KlhSkOFjqXmTaLy6LzatU5TWS+dAPKf5UfysEeO19vXwVk6f6zCMci8fpbA==
X-Received: by 2002:a17:907:6d1d:b0:96a:1c2a:5a38 with SMTP id
 sa29-20020a1709076d1d00b0096a1c2a5a38mr7615751ejc.11.1685606335678; 
 Thu, 01 Jun 2023 00:58:55 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.3.103])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a1709064e4500b0096f6647b5e8sm10183211ejw.64.2023.06.01.00.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 00:58:54 -0700 (PDT)
Date: Thu, 1 Jun 2023 09:58:47 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net] virtio/vsock: fix sock refcnt bug on owner set failure
Message-ID: <35xlmp65lxd4eoal2oy3lwyjxd3v22aeo2nbuyknc4372eljct@vkilkppadayd>
References: <20230531-b4-vsock-fix-refcnt-v1-1-0ed7b697cca5@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230531-b4-vsock-fix-refcnt-v1-1-0ed7b697cca5@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, May 31, 2023 at 07:47:32PM +0000, Bobby Eshleman wrote:
>Previous to setting the owner the socket is found via
>vsock_find_connected_socket(), which returns sk after a call to
>sock_hold().
>
>If setting the owner fails, then sock_put() needs to be called.
>
>Fixes: f9d2b1e146e0 ("virtio/vsock: fix leaks due to missing skb owner")
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b769fc258931..f01cd6adc5cb 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1343,6 +1343,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
>
> 	if (!skb_set_owner_sk_safe(skb, sk)) {
> 		WARN_ONCE(1, "receiving vsock socket has sk_refcnt == 0\n");
>+		sock_put(sk);

Did you have any warning, issue here?

IIUC skb_set_owner_sk_safe() can return false only if the ref counter
is 0, so calling a sock_put() on it should have no effect except to
produce a warning.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
