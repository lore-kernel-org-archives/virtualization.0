Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0B2C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:58:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BEE32416EC;
	Mon,  8 Aug 2022 10:58:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEE32416EC
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YHYBzEHy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HL7Zg8H58S3; Mon,  8 Aug 2022 10:58:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 09B2D4161D;
	Mon,  8 Aug 2022 10:58:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09B2D4161D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D15C2C0033;
	Mon,  8 Aug 2022 10:58:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D7D2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:58:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 554794168E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:58:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 554794168E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHePYLfW7PyI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:58:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F25B4161D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F25B4161D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659956327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BkF9VQ4oVZ/Nt6vln0zfXoLspYvmMIFVYA6ooCx7l8=;
 b=YHYBzEHyedFpo1X4GXNn6bMwFIFnlP+tSphHZkCneHUKQe/r8dHK0r1QWphB9BpzGcZOeo
 nFJoez2AUe0qRRenWPwAOzSIQ1mP0+jGeG9N5b7KIilf3ATkxJYX9/GeM4zgY/mER7UI01
 jfm0pPhmP6z3iZNRoCk6Apojx1k3VTA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-155-uss_JWuVMoWxvPRp8YPDgQ-1; Mon, 08 Aug 2022 06:58:44 -0400
X-MC-Unique: uss_JWuVMoWxvPRp8YPDgQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 k3-20020ac86043000000b0033cab47c483so6524677qtm.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=5BkF9VQ4oVZ/Nt6vln0zfXoLspYvmMIFVYA6ooCx7l8=;
 b=S4vsrA1pCyePTSE2rudCKl42sdoqNx4f/yXiaJGu1YRzI3dViPgY/MwcSTfWt5fCQK
 ZyAXqQpkQz+dHAt+7fyKGD+sgMAsishwayoVFEHJoNb5XGQKUiN6AJAG6t0JAxu24Qjo
 NrU/C1DWBiyRJQPtve4Yk1HnoxgHCJzGYjS1crXRXZRhOO6p9DILf8HkAeWcu99aygt8
 3rrigyCyVNjmyIEDQ1YaQsDIt0d650CxO+Yw8Bm6k0BoN7yTWZ8hAOtyuAewnnZqeAol
 r87Rml02hZmUAYH2ZITLCIxoz/N4C4HXf1P/sHgedl19wlSCl5dnaQ/b1dddxXethK/z
 uooQ==
X-Gm-Message-State: ACgBeo3R245bsfHIUqvZmXoyY0aWGwy2MeVwJ56nT+pj9zmrzeR8dyvs
 s7k6yYZemeqMBCFPgGRLFbNQ/A+IDkB8XSaXKGa7lMhPxhte37BoK0JJXY9wp0hVm0movKtHkm9
 6e025K64xI6N3oe7oBWZ/+6HL/4XshxnBxqngrD4KTw==
X-Received: by 2002:ac8:5f88:0:b0:31e:f6dd:8f13 with SMTP id
 j8-20020ac85f88000000b0031ef6dd8f13mr15458709qta.186.1659956323687; 
 Mon, 08 Aug 2022 03:58:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5BsuHRIUq6wXNolDgQxk5mQgfsZOfzYCRJPeNXwjqfHLEGI2rLwNjrLc7Z9hUqvybFoBiEUw==
X-Received: by 2002:ac8:5f88:0:b0:31e:f6dd:8f13 with SMTP id
 j8-20020ac85f88000000b0031ef6dd8f13mr15458701qta.186.1659956323477; 
 Mon, 08 Aug 2022 03:58:43 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 e13-20020ac8490d000000b00342f80223adsm2359896qtq.89.2022.08.08.03.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:58:42 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:58:29 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 7/9] virtio/vsock: check SO_RCVLOWAT before wake
 up reader
Message-ID: <20220808105829.fwenw7tuda4rdxob@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <e08064c5-fd4a-7595-3138-67aa2f46c955@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <e08064c5-fd4a-7595-3138-67aa2f46c955@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Bryan Tan <bryantan@vmware.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, kernel <kernel@sberdevices.ru>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

On Wed, Aug 03, 2022 at 02:03:58PM +0000, Arseniy Krasnov wrote:
>This adds extra condition to wake up data reader: do it only when number
>of readable bytes >= SO_RCVLOWAT. Otherwise, there is no sense to kick
>user,because it will wait until SO_RCVLOWAT bytes will be dequeued.

Maybe we can mention that these are done in vsock_data_ready().

Anyway, the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 8f6356ebcdd1..35863132f4f1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1081,7 +1081,7 @@ virtio_transport_recv_connected(struct sock *sk,
> 	switch (le16_to_cpu(pkt->hdr.op)) {
> 	case VIRTIO_VSOCK_OP_RW:
> 		virtio_transport_recv_enqueue(vsk, pkt);
>-		sk->sk_data_ready(sk);
>+		vsock_data_ready(sk);
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> 		virtio_transport_send_credit_update(vsk);
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
