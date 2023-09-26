Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76383E8181D
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 05:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C610821A6;
	Tue, 26 Sep 2023 05:43:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C610821A6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ycbm38q4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ucg2u9R_vwF7; Tue, 26 Sep 2023 05:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3107082164;
	Tue, 26 Sep 2023 05:43:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3107082164
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11AD3C0039;
	Tue, 26 Sep 2023 05:43:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 345A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08EC6821A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08EC6821A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XH0UyER_-VwF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:43:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3430A82164
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 05:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3430A82164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695706980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6PTVVGgnSxG292uHCCvsYdfBj5DPcr+BlloC+r5OzIo=;
 b=Ycbm38q4AqjTilCj65M2fNk4XrWoMYSfNjW8EI6fuaZpC56qARSUG/DWPs+2P5PCYZwnOW
 bFNf8nthCicmq4p9bpxgLhyxdai9GglumWl4kB13VAeuVVps0Kq8tlsn1k5yQYUP3LjwVM
 MvTCCZtZSlqBJwrW7TNqupIEKSSVsH8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-cIHH7KHyOKKsGvrp_UuE8Q-1; Tue, 26 Sep 2023 01:42:58 -0400
X-MC-Unique: cIHH7KHyOKKsGvrp_UuE8Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5041a72d2edso11930320e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 22:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695706977; x=1696311777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6PTVVGgnSxG292uHCCvsYdfBj5DPcr+BlloC+r5OzIo=;
 b=qKh/ouwkefkJGYObH0HSBW+Day1C5NjM3BLIfoNSB37qE4vbbRYTa4qH6HxskG0IAL
 8knSNS7Ls69SUdqHdFegLp+u+ZatKFIt2Rbq4iSABdmE238qcRzdmji9V3YRWXwh9uUp
 e6AX5iPVc8PGHBSYBeD1AVeaT4IKExslFNTYrEytDYaXCFO4V8kJzE0vPCbnKWMkF1UH
 nB+BVgcU4Sux+BN3FtIH6iRPGIkK3dLyBiJ6P4pVDxjEm6M2FURwZilKW7GKmszuOk/C
 Xy2Jl8/enAa/suDgkmRZKiwAsCBMKO4V8juL+ZAd+WrxV2wteZzMj6R7ls2RMypxsEHL
 a+5g==
X-Gm-Message-State: AOJu0YxQV+Eb006+PnCv9xNA81jRaL3KGyfkxIi+4Lypoa5bGyec2urp
 TgoPRuTsok3trKV6PS1eFRkZmLCEK0rzLzL5zj+A+Kueohqm6XxvPZMPhSkRuBRJIvGPEP68oQu
 1xzwPhxyOuXEvgwheR3FS7ywmf4RzSpLX70Kkn5J5pQ==
X-Received: by 2002:a05:6512:547:b0:4f8:7513:8cac with SMTP id
 h7-20020a056512054700b004f875138cacmr6549922lfl.48.1695706977472; 
 Mon, 25 Sep 2023 22:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3PKzs08RZrdyPVtt6kvBErYsZn9mRO+eRjTXkFSHQF1HStKvm+y1T3gseydhDZJdu84Zd2Q==
X-Received: by 2002:a05:6512:547:b0:4f8:7513:8cac with SMTP id
 h7-20020a056512054700b004f875138cacmr6549909lfl.48.1695706977143; 
 Mon, 25 Sep 2023 22:42:57 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 z15-20020a05640235cf00b00533fa47273fsm2642675edc.42.2023.09.25.22.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 22:42:56 -0700 (PDT)
Date: Tue, 26 Sep 2023 01:42:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230926014005-mutt-send-email-mst@kernel.org>
References: <20230921124331-mutt-send-email-mst@kernel.org>
 <20230921183926.GV13733@nvidia.com>
 <20230921150448-mutt-send-email-mst@kernel.org>
 <20230921194946.GX13733@nvidia.com>
 <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
 <20230925143708-mutt-send-email-mst@kernel.org>
 <20230926004059.GM13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230926004059.GM13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Mon, Sep 25, 2023 at 09:40:59PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 25, 2023 at 03:44:11PM -0400, Michael S. Tsirkin wrote:
> > > VDPA is very different from this. You might call them both mediation,
> > > sure, but then you need another word to describe the additional
> > > changes VPDA is doing.
> > 
> > Sorry about hijacking the thread a little bit, but could you
> > call out some of the changes that are the most problematic
> > for you?
> 
> I don't really know these details.

Maybe, you then should desist from saying things like "It entirely fails
to achieve the most important thing it needs to do!" You are not making
any new friends with saying this about a piece of software without
knowing the details.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
