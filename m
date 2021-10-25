Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAADC433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:14:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2983060C49
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2983060C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E083480C28;
	Mon, 25 Oct 2021 17:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LeJZRPcHm_oq; Mon, 25 Oct 2021 17:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 922D380C22;
	Mon, 25 Oct 2021 17:14:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68791C0012;
	Mon, 25 Oct 2021 17:14:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D00AC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5FFEA80C22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XV6psTEo8FVQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:14:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3499080C02
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635182058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDvYeZ/5yKHpS/y5o2U3cKIzexwhLSxWoPVV6kYxJY4=;
 b=emH4Ho4/S/zFxfKvb4XNwCceSigPCEYbcHqzCIxp2lLw8pRqV4Yd7WDF0+APXivQuw70Hd
 D4MC421YuG8VrndPGDYl298etaJthOyv3d6t5Im0WvAFhtjGnnCn0TL7R270SdO6bPBl8T
 LovcjIzvXu6NMttuBIvyabjSIuYNyMY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-CEZd5zGSMqi-zOqs-VgZrw-1; Mon, 25 Oct 2021 13:14:14 -0400
X-MC-Unique: CEZd5zGSMqi-zOqs-VgZrw-1
Received: by mail-wm1-f70.google.com with SMTP id
 r205-20020a1c44d6000000b0032cb058fe13so1814209wma.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 10:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jDvYeZ/5yKHpS/y5o2U3cKIzexwhLSxWoPVV6kYxJY4=;
 b=UR8geJQ1X8gNwHwbmZYJQfJPiVp3xXYiQsQoQBBgpiX3RrKt8bCTaRpONS6LQEmkeS
 UA962oqnNZlhlLxA+1Mlrt9btdZznC7qLRefXfrGn0MAPlqKqy9BrWKr6kkqTzK7Bceo
 I+2mz2dcZVpiKRPbcagp8CYs954NPkUEQOi7eSDt5x64VpsWoGlaED5uhAOtOHgDiAkI
 hOcCNdZOCdGyzOcTrVcu+4pQUqc2wGZ7TrkoY85gFjBXYI7Z/7yO5uIr5QP83jW6uOkW
 eLVLiYFiBXcUiJcCh8AyHJuGxWx9tePNTeKSNF/dPf/OMb2gP1Za/4OJtUewtQ5goCiJ
 AxXQ==
X-Gm-Message-State: AOAM533yp56J7DxD/g+C0jONXTh8Wn5fPJckYYeqe1wSO2P+JX9Cuy+T
 ir5czpGTRdkt4FpPi29AtwGksKlSseUG62KzMvKd0OT1HF8ql1KWdrlRk1+7n1zIf5swjkA81+/
 jgw+6M5TU/LeDc4j+Vb2x/ib3LZt4nfZ1e9bm3DJ09A==
X-Received: by 2002:adf:959a:: with SMTP id p26mr24267356wrp.342.1635182053648; 
 Mon, 25 Oct 2021 10:14:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPjAk9GD9Qq6TDEXymeEUOZOzH5s5aVdeE0O1R9NwaI5SUu899r8VU7ZL34/y115rEjiXF/w==
X-Received: by 2002:adf:959a:: with SMTP id p26mr24267322wrp.342.1635182053416; 
 Mon, 25 Oct 2021 10:14:13 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id n66sm16926079wmn.2.2021.10.25.10.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:14:12 -0700 (PDT)
Date: Mon, 25 Oct 2021 13:14:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH V3 11/11] vhost: allow userspace to create workers
Message-ID: <20211025131338-mutt-send-email-mst@kernel.org>
References: <20211022051911.108383-1-michael.christie@oracle.com>
 <20211022051911.108383-13-michael.christie@oracle.com>
 <20211022064359-mutt-send-email-mst@kernel.org>
 <94289c36-431a-513f-9b52-b55225f6b89d@oracle.com>
 <28250f62-ff38-901f-6014-9e975381d523@oracle.com>
 <20211023160838-mutt-send-email-mst@kernel.org>
 <e2d7796f-68d7-1cca-f9ed-0f2f2f3fdeb4@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e2d7796f-68d7-1cca-f9ed-0f2f2f3fdeb4@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, pbonzini@redhat.com
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

On Mon, Oct 25, 2021 at 11:04:42AM -0500, michael.christie@oracle.com wrote:
> On 10/23/21 3:11 PM, Michael S. Tsirkin wrote:
> > On Fri, Oct 22, 2021 at 01:17:26PM -0500, michael.christie@oracle.com wrote:
> >> On 10/22/21 11:12 AM, michael.christie@oracle.com wrote:
> >>> On 10/22/21 5:47 AM, Michael S. Tsirkin wrote:
> >>>>> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> >>>>> index c998860d7bbc..e5c0669430e5 100644
> >>>>> --- a/include/uapi/linux/vhost.h
> >>>>> +++ b/include/uapi/linux/vhost.h
> >>>>> @@ -70,6 +70,17 @@
> >>>>>  #define VHOST_VRING_BIG_ENDIAN 1
> >>>>>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
> >>>>>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> >>>>> +/* By default, a device gets one vhost_worker created during VHOST_SET_OWNER
> >>>>> + * that its virtqueues share. This allows userspace to create a vhost_worker
> >>>>> + * and map a virtqueue to it or map a virtqueue to an existing worker.
> >>>>> + *
> >>>>> + * If pid > 0 and it matches an existing vhost_worker thread it will be bound
> >>>>> + * to the vq. If pid is VHOST_VRING_NEW_WORKER, then a new worker will be
> >>>>> + * created and bound to the vq.
> >>>>> + *
> >>>>> + * This must be called after VHOST_SET_OWNER and before the vq is active.
> >>>>> + */
> >>>>
> >>>> A couple of things here:
> >>>> it's probably a good idea not to make it match pid exactly,
> >>>> if for no other reason than I'm not sure we want to
> >>>> commit this being a pid. Let's just call it an id?
> >>>
> >>> Ok.
> >>>
> >>>> And maybe byteswap it or xor with some value
> >>>> just to make sure userspace does not begin abusing it anyway.
> >>>>
> >>>> Also, interaction with pid namespace is unclear to me.
> >>>> Can you document what happens here?
> >>>
> >>> This current patchset only allows the vhost_dev owner to
> >>> create/bind workers for devices it owns, so namespace don't come
> >>
> >> I made a mistake here. The patches do restrict VHOST_SET_VRING_WORKER
> >> to the same owner like I wrote. However, it looks like we could have 2
> >> threads with the same mm pointer so vhost_dev_check_owner returns true,
> >> but they could be in different namespaces.
> >>
> >> Even though we are not going to pass the pid_t between user/kernel
> >> space, should I add a pid namespace check when I repost the patches?
> > 
> > Um it's part of the ioctl. How you are not going to pass it around?
> 
> The not passing a pid around was referring to your comment about
> obfuscating the pid. I might have misunderstood you and thought you
> wanted to do something more like you suggested below where to userspace
> it's just some int as far as userspace knows.
> 
> 
> > 
> > So if we do worry about this, I would just make it a 64 bit integer,
> > rename it "id" and increment each time a thread is created.
> >  
> Yeah, this works for me. I just used a ida to allocate the id. We can 
> then use it's lookup functions too.

Probably for the best, linear lookups will make destroying lots of
threads and O(N^2) operation.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
