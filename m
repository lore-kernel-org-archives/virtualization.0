Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B00EC678D5
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 09:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E25E2813D6;
	Tue,  7 Mar 2023 09:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E25E2813D6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RzP6qKsP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6PzcZN04_UBR; Tue,  7 Mar 2023 09:53:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7134E813D1;
	Tue,  7 Mar 2023 09:53:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7134E813D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43377C0071;
	Tue,  7 Mar 2023 09:53:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 058CFC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D45A960BFE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:53:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D45A960BFE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RzP6qKsP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RribiTQUcSdh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:53:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C6A260BC7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C6A260BC7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 09:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678182828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggd3+ao+WeqD8liBzoZLjCqGeA5JT3k3Ek928KuXPYA=;
 b=RzP6qKsPUHGTAI4LHFDZ9vq85WStAi6SFTqna5PqZDqVtBHNuZQtiZGIqZePJWlqwMGm+h
 WeEoZdS41lfdfbKn+EOhkRs9IgN4/brqkFZi8E7Y1SbQ4w8hRV4bs8YJW4oGaLE2JNB8rh
 MxhCB0RFu5wtnPoDDtUEAWXyX8sz//U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-kfhn3HigOiqmA4PXqkwj3A-1; Tue, 07 Mar 2023 04:53:47 -0500
X-MC-Unique: kfhn3HigOiqmA4PXqkwj3A-1
Received: by mail-qv1-f72.google.com with SMTP id
 s18-20020a0cf792000000b00572c04240f1so7145409qvn.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 01:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678182827;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ggd3+ao+WeqD8liBzoZLjCqGeA5JT3k3Ek928KuXPYA=;
 b=DV64F7Kk4m+Nvs/VX1widDeRffy9bE1PGAlqmiBLccgiNH7f+igzMZSRtk00w7K+Re
 XevLSENCRcHxpKydfGQvXrDYe37ji2xQq9fCLF2wK6wUgDaHE/PdlHC8dj2rL7H5FrcR
 KiuD8COB3pNiXjevfQFlEHyZPhcPJsA7uus8VGwRmVEIv2I7zHp2Gdw2alTqPSEEmaHw
 E+lGeTVJhvbP/sUkG75MsRoFKkkQTj9nioWFV0SvUTGVbPSWwj3Yw/e83KWLL6Hn4L4V
 r/14mHgJP1PQenrIho8s/hRuZHBlAnGn+6KssSYp70jsCw6nWQMK5ztAxcEor6Ngr0Gf
 QilQ==
X-Gm-Message-State: AO0yUKUGJAIARPZAN1mIrsKV4imirdn5V9GLJ8oCOO++WflXEQq1x8ls
 EVLem6tzsBqDAjCETmRg79pFacZ1fGan9HEwpgecD6x15p5r4wtqCi8LedwVNE3AeGoahcOTF1J
 EFN/pVP14INyPlPixF29cYoUzGK6bwCCAiM8chP5BlA==
X-Received: by 2002:a05:622a:1443:b0:3bf:cf77:a861 with SMTP id
 v3-20020a05622a144300b003bfcf77a861mr26042695qtx.4.1678182826885; 
 Tue, 07 Mar 2023 01:53:46 -0800 (PST)
X-Google-Smtp-Source: AK7set/Ht7SnNixqcSsXD0GLyGOfUcXl++SZRRVs2S7WoQNC08oY0HQ25bhDHtpsc4xRCT0+4cdvAg==
X-Received: by 2002:a05:622a:1443:b0:3bf:cf77:a861 with SMTP id
 v3-20020a05622a144300b003bfcf77a861mr26042676qtx.4.1678182826522; 
 Tue, 07 Mar 2023 01:53:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-28.dyn.eolo.it.
 [146.241.121.28]) by smtp.gmail.com with ESMTPSA id
 127-20020a370b85000000b007425ef4cbc2sm9256355qkl.100.2023.03.07.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 01:53:46 -0800 (PST)
Message-ID: <27a06a7d79fef3446ae1167612808a2af09922be.camel@redhat.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Date: Tue, 07 Mar 2023 10:53:41 +0100
In-Reply-To: <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306125742-mutt-send-email-mst@kernel.org>
 <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>
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

Hi,
On Tue, 2023-03-07 at 09:49 +0800, Xuan Zhuo wrote:
> On Mon, 6 Mar 2023 12:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> > > If the queue of xdp xmit is not an independent queue, then when the xdp
> > > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > > the following error.
> > > 
> > > net ens4: Unexpected TXQ (0) queue failure: -28
> > > 
> > > This patch adds a check whether sq is full in XDP Xmit.
> > > 
> > > Thanks.
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > needed for stable?
> 
> Yes i think.

Could you please re-post including a suitable 'Fixes' tag? That would
address stable, too. Additionally you could rename check_sq_full() in
patch 1, perhaps 'check_disable_sq_full()' would do.

You can retain the already collected tags.

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
