Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9930EC77B7D
	for <virtualization@archiver.kernel.org>; Sun,  7 May 2023 13:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 331D940BCB;
	Sun,  7 May 2023 13:38:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 331D940BCB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WSq2DSmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z33_M2rCilDc; Sun,  7 May 2023 13:38:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B6E26400CF;
	Sun,  7 May 2023 13:38:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6E26400CF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CD8DC0036;
	Sun,  7 May 2023 13:38:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85322C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 51713410CF
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51713410CF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WSq2DSmo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qf1P4KNOHdYK
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:38:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62CAE410C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62CAE410C0
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 May 2023 13:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683466700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uS0RstiP8T7ZH+Gobo8YpS9JLxcIWNZn7s+bIcTHKj0=;
 b=WSq2DSmoVjbQDTrdAFvn9J8kxStrSKiZo6eEOIUF57yypali3opguO/cIm+460bB5rNMlH
 pxkdMzHlwjA43nFHgON2UeaI57zBX7hdmLu4MDUtMnMgTC+jsFhSf+A0CbXNK54UFJjwV/
 ZQb/Dmx+pcM8epBQzyGLDbiu4sxyyH4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-TGKF45lxMMq8U9p3PMXoTA-1; Sun, 07 May 2023 09:38:18 -0400
X-MC-Unique: TGKF45lxMMq8U9p3PMXoTA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2ff4bc7a6a3so2027171f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 07 May 2023 06:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683466697; x=1686058697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uS0RstiP8T7ZH+Gobo8YpS9JLxcIWNZn7s+bIcTHKj0=;
 b=R8HBum0B9y+/Nde75eIrLzttwXCO0Ynu2wPdX4XS+IwETZEaCB7R/FZvMEQY6eNjc9
 QqyE8cjAT4zkBIwVCfmkauuNtP9iJ1VduGouc0NFKTeF7tlO/6+fG53gBeDwbM1sSJD6
 tOHvzdkZZjYZSSTHjuDtvhkpZWeoo1GuyY6aCHjaoe5yeKGrjHvcifqT1fLtPTB8RWZn
 LlQkCkRBgQLFX7K9su8nTW575hVf6iLGU+UDLhyg57E8xcQS1mwv+4wa/3hZFuvGeBzV
 5W6HoYQb48eYTeTyYXA9D+czH86RfgzGO8pWMVBN4a2qHt/mnT6YMvhLE8BihlMrM7pE
 aJ0w==
X-Gm-Message-State: AC+VfDwXiSFrIvrt8oJUsKp2dQN9pcH0IB4vVNxNGKap42yRLWYkHNfW
 q1TIR509y+VFFfBXRPm2hPwxdlQvP9lbhyGT5AU9Q0htuQ7yoKO5swbBZh4loUDLwnTnQjSiuSr
 OwlHZ4b1RN9obbun/a6haVnBbMEUf9NHtMNUDQbmPvg==
X-Received: by 2002:adf:e3cd:0:b0:306:2bff:aad8 with SMTP id
 k13-20020adfe3cd000000b003062bffaad8mr5217171wrm.35.1683466697640; 
 Sun, 07 May 2023 06:38:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7raV+1H23nZQQyJsfP3v5WDmwROkIJoLbvrcVTI1UBSNcA2EkWNlsLTJqPAmKBYRZa7JSNpg==
X-Received: by 2002:adf:e3cd:0:b0:306:2bff:aad8 with SMTP id
 k13-20020adfe3cd000000b003062bffaad8mr5217160wrm.35.1683466697361; 
 Sun, 07 May 2023 06:38:17 -0700 (PDT)
Received: from redhat.com ([2.52.158.28]) by smtp.gmail.com with ESMTPSA id
 l11-20020adfe58b000000b002f22c44e974sm8247506wrm.102.2023.05.07.06.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 May 2023 06:38:16 -0700 (PDT)
Date: Sun, 7 May 2023 09:38:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Message-ID: <20230507093502-mutt-send-email-mst@kernel.org>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <49455AA8-0606-447E-B455-F905EA184E42@infradead.org>
MIME-Version: 1.0
In-Reply-To: <49455AA8-0606-447E-B455-F905EA184E42@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, zy@yusur.tech,
 Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, huangml@yusur.tech,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, May 07, 2023 at 10:31:34AM +0100, David Woodhouse wrote:
> 
> 
> On 6 May 2023 09:56:35 BST, Hao Chen <chenh@yusur.tech> wrote:
> >In the current code, if the maximum MTU supported by the virtio net hardware is 9000, the default MTU of the virtio net driver will also be set to 9000. When sending packets through "ping -s 5000", if the peer router does not support negotiating a path MTU through ICMP packets, the packets will be discarded.
> 
> That router is just plain broken, and it's going to break all kinds of traffic. Hacking the virtio-net MTU is only a partial workaround.
> 
> Surely the correct fix here is to apply percussive education to whatever idiot thought it was OK to block ICMP. Not to hack the default MTU of one device to the lowest common denominator. 

Yea I don't understand what does path MTU have to do with it.
MTU has to be set the same for all endpoints on LAN, that's
a fundamental assumption that ethernet makes. Going outside LAN
all best are off.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
