Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C48C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:41:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08CD560F51;
	Mon, 17 Apr 2023 06:41:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08CD560F51
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuETFynO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hKBZAOOZ3FNh; Mon, 17 Apr 2023 06:41:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 95F6F60A9B;
	Mon, 17 Apr 2023 06:41:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 95F6F60A9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 780B6C0037;
	Mon, 17 Apr 2023 06:41:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C56D4C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AA11682215
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA11682215
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YuETFynO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ARISqh9wegLS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:41:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 87D8282214
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87D8282214
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681713673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OxKMHMF5ij1bxNLeFZRcL6SeBcLJINT9bFcDHFvcGBQ=;
 b=YuETFynOezCctj1CJlHYhFR+u8Gtev3GqeiR4y5+NBR8qP9E3DPA4HBtcAIyNzhvt4sDLc
 kVVfYzhcOUvBNMtBVOY2BcM6VhjQ7bc3f3xvBEmtceifg98HEa3AKCm6ygU2JY+y0VuO19
 roQOQ21fzHzFbHc1bga78lJrY93CVNk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-CSr3L_1kN_al52m-xEcyXg-1; Mon, 17 Apr 2023 02:41:12 -0400
X-MC-Unique: CSr3L_1kN_al52m-xEcyXg-1
Received: by mail-qv1-f69.google.com with SMTP id
 q5-20020ad44025000000b005ef45791eb5so5421123qvp.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 23:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681713671; x=1684305671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OxKMHMF5ij1bxNLeFZRcL6SeBcLJINT9bFcDHFvcGBQ=;
 b=deTbeCZqlh7YjMXYtAFJcbn476RJ7GEV08KqFtHyxzZa3o4ByW5Xt8xZG4xstFTXGi
 a03PlhrldhPwpf0xxtrkOX6lYyecOa84jZH3mJUQgLufK0EJSRouF0jG5Iw9Wgf58QuE
 9mG86CCukaH9uOBX9bKBqmnJvAAph7BAUNJHsYmQRqgu7m5nU14LMxyzOWD975xkAL+W
 lCotcfmZn8JbUXdXSHOeoU6apBKo4Y4lGYErKdwTRxyIc2xV7UfcCsKJTvlHRw9OGPty
 JeKxoAvDwpKi61XIpSwI76yOAyTNWAWk5MLFjmrctXVgARQOfESVw6Q91C5+p8JSQwdA
 whlQ==
X-Gm-Message-State: AAQBX9cCS6JmEXqBwoo03zIwOIQ1LjOOUzYU5AJs1Coz6sMu9PJ/QK45
 wOL8rPuo0XOI6p08LfQ4TfEtrCxGsvW05ei0JkYg29a7s1rPYyVFJq9dF7KEF65zv4Hu4+wONkS
 b4yknKHJfyN+d2CxK1/eW2rd2qMWuTWAIiFu8Sj6TgQGtM10SQsYr
X-Received: by 2002:a05:622a:144:b0:3e3:9036:8d7b with SMTP id
 v4-20020a05622a014400b003e390368d7bmr23144627qtw.24.1681713671547; 
 Sun, 16 Apr 2023 23:41:11 -0700 (PDT)
X-Google-Smtp-Source: AKy350awUisy2QmOytI/7wHAUSKfUVvRV0PC8LxBgH9zz1azFDxXLfpwgedyZCjCtr2bsDRdI6Gagw==
X-Received: by 2002:a05:622a:144:b0:3e3:9036:8d7b with SMTP id
 v4-20020a05622a014400b003e390368d7bmr23144611qtw.24.1681713671291; 
 Sun, 16 Apr 2023 23:41:11 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 bi8-20020a05620a318800b007456b51ee13sm1898249qkb.16.2023.04.16.23.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 23:41:10 -0700 (PDT)
Date: Mon, 17 Apr 2023 02:41:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417023911-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Mon, Apr 17, 2023 at 06:38:43AM +0000, Alvaro Karsz wrote:
> > Actually, I think that all you need to do is disable NETIF_F_SG,
> > and things will work, no?
> 
> I think that this is not so simple, if I understand correctly, by disabling NETIF_F_SG we will never receive a chained skbs to transmit, but we still have more functionality to address, for example:
> * The TX timeouts.

I don't get it. With a linear skb we can transmit it as long as there's
space for 2 entries in the vq: header and data. What's the source of the
timeouts?

> * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.

I think we can.  mergeable_min_buf_len will just be large.


> > Alvaro, can you try?
> 
> It won't matter at the moment, we'll get TX timeout after the first tx packet, we need to address this part as well.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
