Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE76E6FE48
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 15:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9D2F83A3F;
	Fri, 22 Sep 2023 15:13:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B9D2F83A3F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IaItkzYO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oSbDpASfh-Zx; Fri, 22 Sep 2023 15:13:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E756C8376B;
	Fri, 22 Sep 2023 15:13:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E756C8376B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C926FC0039;
	Fri, 22 Sep 2023 15:13:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4765EC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C83A838B6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:13:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C83A838B6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id epWdfy9u3S65
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:13:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E27238376B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E27238376B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695395608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1fwravdlQW+TfYmAP3Jwly7QmycP8GgTViJStGE1Ymw=;
 b=IaItkzYOOqGPQO+InBVZA7USENROXnhRt0R3I/Xys5MyEiDIoxAaMquYo5fGCF02fwl50v
 jBeJQRWEMbWNf4+dA1BD2btzzXo/2tioDvymX9Zpp4qbhTfwA3V/ee0pvGUAWIstIZCfAL
 B5p6MDnYuz8reErZDymw6a9+GnvThlk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-eqthouBVOMScwiY8wUGCQQ-1; Fri, 22 Sep 2023 11:13:24 -0400
X-MC-Unique: eqthouBVOMScwiY8wUGCQQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-530f2ccceeeso1543227a12.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695395603; x=1696000403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fwravdlQW+TfYmAP3Jwly7QmycP8GgTViJStGE1Ymw=;
 b=ejrRaeGwoF3GlsJfxtWU8cp+0SU7Gpj/szAwCZq9K5j9Qvx7oPB2dY5/qczNcpspX5
 VaLBiuqTN5Ip9chk+phscD7iyJHQ1wD5UhPqTQkGdMZMUTsy/+oFC5tUovPhprj7aItZ
 RkCHNhdgoEEFVp5b3/Kvtx/OgHgu4ppY3XXyfK+zJWkV820yM4Pt1rzGAAQpnJp8BLA2
 qvpWTMCTFuGadzssKG7Jqf5lAvyaWov71gGvkA4YyYjSQCl/+YY3lSOzAjnJAyyqBO9k
 r4WFV902r1hh04hD7aiubKxEl8t7Hgyd5C2OzMAZNxndxGFw967VYD8qw7Uk/atqCjrK
 ITjw==
X-Gm-Message-State: AOJu0YytPJC3q9czSJE+XM68qHwdGgZc+EmacXRWAcUrNQKdyX4sSBSt
 Dyq6fLWsyDlXPXuHGy5Q0pjD5wyCm81AFKHYb+XKIFpZyzLwwo6JVOSye2XZAcFEOD1G4IkdJD2
 kTx5EhoqIBybRyo1bsXWD0TS3bMzzaoBsAavRr694KQ==
X-Received: by 2002:a50:ed19:0:b0:52a:943:9ab5 with SMTP id
 j25-20020a50ed19000000b0052a09439ab5mr7345418eds.31.1695395603652; 
 Fri, 22 Sep 2023 08:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0GrOD/17wfL7ZvOlZyM/FdueLD1tF3NbMlJUxhkMCutGNKq9CV+OCyqlu/MCmwJVlx6neRA==
X-Received: by 2002:a50:ed19:0:b0:52a:943:9ab5 with SMTP id
 j25-20020a50ed19000000b0052a09439ab5mr7345404eds.31.1695395603338; 
 Fri, 22 Sep 2023 08:13:23 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 e9-20020aa7d7c9000000b00532acb014a6sm2366924eds.68.2023.09.22.08.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:13:22 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:13:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922111132-mutt-send-email-mst@kernel.org>
References: <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
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

On Fri, Sep 22, 2023 at 12:25:06PM +0000, Parav Pandit wrote:
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, September 22, 2023 5:53 PM
> 
> 
> > > And what's more, using MMIO BAR0 then it can work for legacy.
> > 
> > Oh? How? Our team didn't think so.
> 
> It does not. It was already discussed.
> The device reset in legacy is not synchronous.
> The drivers do not wait for reset to complete; it was written for the sw backend.
> Hence MMIO BAR0 is not the best option in real implementations.

Or maybe they made it synchronous in hardware, that's all.
After all same is true for the IO BAR0 e.g. for the PF: IO writes are posted anyway.

Whether that's possible would depend on the hardware architecture.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
