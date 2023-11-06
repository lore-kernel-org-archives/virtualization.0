Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3457FC4332F
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 10:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEFA241F6D;
	Mon,  6 Nov 2023 10:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEFA241F6D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ux4XiRTB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ZtgVYjaSPje; Mon,  6 Nov 2023 10:43:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F18A041F65;
	Mon,  6 Nov 2023 10:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F18A041F65
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9C94C0039;
	Mon,  6 Nov 2023 10:43:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07C26C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:43:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C0A7541464
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:43:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0A7541464
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ux4XiRTB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xq5Rs8jnUnYF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:43:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 435F741193
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 10:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 435F741193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699267433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tt2ufQi3V0WzCPqFhIfFg69WryxcO+HVUXT9JipxxcY=;
 b=Ux4XiRTB3P4EYpDP6g2Nc1UaZM0lJ85NuTBORbBlrwQnj/O5u9jR/4F1DYbt1XpqBEfDzq
 qDqoO8I4C8Q4M//TD0sx1cgfBvhyv/+zyU0Nv7TryJ3LtyjW1Jy83qkQUPu07CuGvPBnIo
 vmTkalm8sN7OBix394ovD7BLTGC0z2Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-JzPPHjqsMzOy8xrK8uaK5g-1; Mon, 06 Nov 2023 05:43:51 -0500
X-MC-Unique: JzPPHjqsMzOy8xrK8uaK5g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41cc9224395so47821971cf.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Nov 2023 02:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267431; x=1699872231;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tt2ufQi3V0WzCPqFhIfFg69WryxcO+HVUXT9JipxxcY=;
 b=h6DV3uFNmlulf4lfzxfULQa8fIr6XqiQ64sNeQWnHd6ooviIsqTm72DAluFmKEPllo
 vMd+uSpD8BkYnrvmrGXKAyynC0MYwXK8JftMUtSw1HudIoOVsmPxOzId+R2UWFu6sqUg
 ovXe8tDF5J1eE2zAgxDssvUXNx7uDMLhdf4AKX7a+E7oISqVHxTshUKgs75ZvpI7ShGp
 NoFJFckM1D/mFocJm4oSDF5wADo5DVUrED/YkNzGnXJ27NYXtOgaxvD3/nmYXLNgasNI
 3I0F0xzuGaC1c2jINHkPbBHVAB6JvwJsUZ0AX3jVI/bV7gpijg6OsjP56XilQ0QFARAf
 PekA==
X-Gm-Message-State: AOJu0YzwGmmB/oTL/zvtDCHJAm8w1GNyJD8nZ+SRGZkrSqAZbeHTn1w5
 88USonY/o/iBWQ4AwMXeOnuL552INiVF4jZ3/AuC+N4PviXICqRNYrS/F7334H+zaPq+TYV2TTg
 QwxftJCSGKbCQRG6QxzCxzfq2Rt4KXjh6lip0TVdcKA==
X-Received: by 2002:a05:622a:170f:b0:41e:1fea:8a49 with SMTP id
 h15-20020a05622a170f00b0041e1fea8a49mr33316909qtk.65.1699267431510; 
 Mon, 06 Nov 2023 02:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpuzj6aF53BZWIRx0q0bbK7VrzzNhPJJTleXguDnfuNabXjh8InW8/+0AEmmiTq79rP6tdsQ==
X-Received: by 2002:a05:622a:170f:b0:41e:1fea:8a49 with SMTP id
 h15-20020a05622a170f00b0041e1fea8a49mr33316894qtk.65.1699267431238; 
 Mon, 06 Nov 2023 02:43:51 -0800 (PST)
Received: from sgarzare-redhat ([5.179.191.143])
 by smtp.gmail.com with ESMTPSA id
 bw7-20020a05622a098700b004181f542bcbsm3295696qtb.11.2023.11.06.02.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 02:43:50 -0800 (PST)
Date: Mon, 6 Nov 2023 11:43:25 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: f.storniolo95@gmail.com
Subject: Re: [PATCH net 1/4] vsock/virtio: remove socket from connected/bound
 list on shutdown
Message-ID: <rpawubezrb23ktdzs4odz36lcyc7onyyyadcij3jxvw3sfb7yh@vawgl5x2ueoe>
References: <20231103175551.41025-1-f.storniolo95@gmail.com>
 <20231103175551.41025-2-f.storniolo95@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20231103175551.41025-2-f.storniolo95@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 imbrenda@linux.vnet.ibm.com, edumazet@google.com,
 Daan De Meyer <daan.j.demeyer@gmail.com>, stefanha@redhat.com, kuba@kernel.org,
 asias@redhat.com, pabeni@redhat.com, luigi.leonardi@outlook.com,
 davem@davemloft.net
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

On Fri, Nov 03, 2023 at 06:55:48PM +0100, f.storniolo95@gmail.com wrote:
>From: Filippo Storniolo <f.storniolo95@gmail.com>
>
>If the same remote peer, using the same port, tries to connect
>to a server on a listening port more than once, the server will
>reject the connection, causing a "connection reset by peer"
>error on the remote peer. This is due to the presence of a
>dangling socket from a previous connection in both the connected
>and bound socket lists.
>The inconsistency of the above lists only occurs when the remote
>peer disconnects and the server remains active.
>
>This bug does not occur when the server socket is closed:
>virtio_transport_release() will eventually schedule a call to
>virtio_transport_do_close() and the latter will remove the socket
>from the bound and connected socket lists and clear the sk_buff.
>
>However, virtio_transport_do_close() will only perform the above
>actions if it has been scheduled, and this will not happen
>if the server is processing the shutdown message from a remote peer.
>
>To fix this, introduce a call to vsock_remove_sock()
>when the server is handling a client disconnect.
>This is to remove the socket from the bound and connected socket
>lists without clearing the sk_buff.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Reported-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Tested-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>Co-developed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Luigi Leonardi <luigi.leonardi@outlook.com>
>Signed-off-by: Filippo Storniolo <f.storniolo95@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index e22c81435ef7..4c595dd1fd64 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1369,11 +1369,17 @@ virtio_transport_recv_connected(struct sock *sk,
> 			vsk->peer_shutdown |= RCV_SHUTDOWN;
> 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
> 			vsk->peer_shutdown |= SEND_SHUTDOWN;
>-		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
>-		    vsock_stream_has_data(vsk) <= 0 &&
>-		    !sock_flag(sk, SOCK_DONE)) {
>-			(void)virtio_transport_reset(vsk, NULL);
>-			virtio_transport_do_close(vsk, true);
>+		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
>+			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
>+				(void)virtio_transport_reset(vsk, NULL);
>+				virtio_transport_do_close(vsk, true);
>+			}
>+			/* Remove this socket anyway because the remote peer sent
>+			 * the shutdown. This way a new connection will succeed
>+			 * if the remote peer uses the same source port,
>+			 * even if the old socket is still unreleased, but now disconnected.
>+			 */
>+			vsock_remove_sock(vsk);
> 		}
> 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
> 			sk->sk_state_change(sk);
>-- 
>2.41.0
>

Thanks for fixing this issue! LGTM.

Just to inform other maintainers as well. Daan reported this issue to me
at DevConf.cz, I shared it with Filippo and Luigi who analyzed and
solved it.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
