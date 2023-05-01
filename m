Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB67C77B61
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 10:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C01B0408FB;
	Mon,  1 May 2023 10:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C01B0408FB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5EZSN2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKEf3wKqyCna; Mon,  1 May 2023 10:27:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E441400CC;
	Mon,  1 May 2023 10:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E441400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 224E9C0037;
	Mon,  1 May 2023 10:27:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1FFDAC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E265D4151A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E265D4151A
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5EZSN2k
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Maf0sZH1ifR
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:27:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB3184150E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB3184150E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682936860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRtuEtk1Agus0i9a6G5WkwqsQ87YPTcPf/QGDRjhWqA=;
 b=H5EZSN2ko9LRDsD7BdDWQztbHQeXTj4PNMhw5IwRCWZXE403Oj0fHVNOvkz1UmNT8D3zBN
 szCVwN/+I0l8fcTfWq+N/ffoiRX8VopkKavya4bJKnp3PyxxKW4CjeBehRd6hretTAX+0y
 hQC+zJQD5DRRkX1zEeNxhtC8ZO6cfa4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-wajsErf2PECDk1C-jwQrcw-1; Mon, 01 May 2023 06:27:39 -0400
X-MC-Unique: wajsErf2PECDk1C-jwQrcw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f19517536eso6955385e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 May 2023 03:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682936858; x=1685528858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRtuEtk1Agus0i9a6G5WkwqsQ87YPTcPf/QGDRjhWqA=;
 b=Fscjq+PzRIMCU/DvAfrPUud8tKurSEt9FhF21lNQ3MMr/gmhf6Z16kzy84nmSAnJHF
 QhJwl0agfeZwNkWV0Bnl/a8dD0RgomRENj2FOUHEj+eEC9kdHyTUWLH32b4i7tGtSueU
 wkYqBo+z/Jzy/T01nyk7SQOLe8/KCmhZH3m0amKzTtjIhXGTzCbVnCKQcA5z77QyFYIj
 uj4yZd8sx0gNZKqhA3sMVIJ+19GsNaJnR0U64Hbaoet9VQ2VJnmFqm0TH3Eqs5T7oIfX
 QQueyekldInSehvIa9P0JHpLsTD4UmVth/1PFz+I8uUCO9aMZD3Rp6w19d8bYJJpsn/Q
 X+lw==
X-Gm-Message-State: AC+VfDxHpS1PxIC3EovisoCGwY4OXWHXWvrbXTideQHcC3RXc319d5x5
 3WlE+0/nncvq8Ynrpcdy0jVmD3FpRVYSa4fdYtlQn/rKkySHNwMNDi1+HTeVlRtbnON7noAG2QG
 kswx8KT6Dy0Ig7Q8lymY2ZPCBeH1rS5KY+YvbwMwvUQ==
X-Received: by 2002:a05:600c:24cd:b0:3f1:92e8:a6fe with SMTP id
 13-20020a05600c24cd00b003f192e8a6femr9959572wmu.31.1682936858082; 
 Mon, 01 May 2023 03:27:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UGe6rKgDK9J0Fv3OD1362dMlDO30XbwBLq2L7tXBmbUGS4RqXkA11U0RdxloRzim2DjKI3Q==
X-Received: by 2002:a05:600c:24cd:b0:3f1:92e8:a6fe with SMTP id
 13-20020a05600c24cd00b003f192e8a6femr9959562wmu.31.1682936857810; 
 Mon, 01 May 2023 03:27:37 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742c:c300:3695:a81b:6f0b:8940])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a7bcd0f000000b003f182cc55c4sm32005051wmj.12.2023.05.01.03.27.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 03:27:37 -0700 (PDT)
Date: Mon, 1 May 2023 06:27:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Message-ID: <20230501062107-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430100535-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723C479C388266434DE415ED4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723C479C388266434DE415ED4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Sun, Apr 30, 2023 at 06:15:03PM +0000, Alvaro Karsz wrote:
> 
> > > This patchset follows a discussion in the mailing list [1].
> > >
> > > This fixes only part of the bug, rings with less than 4 entries won't
> > > work.
> > 
> > Why the difference?
> > 
> 
> Because the RING_SIZE < 4 case requires much more adjustments.
> 
> * We may need to squeeze the virtio header into the headroom.
> * We may need to squeeze the GSO header into the headroom, or block the features.

We alread do this though no?
I think we'll need to tweak hard_header_len to guarantee it's there
as opposed to needed_headroom ...

> * At the moment, without NETIF_F_SG, we can receive a skb with 2 segments, we may need to reduce it to 1.

You are saying clearing NETIF_F_SG does not guarantee a linear skb?

> * We may need to change all the control commands, so class,  command and command specific data will fit in a single segment.
> * We may need to disable the control command and all the features depending on it.

well if we don't commands just fail as we can't add them right?
no corruption or stalls ...

> * We may need to disable NAPI?

hmm why napi?

> There may be more changes..
> 
> I was thinking that it may be easier to start with the easier case RING_SIZE >= 4, make sure everything is working fine, then send a follow up patchset with the required adjustments for RING_SIZE < 4.


it's ok but I'm just trying to figure out where does 4 come from.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
