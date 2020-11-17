Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F168C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:16:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22BD221F8
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDELJi8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D22BD221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0E32D85B94;
	Tue, 17 Nov 2020 14:16:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpGE-UYWD1TI; Tue, 17 Nov 2020 14:16:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0876A85BEE;
	Tue, 17 Nov 2020 14:16:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0888C0891;
	Tue, 17 Nov 2020 14:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B45C7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8587D21FA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rfIv9m5eUt+n
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:16:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 3981C214F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605622590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CzMT1+oVbQ9dwG/lsdpdD0JPtzFvgGD2Po3JeM77ORU=;
 b=BDELJi8WAkg3dVK3V9o427rrcgYudCi6TRpDpZze1SMDk78VtkfeSmAmK6pAvSdRL40ngN
 MfmYOhbG1/ptZYXlquFFg6tjO0uwqoWOXrkm0GolGOrcKHT2mRSimmPXRZeqGIgH2xCrx6
 iBkTVtyPy59bkN3KGqgK7gHbDEZ1TNQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-LDy25zwQOkaMeEipXMG_WQ-1; Tue, 17 Nov 2020 09:16:25 -0500
X-MC-Unique: LDy25zwQOkaMeEipXMG_WQ-1
Received: by mail-wr1-f70.google.com with SMTP id f4so13090386wru.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 06:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CzMT1+oVbQ9dwG/lsdpdD0JPtzFvgGD2Po3JeM77ORU=;
 b=UOQfBgvWzE0R95viEcWyxADlQuxpm+xxrNa97dewjKpS+uZkzSiQZ1DZvJ9nu9yACQ
 BwPIFfXq6D2xd5Rd9PcPzOXlx0wd++M9oisn8vJx3O//4DsmurbX1i9KV/jBBwnQymvA
 A0lhJapsfAf5KMvjIEhqQ/cuXY2B/lt0WYaUNmXkYM86yNWleALMiVcik702MNLtXcL/
 OlKnKhG57Op62NMZsDbbvMOrVCQWrvGDXtC/LSlQJi5EGoALIWemHu5mVC7jtydBX0N7
 kjTUFgHff4v99yZvUdhGWv+BSGuhgNCjJiZkJfhdsOLQnFv0RTOBP5BEqk67O7g+dupO
 7XyQ==
X-Gm-Message-State: AOAM533HQZdudlIxAiNJZOCLeY4ywnRo5YixCw8kwHdf/jU8A47u+ddX
 muZYE0C+7YCwqjpJP0+hEPOnFk6zGC2RwmrQbg8xQeYZsZDqLllYVOBhYOnwd7f01JaLTMEscou
 oP1Iq9Mg0PVRTtudNIIFDNvKuKWz2mvWCQWdZLT2uYA==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr4676410wmi.138.1605622584207; 
 Tue, 17 Nov 2020 06:16:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBkIRbW/E0QpPWzxXv/oO7j1HcflxKjnPt/yFzKIM9ogMSgtbRK19mcoLGa0kZoD3/i5gmAg==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr4676379wmi.138.1605622583987; 
 Tue, 17 Nov 2020 06:16:23 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id d3sm29797039wrg.16.2020.11.17.06.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 06:16:23 -0800 (PST)
Date: Tue, 17 Nov 2020 15:16:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201117141620.ytium7r6xpxi4and@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201117111121.GD131917@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>
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

On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
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
>> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>> +					    &vq->head, GFP_ATOMIC) > 0) {
>> +
>> +			int write;
>> +
>> +			vq->iov.i = vq->iov.used - 1;
>> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>> +			if (write <= 0)
>> +				break;
>
>We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)

The crash could happen if the simulator doesn't put the string 
terminator, but in virtio_blk.c, the serial_show() initialize the buffer 
putting the string terminator in the VIRTIO_BLK_ID_BYTES element:

     buf[VIRTIO_BLK_ID_BYTES] = '\0';
     err = virtblk_get_id(disk, buf);

This should prevent the issue, right?

However in the last patch of this series I implemented 
VIRTIO_BLK_T_GET_ID support :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
