Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEAEEB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 14:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22919614C9;
	Thu, 22 Jun 2023 14:57:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22919614C9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxWqeDrX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGzpcwmTigGA; Thu, 22 Jun 2023 14:57:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADDB16145C;
	Thu, 22 Jun 2023 14:57:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADDB16145C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 862E9C007A;
	Thu, 22 Jun 2023 14:57:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7362C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 14:57:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F4FF4059D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 14:57:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F4FF4059D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxWqeDrX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pz07Wncg9Xbo
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 14:57:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD4AD4010C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD4AD4010C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 14:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687445851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=StWTcZ4+l9QPhbORn1PrY5bDL4InPF3vO5n1F8OE0xo=;
 b=IxWqeDrXnLCRseigg1Smfucg6doMAZ2GsUNeZrzSI+68mgzK1CarYFG0b03nt5IUbq3O3m
 RBexMhJHYFDfUXZIa4YiKrRATdSPPPefnWrpyNMSt+5gVfWiQiJ9csmh9ql+wjszqB265+
 M4YF1AYM7BpVnHklAsCmn0vc6sNBkiE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-wC5RfAQTNeaR6xwU4ZM5pg-1; Thu, 22 Jun 2023 10:57:29 -0400
X-MC-Unique: wC5RfAQTNeaR6xwU4ZM5pg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e4d85e1ffso10906007f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 07:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687445847; x=1690037847;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StWTcZ4+l9QPhbORn1PrY5bDL4InPF3vO5n1F8OE0xo=;
 b=KhjXGkWEgcXB3KZt0EqgJjeRloyAKXa7q6ksGY8GQCtSiOZEoA6BPgI4nKebHNHLh4
 xXAMqzRkyosJRqz9P8NcVtX9Edx+CY0VDl/nVvyxtygCQSTA3YNL+wonii+PWUZOS8KS
 MTJD6h7aNZMk7e/WwMLs+JyZuIaPoPi+U6EBKn5IiykFYJKYVlZHnpj3Se5ESDr9F1DG
 AqJ+lrB+M3a6+HiMWItFwnlUtzK6grS4fdAMlXA0HaRWFCQcjzu55ywRV2a1mTRE/tnN
 LgxnlMG44ss41ypHqsVv+/8/cawFhBZG1B/0KUWG7AfxxOz6FxTYCTUZCkZ6HAVBdQg4
 uzhw==
X-Gm-Message-State: AC+VfDw7XD+8/9N+pEVMviHI9uM3Xry563MsfGy2BcCT7WRLR9EjwFKB
 UacHRDhYd2+iMfkzKYOaf32Rmd2iXciMMl90dYBGEhn7bjfj8bMB1U2gfbcXCWbokHlYgtvw1qe
 dY7X9URkCJNYKkfa5VZv+D2Iy7Sx4VVAii+qR5nBiaA==
X-Received: by 2002:adf:cf11:0:b0:30a:e435:63a6 with SMTP id
 o17-20020adfcf11000000b0030ae43563a6mr19252155wrj.4.1687445846767; 
 Thu, 22 Jun 2023 07:57:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6buBbyxIEJzfQL6PgRyTGWSK7AHMk6+0fjAWJPeOmyomH1eoQU5jcnnNJ9NYA+HxSgqoL/xA==
X-Received: by 2002:adf:cf11:0:b0:30a:e435:63a6 with SMTP id
 o17-20020adfcf11000000b0030ae43563a6mr19252133wrj.4.1687445846476; 
 Thu, 22 Jun 2023 07:57:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 e10-20020a5d65ca000000b002f28de9f73bsm7231665wrw.55.2023.06.22.07.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 07:57:25 -0700 (PDT)
Date: Thu, 22 Jun 2023 16:57:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 2/8] vsock: refactor transport lookup code
Message-ID: <ytlovggd6p6m5i3ye2y7qgtdhss57lqnohgkixp5z3imh6trv7@jnfdvnhstgyf>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-2-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v4-2-0cebbb2ae899@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-hyperv@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Simon Horman <simon.horman@corigine.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Krasnov Arseniy <oxffffaa@gmail.com>,
 Vishnu Dasa <vdasa@vmware.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Sat, Jun 10, 2023 at 12:58:29AM +0000, Bobby Eshleman wrote:
>Introduce new reusable function vsock_connectible_lookup_transport()
>that performs the transport lookup logic.
>
>No functional change intended.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ffb4dd8b6ea7..74358f0b47fa 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -422,6 +422,22 @@ static void vsock_deassign_transport(struct vsock_sock *vsk)
> 	vsk->transport = NULL;
> }
>
>+static const struct vsock_transport *
>+vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
>+{
>+	const struct vsock_transport *transport;
>+
>+	if (vsock_use_local_transport(cid))
>+		transport = transport_local;
>+	else if (cid <= VMADDR_CID_HOST || !transport_h2g ||
>+		 (flags & VMADDR_FLAG_TO_HOST))
>+		transport = transport_g2h;
>+	else
>+		transport = transport_h2g;
>+
>+	return transport;
>+}
>+
> /* Assign a transport to a socket and call the .init transport callback.
>  *
>  * Note: for connection oriented socket this must be called when vsk->remote_addr
>@@ -462,13 +478,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
> 		break;
> 	case SOCK_STREAM:
> 	case SOCK_SEQPACKET:
>-		if (vsock_use_local_transport(remote_cid))
>-			new_transport = transport_local;
>-		else if (remote_cid <= VMADDR_CID_HOST || !transport_h2g ||
>-			 (remote_flags & VMADDR_FLAG_TO_HOST))
>-			new_transport = transport_g2h;
>-		else
>-			new_transport = transport_h2g;
>+		new_transport = vsock_connectible_lookup_transport(remote_cid,
>+								   remote_flags);
> 		break;
> 	default:
> 		return -ESOCKTNOSUPPORT;
>
>-- 
>2.30.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
