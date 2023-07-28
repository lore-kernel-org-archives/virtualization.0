Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A5BC001DE
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 05:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07DFE40462;
	Fri, 28 Jul 2023 05:47:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07DFE40462
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F6aBwja2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id peU8PMBr_-7K; Fri, 28 Jul 2023 05:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82F3440556;
	Fri, 28 Jul 2023 05:47:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82F3440556
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F9B3C0071;
	Fri, 28 Jul 2023 05:47:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 450A8C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F9738401F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:47:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F9738401F
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F6aBwja2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jqWAimRpBjpu
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:47:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2686F84019
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2686F84019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690523221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oAXmH+qYY8bjmfYawJukNpxQ9bW1VMYi2zFEUqTpT64=;
 b=F6aBwja2csTU7V/vIATbjk7QBYXz/HSmv/8B7+a0ycSzv7FgkGGxmSBGkB38xnRp2U9OBt
 mXmgB2m7652SYNQ027yks9p19xlm2ZCDqm0j8xcyWjEwF99G3C9pmHp2TWEY5/bTaeu/mz
 N3YZGGa05kTp0YNJFmVKY1ltYPU+pFE=
Received: from mail-ed1-f72.google.com (209.85.208.72 [209.85.208.72]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-ro8HZQiuPyikUkrLvys5hQ-1; Fri,
 28 Jul 2023 01:45:19 -0400
X-MC-Unique: ro8HZQiuPyikUkrLvys5hQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5223854ef71so1086915a12.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690523117; x=1691127917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAXmH+qYY8bjmfYawJukNpxQ9bW1VMYi2zFEUqTpT64=;
 b=aQluTSaX/L32giPd/JlLXvtgiGklwWAdDhnHDW1E4hL63vIW98HUwhyFWnJC4AjVwj
 GYmWd2UcH748tPpR8XiKxZbr9cY5gHpfuZxe98EICq2FVpKni4BDmcoFOZgEhgRno+Ka
 zchH/mnUz/4A5kq8bzAGeflO/oxGfgGnch02gH/qm3cpm0hHleXFeE1giBiM886wPWke
 U1qea6CDja36EjqA0MnL4QCSK6JfItYynC7BlsVhlz4Eww3H0EWlBAdbDqiO/HLG9Yq6
 jkNBmU5eNpEmSkbpoA3fhFsOhvoIcW4tOd6s18qOOo358148cRy7PHsOGJO/sALXeoGF
 BY3g==
X-Gm-Message-State: ABy/qLZRjwTAHAmMBrAHKj2JurmwYxOeakZQ8rGAFfVdJDyyaN9mfXFt
 9niFF6Yso6wR4VXfSzRBqj4640dgscgsAn+OfIouOeMCaL4RrcqlrT1VVsPKm5cqqMuCVIXBIJc
 datWe51j9U8GHZM8Vt5yykhMhhjFMWrU7O5yo7fkIRQ==
X-Received: by 2002:a05:6402:1b1a:b0:522:5932:57ec with SMTP id
 by26-20020a0564021b1a00b00522593257ecmr857298edb.41.1690523117664; 
 Thu, 27 Jul 2023 22:45:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFBXUrFKZkaaBFtalSQoz0QArd65X5FID0AfhTTUMyGnaIqLIFeqt+FaMOPM4wBS7TieKmTsQ==
X-Received: by 2002:a05:6402:1b1a:b0:522:5932:57ec with SMTP id
 by26-20020a0564021b1a00b00522593257ecmr857285edb.41.1690523117382; 
 Thu, 27 Jul 2023 22:45:17 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 f26-20020a056402069a00b005224d960e66sm1384975edy.96.2023.07.27.22.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 22:45:15 -0700 (PDT)
Date: Fri, 28 Jul 2023 01:45:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [PATCH net-next v4 0/4] vsock/virtio/vhost: MSG_ZEROCOPY
 preparations
Message-ID: <20230728012845-mutt-send-email-mst@kernel.org>
References: <20230727222627.1895355-1-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230727222627.1895355-1-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Fri, Jul 28, 2023 at 01:26:23AM +0300, Arseniy Krasnov wrote:
> Hello,
> 
> this patchset is first of three parts of another big patchset for
> MSG_ZEROCOPY flag support:
> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/

overall looks good. Two points I'd like to see addressed:
- what's the performance with all these changes - still same?
- most systems have a copybreak scheme where buffers
  smaller than a given size are copied directly.
  This will address regression you see with small buffers -
  but need to find that value. we know it's between 4k and 32k :)


> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
> suggested to split it for three parts to simplify review and merging:
> 
> 1) virtio and vhost updates (for fragged skbs) <--- this patchset
> 2) AF_VSOCK updates (allows to enable MSG_ZEROCOPY mode and read
>    tx completions) and update for Documentation/.
> 3) Updates for tests and utils.
> 
> This series enables handling of fragged skbs in virtio and vhost parts.
> Newly logic won't be triggered, because SO_ZEROCOPY options is still
> impossible to enable at this moment (next bunch of patches from big
> set above will enable it).
> 
> I've included changelog to some patches anyway, because there were some
> comments during review of last big patchset from the link above.
> 
> Head for this patchset is 9d0cd5d25f7d45bce01bbb3193b54ac24b3a60f3
> 
> Link to v1:
> https://lore.kernel.org/netdev/20230717210051.856388-1-AVKrasnov@sberdevices.ru/
> Link to v2:
> https://lore.kernel.org/netdev/20230718180237.3248179-1-AVKrasnov@sberdevices.ru/
> Link to v3:
> https://lore.kernel.org/netdev/20230720214245.457298-1-AVKrasnov@sberdevices.ru/
> 
> Changelog:
>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
>  * See per-patch changelog after ---.
> 
> Arseniy Krasnov (4):
>   vsock/virtio/vhost: read data from non-linear skb
>   vsock/virtio: support to send non-linear skb
>   vsock/virtio: non-linear skb handling for tap
>   vsock/virtio: MSG_ZEROCOPY flag support
> 
>  drivers/vhost/vsock.c                   |  14 +-
>  include/linux/virtio_vsock.h            |   6 +
>  net/vmw_vsock/virtio_transport.c        |  79 +++++-
>  net/vmw_vsock/virtio_transport_common.c | 312 ++++++++++++++++++------
>  4 files changed, 330 insertions(+), 81 deletions(-)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
