Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF42C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 15:50:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F3764F5E
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 15:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F3764F5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ACD5A87016;
	Tue,  2 Feb 2021 15:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ro+VUIO9GzNd; Tue,  2 Feb 2021 15:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 14CD38632E;
	Tue,  2 Feb 2021 15:50:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0214C0174;
	Tue,  2 Feb 2021 15:49:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4929C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:49:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B01A68669C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9y+w80fU4nt3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E9536855D8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612280996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xl3UYgDrwSAlvWw9aAeOlF3n/HRosBCyWycSbwiVnos=;
 b=KwyWQHwu9BSdQmFFmFK2HkQZS7inr2mcn5GE5v1SmZrCbUxQaQFZxzPoHJNPz2MqI360vK
 +AQHLyQBF8KMiLWNwmPwYQUvYIPo8X1ZkynVrR05va/IDMAdWKqfstl4Ts/jfwbkts8PNA
 ju6Vp19GaR1j1cvKxsZ7TrymB7Ro1pI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-lYs8VhzNPJ-e-fLgNE8a5w-1; Tue, 02 Feb 2021 10:49:55 -0500
X-MC-Unique: lYs8VhzNPJ-e-fLgNE8a5w-1
Received: by mail-wm1-f71.google.com with SMTP id f6so1125330wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 07:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xl3UYgDrwSAlvWw9aAeOlF3n/HRosBCyWycSbwiVnos=;
 b=BE0xbqMmJnKaCpme2c+iaWxSeChIdtw4RFZWhzDJGx7CzwgKjsjRYWyEo7VnzKbTVB
 IBnf2Uyy9tjilF2I1oG96IjDdtm08McXKO/zBPoRhw8jkNMQx5OGs8MigqmbnjzrnhrH
 8yMvQKR93yueAx1+Xf8DREtCz8UwAbkgWpjRXuWSJKA6ArkHFomeBo5yEhMFvYAsU+OJ
 JNfI31022IGoevqkPfs93ZmGIuLEX10z4tHd8ssN8Hrs+s11OqiiWOVaFz+ZJjkrOMHR
 FfaNFe005grbGurKRkATpMHqVo7rRt6ScqxJTMbhoJPkpcnfCaggJWiotkyfS4zXf/jc
 SPug==
X-Gm-Message-State: AOAM5319YN7K/tbKeWHuLI/XtQ4AipJpQvJqwbw6vzX1Qet11hKrMhAs
 SaEszNtQlK952qXKcbpYHeJmWfajopUod5pJUObVrx4hxiIiX4WMNKJTPzE/HVPnKBLawRQJy9g
 x7NkozPRiQqRbNbWXtGNEL+RrqjdUwGYT/i/m4SRhQA==
X-Received: by 2002:a05:600c:4f0d:: with SMTP id
 l13mr4266404wmq.92.1612280993774; 
 Tue, 02 Feb 2021 07:49:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWu4WNYzB77YBRASb1WGMExDKDUMNYTw6v09BmpngKIZyogm2i5LC52DUiZnh7HxS460FjEg==
X-Received: by 2002:a05:600c:4f0d:: with SMTP id
 l13mr4266379wmq.92.1612280993532; 
 Tue, 02 Feb 2021 07:49:53 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id f17sm34650125wrv.0.2021.02.02.07.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 07:49:52 -0800 (PST)
Date: Tue, 2 Feb 2021 16:49:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC v2 08/10] vdpa: add vdpa simulator for block device
Message-ID: <20210202154950.g3rclpigyaigzfgo@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-9-sgarzare@redhat.com>
 <20210202093412.GA243557@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20210202093412.GA243557@stefanha-x1.localdomain>
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

On Tue, Feb 02, 2021 at 09:34:12AM +0000, Stefan Hajnoczi wrote:
>On Thu, Jan 28, 2021 at 03:41:25PM +0100, Stefano Garzarella wrote:
>> +static void vdpasim_blk_work(struct work_struct *work)
>> +{
>> +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> +	u8 status = VIRTIO_BLK_S_OK;
>> +	int i;
>> +
>> +	spin_lock(&vdpasim->lock);
>> +
>> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +		goto out;
>> +
>> +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> +
>> +		if (!vq->ready)
>> +			continue;
>> +
>> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->out_iov,
>> +					    &vq->in_iov, &vq->head,
>> +					    GFP_ATOMIC) > 0) {
>> +			int write;
>> +
>> +			vq->in_iov.i = vq->in_iov.used - 1;
>> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
>> +						      &status, 1);
>> +			if (write <= 0)
>> +				break;
>
>This code looks fragile:
>
>1. Relying on unsigned underflow and the while loop in
>   vringh_iov_push_iotlb() to handle the case where in_iov.used == 0 is
>   risky and could break.
>
>2. Does this assume that the last in_iov element has size 1? For
>   example, the guest driver may send a single "in" iovec with size 513
>   when reading 512 bytes (with an extra byte for the request status).
>
>Please validate inputs fully, even in test/development code, because
>it's likely to be copied by others when writing production code (or
>deployed in production by unsuspecting users) :).

Perfectly agree on that, so I addressed these things, also following 
your review on the previous version, on the next patch of this series:
"vdpa_sim_blk: implement ramdisk behaviour".

Do you think should I move these checks in this patch?

I did this to leave Max credit for this patch and add more code to 
emulate a ramdisk in later patches.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
