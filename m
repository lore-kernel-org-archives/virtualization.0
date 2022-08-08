Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557FDC00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 11:02:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C42C9416F4;
	Mon,  8 Aug 2022 11:02:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C42C9416F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V5YqgD51
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rCrhxwJY8s2e; Mon,  8 Aug 2022 11:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 120C6416DC;
	Mon,  8 Aug 2022 11:02:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 120C6416DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D66A2C0033;
	Mon,  8 Aug 2022 11:02:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10AACC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3716416DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3716416DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rZ1opYI0Jxmu
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:02:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 390C5416DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 390C5416DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 11:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659956526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dqSC8Z4HeQqm883ffB+WsfLf65IQJEdZYAKuOt873gg=;
 b=V5YqgD51quakaI+m6FGh71cy9/Wf9Pp/sgmrZafpgiGbe8sIYc6HK6lyO4zvBFVHdn/Jra
 GpdO4B7fE0a1lqHjQW5mFgwvbqov4wbr2k0vOjjA73LhOrBCmiq2WyrDRhWHf/Tvrw+M52
 eWUHbJpiiHDCFO83btklU1BGY2cX2YM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-GV2xUsCpP3u5sLguLlvQkw-1; Mon, 08 Aug 2022 07:02:05 -0400
X-MC-Unique: GV2xUsCpP3u5sLguLlvQkw-1
Received: by mail-qv1-f71.google.com with SMTP id
 kk30-20020a056214509e00b004780ff644d7so4242880qvb.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 04:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=dqSC8Z4HeQqm883ffB+WsfLf65IQJEdZYAKuOt873gg=;
 b=FuqUG/qNW68tiV1Am7EOiMFnZnPkYuxqwxomav/7lM9/tewZb3NNJb/Bwotmj4O0/n
 GUpXCLIzJmo5kaBHF4Rp9AdKqYzbyzUbnOoJaNp6h7JRwP2qjYP0GEJ8U3mAadU4H6Nb
 UQeAifeucxEnzYpBGMfuXYMJJHcONVNrsFTiaIqcODXz72MTgk5waU9KxooTEYG/VYQ0
 3pRo4zICkXs8c3V3dEjTrn4bxO78gAfs90Q+FSzGGWJQRlpOjdEqQ0XoAoTKD3LTqfJ2
 9BMt8B6Pq7SWY6WfokdrmQ99+bgY7yteSR05LkxqMz6Qu0jLfayqzn3tc7dxISHG2uFf
 9DTw==
X-Gm-Message-State: ACgBeo22j3Wl5Flt19vJNy4kj2DDW26hoD7alcbX3UHanMEidxh90HtO
 rfOKVkB7TvZIHsJyg+lMpBq61eabsetGQDjZKiNAVC1uPVL1vxl+ueCsdtRjlW6I/CLBX6zDENY
 KwQ06/MVoRcHsoAEHY6WBaXZ6EK85ALyMwjkiHIDWjg==
X-Received: by 2002:a05:6214:20e8:b0:47a:e5b6:bcb3 with SMTP id
 8-20020a05621420e800b0047ae5b6bcb3mr7619240qvk.38.1659956524320; 
 Mon, 08 Aug 2022 04:02:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5af4E0jk6+7t6mFWBjWuptUfkOlYxy4pZL8QV5ftEnM5OWH42lAy5tmEXpZlpzsK0Juazm5g==
X-Received: by 2002:a05:6214:20e8:b0:47a:e5b6:bcb3 with SMTP id
 8-20020a05621420e800b0047ae5b6bcb3mr7619210qvk.38.1659956524067; 
 Mon, 08 Aug 2022 04:02:04 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 u12-20020a05620a454c00b006b928ba8989sm885511qkp.23.2022.08.08.04.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 04:02:03 -0700 (PDT)
Date: Mon, 8 Aug 2022 13:01:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Subject: Re: [RFC PATCH v3 8/9] vmci/vsock: check SO_RCVLOWAT before wake up
 reader
Message-ID: <20220808110153.fkxwwqbbqxz7wvgw@sgarzare-redhat>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <5b7e133e-f8e1-1f71-9a3c-ac0265cffb63@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <5b7e133e-f8e1-1f71-9a3c-ac0265cffb63@sberdevices.ru>
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

On Wed, Aug 03, 2022 at 02:05:52PM +0000, Arseniy Krasnov wrote:
>This adds extra condition to wake up data reader: do it only when number
>of readable bytes >= SO_RCVLOWAT. Otherwise, there is no sense to kick
>user,because it will wait until SO_RCVLOWAT bytes will be dequeued.

Ditto as previous patch.

@Bryan, @Vishnu, plaese, can you review/ack also this patch?

Thanks,
Stefano

>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vmci_transport_notify.c        | 2 +-
> net/vmw_vsock/vmci_transport_notify_qstate.c | 4 ++--
> 2 files changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/vmci_transport_notify.c b/net/vmw_vsock/vmci_transport_notify.c
>index 852097e2b9e6..7c3a7db134b2 100644
>--- a/net/vmw_vsock/vmci_transport_notify.c
>+++ b/net/vmw_vsock/vmci_transport_notify.c
>@@ -307,7 +307,7 @@ vmci_transport_handle_wrote(struct sock *sk,
> 	struct vsock_sock *vsk = vsock_sk(sk);
> 	PKT_FIELD(vsk, sent_waiting_read) = false;
> #endif
>-	sk->sk_data_ready(sk);
>+	vsock_data_ready(sk);
> }
>
> static void vmci_transport_notify_pkt_socket_init(struct sock *sk)
>diff --git a/net/vmw_vsock/vmci_transport_notify_qstate.c b/net/vmw_vsock/vmci_transport_notify_qstate.c
>index 12f0cb8fe998..e96a88d850a8 100644
>--- a/net/vmw_vsock/vmci_transport_notify_qstate.c
>+++ b/net/vmw_vsock/vmci_transport_notify_qstate.c
>@@ -84,7 +84,7 @@ vmci_transport_handle_wrote(struct sock *sk,
> 			    bool bottom_half,
> 			    struct sockaddr_vm *dst, struct sockaddr_vm *src)
> {
>-	sk->sk_data_ready(sk);
>+	vsock_data_ready(sk);
> }
>
> static void vsock_block_update_write_window(struct sock *sk)
>@@ -282,7 +282,7 @@ vmci_transport_notify_pkt_recv_post_dequeue(
> 		/* See the comment in
> 		 * vmci_transport_notify_pkt_send_post_enqueue().
> 		 */
>-		sk->sk_data_ready(sk);
>+		vsock_data_ready(sk);
> 	}
>
> 	return err;
>-- 
>2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
