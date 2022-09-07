Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33BEC54EE9
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 08:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 439E160A69;
	Wed,  7 Sep 2022 08:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 439E160A69
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFiPVHXU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Lbmlh7U7_h_n; Wed,  7 Sep 2022 08:13:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE03C6058F;
	Wed,  7 Sep 2022 08:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE03C6058F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86B2FC0033;
	Wed,  7 Sep 2022 08:13:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A847C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 08:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CBB8060594
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 08:13:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CBB8060594
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fjqzN64SYFSC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 08:13:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A8FB16058F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8FB16058F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662538427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jGCBXs/LiZV7m+4iWwK0A0ed0uGkgznMIVJgxIo+Gcw=;
 b=DFiPVHXUjLE83Ba70fSOqiEF0IDmsLL7Bu2fxKwoy+VA7Oulo5a65Vpkhi97TWoXDK53UM
 L0WpZptATaQ2GYpYrXqlvPHxkOhrjEyBRd4CufQnyyWLLOg3n5NoqLTe6eKJu9W3ONjnui
 270zOL3uJhY2deteoxhzCtrildp25YA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-2K6aXV6BN3-NYQNAcIV62Q-1; Wed, 07 Sep 2022 04:13:44 -0400
X-MC-Unique: 2K6aXV6BN3-NYQNAcIV62Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 v5-20020ac873c5000000b003434ef0a8c7so11273253qtp.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Sep 2022 01:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=jGCBXs/LiZV7m+4iWwK0A0ed0uGkgznMIVJgxIo+Gcw=;
 b=MONDc7WnM/y+ZtPrMa9Scf2g6DGsb0UZlLKCle6shyoW0J9oJdfgWQwO4ho7MXvZxA
 FczpwU/yXKge0l/J2cDH4WdyE+jtsnGgMbhioZBxEHWLtNTPatCbmjIK/iWl8l5MWsR9
 ra3wV5QmAjwvy36D2MFtJdSglB9YhQNJXw3EMxJ3q4JoK+vGHjPMCwWSHRL5KKXi2aFB
 2R+4qhqsMbhFdbo1he7W53Ff1WCCknHLPDPhnsqfyH1IEMkRvtaN0O++Dw5SgGTsl9fU
 Ami0XMN521rkH+5XkCCz1JIMoG33shL7VTL+G7m5s4ApdRw313y6vOMg7Ut8H/QgAh0x
 gMoQ==
X-Gm-Message-State: ACgBeo3vXhcp+SJYnvqzr2yoOq8d71N72bobMD0IHqX24Dn5BJ2FSLof
 SOCfwQB2zCeh7M0UCN5zTheuv6ct4hogKqe3b6vTqA3ocpMi+G6UocrlAhKyaA15SOeyvWX2eIw
 mM/Umh+SkXKB/Npc7X0EsCo5jTMirmYeiGBo2TouZOw==
X-Received: by 2002:a05:622a:103:b0:343:3ce4:c383 with SMTP id
 u3-20020a05622a010300b003433ce4c383mr2147911qtw.388.1662538424190; 
 Wed, 07 Sep 2022 01:13:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4M+BpK0S3drKVwl3E/AGnsS1H35ouLbhYkpwM8Wr1TNLAJDN5peZCbYmUDdaNP/jFdyZTRnQ==
X-Received: by 2002:a05:622a:103:b0:343:3ce4:c383 with SMTP id
 u3-20020a05622a010300b003433ce4c383mr2147902qtw.388.1662538423966; 
 Wed, 07 Sep 2022 01:13:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it.
 [87.11.6.69]) by smtp.gmail.com with ESMTPSA id
 f20-20020ac84994000000b0031eebfcb369sm11206617qtq.97.2022.09.07.01.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 01:13:23 -0700 (PDT)
Date: Wed, 7 Sep 2022 10:12:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: Re: [PATCH] vsock/vmci: fix repeated words in comments
Message-ID: <20220907081256.wlua35p72s6azgqr@sgarzare-redhat>
References: <20220907040131.52975-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
In-Reply-To: <20220907040131.52975-1-yuanjilin@cdjrlc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Wed, Sep 07, 2022 at 12:01:31PM +0800, Jilin Yuan wrote:
>Delete the redundant word 'that'.
>
>Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
>---
> net/vmw_vsock/vmci_transport.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
>index b14f0ed7427b..842c94286d31 100644
>--- a/net/vmw_vsock/vmci_transport.c
>+++ b/net/vmw_vsock/vmci_transport.c
>@@ -951,7 +951,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
> 	 * for ourself or any previous connection requests that we received.
> 	 * If it's the latter, we try to find a socket in our list of pending
> 	 * connections and, if we do, call the appropriate handler for the
>-	 * state that that socket is in.  Otherwise we try to service the
>+	 * state that socket is in.  Otherwise we try to service the
> 	 * connection request.
> 	 */
> 	pending = vmci_transport_get_pending(sk, pkt);
>-- 
>2.36.1
>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
