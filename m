Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24213C433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 14:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8CBC83F6F;
	Thu, 17 Feb 2022 14:30:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oIFUqFT0iVCU; Thu, 17 Feb 2022 14:30:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5031C83F68;
	Thu, 17 Feb 2022 14:30:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 248F8C0011;
	Thu, 17 Feb 2022 14:30:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60D17C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 14:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D4FE6F6D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 14:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qFGI4vc5Nc7m
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 14:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8EEA160A6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645108229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8Mg0Zawzb8iLXTRP4iGXQx+ghVFngEDKpSNR36LONs=;
 b=BDb48vBo6Zv0DxhgvN9vtbkuxsUKUAhiVYvap0A+YDDmc7hGEu3ktRwZiQZgHWJpQRH8PF
 hnR/8x2YaI6XyFmrFvytPg4eMKTs2Uyzc4StlGukLwD9gCiy9VtcygV0lSC5RGuiUrSks2
 iOPIAbUtu0/wVT+I+OLqB0h3tv/gyjA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-1kNDY8HlNk6Cc7tXCSvtOQ-1; Thu, 17 Feb 2022 09:30:28 -0500
X-MC-Unique: 1kNDY8HlNk6Cc7tXCSvtOQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 hu9-20020a056214234900b0042c4017aeb3so5450784qvb.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 06:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=I8Mg0Zawzb8iLXTRP4iGXQx+ghVFngEDKpSNR36LONs=;
 b=KeiGQS4SHvG8Gzx2Mq6LnjLM2/IxZpVFef4DMSOHFQaK7Fw5U7X05xyXlz6XiiPZOy
 htSR/Txe0CRUEgl8ANOKFlNrTBkBRuQ5DL1JkU9/R09SzaIiO+/7gxfwRzvqdbgLcQp1
 lehXjhgdqY/CrAx/iMmb6i3HaokwWdB0iFDL7uF9zFGBw5lZ4lCln/OgnknPmJU/8dkN
 o5I8zSOz+oLtj7+IwkmJFHm5ejWzkrnm0R82v199BnnBScaJ4UhmUxHCZPH7iLNgjcyS
 v/1RHhiP5goXbZ93kXpNMofqebl4vzepcEG094oJh9x7UgKDjcKSUdVTPmR6/bh8JpCy
 W4iA==
X-Gm-Message-State: AOAM533AHb/rW0Ie43W43esUbU7qh1nILv72uOfCZ1VlCUz98qk0X99x
 KfmP7pYcv07RJ/e4TV9tFYBFg5zjgjmIf23g0Nykf9dOEqL/p7EKj/iniNMttbbHdq1Q1seef6H
 PvB+IKa1Ag6K6/qkquf1LutrhnZEOzYNW09vNWZF1sA==
X-Received: by 2002:a05:6214:e6e:b0:42c:47ae:3fc6 with SMTP id
 jz14-20020a0562140e6e00b0042c47ae3fc6mr2236847qvb.17.1645108227682; 
 Thu, 17 Feb 2022 06:30:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOTVuqdLPw6ZhB/cmq9wC9kbP+29WSlDiHADWZpzLBvhvaL8RlSP+/TYxFvL4euXWKUsFqUA==
X-Received: by 2002:a05:6214:e6e:b0:42c:47ae:3fc6 with SMTP id
 jz14-20020a0562140e6e00b0042c47ae3fc6mr2236825qvb.17.1645108227355; 
 Thu, 17 Feb 2022 06:30:27 -0800 (PST)
Received: from sgarzare-redhat (host-95-248-229-156.retail.telecomitalia.it.
 [95.248.229.156])
 by smtp.gmail.com with ESMTPSA id bl34sm18072851qkb.15.2022.02.17.06.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 06:30:26 -0800 (PST)
Date: Thu, 17 Feb 2022 15:30:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Seth Forshee <sforshee@digitalocean.com>
Subject: Re: [PATCH v2] vsock: remove vsock from connected table when connect
 is interrupted by a signal
Message-ID: <20220217143021.ylu2ymjytrwdmwmu@sgarzare-redhat>
References: <20220217141312.2297547-1-sforshee@digitalocean.com>
MIME-Version: 1.0
In-Reply-To: <20220217141312.2297547-1-sforshee@digitalocean.com>
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

On Thu, Feb 17, 2022 at 08:13:12AM -0600, Seth Forshee wrote:
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
>Note for backporting: this patch requires d5afa82c977e ("vsock: correct
>removal of socket from the list"), which is in all current stable trees
>except 4.9.y.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Seth Forshee <sforshee@digitalocean.com>
>---
>v2: Add Fixes tag and backporting notes.
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
