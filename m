Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCB3EB64D8
	for <virtualization@archiver.kernel.org>; Thu, 22 Jun 2023 15:19:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD6DB83C8F;
	Thu, 22 Jun 2023 15:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD6DB83C8F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmqY5nNe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFyZTKmfEifw; Thu, 22 Jun 2023 15:19:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5F9E83C87;
	Thu, 22 Jun 2023 15:19:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5F9E83C87
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9FFEC0037;
	Thu, 22 Jun 2023 15:19:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5FB0C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:19:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F01742108
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:19:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F01742108
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dmqY5nNe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPYXQp-kpb18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:19:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7B9A42096
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7B9A42096
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 15:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687447157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YAWCmrAmwCl1N7fCfizEGws+8a3F56UqQiaEh7J5B+E=;
 b=dmqY5nNeKI2f93rHks+DgYGslLxI7OxoCovp2pg7vlBjaJoYpAned35eWBHRzdJvnBWebf
 sW/zghqmWlmEHmz2TsN+4UbN4sQRLmpMzMhqdbJTqwgpSyJboW74clX68mXQVSlGONhKiO
 ti6EnVM+5FeM8XPySACG8zVKLatpC7c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-CqaiulXaPKqME93qeeWHVw-1; Thu, 22 Jun 2023 11:19:15 -0400
X-MC-Unique: CqaiulXaPKqME93qeeWHVw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f810b4903fso37367135e9.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jun 2023 08:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687447152; x=1690039152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAWCmrAmwCl1N7fCfizEGws+8a3F56UqQiaEh7J5B+E=;
 b=bHsCZ1IvFEt/dFgPmMpdecOkqPWH2abJboKJ9OZ/2kc21hnMw1myPMvxg+fFWT8Tzo
 WGNynzqo8QvAuwQOvJayZ3R2mdwfWgPlw2WbAR3xwgZzHPmplloj6Y0wCom3uRPCdbJN
 XGgMTQUjqeyLOW8J+IMYZY1GQHl8PdPCqOTEa+vPZBcx6XZBGpw0WiOyEhdDZqvNiV2A
 aDGS20G8pf3ntIn7wOCIA7GU9X4y9ncBePohZDUytYX99+/Y4nZApTkyjv8IDHgLcozH
 S7CKyUxn3XxlbO4Gz4RQRut4Sdu9nDOu3zzPflOkCiz+9EaAzVgxAmrxTwA4UtPEFoeA
 QfLQ==
X-Gm-Message-State: AC+VfDwqoQ0ragPacgRIVbsw7KMdepRrLgyvEozyKQnrnJLvjOlN4Jnb
 FMj2vmL+0sVmNZXrP9H580CcWGc8pAbl2xIwiENXnMRrh4lhE3VRLrNY8tvYD/pt1nJ5y8P+HgX
 JUTS0X+SXDlNPUxyK/2FoQilyGjOeVJjiwqXnrOULpw==
X-Received: by 2002:a7b:cd16:0:b0:3f9:b119:e42b with SMTP id
 f22-20020a7bcd16000000b003f9b119e42bmr9403370wmj.30.1687447152464; 
 Thu, 22 Jun 2023 08:19:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UtO+vdPl4TbSBFba6U7sn8uXDPfnnKtHGMCmuC/vX/EQ7I92imvaPRsCck5pPB0+FXg2gyA==
X-Received: by 2002:a7b:cd16:0:b0:3f9:b119:e42b with SMTP id
 f22-20020a7bcd16000000b003f9b119e42bmr9403350wmj.30.1687447152070; 
 Thu, 22 Jun 2023 08:19:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 f20-20020a1c6a14000000b003f8f884ebe5sm8051180wmc.2.2023.06.22.08.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:19:11 -0700 (PDT)
Date: Thu, 22 Jun 2023 17:19:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH RFC net-next v4 3/8] vsock: support multi-transport
 datagrams
Message-ID: <tngyeva5by3aldrhlixajjin2hqmcl6uruvuoed7hyrndlesfd@bbv7aphqye2q>
References: <20230413-b4-vsock-dgram-v4-0-0cebbb2ae899@bytedance.com>
 <20230413-b4-vsock-dgram-v4-3-0cebbb2ae899@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230413-b4-vsock-dgram-v4-3-0cebbb2ae899@bytedance.com>
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

On Sat, Jun 10, 2023 at 12:58:30AM +0000, Bobby Eshleman wrote:
>This patch adds support for multi-transport datagrams.
>
>This includes:
>- Per-packet lookup of transports when using sendto(sockaddr_vm)
>- Selecting H2G or G2H transport using VMADDR_FLAG_TO_HOST and CID in
>  sockaddr_vm
>
>To preserve backwards compatibility with VMCI, some important changes
>were made. The "transport_dgram" / VSOCK_TRANSPORT_F_DGRAM is changed to
>be used for dgrams iff there is not yet a g2h or h2g transport that has

s/iff/if

>been registered that can transmit the packet. If there is a g2h/h2g
>transport for that remote address, then that transport will be used and
>not "transport_dgram". This essentially makes "transport_dgram" a
>fallback transport for when h2g/g2h has not yet gone online, which
>appears to be the exact use case for VMCI.
>
>This design makes sense, because there is no reason that the
>transport_{g2h,h2g} cannot also service datagrams, which makes the role
>of transport_dgram difficult to understand outside of the VMCI context.
>
>The logic around "transport_dgram" had to be retained to prevent
>breaking VMCI:
>
>1) VMCI datagrams appear to function outside of the h2g/g2h
>   paradigm. When the vmci transport becomes online, it registers itself
>   with the DGRAM feature, but not H2G/G2H. Only later when the
>   transport has more information about its environment does it register
>   H2G or G2H. In the case that a datagram socket becomes active
>   after DGRAM registration but before G2H/H2G registration, the
>   "transport_dgram" transport needs to be used.

IIRC we did this, because at that time only VMCI supported DGRAM. Now 
that there are more transports, maybe DGRAM can follow the h2g/g2h 
paradigm.

>
>2) VMCI seems to require special message be sent by the transport when a
>   datagram socket calls bind(). Under the h2g/g2h model, the transport
>   is selected using the remote_addr which is set by connect(). At
>   bind time there is no remote_addr because often no connect() has been
>   called yet: the transport is null. Therefore, with a null transport
>   there doesn't seem to be any good way for a datagram socket a tell the
>   VMCI transport that it has just had bind() called upon it.

@Vishnu, @Bryan do you think we can avoid this in some way?

>
>Only transports with a special datagram fallback use-case such as VMCI
>need to register VSOCK_TRANSPORT_F_DGRAM.

Maybe we should rename it in VSOCK_TRANSPORT_F_DGRAM_FALLBACK or
something like that.

In any case, we definitely need to update the comment in 
include/net/af_vsock.h on top of VSOCK_TRANSPORT_F_DGRAM mentioning
this.

>
>Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
>---
> drivers/vhost/vsock.c                   |  1 -
> include/linux/virtio_vsock.h            |  2 -
> net/vmw_vsock/af_vsock.c                | 78 +++++++++++++++++++++++++--------
> net/vmw_vsock/hyperv_transport.c        |  6 ---
> net/vmw_vsock/virtio_transport.c        |  1 -
> net/vmw_vsock/virtio_transport_common.c |  7 ---
> net/vmw_vsock/vsock_loopback.c          |  1 -
> 7 files changed, 60 insertions(+), 36 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index c8201c070b4b..8f0082da5e70 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -410,7 +410,6 @@ static struct virtio_transport vhost_transport = {
> 		.cancel_pkt               = vhost_transport_cancel_pkt,
>
> 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
>-		.dgram_bind               = virtio_transport_dgram_bind,
> 		.dgram_allow              = virtio_transport_dgram_allow,
> 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
> 		.dgram_get_port		  = virtio_transport_dgram_get_port,
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 23521a318cf0..73afa09f4585 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -216,8 +216,6 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val);
> u64 virtio_transport_stream_rcvhiwat(struct vsock_sock *vsk);
> bool virtio_transport_stream_is_active(struct vsock_sock *vsk);
> bool virtio_transport_stream_allow(u32 cid, u32 port);
>-int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>-				struct sockaddr_vm *addr);
> bool virtio_transport_dgram_allow(u32 cid, u32 port);
> int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid);
> int virtio_transport_dgram_get_port(struct sk_buff *skb, unsigned int *port);
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 74358f0b47fa..ef86765f3765 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -438,6 +438,18 @@ vsock_connectible_lookup_transport(unsigned int cid, __u8 flags)
> 	return transport;
> }
>
>+static const struct vsock_transport *
>+vsock_dgram_lookup_transport(unsigned int cid, __u8 flags)
>+{
>+	const struct vsock_transport *transport;
>+
>+	transport = vsock_connectible_lookup_transport(cid, flags);
>+	if (transport)
>+		return transport;
>+
>+	return transport_dgram;
>+}
>+
> /* Assign a transport to a socket and call the .init transport callback.
>  *
>  * Note: for connection oriented socket this must be called when vsk->remote_addr
>@@ -474,7 +486,8 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>
> 	switch (sk->sk_type) {
> 	case SOCK_DGRAM:
>-		new_transport = transport_dgram;
>+		new_transport = vsock_dgram_lookup_transport(remote_cid,
>+							     remote_flags);
> 		break;
> 	case SOCK_STREAM:
> 	case SOCK_SEQPACKET:
>@@ -691,6 +704,9 @@ static int __vsock_bind_connectible(struct vsock_sock *vsk,
> static int __vsock_bind_dgram(struct vsock_sock *vsk,
> 			      struct sockaddr_vm *addr)
> {
>+	if (!vsk->transport || !vsk->transport->dgram_bind)
>+		return -EINVAL;
>+
> 	return vsk->transport->dgram_bind(vsk, addr);
> }
>
>@@ -1172,19 +1188,24 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>
> 	lock_sock(sk);
>
>-	transport = vsk->transport;
>-
>-	err = vsock_auto_bind(vsk);
>-	if (err)
>-		goto out;
>-
>-
> 	/* If the provided message contains an address, use that.  Otherwise
> 	 * fall back on the socket's remote handle (if it has been connected).
> 	 */
> 	if (msg->msg_name &&
> 	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
> 			    &remote_addr) == 0) {
>+		transport = vsock_dgram_lookup_transport(remote_addr->svm_cid,
>+							 remote_addr->svm_flags);
>+		if (!transport) {
>+			err = -EINVAL;
>+			goto out;
>+		}
>+
>+		if (!try_module_get(transport->module)) {
>+			err = -ENODEV;
>+			goto out;
>+		}
>+
> 		/* Ensure this address is of the right type and is a valid
> 		 * destination.
> 		 */
>@@ -1193,11 +1214,27 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> 			remote_addr->svm_cid = transport->get_local_cid();
>

 From here ...

> 		if (!vsock_addr_bound(remote_addr)) {
>+			module_put(transport->module);
>+			err = -EINVAL;
>+			goto out;
>+		}
>+
>+		if (!transport->dgram_allow(remote_addr->svm_cid,
>+					    remote_addr->svm_port)) {
>+			module_put(transport->module);
> 			err = -EINVAL;
> 			goto out;
> 		}
>+
>+		err = transport->dgram_enqueue(vsk, remote_addr, msg, len);

... to here, looks like duplicate code, can we get it out of the if 
block?

>+		module_put(transport->module);
> 	} else if (sock->state == SS_CONNECTED) {
> 		remote_addr = &vsk->remote_addr;
>+		transport = vsk->transport;
>+
>+		err = vsock_auto_bind(vsk);
>+		if (err)
>+			goto out;
>
> 		if (remote_addr->svm_cid == VMADDR_CID_ANY)
> 			remote_addr->svm_cid = transport->get_local_cid();
>@@ -1205,23 +1242,23 @@ static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
> 		/* XXX Should connect() or this function ensure remote_addr is
> 		 * bound?
> 		 */
>-		if (!vsock_addr_bound(&vsk->remote_addr)) {
>+		if (!vsock_addr_bound(remote_addr)) {
> 			err = -EINVAL;
> 			goto out;
> 		}
>-	} else {
>-		err = -EINVAL;
>-		goto out;
>-	}
>
>-	if (!transport->dgram_allow(remote_addr->svm_cid,
>-				    remote_addr->svm_port)) {
>+		if (!transport->dgram_allow(remote_addr->svm_cid,
>+					    remote_addr->svm_port)) {
>+			err = -EINVAL;
>+			goto out;
>+		}
>+
>+		err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
>+	} else {
> 		err = -EINVAL;
> 		goto out;
> 	}
>
>-	err = transport->dgram_enqueue(vsk, remote_addr, msg, len);
>-
> out:
> 	release_sock(sk);
> 	return err;
>@@ -1255,13 +1292,18 @@ static int vsock_dgram_connect(struct socket *sock,
> 	if (err)
> 		goto out;
>
>+	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
>+
>+	err = vsock_assign_transport(vsk, NULL);
>+	if (err)
>+		goto out;
>+
> 	if (!vsk->transport->dgram_allow(remote_addr->svm_cid,
> 					 remote_addr->svm_port)) {
> 		err = -EINVAL;
> 		goto out;
> 	}
>
>-	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));
> 	sock->state = SS_CONNECTED;
>
> 	/* sock map disallows redirection of non-TCP sockets with sk_state !=
>diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
>index ff6e87e25fa0..c00bc5da769a 100644
>--- a/net/vmw_vsock/hyperv_transport.c
>+++ b/net/vmw_vsock/hyperv_transport.c
>@@ -551,11 +551,6 @@ static void hvs_destruct(struct vsock_sock *vsk)
> 	kfree(hvs);
> }
>
>-static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
>-{
>-	return -EOPNOTSUPP;
>-}
>-
> static int hvs_dgram_get_cid(struct sk_buff *skb, unsigned int *cid)
> {
> 	return -EOPNOTSUPP;
>@@ -841,7 +836,6 @@ static struct vsock_transport hvs_transport = {
> 	.connect                  = hvs_connect,
> 	.shutdown                 = hvs_shutdown,
>
>-	.dgram_bind               = hvs_dgram_bind,
> 	.dgram_get_cid		  = hvs_dgram_get_cid,
> 	.dgram_get_port		  = hvs_dgram_get_port,
> 	.dgram_get_length	  = hvs_dgram_get_length,
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 5763cdf13804..1b7843a7779a 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -428,7 +428,6 @@ static struct virtio_transport virtio_transport = {
> 		.shutdown                 = virtio_transport_shutdown,
> 		.cancel_pkt               = virtio_transport_cancel_pkt,
>
>-		.dgram_bind               = virtio_transport_dgram_bind,
> 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> 		.dgram_allow              = virtio_transport_dgram_allow,
> 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e6903c719964..d5a3c8efe84b 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -790,13 +790,6 @@ bool virtio_transport_stream_allow(u32 cid, u32 port)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_stream_allow);
>
>-int virtio_transport_dgram_bind(struct vsock_sock *vsk,
>-				struct sockaddr_vm *addr)
>-{
>-	return -EOPNOTSUPP;
>-}
>-EXPORT_SYMBOL_GPL(virtio_transport_dgram_bind);
>-
> int virtio_transport_dgram_get_cid(struct sk_buff *skb, unsigned int *cid)
> {
> 	return -EOPNOTSUPP;
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 2f3cabc79ee5..e9de45a26fbd 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -61,7 +61,6 @@ static struct virtio_transport loopback_transport = {
> 		.shutdown                 = virtio_transport_shutdown,
> 		.cancel_pkt               = vsock_loopback_cancel_pkt,
>
>-		.dgram_bind               = virtio_transport_dgram_bind,
> 		.dgram_enqueue            = virtio_transport_dgram_enqueue,
> 		.dgram_allow              = virtio_transport_dgram_allow,
> 		.dgram_get_cid		  = virtio_transport_dgram_get_cid,
>
>-- 
>2.30.2
>

The rest LGTM!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
