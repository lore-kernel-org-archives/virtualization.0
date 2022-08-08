Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274B8C25B06
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 10:30:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4A0760E24;
	Mon,  8 Aug 2022 10:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4A0760E24
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLkUmwaK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1HQtgV0ErTGs; Mon,  8 Aug 2022 10:30:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BCC7360E36;
	Mon,  8 Aug 2022 10:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BCC7360E36
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76007C0071;
	Mon,  8 Aug 2022 10:30:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4826CC0033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:30:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11E93416EB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:30:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11E93416EB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLkUmwaK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lHh-jHRWTkT7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:30:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8684C414C4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8684C414C4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659954625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GcMiTNAh1hTDrL+vg0EvQccfaH3LEJ6CT3JlnBgaxfg=;
 b=BLkUmwaKYmG8yJH6FylkjKL1AMXJnmQNmnJcmKbaAz0Q9s5PNIOn3iZ4ysDtG3c/qoaQnf
 yrHL4hAMwBCGRCqRHGHjz47DjtRodX8Jcz8wUS1A3MLOC5FpnFJWvXt5KJqxJdtrHdBbai
 0k3gRzSOUnKWH9u59cM1F9zavS40r6Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-MiXpeAUeOoi5yCb-bPzjvg-1; Mon, 08 Aug 2022 06:30:22 -0400
X-MC-Unique: MiXpeAUeOoi5yCb-bPzjvg-1
Received: by mail-qt1-f200.google.com with SMTP id
 a18-20020a05622a02d200b0031ed7ae9abeso6456810qtx.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Aug 2022 03:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=GcMiTNAh1hTDrL+vg0EvQccfaH3LEJ6CT3JlnBgaxfg=;
 b=uHmD6fDcxcl1066g/jTw4JAKMf+4bXObn8Y0dASz4y00uhPlrkjcaaCsTSb6PNPPdt
 9FG8xJLCzbontyA1kj9An6Pld6V2wnRgFruMgVlCf0MZYsrmHQutP89shzSNwwcM4yK4
 8K7qBl0wl4wixGJrHtyBPhTIauJ8gE/4E9zQelsSs6o25D4gjS5vb5PTqFJMzEleD73s
 kY5bHUfF86FtjGezDcp9SzFOTOUcpXmG838JH7IIYxqiLYPevilAHr0A6+GH8/Aa8fy4
 VAjG5esyMV6UvphfM9WHSFHY6toAk7k1kM2gU8aJRJzDy/xnZMVd/wQyKTXAT5zNL2eM
 i5ow==
X-Gm-Message-State: ACgBeo33jmT4TIEemUARSkAmBg7Dvs1tRij6GzYvxDg7c0LzjlLAWOVH
 ShLSPD7lzD1YWJH1DAV5I2uamlcnvrVeWHgVCK5TS5229ywhXEoER5u321G85g2RyixAg2pGPHF
 4qoaUBkV1ladk+lZFKEgBWj8kxyOoeqoOsEg/pVkoZw==
X-Received: by 2002:a37:2f03:0:b0:6b5:f8d9:7eab with SMTP id
 v3-20020a372f03000000b006b5f8d97eabmr13681280qkh.79.1659954622001; 
 Mon, 08 Aug 2022 03:30:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4XGLj1VfcJFS+ebiNnab2ZLX5E3Tf208Zo5b4se2GNkoL41B1DWrzqhZGDT4lGv++JCSXVQA==
X-Received: by 2002:a37:2f03:0:b0:6b5:f8d9:7eab with SMTP id
 v3-20020a372f03000000b006b5f8d97eabmr13681272qkh.79.1659954621774; 
 Mon, 08 Aug 2022 03:30:21 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 g6-20020ac80706000000b0034068f9d8fcsm7431142qth.20.2022.08.08.03.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 03:30:21 -0700 (PDT)
Date: Mon, 8 Aug 2022 12:30:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 1/9] vsock: SO_RCVLOWAT transport set callback
Message-ID: <CAGxU2F513N+0sB0fEz4EF7+NeELhW9w9Rk6hh5K7QQO+eXRymA@mail.gmail.com>
References: <2ac35e2c-26a8-6f6d-2236-c4692600db9e@sberdevices.ru>
 <45822644-8e37-1625-5944-63fd5fc20dd3@sberdevices.ru>
 <20220808102335.nkviqobpgcmcaqhn@sgarzare-redhat>
MIME-Version: 1.0
In-Reply-To: <20220808102335.nkviqobpgcmcaqhn@sgarzare-redhat>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Aug 8, 2022 at 12:23 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Aug 03, 2022 at 01:51:05PM +0000, Arseniy Krasnov wrote:
> >This adds transport specific callback for SO_RCVLOWAT, because in some
> >transports it may be difficult to know current available number of bytes
> >ready to read. Thus, when SO_RCVLOWAT is set, transport may reject it.
> >
> >Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> >---
> > include/net/af_vsock.h   |  1 +
> > net/vmw_vsock/af_vsock.c | 25 +++++++++++++++++++++++++
> > 2 files changed, 26 insertions(+)
> >
> >diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> >index f742e50207fb..eae5874bae35 100644
> >--- a/include/net/af_vsock.h
> >+++ b/include/net/af_vsock.h
> >@@ -134,6 +134,7 @@ struct vsock_transport {
> >       u64 (*stream_rcvhiwat)(struct vsock_sock *);
> >       bool (*stream_is_active)(struct vsock_sock *);
> >       bool (*stream_allow)(u32 cid, u32 port);
> >+      int (*set_rcvlowat)(struct vsock_sock *, int);
>
> checkpatch suggests to add identifier names. For some we put them in,
> for others we didn't, but I suggest putting them in for the new ones
> because I think it's clearer too.
>
> WARNING: function definition argument 'struct vsock_sock *' should also
> have an identifier name
> #25: FILE: include/net/af_vsock.h:137:
> +       int (*set_rcvlowat)(struct vsock_sock *, int);
>
> WARNING: function definition argument 'int' should also have an identifier name
> #25: FILE: include/net/af_vsock.h:137:
> +       int (*set_rcvlowat)(struct vsock_sock *, int);
>
> total: 0 errors, 2 warnings, 0 checks, 44 lines checked
>
> >
> >       /* SEQ_PACKET. */
> >       ssize_t (*seqpacket_dequeue)(struct vsock_sock *vsk, struct msghdr *msg,
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index f04abf662ec6..016ad5ff78b7 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -2129,6 +2129,30 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> >       return err;
> > }
> >
> >+static int vsock_set_rcvlowat(struct sock *sk, int val)
> >+{
> >+      const struct vsock_transport *transport;
> >+      struct vsock_sock *vsk;
> >+      int err = 0;
> >+
> >+      vsk = vsock_sk(sk);
> >+
> >+      if (val > vsk->buffer_size)
> >+              return -EINVAL;
> >+
> >+      transport = vsk->transport;
> >+
> >+      if (!transport)
> >+              return -EOPNOTSUPP;
>
> I don't know whether it is better in this case to write it in
> sk->sk_rcvlowat, maybe we can return EOPNOTSUPP only when the trasport
> is assigned and set_rcvlowat is not defined. This is because usually the
> options are set just after creation, when the transport is practically
> unassigned.
>
> I mean something like this:
>
>          if (transport) {
>                  if (transport->set_rcvlowat)
>                          return transport->set_rcvlowat(vsk, val);
>                  else
>                          return -EOPNOTSUPP;
>          }
>
>          WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
>
>          return 0;

Since hv_sock implements `set_rcvlowat` to return EOPNOTSUPP. maybe we 
can just do the following:

        if (transport && transport->set_rcvlowat)
                return transport->set_rcvlowat(vsk, val);

        WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
        return 0;

That is, the default behavior is to set sk->sk_rcvlowat, but for 
transports that want a different behavior, they need to define 
set_rcvlowat() (like hv_sock).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
