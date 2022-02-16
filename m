Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBB5C43219
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 16:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5DDB9404A0;
	Wed, 16 Feb 2022 16:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LbcjtwqRzFOo; Wed, 16 Feb 2022 16:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90ED6400E6;
	Wed, 16 Feb 2022 16:11:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C1F1C001A;
	Wed, 16 Feb 2022 16:11:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBA5FC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B908040186
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZ3cJMH9U4Q5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:11:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFC17400E6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645027892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TWp8XfA6tyc//eVPa5BXVi9Z+b2Xu2vCpHljwlzLi0E=;
 b=H9QynJK4i83pOcYnelDVUoJVDdAUETwjirjuU0ENWH5T+MPLvHAwq8Ma3LLAB2486BuXwh
 8MduTXe9S5Pr5xcaWhjjuddXkHJbyX2RHR4uyXFwXFu6MKric8YacprGhjJn3LiCPcsjf2
 PdhRGui7gUD9LhUCNfBPSoYZmd5dC5o=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-agNjsYotOyaRvMN3DXLslw-1; Wed, 16 Feb 2022 11:11:30 -0500
X-MC-Unique: agNjsYotOyaRvMN3DXLslw-1
Received: by mail-ot1-f70.google.com with SMTP id
 e21-20020a9d7315000000b005a6d56ac70bso1560030otk.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TWp8XfA6tyc//eVPa5BXVi9Z+b2Xu2vCpHljwlzLi0E=;
 b=M6nHZBCWAOZeLA0Xpjc7NQsFjGbTup+dqfFvea0eicsgPZzminFI/pLJTo2w9WVtz4
 7eMpXZ8YikkYARxh/XmFaoyzwM4NuY5fBPfaJvPBCYtAz14hE7K2EypUFYmAFB8asEzl
 DaTG4mnwBHkf1z5kiqa8uJo7WqWr0hFwXCZLI53RBRhmyEg1U1yVsX9kBUSnbriAnruU
 0208xTbhT+jfrTcvdKWf59bxDsp7V+lHXFSBjN8+IWbkvfUqKKX9MzvrTVBq7akE2ccw
 Ya/Jd2zooEUE4o4TRaUSd1t4qMk9O5Gl9JW3l/s1Z+BLX91QZVPRlm/BNweqUxbFbh//
 pwkQ==
X-Gm-Message-State: AOAM533VSQ/UaflcMliz4GA0J/e4+rIEDRZksflNuo8IyK4bQBU/v0Py
 l6ASzYVzngQhiieK0BKHoLHeue902OOgcHz+rDpmj8ivEzMvh+eEs1nGvfjabcwrSZ1HYCIsxVI
 bQ+DR65Gcpkw/uGnf4AhRWicijQJNe2fxZ5qYU9EJcQ==
X-Received: by 2002:a05:6808:19a5:b0:2cf:3047:e78f with SMTP id
 bj37-20020a05680819a500b002cf3047e78fmr1017621oib.43.1645027890112; 
 Wed, 16 Feb 2022 08:11:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt+YgdfI5Fk0Xh7kX7VKIgYAe4XUjIZjnwAnXycbpxMk9pjuatlkjUMY0+5sKDhCNzHWL9NA==
X-Received: by 2002:a05:6808:19a5:b0:2cf:3047:e78f with SMTP id
 bj37-20020a05680819a500b002cf3047e78fmr1017598oib.43.1645027889848; 
 Wed, 16 Feb 2022 08:11:29 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id bg30sm2235654oib.4.2022.02.16.08.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 08:11:29 -0800 (PST)
Date: Wed, 16 Feb 2022 17:11:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH] vsock: remove vsock from connected table when connect is
 interrupted by a signal
Message-ID: <20220216161122.eacdfgljg2c6yeby@sgarzare-redhat>
References: <20220216143222.1614690-1-sforshee@digitalocean.com>
MIME-Version: 1.0
In-Reply-To: <20220216143222.1614690-1-sforshee@digitalocean.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

Hi Seth,

On Wed, Feb 16, 2022 at 08:32:22AM -0600, Seth Forshee wrote:
>vsock_connect() expects that the socket could already be in the
>TCP_ESTABLISHED state when the connecting task wakes up with a signal
>pending. If this happens the socket will be in the connected table, and
>it is not removed when the socket state is reset. In this situation it's
>common for the process to retry connect(), and if the connection is
>successful the socket will be added to the connected table a second
>time, corrupting the list.
>
>Prevent this by calling vsock_remove_connected() if a signal is received
>while waiting for a connection. This is harmless if the socket is not in
>the connected table, and if it is in the table then removing it will
>prevent list corruption from a double add.
>
>Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 3235261f138d..38baeb189d4e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1401,6 +1401,7 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
> 			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
> 			sock->state = SS_UNCONNECTED;
> 			vsock_transport_cancel_pkt(vsk);
>+			vsock_remove_connected(vsk);
> 			goto out_wait;
> 		} else if (timeout == 0) {
> 			err = -ETIMEDOUT;
>-- 
>2.32.0
>

Thanks for this fix! The patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


@Dave, @Jakub, since we need this also in stable branches, I was going 
to suggest adding a Fixes tag, but I'm a little confused: the issue 
seems to have always been there, so from commit d021c344051a ("VSOCK: 
Introduce VM Sockets"), but to use vsock_remove_connected() as we are 
using in this patch, we really need commit d5afa82c977e ("vsock: correct 
removal of socket from the list").

Commit d5afa82c977e was introduces in v5.3 and it was backported in 
v4.19 and v4.14, but not in v4.9.
So if we want to backport this patch also for v4.9, I think we need 
commit d5afa82c977e as well.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
