Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAD9CE7AF8
	for <virtualization@archiver.kernel.org>; Thu, 28 Sep 2023 05:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A968B61020;
	Thu, 28 Sep 2023 05:32:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A968B61020
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RpltgSF7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nvw4WnQcx6Xl; Thu, 28 Sep 2023 05:32:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F16D561084;
	Thu, 28 Sep 2023 05:32:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F16D561084
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC937C0071;
	Thu, 28 Sep 2023 05:32:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83363C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50A6840AAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:32:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50A6840AAB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RpltgSF7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L4ONeSZWblZy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:32:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F72740629
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Sep 2023 05:32:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F72740629
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695879125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJKTBrFfNa844uYvKAsmJlERJoic2KHS63xODOblJos=;
 b=RpltgSF7qncCwYIIQfDi07FeQQjrU+f8rPh4BX9VdbfwT0ezJuTVSW1qHRLya2lcDec6Mj
 vVqhmi9dp2+BIL161A/n8z7v01I1dth4iC430bb1qr4NV4QrEKTr3h3lEutEsIp4hz7DA1
 PZWzDFcdY7sw5F5JLk2K0c+pG/kryVE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-jYUyo_LtO2C1ZCWGE_z2cg-1; Thu, 28 Sep 2023 01:32:03 -0400
X-MC-Unique: jYUyo_LtO2C1ZCWGE_z2cg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso107940335e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Sep 2023 22:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695879122; x=1696483922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJKTBrFfNa844uYvKAsmJlERJoic2KHS63xODOblJos=;
 b=j/EUSzAyR8k8Pou0gU2I81mexjZJopj5B87M1tjgUyCbVtv0sfeNHTOkv2gpvWuogS
 pq7gASR71BAbI49zdF+LBng9Hc9aiyKMTuwW2Lxs4Ph6hiSIHBfHvnbBrXxES2u/wRlj
 QnXp0xO7dTSRPAYGBpMgTJ+ZBlgvLBMQYxSb5fXdfZMBWTMqY5AsfQt10yc1rq+f5aCs
 GWfv5Sxry0NsExay3oK+BDL5Wr021tikUkp/7Y1GPGtwu4YxSfsAWHVSY/bD8en2hiAV
 LXn5XbQQjEfVjHY05zxlOxH9OA+Bv4dP5nv+YyJPNZgBhAitrgCIXErU7tBlx8q54Mva
 RyOQ==
X-Gm-Message-State: AOJu0YyneE6slgolsl2/zLwVhNsBmF5ksGPmF3y3jNNEQCBAAMobtorA
 Mum/plkpf4DB1ceKEsvcXhr0LZr7s8PQdfSHRSl/bUVDH8DNXX+zT/DoMylOm0kwEL3R4QjCss3
 nRhBqg1rbquMnJm542yb5lnSRh86BZVKNbhJdgTrT7A==
X-Received: by 2002:a7b:cb8c:0:b0:405:36d7:4579 with SMTP id
 m12-20020a7bcb8c000000b0040536d74579mr210548wmi.28.1695879122704; 
 Wed, 27 Sep 2023 22:32:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnQQOsX2nd46FlaNt8Gwvvx+JHgJ+INrZJAdTjHC8F4FEZId76DIGMa4aSekPcBkjhv4hyCA==
X-Received: by 2002:a7b:cb8c:0:b0:405:36d7:4579 with SMTP id
 m12-20020a7bcb8c000000b0040536d74579mr210537wmi.28.1695879122411; 
 Wed, 27 Sep 2023 22:32:02 -0700 (PDT)
Received: from redhat.com ([2.52.19.249]) by smtp.gmail.com with ESMTPSA id
 19-20020a05600c029300b004060f0a0fdbsm6639359wmk.41.2023.09.27.22.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 22:32:01 -0700 (PDT)
Date: Thu, 28 Sep 2023 01:31:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230928012650-mutt-send-email-mst@kernel.org>
References: <CACGkMEvMP05yTNGE5dBA2-M0qX-GXFcdGho7_T5NR6kAEq9FNg@mail.gmail.com>
 <20230922121132.GK13733@nvidia.com>
 <CACGkMEsxgYERbyOPU33jTQuPDLUur5jv033CQgK9oJLW+ueG8w@mail.gmail.com>
 <20230925122607.GW13733@nvidia.com>
 <20230925143708-mutt-send-email-mst@kernel.org>
 <20230926004059.GM13733@nvidia.com>
 <20230926014005-mutt-send-email-mst@kernel.org>
 <20230926135057.GO13733@nvidia.com>
 <20230927173221-mutt-send-email-mst@kernel.org>
 <20230927232005.GE339126@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230927232005.GE339126@nvidia.com>
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

On Wed, Sep 27, 2023 at 08:20:05PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 27, 2023 at 05:38:55PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Sep 26, 2023 at 10:50:57AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Sep 26, 2023 at 01:42:52AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 25, 2023 at 09:40:59PM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Sep 25, 2023 at 03:44:11PM -0400, Michael S. Tsirkin wrote:
> > > > > > > VDPA is very different from this. You might call them both mediation,
> > > > > > > sure, but then you need another word to describe the additional
> > > > > > > changes VPDA is doing.
> > > > > > 
> > > > > > Sorry about hijacking the thread a little bit, but could you
> > > > > > call out some of the changes that are the most problematic
> > > > > > for you?
> > > > > 
> > > > > I don't really know these details.
> > > > 
> > > > Maybe, you then should desist from saying things like "It entirely fails
> > > > to achieve the most important thing it needs to do!" You are not making
> > > > any new friends with saying this about a piece of software without
> > > > knowing the details.
> > > 
> > > I can't tell you what cloud operators are doing, but I can say with
> > > confidence that it is not the same as VDPA. As I said, if you want to
> > > know more details you need to ask a cloud operator.
> >
> > So it's not the changes that are problematic, it's that you have
> > customers who are not using vdpa. The "most important thing" that vdpa
> > fails at is simply converting your customers from vfio to vdpa.
> 
> I said the most important thing was that VFIO presents exactly the
> same virtio device to the VM as the baremetal. Do you dispute that,
> technically, VDPA does not actually achieve that?

I dispute that it is the most important. The important thing is to have
guests work.

> Then why is it so surprising that people don't want a solution that
> changes the vPCI ABI they worked hard to create in the first place?
> 
> I'm still baffled why you think everyone should use vdpa..
> 
> Jason

They shouldn't. If you want proprietary extensions then vfio is the way
to go, I don't think vdpa will support that.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
