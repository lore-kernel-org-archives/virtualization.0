Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6891C4321E
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 05:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E088401F9;
	Mon,  5 Dec 2022 05:43:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E088401F9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFWCi7d9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WBlZhxbyr0nC; Mon,  5 Dec 2022 05:43:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FD4C40239;
	Mon,  5 Dec 2022 05:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FD4C40239
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54962C0032;
	Mon,  5 Dec 2022 05:43:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 159ADC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 05:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D31F281A24
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 05:43:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D31F281A24
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DFWCi7d9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6djgsz0y7m0a
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 05:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 91D5C81A23
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91D5C81A23
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 05:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670218993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t86XBbARlnyk81OrJxXEcmWTfD1S3vRJrUaYSNvxuJs=;
 b=DFWCi7d9tAFrwpvGjSSHgKh8GqGMGT8+iDPyBa2vRfV1UmQ4FbGRhweeE0oF2bsEAnbVbf
 TTEI3I6/hQwSNqfl4bpWxJYTl4YYC8f9R36hQqPrLW4pwL7RyH9rLWmWMtib12tW0EnVHx
 c5bbYswHONv0twEILKNN3+pe9WQcXk8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-fWpbB9tkPtiL1xcdfUUL2Q-1; Mon, 05 Dec 2022 00:43:12 -0500
X-MC-Unique: fWpbB9tkPtiL1xcdfUUL2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 f1-20020a1cc901000000b003cf703a4f08so3904024wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Dec 2022 21:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t86XBbARlnyk81OrJxXEcmWTfD1S3vRJrUaYSNvxuJs=;
 b=ODvlYHQ516P884q9f+6GZ/qKckXegQnDrFmNJ8y4IGiINPPUFp6ldyW1mGW5GCTmVa
 j0Zm9jjfRoKW+DCVdr46zkBrOMTZbd+xKIh44XdOrCLyu3URr6k+mJ3pYiiaUOelXNFe
 NjJ2oTnH01C8H3BAxAcFkiYR0qrG228wwFTjKvOlIyjVnHQM4JjB4lYNTF76/fROpuK5
 1wykUGXb7H+YnRkymcl6je/BjqeITtCmRl0tnGjpSh2tm6Ly3J8rMc5J1jaR/mS0OsPY
 sFeLuRszi3ChIwzXuVozEOrsrDOUnF8QYzQVmi7blDH75gOn9vdfMmtTycK8iDdPbUtb
 n3Kg==
X-Gm-Message-State: ANoB5pn4wtr3rAVC1krPMRiZDso0YNwDEFUsaf/w74aki1QgTZOFUyDd
 7ipfGsHPKt/2dnmZsuHQdUrdpJaFzDmIpVQARVCQzJ8kJBeg7q5PGrqqHPsup4filR8Tp+lwKeU
 BRDArt7xLiLkWBZpflHZ1b19jdVtsBhUVe494bgPawg==
X-Received: by 2002:adf:e255:0:b0:242:55fe:8ccb with SMTP id
 bl21-20020adfe255000000b0024255fe8ccbmr4201385wrb.474.1670218991006; 
 Sun, 04 Dec 2022 21:43:11 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vc+5k1HZe2PR7rG+o4CAs9JSX4MiG/xl14N5H2dlOqS/tQ3isg50b4f7EIgozsik2U5hZMg==
X-Received: by 2002:adf:e255:0:b0:242:55fe:8ccb with SMTP id
 bl21-20020adfe255000000b0024255fe8ccbmr4201379wrb.474.1670218990773; 
 Sun, 04 Dec 2022 21:43:10 -0800 (PST)
Received: from redhat.com ([2.52.154.150]) by smtp.gmail.com with ESMTPSA id
 r10-20020a05600c458a00b003cfd4a50d5asm22567271wmo.34.2022.12.04.21.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Dec 2022 21:43:09 -0800 (PST)
Date: Mon, 5 Dec 2022 00:43:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221205004149-mutt-send-email-mst@kernel.org>
References: <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
 <20221124013830-mutt-send-email-mst@kernel.org>
 <Y3/WXWoV1jcJnohR@fedora>
 <CAJs=3_AY_1eGwsu5MvzUr4N03=3qgYiVdu5=EV+VSj6+yUYeyg@mail.gmail.com>
 <Y4UG6lQXbzxOix1/@fedora>
 <dc8bf007-a6f6-9824-63e1-9447335da732@nvidia.com>
 <20221129001239-mutt-send-email-mst@kernel.org>
 <b76ad252-3f6a-8f4b-cb2d-0a4f45860aae@nvidia.com>
 <CAJs=3_Bma3KiOW3Cah2KWiN34TG4c=bdw1bTjB71Fo_QLaKmXw@mail.gmail.com>
 <ce455ec6-353b-d273-0d52-44673f4dc0cc@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ce455ec6-353b-d273-0d52-44673f4dc0cc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Dec 05, 2022 at 05:30:34AM +0000, Chaitanya Kulkarni wrote:
> On 12/4/22 00:19, Alvaro Karsz wrote:
> > So, we could create a block-general lifetime ioctl with many reserved
> > bytes, or create a virtio block specific ioctl without reserved bytes
> > at all.
> > I think that we should keep it virtio specific, and if a new lifetime
> > command is added to the spec with more fields, we could create a new
> > ioctl.
> > Does Everyone agree?
> > 
> 
> Unless there are multiple drivers supporting same IOCTL and agreeing
> the same semantics I've not seen new block layer IOCTL was accepted
> you never know ..
> 
> Personally I'd not, unless I find other major drivers and specs
> agreeing on semantics..
> 
> -ck
> 


OK looks like we are in agreement we can keep it as is then.
If new types are added we'll add a new ioctl not a big deal.
Please do Cc storage mailing lists on the next version though.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
