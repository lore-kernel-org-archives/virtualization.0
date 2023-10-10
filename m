Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AB1CD8CA5
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 16:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 402B7400E4;
	Tue, 10 Oct 2023 16:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 402B7400E4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gq2wutR6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-AB8veA8riz; Tue, 10 Oct 2023 16:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ABCCF40635;
	Tue, 10 Oct 2023 16:03:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABCCF40635
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82716C0071;
	Tue, 10 Oct 2023 16:03:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3C3CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:03:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE8F540635
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:03:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CE8F540635
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DFrREndgKwaT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:03:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13DF0400E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 16:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13DF0400E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696953828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P+deqZTg535bR4HNi5vsiV2bgBuh6QmSGi99vJ4+UXs=;
 b=gq2wutR6BgowNxJ5hxXLTcwOSL9Zk95evINw/quVcTORDcM/mliNXzyGz6yxVakFcUdP6k
 j7wfm1ze1M6KnPHODRDKqDVIXGuVdsPCIne5WuwL506O3iATcxlMLZArPb5QckdQ2P1XDy
 cVsr6aA1tTeDZumIYQqcJUJh4vW36cI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-Gzrh7lkONPSxp0Jn8kLWwg-1; Tue, 10 Oct 2023 12:03:37 -0400
X-MC-Unique: Gzrh7lkONPSxp0Jn8kLWwg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d1ba32c95so484481f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 09:03:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696953816; x=1697558616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P+deqZTg535bR4HNi5vsiV2bgBuh6QmSGi99vJ4+UXs=;
 b=NaH07b0+Lra5wRwzWYDJkO041ITRaxD8+n1Sb++sxhPeclKVnWVZOPNKsYWOAZTPb6
 Xn5jyb+uKu8kiF2HyvBMD9iXgqNmaHnknNgqWKLaAdP3ER6n2o0hFADSepttKl+YQTg5
 0hGP8t5SXQ6vEDhiEAwzmKi3Alf1jgRaHnptiL/KW3KEIdUX5d+OX0LG7PcQ3bnO13zl
 IFIskjO7CXpEuXiTrrhOJsCcNbf8Tshgiz0bMAltjg/v4dS/6WY6y8WSyiKxJUsGdhDJ
 KXF6ZJBGq+YLWuWDbDWXIYKcrfDlYUYHdV6N3Yr+Oehz9/uZhyrVdB+k47WD6N7gIH1S
 ymhA==
X-Gm-Message-State: AOJu0YyKpsCzmotxIpka97x2codJVCn4qWU5axhbmlP9LefsHboiIiAo
 TUel1zteHZd3isJk6e1Hwrtg3wzi8Ip4wr4Z/adG9tk036J/Ki4+VO+KNOxBkYMQA32Zkb8eebH
 QxPG1bl2amFNXOQmvhYoUd6j9PmZ2rkPBkBOuvEcqeA==
X-Received: by 2002:adf:ec83:0:b0:323:3346:7d51 with SMTP id
 z3-20020adfec83000000b0032333467d51mr15733208wrn.18.1696953816405; 
 Tue, 10 Oct 2023 09:03:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOcjKGaMOeZZSsZZ/GsS4kBRlzVK2MGUeCU1BbYf2Jw03gcFg1F6hRkT1aSZutRdEwXBsM0A==
X-Received: by 2002:adf:ec83:0:b0:323:3346:7d51 with SMTP id
 z3-20020adfec83000000b0032333467d51mr15733182wrn.18.1696953816009; 
 Tue, 10 Oct 2023 09:03:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 o28-20020adfa11c000000b0032cafeae7fasm2673135wro.34.2023.10.10.09.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 09:03:34 -0700 (PDT)
Date: Tue, 10 Oct 2023 12:03:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010120158-mutt-send-email-mst@kernel.org>
References: <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231010155937.GN3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 12:59:37PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 11:14:56AM -0400, Michael S. Tsirkin wrote:
> 
> > I suggest 3 but call it on the VF. commands will switch to PF
> > internally as needed. For example, intel might be interested in exposing
> > admin commands through a memory BAR of VF itself.
> 
> FWIW, we have been pushing back on such things in VFIO, so it will
> have to be very carefully security justified.
> 
> Probably since that is not standard it should just live in under some
> intel-only vfio driver behavior, not in virtio land.
> 
> It is also costly to switch between pf/vf, it should not be done
> pointlessly on the fast path.
> 
> Jason

Currently, the switch seems to be just a cast of private data.
I am suggesting keeping that cast inside virtio. Why is that
expensive?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
