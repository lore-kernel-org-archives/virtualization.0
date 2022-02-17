Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46490C433EF
	for <virtualization@archiver.kernel.org>; Thu, 17 Feb 2022 07:20:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C54D44019F;
	Thu, 17 Feb 2022 07:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZcvHcubdmW9w; Thu, 17 Feb 2022 07:20:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B5F141DF5;
	Thu, 17 Feb 2022 07:20:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0391EC002D;
	Thu, 17 Feb 2022 07:20:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFEC9C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE18481447
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EeHFp5GAb0GG
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:20:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8A35F8141C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Feb 2022 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645082399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJutfBnC0X47+pe34h2CTuYZucDLnJdhE9tAvo0QiRs=;
 b=gX4N9hxclQ6nwZsGtZenntZNbY65Owf29JUBs2AIPEKUFN4OP0/tTaXN6t0mqDPv8ECTE5
 /pth4A0o5tEUeAjKkTJysq5ErRCm2y0P9+LXNo8xCYp11tuRyBFG3fvo1lQCUZwnFc7mjH
 6pG9SNXCbhS66JR5kPjYCMg/6CyhRd4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-zDwSiX6fPvCicrMFn85CiQ-1; Thu, 17 Feb 2022 02:19:57 -0500
X-MC-Unique: zDwSiX6fPvCicrMFn85CiQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 a6-20020a05651c210600b00244bd884dbfso1885925ljq.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 23:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XJutfBnC0X47+pe34h2CTuYZucDLnJdhE9tAvo0QiRs=;
 b=7+BCNMs9UwfrgILr+IlhBDhoLI7Um04spZ8o2dfhw4dFLvyA8wm02EeCLUTGfIXfxW
 Vdn2/9wx0decw+q6g6phdVYfZSHU++dqxJWNw1wHdmVJlrIh9ZnStQ+w1R9kW9LKJu1e
 LZC5M0GAELanuIkrVE8ioit8cVLm/wi+9CT0rZirQ2SFVWM3DGGCrG7Nlbaqpx+f172W
 ZkBInovG78cWASimsIO4n6HXlEXY43H0m/3hyNgBEgsLJ/kqelWhYWtVkk7mMuXCXbVc
 0pdVc12WPhXixdOt+ds5Y/ztzaY3j81Nn9+vrhTKYhLGOWVdF72SdwoRxYgabN88sMLP
 ZGYA==
X-Gm-Message-State: AOAM5311uentCGOdulyz3SEKgVLyX7AXdDnxDLopgs0BujGCboN9W+0j
 di8SaCKA4Nd4nIy49EirHswlpAUHFeY+iDl6n6SgwJLYFpBYzY/1KbVKlGCQiWzYjovclM167er
 hmsGWpiWYt9b1EXhAV7vUUoB12aW8z7OLabX816HBSNR56PA3dqQpsEzlJw==
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id
 a18-20020ac25052000000b00443146654d1mr1218154lfm.348.1645082396252; 
 Wed, 16 Feb 2022 23:19:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzifvter4e24DeM689k/6VqkrqPQnnlxi7MEbrF24wIX05rQpMzAmEGRsUBjJ5SysczjD22lFOg/vureYGV55U=
X-Received: by 2002:ac2:5052:0:b0:443:1466:54d1 with SMTP id
 a18-20020ac25052000000b00443146654d1mr1218144lfm.348.1645082396065; Wed, 16
 Feb 2022 23:19:56 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Feb 2022 15:19:44 +0800
Message-ID: <CACGkMEtE+Bcdru43F5dOkMO1kDhUe19gKwaN4FqkztTCRXSjmw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] virtio: support advance DMA
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Feb 10, 2022 at 4:51 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> virtqueue_add() only supports virtual addresses, dma is completed in
> virtqueue_add().
>
> In some scenarios (such as the AF_XDP scenario), DMA is completed in advance, so
> it is necessary for us to support passing the DMA address to virtqueue_add().

I'd suggest rename this feature as "unmanaged DMA".

>
> Record this predma information in extra->flags, which can be skipped when
> executing dma unmap.

Question still, can we use per-virtqueue flag instead of per
descriptor flag? If my memory is correct, the answer is yes in the
discussion for the previous version.

Thanks

>
> v1:
>    1. All sgs requested at one time are required to be unified PREDMA, and several
>       of them are not supported to be PREDMA
>    2. virtio_dma_map() is removed from this patch set and will be submitted
>       together with the next time AF_XDP supports virtio dma
>    3. Added patch #2 #3 to remove the check for flags when performing unmap
>       indirect desc
>
> Xuan Zhuo (6):
>   virtio: rename vring_unmap_state_packed() to
>     vring_unmap_extra_packed()
>   virtio: remove flags check for unmap split indirect desc
>   virtio: remove flags check for unmap packed indirect desc
>   virtio: virtqueue_add() support predma
>   virtio: split: virtqueue_add_split() support dma address
>   virtio: packed: virtqueue_add_packed() support dma address
>
>  drivers/virtio/virtio_ring.c | 199 ++++++++++++++++++++++-------------
>  1 file changed, 126 insertions(+), 73 deletions(-)
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
