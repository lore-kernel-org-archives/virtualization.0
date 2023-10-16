Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFF8C41513
	for <virtualization@archiver.kernel.org>; Mon, 16 Oct 2023 08:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C536F6F7AC;
	Mon, 16 Oct 2023 08:52:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C536F6F7AC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i39e+0ti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bz763iQxU13U; Mon, 16 Oct 2023 08:52:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE91B6F793;
	Mon, 16 Oct 2023 08:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE91B6F793
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC9A2C0039;
	Mon, 16 Oct 2023 08:52:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C03CC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7503381F75
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:52:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7503381F75
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i39e+0ti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I03xVy-Bd9EL
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:52:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3425781F70
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 08:52:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3425781F70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697446333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Hrw2mCbpNBx3OcS5SFnx9OpOefvyyFxXG99mO1HFz0=;
 b=i39e+0tidmwJs53kSzJGr0UgxzmlhOumwYSeSjM3gytO1IFrBpsT9/KKr6lBsLNGoE9iR4
 5b3GLlmQI3tCfqncGlmRLCSBgQKi9fA2Ud+JAUQEWtlRXuy9pc+irPx3MjsYaZf7cFdchh
 arfjsGFyvYx1TjMjePAqjL+hsi72TOc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-agZTCCS_PQeo9PLszb0zjg-1; Mon, 16 Oct 2023 04:52:11 -0400
X-MC-Unique: agZTCCS_PQeo9PLszb0zjg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da39f7f2bso1176334f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 01:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446330; x=1698051130;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Hrw2mCbpNBx3OcS5SFnx9OpOefvyyFxXG99mO1HFz0=;
 b=cDsOPYFF0iPd9Re1qhbg9jhiMRtg7MlCK06a1j5/JV6bs7zyrESSzQjqVDC41+pokG
 AYKAhHuhTrywo+DrptImI17s0P+gFAET1Ck2PSACOtmH/hNKhr0QSSHtWgZEwovlvLdu
 25V3w16/eg8TYmIGRQPXmun8SGMScWDye/2zcruG8NsxfemqFdM/sUiIXvwJAAu1RSLD
 q7fNWui+E+dE2J2z58Z3JSKznMwPCXOAmM2z4lvcs9D0GfQ1rg9udehEyxh9wP3W8kUg
 WpL1ea6V4AIZnaS7iS6NgA6F5moI8R/KnAN/eXBDWRVnxQ47f2S33fsvjyoGxSmv+spY
 VDdA==
X-Gm-Message-State: AOJu0Yy/Kclks9ZJUnbecXOJVALfI/9F5XsUvknstZwQxIyGiIyZdXuE
 Un/ru7wXWmozftfz5yxU1zp6DPpTTDVkcnxWykLdeWKH3fVBoEv06Yqr9OYe6WhQgiKYlLnjYKc
 TIWFGl1MjHeC80fEp9tGt/PzF/u4fKh1tDOTcvoY04w==
X-Received: by 2002:a5d:56c8:0:b0:321:4de3:fd5c with SMTP id
 m8-20020a5d56c8000000b003214de3fd5cmr28286177wrw.51.1697446330049; 
 Mon, 16 Oct 2023 01:52:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFHEdbEdPLPHcD0JmCIqUYkAJJe/RYZ2tIkcF4fsieSA7SiZgzIOKXHz1uInqieWq65N3GLQ==
X-Received: by 2002:a5d:56c8:0:b0:321:4de3:fd5c with SMTP id
 m8-20020a5d56c8000000b003214de3fd5cmr28286159wrw.51.1697446329731; 
 Mon, 16 Oct 2023 01:52:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:f56b:1acf:3cb7:c133:f86d])
 by smtp.gmail.com with ESMTPSA id
 n9-20020adff089000000b0031ad2f9269dsm26639385wro.40.2023.10.16.01.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 01:52:08 -0700 (PDT)
Date: Mon, 16 Oct 2023 04:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231016045050-mutt-send-email-mst@kernel.org>
References: <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c75bb669-76fe-ef12-817e-2a8b5f0b317b@intel.com>
 <20231012132749.GK3952@nvidia.com>
 <840d4c6f-4150-4818-a66c-1dbe1474b4c6@intel.com>
 <20231013094959-mutt-send-email-mst@kernel.org>
 <818c4212-9d9a-4775-80f3-c07e82057be8@intel.com>
MIME-Version: 1.0
In-Reply-To: <818c4212-9d9a-4775-80f3-c07e82057be8@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>
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

On Mon, Oct 16, 2023 at 04:33:10PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 10/13/2023 9:50 PM, Michael S. Tsirkin wrote:
> > On Fri, Oct 13, 2023 at 06:28:34PM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 10/12/2023 9:27 PM, Jason Gunthorpe wrote:
> > > 
> > >      On Thu, Oct 12, 2023 at 06:29:47PM +0800, Zhu, Lingshan wrote:
> > > 
> > > 
> > >          sorry for the late reply, we have discussed this for weeks in virtio mailing
> > >          list. I have proposed a live migration solution which is a config space solution.
> > > 
> > >      I'm sorry that can't be a serious proposal - config space can't do
> > >      DMA, it is not suitable.
> > > 
> > > config space only controls the live migration process and config the related
> > > facilities.
> > > We don't use config space to transfer data.
> > > 
> > > The new added registers work like queue_enable or features.
> > > 
> > > For example, we use DMA to report dirty pages and MMIO to fetch the dirty data.
> > > 
> > > I remember in another thread you said:"you can't use DMA for any migration
> > > flows"
> > > 
> > > And I agree to that statement, so we use config space registers to control the
> > > flow.
> > > 
> > > Thanks,
> > > Zhu Lingshan
> > > 
> > > 
> > >      Jason
> > > 
> > If you are using dma then I don't see what's wrong with admin vq.
> > dma is all it does.
> dma != admin vq,

Well they share the same issue that they don't work for nesting
because DMA can not be intercepted.

> and I think we have discussed many details in pros and cons
> in admin vq live migration proposal in virtio-comment.
> I am not sure we should span the discussions here, repeat them over again.
> 
> Thanks
> > 

Yea let's not.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
