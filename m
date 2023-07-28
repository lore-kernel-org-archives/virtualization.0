Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46348C001DF
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 05:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B514E404F7;
	Fri, 28 Jul 2023 05:46:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B514E404F7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4GiWAcI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 75Qrn1-OuXQ9; Fri, 28 Jul 2023 05:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2DA444048F;
	Fri, 28 Jul 2023 05:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2DA444048F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ECA69C0071;
	Fri, 28 Jul 2023 05:46:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A08DFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6742460E33
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6742460E33
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=J4GiWAcI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2AO-FF-MUTXi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:46:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 19DF260D67
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 05:46:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 19DF260D67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690523191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
 b=J4GiWAcIQ29KKEWDhWnDa7phRuWZ54WDl8Duibg4YXS92zlf0HQuVUE+y2ZGi24q4M6BtS
 0ptH+O2cJI/cq/QnmRZ1oq8P/fA7AqOz6RreUifJ2chj9TdqhkzqD2WgwBq2O+LNlhnzht
 ikzP8f/3XyLvuSiUND7a5+pPwqPBNMI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-mTHuWboZPkqth64PlNSqWg-1; Fri, 28 Jul 2023 01:46:29 -0400
X-MC-Unique: mTHuWboZPkqth64PlNSqWg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-521da4c99d4so1382967a12.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jul 2023 22:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690523189; x=1691127989;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sMwD0drsqajj2gsdvqQy67JhYI7KDBbsBKbn31rEdKA=;
 b=U3OUydCGCDLNz2kZDZU3q5C8K6XV3eBAakykClY+nEZWODFpVXW1rIhoXWINcyc0M9
 Rh0blJVC0uGAfKJs/qQ9R511rtlE1b3D2f2aa1l99+jrQhuDsvhCFm7GFJ/9tZ64lcza
 VOgeDO1nHiTf+Hd1kMXX1spiF39H2wlHJMciAACHIJ7iuzoXwR3Rw/oCERkn3NELmvft
 m83b+FezK/9/p46rvVAwE5lcCnumna5lDX9bbUvxyIMqfb+9vit/diYeS97QJaGUtdrF
 xQddeJ24CH+A49NRSpXww4QBadJ3Lv3YqI0+2MlPXblvdZ9720V2w4LEQDFJmUUqQHPp
 oa2w==
X-Gm-Message-State: ABy/qLa80kSHwOW95NhPFCn1huaV+MOv/FSNWLwoaDUPjUBMt97R72rj
 RUM+ld6HhPPcQq31cc9LxTmUtB0qsvMd0aT6n9bkGzI+W+hUguvJg/GqVSCp0xl7xhAMk39EP1W
 JpJhJA7BYiK3rbb2kkytm18iGyyyz3rSMcxEY82RB+w==
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id
 u10-20020a056402064a00b0052238f9e653mr925617edx.30.1690523188871; 
 Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFwNX2G2yaLNlyBnSQngMGgFCKafl26b6p6i9OLIBTwmvo9JWC9mtmTi/aUFyCJtgfKzLDHvA==
X-Received: by 2002:a05:6402:64a:b0:522:38f9:e653 with SMTP id
 u10-20020a056402064a00b0052238f9e653mr925594edx.30.1690523188591; 
 Thu, 27 Jul 2023 22:46:28 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa7c602000000b00522536c2e6esm1419837edq.38.2023.07.27.22.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 22:46:27 -0700 (PDT)
Date: Fri, 28 Jul 2023 01:46:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
Message-ID: <20230728014601-mutt-send-email-mst@kernel.org>
References: <20230725130709.58207-1-gavinl@nvidia.com>
 <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org, hawk@kernel.org,
 daniel@iogearbox.net, netdev@vger.kernel.org, john.fastabend@gmail.com,
 ast@kernel.org, gavi@nvidia.com, edumazet@google.com,
 Heng Qi <hengqi@linux.alibaba.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 davem@davemloft.net, Gavin Li <gavinl@nvidia.com>
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

On Thu, Jul 27, 2023 at 03:28:32PM +0200, Paolo Abeni wrote:
> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> > Add interrupt_coalesce config in send_queue and receive_queue to cache user
> > config.
> > 
> > Send per virtqueue interrupt moderation config to underlying device in
> > order to have more efficient interrupt moderation and cpu utilization of
> > guest VM.
> > 
> > Additionally, address all the VQs when updating the global configuration,
> > as now the individual VQs configuration can diverge from the global
> > configuration.
> > 
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> FTR, this patch is significantly different from the version previously
> acked/reviewed, I'm unsure if all the reviewers are ok with the new
> one.
> 
> [...]

still ok by me

Acked-by: Michael S. Tsirkin <mst@redhat.com>

let's wait for Jason too.

> >  static int virtnet_set_coalesce(struct net_device *dev,
> >  				struct ethtool_coalesce *ec,
> >  				struct kernel_ethtool_coalesce *kernel_coal,
> >  				struct netlink_ext_ack *extack)
> >  {
> >  	struct virtnet_info *vi = netdev_priv(dev);
> > -	int ret, i, napi_weight;
> > +	int ret, queue_number, napi_weight;
> >  	bool update_napi = false;
> >  
> >  	/* Can't change NAPI weight if the link is up */
> >  	napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
> > -	if (napi_weight ^ vi->sq[0].napi.weight) {
> > -		if (dev->flags & IFF_UP)
> > -			return -EBUSY;
> > -		else
> > -			update_napi = true;
> > +	for (queue_number = 0; queue_number < vi->max_queue_pairs; queue_number++) {
> > +		ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
> > +						      vi->sq[queue_number].napi.weight,
> > +						      &update_napi);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (update_napi) {
> > +			/* All queues that belong to [queue_number, queue_count] will be
> > +			 * updated for the sake of simplicity, which might not be necessary
> 
> It looks like the comment above still refers to the old code. Should
> be:
> 	[queue_number, vi->max_queue_pairs]
> 			
> Otherwise LGTM, thanks!
> 
> Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
