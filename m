Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74B1C77B73
	for <virtualization@archiver.kernel.org>; Sun, 16 Apr 2023 20:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5F12E40112;
	Sun, 16 Apr 2023 20:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F12E40112
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NjhCUl15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rt6seuSlIOZ; Sun, 16 Apr 2023 20:45:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 144B3400C6;
	Sun, 16 Apr 2023 20:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 144B3400C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D69DAC0036;
	Sun, 16 Apr 2023 20:45:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2FFDC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A794483C65
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A794483C65
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=NjhCUl15
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVSCdmYjWfXK
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:45:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 077C383C51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 077C383C51
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681677939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oEdPmorOX8xiHI6aIlzUXoimXi6nlh8J6/c2SPzObI=;
 b=NjhCUl15RR9NELNZKCiT89/pXUt4hifW6mvbU6SgEAbOPgKUIB0v5SXv9KEw/YUNOT84u0
 CGpBhXuaDsEBLOu+/yLaLpKnkZU+fA6JRE8gKcfVwBJLAmcoSoJM9XB+7OxGmKcSlkylAI
 CyNDr5eYXEzuIRcJpOLuoLeq+a5DigY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-17YtwF17NKa065SJCO-WPg-1; Sun, 16 Apr 2023 16:45:27 -0400
X-MC-Unique: 17YtwF17NKa065SJCO-WPg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f0b0c85c4fso15032405e9.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 16 Apr 2023 13:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681677926; x=1684269926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oEdPmorOX8xiHI6aIlzUXoimXi6nlh8J6/c2SPzObI=;
 b=ku4jVBMR3HZ/a8zEmRT8Qnzl9TLmnDOtJQ6TuYWPtNWMei8yv7OQXxqfEQREGR4chy
 SXAHcF9t+jQ4zxRvpTImydUVVagWM9vQxzSzAQ+fTmGZ2Qgoc6gmUkYDr/DH44sDKZyb
 KfrMXznankNu6ScHM3ifAW2uuIOY5lvCz/87Ya8Q4e1qRxB35y53HHTKMqhx58IgJuJP
 3XTcxP+XPWN4rX6hi6I49jQ7dcafEo/h7Ae0O737o8S9uT8LNoTSA4Lc/d+mus+gRNID
 xx7NF3RY9KMiUvJPnLHk1bi5Z/GM3m5lhCOe3eA5i+A2yGj3FZ5DnZ7tX21JCt3AQK7s
 p0Dg==
X-Gm-Message-State: AAQBX9fi/y/lTWscOHNH7S8gH4mdn4IhxdeC8XJKhEaWE9UTSuVFiMQ4
 ErhugJrg3jOSPew0Q2KiOaltVbXMBA6I2Uow/p/8C1oftNGnt12YOFU1O7UXYBsCz8zRcM1ryKX
 pIZhzIjZymCZ1016/P1Ir0iFW6K9kFRGkk7QZOoW5+g==
X-Received: by 2002:adf:fe8b:0:b0:2f0:2d96:1c5a with SMTP id
 l11-20020adffe8b000000b002f02d961c5amr4138811wrr.32.1681677926212; 
 Sun, 16 Apr 2023 13:45:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDl/2JrZl6WsLaTRzcyBgmzO98oVO5tAjDcD6uIrGp34aJUzDZmevyT0zIoSMohrF91ayUKg==
X-Received: by 2002:adf:fe8b:0:b0:2f0:2d96:1c5a with SMTP id
 l11-20020adffe8b000000b002f02d961c5amr4138799wrr.32.1681677925915; 
 Sun, 16 Apr 2023 13:45:25 -0700 (PDT)
Received: from redhat.com ([2.52.136.129]) by smtp.gmail.com with ESMTPSA id
 g17-20020adff3d1000000b002f777345d21sm6099498wrp.95.2023.04.16.13.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Apr 2023 13:45:25 -0700 (PDT)
Date: Sun, 16 Apr 2023 16:45:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230416164453-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Sun, Apr 16, 2023 at 04:54:57PM +0000, Alvaro Karsz wrote:
> After further consideration, other virtio drivers need a minimum limit to the vring size too.
> 
> Maybe this can be more general, for example a new virtio_driver callback that is called (if implemented) during virtio_dev_probe, before drv->probe.
> 
> What do you think?
> 
> Thanks,
> Alvaro

Let's start with what you did here, when more than 2 drivers do it we'll
move it to core.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
