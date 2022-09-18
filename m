Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05E3C32771
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 15:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44A5283E7B;
	Sun, 18 Sep 2022 15:14:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44A5283E7B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FaVyKccP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWj-Rvz2mNMs; Sun, 18 Sep 2022 15:14:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A065F83E3D;
	Sun, 18 Sep 2022 15:14:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A065F83E3D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71B20C0032;
	Sun, 18 Sep 2022 15:14:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6280C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 15:14:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A0B84050C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 15:14:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A0B84050C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FaVyKccP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MDmtA1q_Ptdb
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 15:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 55F48400F2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55F48400F2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663514039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYR1Y/lyfv2ANC8pNSjMJcllsVt+ZyB89THnBjU7d7Q=;
 b=FaVyKccPBeEI8M7EibfC6KFPQXWHuk0M+MuOypuNd2RwGcYUZyJ1y66evS8/vd1qdlicUp
 ZMiIVnw5CZat+LOL7DF7FgMQjmrtJEPS3sMzOBDH69jWLRBW0A6uh5YMAHE0u55GRDnk/F
 AIpmGg1/WIbwERPcB72zoMF1PVsVbxM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-299-xGfYw8rOO4O2NC-q3Ym-ww-1; Sun, 18 Sep 2022 11:13:57 -0400
X-MC-Unique: xGfYw8rOO4O2NC-q3Ym-ww-1
Received: by mail-wm1-f69.google.com with SMTP id
 b5-20020a05600c4e0500b003b499f99aceso3158598wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 08:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=cYR1Y/lyfv2ANC8pNSjMJcllsVt+ZyB89THnBjU7d7Q=;
 b=iRGZEvkniNv3Tk8WRdnGfOSJIiS4dFYPPtdU6dyytyPrQ+v2nTc8qYPc23G+ma9IT8
 zY5Frp97HT2Zv6mWYeYzm322TrteUu6R4eJvvD1XR6PDnN1ZqxWfxFWM2kDMKKKbH1NK
 CFxXCgBK9N6LXJMgBjVtRUoJe0j7WdoQ5tQxZSZTguK8s+k2Cq6iRzM8LWAcENreZb2F
 XgX4LIBSMFlB8BOkKX0WMksXGPxKwN0eO1KbzmsYTomC16EqW2ryLT6yYJJxh5SFC5ho
 kFSXwKxTegQpE5h/8DnHjvVnccIqSaxZSA3JbI2LydGbzhTS5P4LJ59Z6hYAk+GNfOpq
 pPAA==
X-Gm-Message-State: ACrzQf11PRMEBXKK1mNRSAo3pc4oyYjbYH/Y/o3m3F76efvsPxujrcCB
 sxad+WNAi3xSwFnWIuiulwZS1xgdqWpsLUW3wFZdrt97sbseLSPzQiQu6muztXASZQeL/4Vt5vw
 1BTooVEE8pLJ6r9w0ZdzgrB2uB5jNFW4zhXaHgRZILQ==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id
 y9-20020a056000168900b0022aa66d1f37mr8378833wrd.197.1663514036637; 
 Sun, 18 Sep 2022 08:13:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69O2bcvezAbVNXRwdgrmVunQjy1yMBHVMFLirtCkrtlMCH8eg0IT2g4Ct3tqxRNIOb3tobDQ==
X-Received: by 2002:a05:6000:1689:b0:22a:a66d:1f37 with SMTP id
 y9-20020a056000168900b0022aa66d1f37mr8378826wrd.197.1663514036348; 
 Sun, 18 Sep 2022 08:13:56 -0700 (PDT)
Received: from redhat.com ([2.52.4.6]) by smtp.gmail.com with ESMTPSA id
 r11-20020adfda4b000000b00228dc1c7063sm10870060wrl.85.2022.09.18.08.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Sep 2022 08:13:55 -0700 (PDT)
Date: Sun, 18 Sep 2022 11:13:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
Message-ID: <20220918110951-mutt-send-email-mst@kernel.org>
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <20220918091848-mutt-send-email-mst@kernel.org>
 <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Sun, Sep 18, 2022 at 05:01:53PM +0300, Alvaro Karsz wrote:
> Thanks for the reply.
> 
> > why minimum?
> 
> >  why is that?
> 
> This was discussed in the previous version
> (https://www.spinics.net/lists/linux-virtualization/msg58232.html).
> As far as I know, the Linux kernel uses the same "max segments" value
> for a discard and a secure erase command.
> In the first version, I ignored the max_secure_erase_seg and
> secure_erase_sector_alignment config fields (just like
> max_write_zeroes_seg and write_zeroes_may_unmap are ignored in the
> write zeros command implementation).
> 
> It was suggested to use the minimum "max segments" value if both
> VIRTIO_BLK_F_SECURE_ERASE and VIRTIO_BLK_F_DISCARD are negotiated.
> The same is true for the sector alignment values.

sounds good. Add a code comment?

> > is this logic repeating code from below?
> 
> I'm not sure what you mean.
> The idea is:
> At this point, the VIRTIO_BLK_F_DISCARD fields were read from the
> virtio config (if VIRTIO_BLK_F_DISCARD is negotiated).
> If max_discard_segs is 0, VIRTIO_BLK_F_DISCARD is not negotiated (or
> set to 0), so we should use the max_secure_erase_seg value as
> max_discard_segs.

yes but I now see two places that seem to include this logic.

> 
> > Always? What's going on here?
> > which versions handled max_secure_erase_seg == 0?
> 
> This comment is from the VIRTIO_BLK_F_DISCARD implementation.
> I added the max_secure_erase_seg part since I could not find how to
> handle the case when max_secure_erase_seg is 0 in the spec.
> So, like with the VIRTIO_BLK_F_DISCARD implementation, I'm setting the
> value to sg_elems.

I am not 100% sure. Two options:
1- Add a validate callback and clear VIRTIO_BLK_F_SECURE_ERASE.
2- Alternatively, fail probe.

which is preferable depends on how bad is it if host sets
VIRTIO_BLK_F_SECURE_ERASE but guest does not use it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
