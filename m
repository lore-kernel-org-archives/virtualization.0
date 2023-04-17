Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7F0C77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 11:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5A1D41836;
	Mon, 17 Apr 2023 11:40:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5A1D41836
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCk7y5um
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SVOgFnmpQOtM; Mon, 17 Apr 2023 11:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1F5CF41863;
	Mon, 17 Apr 2023 11:40:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F5CF41863
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA97EC0036;
	Mon, 17 Apr 2023 11:40:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C49DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E30841CB5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E30841CB5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FCk7y5um
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dJGK-y_okjZd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D348841C9D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D348841C9D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681731625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L56R2gu/x3s7dqlmSUQPJXypT34J4O84wjA7Kd+V4c4=;
 b=FCk7y5umbbOQHjO80zB/4fTF5h3xRf1mOnGX1c6YxfRGgaVOHw1Sn5pZVDxFU0N9PoH8J/
 ultHyijYZkRURH/BrsmzggQk/8K5cQ4vh4DJe0wWkFoqZf5L2ILmjEhabmvlOJXAu/Vr5t
 EyBZk0Vo+Qt6dGACgNAAsSZilTWUKl4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-0JNdDFliOrikXvpcxRZV0w-1; Mon, 17 Apr 2023 07:40:24 -0400
X-MC-Unique: 0JNdDFliOrikXvpcxRZV0w-1
Received: by mail-wm1-f69.google.com with SMTP id
 q19-20020a05600c46d300b003ef69894934so11493793wmo.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 04:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681731623; x=1684323623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L56R2gu/x3s7dqlmSUQPJXypT34J4O84wjA7Kd+V4c4=;
 b=ZUVEtnp2jMfWNUacxZx6BHSiLlj0dqbPCAfUH3PlK2CVEg3sqwxoSKd3pXIAmyeOKE
 Rm6VeO3Cj+qO1PygEGY9tLMGn1/hBDkLof7nN164LwpCti5bM0bcN0X/+G55dTi4jR0U
 O3aYBEPfnnheZigAsVCUCcP7rsVbqe1jFbuMSRFDL74lI2IabYmWqCTcOa94kZAiZAO9
 Hl2jjudZWnTQDJmfGNQ7l6gZBRoK1SnlGvNf3/TVd8iOC7R2a1rGJyqlzFopQpG6ehag
 +28QyIZSJbyb4Ki+SipN0nLk8UPgeXqiKVcCHo641JgqNpcM0U1hY3+4dHiWdVtPOaQr
 JFcw==
X-Gm-Message-State: AAQBX9f3umoXje6xi5R4eYqbcMljVqzB6d/j2JrmJW2ytkAEBMrIDvU2
 CbOJuMamLQJ0yj+LiM79aW0rLEI7Wbx20MBZ6CH+ATQ9Pw0ekhu85lEw9iry1HoFedVzJiaWMgk
 25QeoQ1JLzBEAZTwjX5vLnxwDDhJK0XrGbQYbZVMd4A==
X-Received: by 2002:a7b:cc94:0:b0:3f0:5beb:6f0 with SMTP id
 p20-20020a7bcc94000000b003f05beb06f0mr10675208wma.18.1681731623565; 
 Mon, 17 Apr 2023 04:40:23 -0700 (PDT)
X-Google-Smtp-Source: AKy350bzdruND4QIBAEvHw/OOARmMTC+ApbrrhIRUF7EKyLK+57bgrdl2Y6bv5uzN2rwe1n5p+gkUg==
X-Received: by 2002:a7b:cc94:0:b0:3f0:5beb:6f0 with SMTP id
 p20-20020a7bcc94000000b003f05beb06f0mr10675192wma.18.1681731623309; 
 Mon, 17 Apr 2023 04:40:23 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 y25-20020a05600c365900b003f0aeac475esm9692979wmq.44.2023.04.17.04.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 04:40:22 -0700 (PDT)
Date: Mon, 17 Apr 2023 07:40:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417073830-mutt-send-email-mst@kernel.org>
References: <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Mon, Apr 17, 2023 at 10:04:56AM +0000, Alvaro Karsz wrote:
> > > So, what do you think, we should fix virtio-net to work with smaller rings? we should fail probe?
> > >
> > > I think that since this never came up until now, there is no big demand to such small rings.
> > 
> > The worry is that once we start failing probe there's just a tiny chance
> > hosts begin to rely on us failing probe then we won't be able to fix it.
> > So it depends on the size of the patch I think. So far it seems small enough
> > that wasting code on failing probe isn't worth it.
> > 
> 
> I see your point.
> Regardless, we'll need to fail probe in some cases.
> ring size of 1 for example (if I'm not mistaken)

Hmm. We can make it work if we increase hard header size, then
there will always be room for vnet header.

> control vq even needs a bigger ring.

Why does it?

> Maybe we can fix virtnet to allow smaller rings + fail probe in some cases, all in the same patch/patchset.

If we can't make it work then yes.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
