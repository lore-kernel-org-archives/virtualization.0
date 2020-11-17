Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC4CC56202
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:33:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF5A2222E
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 14:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8mpnF3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF5A2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1AB8B863EE;
	Tue, 17 Nov 2020 14:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2iZufAxuk5GR; Tue, 17 Nov 2020 14:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2314386254;
	Tue, 17 Nov 2020 14:33:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A0F8C0891;
	Tue, 17 Nov 2020 14:33:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE22C07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 78D2E85B0C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7obDMR2s7-k
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3B1F085604
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605623585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4FZvUH2HZR1j9AWlmRfDoE5NQCnlGVtxpdam0CDlxdg=;
 b=B8mpnF3UhK16VZXmdhE08HYOfKef19R72zv0hljiRMZAjFHqc93izt9IfdPxpXrMFd4muC
 57YgqgRhaNFpycg5jtzWJLBlFRfwYR9MqYfxLDZn7gMBLcsqOzkmRajlYObtKqq3yKMCFZ
 b0Tz9M+YU6wI/gnwShcKaOX+KZMdKqI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-9olb9Y4NPn2dBFDjYSNbHg-1; Tue, 17 Nov 2020 09:33:03 -0500
X-MC-Unique: 9olb9Y4NPn2dBFDjYSNbHg-1
Received: by mail-wr1-f72.google.com with SMTP id w17so12936431wrp.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 06:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4FZvUH2HZR1j9AWlmRfDoE5NQCnlGVtxpdam0CDlxdg=;
 b=PP7qZvzmg6W8zj9MpQo2VVLp8uxp6TMxA55wDGRl2dJGuF1O1vl5ShOE+dLZBv1hx0
 nB1Niq2PGAhLW6QVt05wU3eGnBW1fRDwayvA4zmD8z0SftTT71cBY5PX5njBysADwN1P
 vr4wWNdVWwqWWQ6YbiJ79LCRZyh68vdR785Aw5+8r87CTdIinYGBns9K0oU+2sY+6/iZ
 +4X0ZbnVkf5AZXGHSuNbHTxTnS+KyEFQ34xTwe1xd7xrdttysRnxf1AAqx6TS4izOM9T
 D+j4HhkrRr1S+plkQIcrKGnjGHFvyn4dh9hbm8ZPIDXHR+/mJ6eF6ZTh7QLJJCw7xaoj
 ul7Q==
X-Gm-Message-State: AOAM533oOWWd3+vbW23vx5j4CiZVI8/EffBZ44nbgR3I8Wi55HcXOTN6
 sPOUknLU5CJEwnqiUx2q9tTaJJxXwIJnVxykMNS73wFptUR/DSzFvahX9++PwmHeRfmR3YS3TT/
 5XNj0wgaDNF9E+u+jCF5rWG6CrA10qke2HtOBvY8vCw==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr4880152wmh.110.1605623581859; 
 Tue, 17 Nov 2020 06:33:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzelJd9YzCnQ6HlAkPG0dYJhRmCRZ5mnkDM4NfpaGFovbOgWp0v59ANAyM7wHvxfIF0qlRi4Q==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr4880133wmh.110.1605623581660; 
 Tue, 17 Nov 2020 06:33:01 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id f18sm14045497wru.42.2020.11.17.06.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2020 06:33:01 -0800 (PST)
Date: Tue, 17 Nov 2020 15:32:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 12/12] vdpa_sim_blk: implement ramdisk behaviour
Message-ID: <20201117143258.kfm7jhkofwavq6p6@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-13-sgarzare@redhat.com>
 <20201117113636.GG131917@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201117113636.GG131917@stefanha-x1.localdomain>
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

On Tue, Nov 17, 2020 at 11:36:36AM +0000, Stefan Hajnoczi wrote:
>On Fri, Nov 13, 2020 at 02:47:12PM +0100, Stefano Garzarella wrote:
>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> index 8e41b3ab98d5..68e74383322f 100644
>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>> @@ -7,6 +7,7 @@
>>   */
>>
>>  #include <linux/module.h>
>> +#include <linux/blkdev.h>
>>  #include <uapi/linux/virtio_blk.h>
>>
>>  #include "vdpa_sim.h"
>> @@ -24,10 +25,137 @@
>>
>>  static struct vdpasim *vdpasim_blk_dev;
>>
>> +static int vdpasim_blk_handle_req(struct vdpasim *vdpasim,
>> +				  struct vdpasim_virtqueue *vq)
>
>This function has a non-standard int return value. Please document it.

Yes, I'll do.

>
>> +{
>> +	size_t wrote = 0, to_read = 0, to_write = 0;
>> +	struct virtio_blk_outhdr hdr;
>> +	uint8_t status;
>> +	uint32_t type;
>> +	ssize_t bytes;
>> +	loff_t offset;
>> +	int i, ret;
>> +
>> +	vringh_kiov_cleanup(&vq->riov);
>> +	vringh_kiov_cleanup(&vq->wiov);
>> +
>> +	ret = vringh_getdesc_iotlb(&vq->vring, &vq->riov, &vq->wiov,
>> +				   &vq->head, GFP_ATOMIC);
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	for (i = 0; i < vq->wiov.used; i++)
>> +		to_write += vq->wiov.iov[i].iov_len;
>> +	to_write -= 1; /* last byte is the status */
>
>What if vq->wiov.used == 0?

Right, we should discard the descriptor.

>
>> +
>> +	for (i = 0; i < vq->riov.used; i++)
>> +		to_read += vq->riov.iov[i].iov_len;
>> +
>> +	bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->riov, &hdr, sizeof(hdr));
>> +	if (bytes != sizeof(hdr))
>> +		return 0;
>> +
>> +	to_read -= bytes;
>> +
>> +	type = le32_to_cpu(hdr.type);
>> +	offset = le64_to_cpu(hdr.sector) << SECTOR_SHIFT;
>> +	status = VIRTIO_BLK_S_OK;
>> +
>> +	switch (type) {
>> +	case VIRTIO_BLK_T_IN:
>> +		if (offset + to_write > VDPASIM_BLK_CAPACITY << SECTOR_SHIFT) {
>
>Integer overflow is not handled.

I'll fix.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
