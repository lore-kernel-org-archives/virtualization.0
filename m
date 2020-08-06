Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4150C433E1
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 12:29:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9965322DFA
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2mrWlXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965322DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 154B2880FB;
	Thu,  6 Aug 2020 12:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FCcZp1N59e5K; Thu,  6 Aug 2020 12:29:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 433C7868E5;
	Thu,  6 Aug 2020 12:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2A99AC0051;
	Thu,  6 Aug 2020 12:29:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4C9C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 12:29:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E94B286E5E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 12:29:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VEdcgewK8TMB
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 12:29:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 480F586DF4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596716972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nr31koH93+WFCQ1SShZUdSdGjjcRGiTN1IIFjT+aQyE=;
 b=S2mrWlXDNmbWszY7zjVboaUHonVwr8HMkiUrjdvE/4wYmFGA9+OsGl/lag6emVI69dSNTG
 JvzJfr5yMwlNWqIsD8YOdrka1ftB5HN4q1om8kWclIFNqil+JJJQFTI23mP+efd4m2cLjS
 Ybs/sPz0F6Uf7tFweSgD7NaRGCvGtjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-J73vYnAoPkWCzknreeKiqQ-1; Thu, 06 Aug 2020 08:29:29 -0400
X-MC-Unique: J73vYnAoPkWCzknreeKiqQ-1
Received: by mail-wr1-f72.google.com with SMTP id j2so12123160wrr.14
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Aug 2020 05:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Nr31koH93+WFCQ1SShZUdSdGjjcRGiTN1IIFjT+aQyE=;
 b=D8fae95rfettNpgEBx35u/rAYHR0Aiu4JIwaaA3uv74Igxs/sUbopgG5sSSjv9I9Mi
 7Jz/V41QtP17XWHDCXhKdwYRgXml3ou2N2OQ3y399W4skorCHJfPef6YdBfbsm/FMoPb
 gEFMYJ9hsFUXFML+4Xa39OBxGWM2o/9V86K0k7YVuvwhTVF5FaAI2rgYwHbZyYsLNNPu
 s7j2C8Dx7iWysWoekLo/bzpEttSXzk+t/0XUpIXhT4VC7K2HA/yLuhqtN4HjBKv4fZNH
 Vn6jnL7ag2+GjBjS4PUk0CKdZyS0RRVaIE0wGoqL/6TDld+sI1KVZKn0SEkzznY6tCn9
 zdzQ==
X-Gm-Message-State: AOAM532HuwtIDlXH0QykEjPfWFyFyFy52CU8QndTiJ7JdcYnF29DaV3u
 GU140+C/oNAetXyrWoROd5ugRRQEIA+LR7rm2AEAjydaIWCR3SDjJppqAlT4rRrrSN0bR0WVFrD
 +Hyq2SGBzsTZuk95+jtBejpDunxh1lI1hRWQwEYSujw==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr7084613wrp.84.1596716968174;
 Thu, 06 Aug 2020 05:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ4+AA6iquJ/sckIZtxP+kOJp4F9JmrvFvoL/Ez3y4VOCxeSwNfgBeYWoNlFlzVDFCbQoFrw==
X-Received: by 2002:adf:ef44:: with SMTP id c4mr7084593wrp.84.1596716967976;
 Thu, 06 Aug 2020 05:29:27 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id z8sm6159274wmf.42.2020.08.06.05.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 05:29:26 -0700 (PDT)
Date: Thu, 6 Aug 2020 08:29:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <eli@mellanox.com>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806082727-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
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

On Thu, Aug 06, 2020 at 03:03:55PM +0300, Eli Cohen wrote:
> On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > > This patch introduce a config op to get valid iova range from the vDPA
> > > device.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  include/linux/vdpa.h | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > index 239db794357c..b7633ed2500c 100644
> > > --- a/include/linux/vdpa.h
> > > +++ b/include/linux/vdpa.h
> > > @@ -41,6 +41,16 @@ struct vdpa_device {
> > >  	unsigned int index;
> > >  };
> > >  
> > > +/**
> > > + * vDPA IOVA range - the IOVA range support by the device
> > > + * @start: start of the IOVA range
> > > + * @end: end of the IOVA range
> > > + */
> > > +struct vdpa_iova_range {
> > > +	u64 start;
> > > +	u64 end;
> > > +};
> > > +
> > 
> > 
> > This is ambiguous. Is end in the range or just behind it?
> > How about first/last?
> 
> It is customary in the kernel to use start-end where end corresponds to
> the byte following the last in the range. See struct vm_area_struct
> vm_start and vm_end fields

Exactly my point:

include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address

in this case Jason wants it to be the last byte, not one behind.


> > 
> > 
> > 
> > >  /**
> > >   * vDPA_config_ops - operations for configuring a vDPA device.
> > >   * Note: vDPA device drivers are required to implement all of the
> > > @@ -134,6 +144,9 @@ struct vdpa_device {
> > >   * @get_generation:		Get device config generation (optional)
> > >   *				@vdev: vdpa device
> > >   *				Returns u32: device generation
> > > + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> > > + *				@vdev: vdpa device
> > > + *				Returns the iova range supported by the device
> > >   * @set_map:			Set device memory mapping (optional)
> > >   *				Needed for device that using device
> > >   *				specific DMA translation (on-chip IOMMU)
> > > @@ -195,6 +208,7 @@ struct vdpa_config_ops {
> > >  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
> > >  			   const void *buf, unsigned int len);
> > >  	u32 (*get_generation)(struct vdpa_device *vdev);
> > > +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> > >  
> > >  	/* DMA ops */
> > >  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > > -- 
> > > 2.20.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
