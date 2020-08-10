Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13792C433E0
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 12:06:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDF02070B
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WrqylYWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDF02070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 692BE87D11;
	Mon, 10 Aug 2020 12:06:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9m0Z+hWB1NSr; Mon, 10 Aug 2020 12:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1ABBC87B7D;
	Mon, 10 Aug 2020 12:06:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 037CBC0864;
	Mon, 10 Aug 2020 12:06:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15362C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 00AE9890B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8PzoPt2ZLF+A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:06:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1273C890A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 12:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597061163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EKMEj4LLBIlpg9dc7O4gTO5SL6FSODyW/zNWUMbYW/4=;
 b=WrqylYWGt7CYAeQeFjyyJN7yKqj/bUsdUwRx9GjjPMa49RIohhJi/hfrt1lDJV2JI7oZq0
 JPAhbCIdToLT/2U+UZc3XF++9oVr4AItRS7AZqv7vsjsY1v4Mqshl9IU2V9qjidUM25X6O
 +7+4D6SD1ONEb+O5weaKLt7xPQuEa14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-WQTw_OEFNtuoBUtShbs7Bg-1; Mon, 10 Aug 2020 08:06:02 -0400
X-MC-Unique: WQTw_OEFNtuoBUtShbs7Bg-1
Received: by mail-wr1-f71.google.com with SMTP id t3so4137868wrr.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EKMEj4LLBIlpg9dc7O4gTO5SL6FSODyW/zNWUMbYW/4=;
 b=m6H/Fr0zoqkZq7kQhZAL7QdNDKMgptakce1pzPQINRHRcQ3PMkCHfP5OXYVZrXuVtB
 nOACFXDfjJcsjn3CF1AtXJa88reHKj5rB3nZMx8OQGtLW/ILNbbIoggfrneBw6bE/fbG
 pz5ZgRHJXBKNGk+PDf2VX/BbXtEzKfWW26sM0Cq/IyP7Qfqfn9jFM1Aw2ZiWekRAEvwp
 D+T+n4HE3MyQgJh+WPPmi1k7AEcGDBfiFWV9HG1YTZyBAvig3bjqb1fnodb+v3bLeYaj
 AufDr7muEFQB1hq+M5vpvtPAAuXLPUmPS/KUWE7zvE3FwZLXiSBDmzAohKFvy93uFBd2
 FijQ==
X-Gm-Message-State: AOAM53305tC2xvfXgzZ14hmGGgd8tu66BIzj/YPdVSXVczFPdP7WZhQQ
 MQoXz7+XS/D9v3mpH2qx37Dx714qlO0sJCOqA1v2B57gd7+nhVGbL9dhKWYjvf89M9va/kS3U2H
 rON+yWzkREgSOrap5kdD1U7+so7CHkozkfhpXUQpiMw==
X-Received: by 2002:a1c:61d5:: with SMTP id
 v204mr26101286wmb.102.1597061161367; 
 Mon, 10 Aug 2020 05:06:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqAFGBcFY9c83qTCgWpUm3fN1gdspLbZEuXOkidZNF9FgzpzShlRZ6XzYHiuISMmVbh8wYDA==
X-Received: by 2002:a1c:61d5:: with SMTP id
 v204mr26101260wmb.102.1597061161105; 
 Mon, 10 Aug 2020 05:06:01 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
 by smtp.gmail.com with ESMTPSA id
 68sm21058637wra.39.2020.08.10.05.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 05:05:59 -0700 (PDT)
Date: Mon, 10 Aug 2020 08:05:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200810080410-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 hanand@xilinx.com, zhangweining@ruijie.com.cn, lingshan.zhu@intel.com,
 mhabets@solarflare.com, rob.miller@broadcom.com
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

On Thu, Aug 06, 2020 at 03:43:54PM +0300, Eli Cohen wrote:
> On Thu, Aug 06, 2020 at 08:29:22AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> > > On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > > > This patch introduce a config op to get valid iova range from the vDPA
> > > > > device.
> > > > > 
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  include/linux/vdpa.h | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > > index 239db794357c..b7633ed2500c 100644
> > > > > --- a/include/linux/vdpa.h
> > > > > +++ b/include/linux/vdpa.h
> > > > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > > > >  	unsigned int index;
> > > > >  };
> > > > >  
> > > > > +/**
> > > > > + * vDPA IOVA range - the IOVA range support by the device
> > > > > + * @start: start of the IOVA range
> > > > > + * @end: end of the IOVA range
> > > > > + */
> > > > > +struct vdpa_iova_range {
> > > > > +	u64 start;
> > > > > +	u64 end;
> > > > > +};
> > > > > +
> > > > 
> > > > 
> > > > This is ambiguous. Is end in the range or just behind it?
> > > > How about first/last?
> > > 
> > > It is customary in the kernel to use start-end where end corresponds to
> > > the byte following the last in the range. See struct vm_area_struct
> > > vm_start and vm_end fields
> > 
> > Exactly my point:
> > 
> > include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address
> > 
> > in this case Jason wants it to be the last byte, not one behind.
> > 
> > 
> Maybe start, size? Not ambiguous, and you don't need to do annoying
> calculations like size = last - start + 1

Size has a bunch of issues: can overlap, can not cover the entire 64 bit
range. The requisite checks are arguably easier to get wrong than
getting the size if you need it.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
