Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4A9C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 08:02:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A1464F4E
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 08:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1464F4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 543A8857A4;
	Thu,  4 Feb 2021 08:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DpQ4+nk7d+P; Thu,  4 Feb 2021 08:02:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 27705857D0;
	Thu,  4 Feb 2021 08:02:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CEBBC08A1;
	Thu,  4 Feb 2021 08:02:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3533C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 08:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A2B5E20437
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 08:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x00JD9izhWPa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 08:02:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C1F5E2041B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 08:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612425749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PC2k5DsAuAqCMx4jOECaSWHG2jS+sWcLS4PYn2OqsJo=;
 b=G+B1RhgVBFBaRjPu7z4O+DKoyeW8Kz1tdSTRN3xiAhOt5Vw/RSliYpeLqKI3GTBLi0yes0
 78jxO/w1ul3+8IokVBFrM5IRX1+eYPr0oWCOxrt0+4QCiO95cdw4MnQvXvx0deGXDM08ya
 PsmgIg1EdM/ziRX0WLaNZ/zI3xYeAGE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-fDjhWztvOeq-I19p7NSAmA-1; Thu, 04 Feb 2021 03:02:27 -0500
X-MC-Unique: fDjhWztvOeq-I19p7NSAmA-1
Received: by mail-wr1-f70.google.com with SMTP id d7so2169388wri.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 00:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PC2k5DsAuAqCMx4jOECaSWHG2jS+sWcLS4PYn2OqsJo=;
 b=BwlCLXVKli65WOQ+4W5p7RcctEbGmkn4KZxkiSB9zhXkE50tnh+GGFxVoLc08EasRi
 LtwLh9P9jegs1KYcnwKeveGpaohOq5+u8HDrelHZsnBhtqpGX6H9CVUsLj/bBgumgxKL
 uf8aLDzpTd9Cj6hcF37uW3y85oHygejUrh8Y84r/+xHetDiSl9CjSW1wiEuAlKbS3EmK
 Qjq4pjQd4RCwFllLBBFUlJPMEg83PulFvlrRCJm/JdqgFJJm4FwxD8SpGhii3Pdave5p
 to0253tZLmPbhtx31OHuO7Nioignc0MbrTsLQd9DvezxSw1HPg8EC+HrYs2j+JwmCb6E
 nYNg==
X-Gm-Message-State: AOAM533fdaJR5Fa9ghq1ukNiTvo/EB2DuUQWHwJsy7FVufqA8rGThszP
 oqVGdFnvBtlM8EbW6ryWdDrJy6+AzL5Lm1TUK0SUuuYoPb5B7v11iOmzcMOvzL0kIiUcf/iJOeh
 5s+zf82jHZ+NE5FeY9s8OJ0u+xRL2jqT87X4LZGeygg==
X-Received: by 2002:a05:6000:143:: with SMTP id
 r3mr7724275wrx.357.1612425746480; 
 Thu, 04 Feb 2021 00:02:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXSUXbbv7QIsSZCrVyfKN0nNnYLUHVULTKkCXlHYVs3OM4HtjhG+7SaPYaWtGCw0U0TLO6MA==
X-Received: by 2002:a05:6000:143:: with SMTP id
 r3mr7724253wrx.357.1612425746232; 
 Thu, 04 Feb 2021 00:02:26 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id c9sm5443636wmb.33.2021.02.04.00.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 00:02:25 -0800 (PST)
Date: Thu, 4 Feb 2021 09:02:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Message-ID: <20210204080223.rkc7zieq34ofs5ku@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
 <20210202093412.GA243557@stefanha-x1.localdomain>
 <20210202154950.g3rclpigyaigzfgo@steredhat>
 <20210203164551.GG74271@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20210203164551.GG74271@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Feb 03, 2021 at 04:45:51PM +0000, Stefan Hajnoczi wrote:
>On Tue, Feb 02, 2021 at 04:49:50PM +0100, Stefano Garzarella wrote:
>> On Tue, Feb 02, 2021 at 09:34:12AM +0000, Stefan Hajnoczi wrote:
>> > On Thu, Jan 28, 2021 at 03:41:25PM +0100, Stefano Garzarella wrote:
>> > > +static void vdpasim_blk_work(struct work_struct *work)
>> > > +{
>> > > +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> > > +	u8 status = VIRTIO_BLK_S_OK;
>> > > +	int i;
>> > > +
>> > > +	spin_lock(&vdpasim->lock);
>> > > +
>> > > +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> > > +		goto out;
>> > > +
>> > > +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> > > +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> > > +
>> > > +		if (!vq->ready)
>> > > +			continue;
>> > > +
>> > > +		while (vringh_getdesc_iotlb(&vq->vring, &vq->out_iov,
>> > > +					    &vq->in_iov, &vq->head,
>> > > +					    GFP_ATOMIC) > 0) {
>> > > +			int write;
>> > > +
>> > > +			vq->in_iov.i = vq->in_iov.used - 1;
>> > > +			write = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
>> > > +						      &status, 1);
>> > > +			if (write <= 0)
>> > > +				break;
>> >
>> > This code looks fragile:
>> >
>> > 1. Relying on unsigned underflow and the while loop in
>> >   vringh_iov_push_iotlb() to handle the case where in_iov.used == 0 is
>> >   risky and could break.
>> >
>> > 2. Does this assume that the last in_iov element has size 1? For
>> >   example, the guest driver may send a single "in" iovec with size 513
>> >   when reading 512 bytes (with an extra byte for the request status).
>> >
>> > Please validate inputs fully, even in test/development code, because
>> > it's likely to be copied by others when writing production code (or
>> > deployed in production by unsuspecting users) :).
>>
>> Perfectly agree on that, so I addressed these things, also following your
>> review on the previous version, on the next patch of this series:
>> "vdpa_sim_blk: implement ramdisk behaviour".
>>
>> Do you think should I move these checks in this patch?
>>
>> I did this to leave Max credit for this patch and add more code to emulate a
>> ramdisk in later patches.
>
>You could update the commit description so it's clear that input
>validation is missing and will be added in the next commit.

I'll do it.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
