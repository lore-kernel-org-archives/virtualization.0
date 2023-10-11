Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B446BCD98FD
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 08:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 596A58144F;
	Wed, 11 Oct 2023 08:11:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 596A58144F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b2vyTqAH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f4koOuevqYC9; Wed, 11 Oct 2023 08:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6577781430;
	Wed, 11 Oct 2023 08:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6577781430
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39F9EC0039;
	Wed, 11 Oct 2023 08:11:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7292DC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4082641686
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4082641686
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b2vyTqAH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WgFQhbdfPeLg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:11:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 044C641698
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 044C641698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697011866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbrBqmqJ7ePTBLmsl9lO89ar2Bi2NjoAUKaJegjcMuQ=;
 b=b2vyTqAHdpZ4tBvtKrJ8x6McJSIjLn1Qq2CP+T+nNXoKdBZu1Ibd3ftk4UGo6ht3ncSgp1
 SQxYu7qDBqRGIMiL3EvHl8iwgrUXIgADBTDC6fpCq80XJU1sd5FJeov9QW5ULs/mkqDxOV
 GcddOsTGlF3UKRMtyI5tvYzNsLkMBAs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-yO0VeZpgMEWB-etxSxnTyQ-1; Wed, 11 Oct 2023 04:11:03 -0400
X-MC-Unique: yO0VeZpgMEWB-etxSxnTyQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3248ebee5f4so4106458f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 01:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697011862; x=1697616662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbrBqmqJ7ePTBLmsl9lO89ar2Bi2NjoAUKaJegjcMuQ=;
 b=Y/46m8NxPiV1NGc1gj4ccsZckXYxNXjWy5lIP/QQRrnM1oa+2OjhWlwUMdv+7LL44j
 rc8Ayi8zS5b8oreSbwAfNLipRSWNjWmEnVWAiEq2NPQ8Tj9boxDwUbw3eMkS1klKHlOB
 GVbBo0YhMH96ipOFw64FhnTXa/PyoKKQ9xeA4Mh+V1DLJfodfkXAwr2+Ewa7Bgf7gPFH
 dWgRfP618Y8KXFUt7TICnmR0LLZSlgN0FV8Ti0U149grZxhCBX6HH4JrwjEAc5v+teHd
 U3/eEZDDI6LeGNsT5VS4/moat4784A0IgZ/A22HuEki093XQeP0GYJdR08Ez6n/UW7a8
 bFfA==
X-Gm-Message-State: AOJu0YzfNfZZJvKHZFylvaBgxi6pirZsPr3Ny116UORK5hzP/aiKUhxj
 bLN52lWLQLZoJC1ODcmjVX/21j8m9NEewFl0g2oWTqRcaT3IiPrKSEK2H5N3eaq/AWn+nrxcKhX
 O0LpUZX6XGvSPwBjz+QIz+gRgTO9I/Bf2sYsrynPiUg==
X-Received: by 2002:adf:eb44:0:b0:323:1887:dd6d with SMTP id
 u4-20020adfeb44000000b003231887dd6dmr15945101wrn.3.1697011862287; 
 Wed, 11 Oct 2023 01:11:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb99wbGqbCatj6kkdKi4CNVNLIz4pYbPSBAqvLknq9Q8mv7txYpLUIY0T/uaaITi94YyZn2w==
X-Received: by 2002:adf:eb44:0:b0:323:1887:dd6d with SMTP id
 u4-20020adfeb44000000b003231887dd6dmr15945083wrn.3.1697011861964; 
 Wed, 11 Oct 2023 01:11:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d4c4a000000b00323287186aasm14697527wrt.32.2023.10.11.01.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:11:01 -0700 (PDT)
Date: Wed, 11 Oct 2023 04:10:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011040331-mutt-send-email-mst@kernel.org>
References: <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
 <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481336B395F38E875ED11D8DCCCA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Wed, Oct 11, 2023 at 08:00:57AM +0000, Parav Pandit wrote:
> Hi Christoph,
> 
> > From: Christoph Hellwig <hch@infradead.org>
> > Sent: Wednesday, October 11, 2023 12:29 PM
> > 
> > On Wed, Oct 11, 2023 at 02:43:37AM -0400, Michael S. Tsirkin wrote:
> > > > Btw, what is that intel thing everyone is talking about?  And why
> > > > would the virtio core support vendor specific behavior like that?
> > >
> > > It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
> > > that implemented vdpa support and so Zhu Lingshan from intel is
> > > working on vdpa and has also proposed virtio spec extensions for migration.
> > > intel's driver is called ifcvf.  vdpa composes all this stuff that is
> > > added to vfio in userspace, so it's a different approach.
> > 
> > Well, so let's call it virtio live migration instead of intel.
> > 
> > And please work all together in the virtio committee that you have one way of
> > communication between controlling and controlled functions.
> > If one extension does it one way and the other a different way that's just
> > creating a giant mess.
> 
> We in virtio committee are working on VF device migration where:
> VF = controlled function
> PF = controlling function
> 
> The second proposal is what Michael mentioned from Intel that somehow combine controlled and controlling function as single entity on VF.
> 
> The main reasons I find it weird are:
> 1. it must always need to do mediation to do fake the device reset, and flr flows
> 2. dma cannot work as you explained for complex device state
> 3. it needs constant knowledge of each tiny things for each virtio device type
> 
> Such single entity appears a bit very weird to me but maybe it is just me.

Yea it appears to include everyone from nvidia. Others are used to it -
this is exactly what happens with virtio generally. E.g. vhost
processes fast path in the kernel and control path is in userspace.
vdpa has been largely modeled after that, for better or worse.
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
