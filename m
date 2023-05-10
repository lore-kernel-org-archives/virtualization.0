Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57354C77B7D
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 20:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DACBB8408C;
	Wed, 10 May 2023 20:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DACBB8408C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwlJL309
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JjwngToWbX_L; Wed, 10 May 2023 20:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D339840E7;
	Wed, 10 May 2023 20:40:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D339840E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4CFEC0036;
	Wed, 10 May 2023 20:40:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B5C2C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 20:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F1C2742014
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 20:40:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1C2742014
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TwlJL309
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WQcgV9Jh_Ulx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 20:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D04B342011
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D04B342011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683751216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c+YVOgzbPmVhXEjjEWcuvNv2oF/4/N7gIelXpRLUbJk=;
 b=TwlJL3091BQkRfeAOqXUMdPsQSaaEEjljItgLoIchya9nLyTuivBlvVjQiBEJ5dxWFCAT1
 lle+7hNbkjIYkc7jqVRGSi+fmd4ztMMgJgdLqbx+zBCJ6As2/QBBm4m2mKEkt/QVxiQv4J
 Wq5CcKgoSYeosapoDQypLO7kcc6yRXo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-P_to_VUQPO66yZ5jePsmxQ-1; Wed, 10 May 2023 16:40:15 -0400
X-MC-Unique: P_to_VUQPO66yZ5jePsmxQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f33f8ffa37so28337455e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 13:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683751214; x=1686343214;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c+YVOgzbPmVhXEjjEWcuvNv2oF/4/N7gIelXpRLUbJk=;
 b=DFOOQArw8rJyhD24utNEs5GU8SqBaol+qkv+cUdP1Qgc4WJyGhne6SowLnwH4NPCFl
 7tsEmUCP63RSdwLmlIEo3T1BOjMGnCp9YgX6gL6qn7ED2DW1gJAvcAf6/Zmduke12CoH
 2rriJV2NOtcVXmqOXyxP17T9EJOGHat/vPV1qvl1GfUOe0QW1T/MneZ8xGEPBivJgPlc
 O5HlswOpOk0LaJeWmrUVw4ddwLtab98C7+1rlZSBHKam9SOEuLEmMVjddhndGtFHIUkW
 aWT9MFeqEnoJM5MoBGwuEeTkWBFBxJEoP7Lzi2VkkagQ3+LLKDdbhVP+DhStHc7jOJrV
 hWnA==
X-Gm-Message-State: AC+VfDxARTlLyHbROIgwQokJeylj2J6O0V+9dwZBFoETbPqAEnKIg9UM
 mjVAEw/FD8kjr8bkuRUrQyHSZ0Hj3QcxouA/usCcorXcLAFJ8oDRonGMgz3ZzUk0NcsIYdcx0Pc
 nUbxbYdEjHRvf2+jT23ekYhb4l+/W2YycGUrEQiKhaw==
X-Received: by 2002:a1c:7319:0:b0:3f1:8ef0:7e2f with SMTP id
 d25-20020a1c7319000000b003f18ef07e2fmr12174290wmb.25.1683751213960; 
 Wed, 10 May 2023 13:40:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6eDoURduChHVCCN6+Chl5iorNMrvcKwRG8uiLTVLS+FrkSHsjJPGzuXrbkWId0VcjA4xStFA==
X-Received: by 2002:a1c:7319:0:b0:3f1:8ef0:7e2f with SMTP id
 d25-20020a1c7319000000b003f18ef07e2fmr12174282wmb.25.1683751213568; 
 Wed, 10 May 2023 13:40:13 -0700 (PDT)
Received: from redhat.com ([31.187.78.71]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c22ca00b003f42158288dsm12676432wmg.20.2023.05.10.13.40.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 May 2023 13:40:12 -0700 (PDT)
Date: Wed, 10 May 2023 16:40:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Horman <horms@kernel.org>
Subject: Re: [PATCH] virtio: Add missing documentation for structure fields
Message-ID: <20230510163954-mutt-send-email-mst@kernel.org>
References: <20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org>
 <20230510120332-mutt-send-email-mst@kernel.org>
 <ZFv4DfUcipQAII5R@kernel.org>
 <20230510161442-mutt-send-email-mst@kernel.org>
 <ZFv8GSdpg1sgVqxy@kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZFv8GSdpg1sgVqxy@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, May 10, 2023 at 10:18:33PM +0200, Simon Horman wrote:
> On Wed, May 10, 2023 at 04:14:53PM -0400, Michael S. Tsirkin wrote:
> > On Wed, May 10, 2023 at 10:01:17PM +0200, Simon Horman wrote:
> > > On Wed, May 10, 2023 at 12:04:21PM -0400, Michael S. Tsirkin wrote:
> > > > On Wed, May 10, 2023 at 02:23:12PM +0200, Simon Horman wrote:
> > > > > Add missing documentation for the vqs_list_lock field of struct virtio_device,
> > > > > and the validate field of struct virtio_driver.
> > > > > 
> > > > > ./scripts/kernel-doc says:
> > > > > 
> > > > >  .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> > > > >  .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> > > > >  2 warnings as Errors
> > > > > 
> > > > > No functional changes intended.
> > > > > 
> > > > > Signed-off-by: Simon Horman <horms@kernel.org>
> > > > > ---
> > > > >  include/linux/virtio.h | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > > > index b93238db94e3..0b2b82ee3220 100644
> > > > > --- a/include/linux/virtio.h
> > > > > +++ b/include/linux/virtio.h
> > > > > @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> > > > >   * @config_enabled: configuration change reporting enabled
> > > > >   * @config_change_pending: configuration change reported while disabled
> > > > >   * @config_lock: protects configuration change reporting
> > > > > + * @vqs_list_lock: protects @vqs.
> > > > >   * @dev: underlying device.
> > > > >   * @id: the device type identification (used to match it with a driver).
> > > > >   * @config: the configuration ops for this device.
> > > > > @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
> > > > >   * @feature_table_size: number of entries in the feature table array.
> > > > >   * @feature_table_legacy: same as feature_table but when working in legacy mode.
> > > > >   * @feature_table_size_legacy: number of entries in feature table legacy array.
> > > > > + * @validate: the function to call to vaidate features at probe time.
> > > > 
> > > > typo
> > > > 
> > > > and this is called before probe actually not at probe time
> > > 
> > > Thanks, how about the following?
> > > 
> > > * @validate: the function to call to validate features
> > 
> > ... and config space
> 
> Ok, so:
> 
> * @validate: the function to call to validate features and config spaces

config space

> > > > >   * @probe: the function to call when a device is found.  Returns 0 or -errno.
> > > > >   * @scan: optional function to call after successful probe; intended
> > > > >   *    for virtio-scsi to invoke a scan.
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
