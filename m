Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0AAC77B6D
	for <virtualization@archiver.kernel.org>; Sun, 26 Mar 2023 19:20:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 61B5D60F10;
	Sun, 26 Mar 2023 19:20:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 61B5D60F10
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=RuYjs/St
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_mR8OGTgeis; Sun, 26 Mar 2023 19:20:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C8E9760BAD;
	Sun, 26 Mar 2023 19:20:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C8E9760BAD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90C5AC0035;
	Sun, 26 Mar 2023 19:20:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEF02C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 19:20:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B305A40A01
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 19:20:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B305A40A01
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=RuYjs/St
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id exofJGmHLT-K
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 19:20:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DE04C4052F
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE04C4052F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 19:20:35 +0000 (UTC)
Received: by mail-yb1-xb30.google.com with SMTP id p204so7903766ybc.12
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Mar 2023 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679858435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oG/w6m6QtpmYcph7ogXNw2Cb+L528y4HO8hE3WHqySk=;
 b=RuYjs/StRoPkkDWrvmwXiGOQ4iyHBLQ/oUc4LBwsJU954HQ34/la6MiLmEMMLNjbqa
 ZiUeOh17f/1xc5lpEgOWba9hMrolYNI2qlhsq4ilNa1fsdj763IHQLcbbtmWlRouvS+U
 dSrhFSfzFxbzx8uTZEIfCUeszCpSx4HsO84dNQebYcswk4G/8jz7sbQ3dA0ol3PQ+waP
 iB4UqDUppIJIX1r2twnkAJr8idV7fWN8MV3e85gpPvi18qlrTsFtoHk6k71NHG36rprB
 swGIloWRV55T8523Do1MGQ3E2dVOcCW0XtgX2jKeLiU0qmhKETcks2Xzm46REysaFt5s
 Evhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679858435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oG/w6m6QtpmYcph7ogXNw2Cb+L528y4HO8hE3WHqySk=;
 b=xBzRoaSp0hh/NAIR3FEVEDMpJ3el8s2JAGnOOnMYe06Ku0HlUvPDcxzgzymmAPltJF
 pGb8re0yyyrYbGADzxcxecg63ceODyc1XKw9+puXzjKANtQDeb9iIyUhfWaKUf/J2yTW
 l7CosFd1JQalfH1VV0wm9itxtvOoIplrNZhg7XFnC1MT06GmExokNCqeKK8PeJFCM5U3
 cnjYx0R0234cl6AJLGxpPvoBmZIx2d/ur50Wy9vD2rmHCu5X9gpm5Fv6P6X6hK+YVZW9
 5VoKlw+/3o2bfVtS6E/1XY6+TUwuGYymbzU+WRvLqUcCjDLxmErEiet03be0369agp5q
 9UAQ==
X-Gm-Message-State: AAQBX9c2a8ZM+g0g2l6tP/19Jx1D2YHohWxNzJruyOWRAom9z2O9NT5F
 zZjI1KVErCsra2qwaB/erQQ=
X-Google-Smtp-Source: AKy350ZX9Q/+0ojpsMuhWZXN3EJq3mCPftR76gOQ189+2+0EJNrC6JBFXYC2V/t/39GIYgzP3Km5zA==
X-Received: by 2002:a25:2650:0:b0:b65:f335:2875 with SMTP id
 m77-20020a252650000000b00b65f3352875mr9567454ybm.37.1679858434757; 
 Sun, 26 Mar 2023 12:20:34 -0700 (PDT)
Received: from localhost ([2600:1700:65a0:ab60:2049:9ff4:d425:1853])
 by smtp.gmail.com with ESMTPSA id
 64-20020a250643000000b00b7767ca749esm1874211ybg.59.2023.03.26.12.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Mar 2023 12:20:34 -0700 (PDT)
Date: Sun, 26 Mar 2023 12:20:33 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [syzbot] [net?] [virt?] [io-uring?] [kvm?] BUG: soft lockup in
 vsock_connect
Message-ID: <ZCCbATwov4U+GBUv@pop-os.localdomain>
References: <00000000000075bebb05f79acfde@google.com>
 <CAGxU2F4jxdzK8Y-jaoKRaX_bDhoMtomOT6TyMek+un-Bp8RX3g@mail.gmail.com>
 <ZBUGp5bvNuE3sK5g@bullseye>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZBUGp5bvNuE3sK5g@bullseye>
Cc: axboe@kernel.dk, Krasnov Arseniy Vladimirovich <AVKrasnov@sberdevices.ru>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org,
 syzbot <syzbot+0bc015ebddc291a97116@syzkaller.appspotmail.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 io-uring@vger.kernel.org, syzkaller-bugs@googlegroups.com, edumazet@google.com,
 stefanha@redhat.com, Krasnov Arseniy <oxffffaa@gmail.com>, kuba@kernel.org,
 pabeni@redhat.com, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Mar 18, 2023 at 12:32:39AM +0000, Bobby Eshleman wrote:
> On Fri, Mar 24, 2023 at 09:38:38AM +0100, Stefano Garzarella wrote:
> > Hi Bobby,
> > FYI we have also this one, but it seems related to
> > syzbot+befff0a9536049e7902e@syzkaller.appspotmail.com
> > 
> > Thanks,
> > Stefano
> > 
> 
> Got it, I'll look into it.
> 

It seems you forgot to set skb->sk??

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 957cdc01c8e8..d47ad27b409d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -236,6 +236,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
        }

        virtio_transport_inc_tx_pkt(vvs, skb);
+       skb_set_owner_w(skb, sk_vsock(vsk));

        return t_ops->send_pkt(skb);
 }

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
