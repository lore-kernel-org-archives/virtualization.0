Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B2BEB64DB
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 15:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81FE84192D;
	Thu, 22 Jun 2023 15:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 81FE84192D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JPs7h+8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQOollac8jFw; Thu, 22 Jun 2023 15:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E0D8740296;
	Thu, 22 Jun 2023 15:26:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0D8740296
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1CF6C0037;
	Thu, 22 Jun 2023 15:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C400C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15AD0614DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15AD0614DC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JPs7h+8n
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CVKerPARBrEE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:26:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40AE760B4C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 40AE760B4C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687447575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s9naFD7gfaMNd05hAGGf5tsGc4tvi4lWlW620oNdE7s=;
 b=JPs7h+8nBFI2BD0GvJzGpgDAExR1ULuylEarCGfmf9TRgloCJYYbOZaJvtXg8Aq9NFAkme
 /a/rCY6a7uUMbfFX6kYxPieQBEtp9UzuG/VE4QYKtJedOPV0Cq+IJPvl/lJ5odPC3F50Tc
 /hSfCMFWGAUvl9ejjIzfEVthRx+Eumg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-k9Iera-kM62DHiB4tTl5yA-1; Thu, 22 Jun 2023 11:26:02 -0400
X-MC-Unique: k9Iera-kM62DHiB4tTl5yA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f8fe1f1199so27676485e9.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 08:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687447559; x=1690039559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9naFD7gfaMNd05hAGGf5tsGc4tvi4lWlW620oNdE7s=;
 b=dhZSoApDCBoF1JZtq63sigVL6fPU85taVnZDxrHtBYkc6Av6LyNWeMY57FOgnG8DWT
 B+x5z+qLNdBsIadw4hslK6Y42DPRYm4GV5NRM+WuQXbITenpFIh4L9EzV+hNddphRKR3
 tbhT2auk1wobWZwVrOqsCckuJNHlLMFD3NBeZjR/oLAzT5CFiEpUb6bBS2Ix7bpnCC9A
 1CTlFMg2+5lDMXRNhNggQZR1gBTmZR1qiGaWLYhr/BMr+mN3RTeA9HkvAJuLSOSH1tJ1
 v7JWYDkX/GGZPB+dbh1t5RcWYfq8DVwrNn2uBwTDOO1VRnrHJkzb47t9UgdbXfnRqfwR
 hPGA==
X-Gm-Message-State: AC+VfDzjt6UyJS2IfCv+nz7ULQUO7dv6Gq8m11BYRRKs61277Kn6r3P5
 7CklPk4EQ2Y7LI+XB09EAZ1NvzQ5pbP3uRevZKpBtOugzVsEuwPw2x1ogjuYpeAPKhcYlOMKNrK
 b0l++Zh2dsgwDaS+pS7QkQrtWB+/DYpKi6x2AV8QKOg==
X-Received: by 2002:a7b:cb90:0:b0:3f9:c2f6:335 with SMTP id
 m16-20020a7bcb90000000b003f9c2f60335mr3570368wmi.36.1687447559670; 
 Thu, 22 Jun 2023 08:25:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yc3YiqgFnTK1MzlExfaEms+r4U/DMqe75/V1PK4F+LuHCCZzMXuAmW0ik7zmWglpxBefjHA==
X-Received: by 2002:a7b:cb90:0:b0:3f9:c2f6:335 with SMTP id
 m16-20020a7bcb90000000b003f9c2f60335mr3570346wmi.36.1687447559371; 
 Thu, 22 Jun 2023 08:25:59 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 n20-20020a1c7214000000b003f8d85b481esm19011755wmc.21.2023.06.22.08.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:25:58 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:25:55 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 4/8] vsock: make vsock bind reusable
Message-ID: <p2tgn3wczd3t3dodyicczetr2nqnqpwcadz6ql5hpvg2cd2dxa@phheksxhxfna>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v4-4-0cebbb2ae899@bytedance.com>
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

On Sat, Jun 10, 2023 at 12:58:31AM +0000, Bobby Eshleman wrote:
>This commit makes the bind table management functions in vsock usable
>for different bind tables. For use by datagrams in a future patch.
>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> net/vmw_vsock/af_vsock.c | 33 ++++++++++++++++++++++++++-------
> 1 file changed, 26 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ef86765f3765..7a3ca4270446 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -230,11 +230,12 @@ static void __vsock_remove_connected(struct vsock_sock *vsk)
> 	sock_put(&vsk->sk);
> }
>
>-static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+struct sock *vsock_find_bound_socket_common(struct sockaddr_vm *addr,
>+					    struct list_head *bind_table)
> {
> 	struct vsock_sock *vsk;
>
>-	list_for_each_entry(vsk, vsock_bound_sockets(addr), bound_table) {
>+	list_for_each_entry(vsk, bind_table, bound_table) {
> 		if (vsock_addr_equals_addr(addr, &vsk->local_addr))
> 			return sk_vsock(vsk);
>
>@@ -247,6 +248,11 @@ static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
> 	return NULL;
> }
>
>+static struct sock *__vsock_find_bound_socket(struct sockaddr_vm *addr)
>+{
>+	return vsock_find_bound_socket_common(addr, vsock_bound_sockets(addr));
>+}
>+
> static struct sock *__vsock_find_connected_socket(struct sockaddr_vm *src,
> 						  struct sockaddr_vm *dst)
> {
>@@ -646,12 +652,17 @@ static void vsock_pending_work(struct work_struct *work)
>
> /**** SOCKET OPERATIONS ****/
>
>-static int __vsock_bind_connectible(struct vsock_sock *vsk,
>-				    struct sockaddr_vm *addr)
>+static int vsock_bind_common(struct vsock_sock *vsk,
>+			     struct sockaddr_vm *addr,
>+			     struct list_head *bind_table,
>+			     size_t table_size)
> {
> 	static u32 port;
> 	struct sockaddr_vm new_addr;
>
>+	if (table_size < VSOCK_HASH_SIZE)
>+		return -1;

Why we need this check now?

>+
> 	if (!port)
> 		port = get_random_u32_above(LAST_RESERVED_PORT);
>
>@@ -667,7 +678,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
>
> 			new_addr.svm_port = port++;
>
>-			if (!__vsock_find_bound_socket(&new_addr)) {
>+			if (!vsock_find_bound_socket_common(&new_addr,
>+							    &bind_table[VSOCK_HASH(addr)])) {
> 				found = true;
> 				break;
> 			}
>@@ -684,7 +696,8 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 			return -EACCES;
> 		}
>
>-		if (__vsock_find_bound_socket(&new_addr))
>+		if (vsock_find_bound_socket_common(&new_addr,
>+						   &bind_table[VSOCK_HASH(addr)]))
> 			return -EADDRINUSE;
> 	}
>
>@@ -696,11 +709,17 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> 	 * by AF_UNIX.
> 	 */
> 	__vsock_remove_bound(vsk);
>-	__vsock_insert_bound(vsock_bound_sockets(&vsk->local_addr), vsk);
>+	__vsock_insert_bound(&bind_table[VSOCK_HASH(&vsk->local_addr)], vsk);
>
> 	return 0;
> }
>
>+static int __vsock_bind_connectible(struct vsock_sock *vsk,
>+				    struct sockaddr_vm *addr)
>+{
>+	return vsock_bind_common(vsk, addr, vsock_bind_table, VSOCK_HASH_SIZE + 1);
>+}
>+
> static int __vsock_bind_dgram(struct vsock_sock *vsk,
> 			      struct sockaddr_vm *addr)
> {
>
>-- 
>2.30.2
>

The rest seems okay to me, but I agree with Simon's suggestion.

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
