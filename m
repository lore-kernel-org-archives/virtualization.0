Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83867C4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 06:42:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 037A781FC7;
	Thu, 24 Nov 2022 06:42:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 037A781FC7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QCf6fiZ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z-DGZSJ9PwA9; Thu, 24 Nov 2022 06:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F2DD82054;
	Thu, 24 Nov 2022 06:42:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F2DD82054
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FC83C0032;
	Thu, 24 Nov 2022 06:42:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADE7C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4B5340C88
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:42:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4B5340C88
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QCf6fiZ8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4439bvSpR2bJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:42:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 845D44027A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 845D44027A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669272163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wOqX//WO/SuD46lY/nGKbW4uQccMAdo5TPL5IV9u1gM=;
 b=QCf6fiZ8nzxN6D4LgrYtuk0VcKO981nzO2OwMpaTEmFD8/4dKOLrW0qkQtBvyaG/+FbZU3
 B6WcTSOOcI+LnG9K8qtW5+hrRSG6u+LzW38IHgNaAtqF/jDIy8JF236+T9x886bybY9Wqy
 3G/sEj4D9n27Gcz/C6DqsrcMqZ+cUso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-8epwXQSoNB-Plp8xDuj9PA-1; Thu, 24 Nov 2022 01:42:41 -0500
X-MC-Unique: 8epwXQSoNB-Plp8xDuj9PA-1
Received: by mail-wm1-f70.google.com with SMTP id
 o5-20020a05600c510500b003cfca1a327fso522041wms.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 22:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOqX//WO/SuD46lY/nGKbW4uQccMAdo5TPL5IV9u1gM=;
 b=eAzYCk2soMJ5yobSFgwCtjHrIfA7mOimjcoGVkdZADDdd5hM4ONKwGemgdZ6BTeQlg
 EQl5+mNbNAaAwOc1F173A+gcKJfhhJ1F1mpBw/aK0arurPOypVRre8N5IymmnnBfk8BE
 QLmajRkjWAetM8CB8+yxDhGhrhkpFjYRfk09nne2WjViVcu5dQQW6ACkC2JHowPgDvXE
 9hyUFEtyoUUCo42JEHJ3koG6kTt9kOLwgHNyxvx+nIY+m2q49s6W/eWJkcgkAstpglQW
 KO4YpJTsfJliIwuib7s+z9CaE85YwizPSHdoqn7CkrIXntVK2Q3xq3Jh4ogLGAqCuWpK
 W+Ng==
X-Gm-Message-State: ANoB5pkIvvjAzdjLA4dRTRBL2kjhl8ACdDXY4ZXFp2JXADNIw0IxYdWL
 LOGEpIlohwmYNkFTYzjued9SUCIXZyboZVj+2IoM3LS9eC1PdQsiuk7yZ5zKzzuWWW1Y4Fz/QHk
 CIlPty+FTIC5P19jBVN37TCrF5OBn14uGqMve6aVHDA==
X-Received: by 2002:a7b:cd81:0:b0:3d0:21f6:43e2 with SMTP id
 y1-20020a7bcd81000000b003d021f643e2mr11963358wmj.83.1669272160693; 
 Wed, 23 Nov 2022 22:42:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5rJHndNv44VSWZREDFYbXnBzZRrIfxjmoY7UQm1EM15OtLI5tmf0qitJlSQg5+kK4CFADS4g==
X-Received: by 2002:a7b:cd81:0:b0:3d0:21f6:43e2 with SMTP id
 y1-20020a7bcd81000000b003d021f643e2mr11963355wmj.83.1669272160419; 
 Wed, 23 Nov 2022 22:42:40 -0800 (PST)
Received: from redhat.com ([2.52.16.74]) by smtp.gmail.com with ESMTPSA id
 r16-20020a5d6950000000b0022e36c1113fsm445969wrw.13.2022.11.23.22.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 22:42:40 -0800 (PST)
Date: Thu, 24 Nov 2022 01:42:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221124013830-mutt-send-email-mst@kernel.org>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1bd1c77e-d8c3-b04a-4fbc-bbc85391e630@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Wed, Nov 23, 2022 at 10:41:46PM +0000, Chaitanya Kulkarni wrote:
> 
> > +/* Get lifetime information from device */
> > +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
> > +{
> > +	struct request_queue *q = vblk->disk->queue;
> > +	struct request *req = NULL;
> > +	struct virtblk_req *vbr;
> > +	struct virtio_blk_lifetime lifetime;
> > +	int ret;
> > +
> > +	/* The virtio_blk_lifetime struct fields follow virtio spec.
> > +	 * There is no check/decode on values received from the device.
> > +	 * The data is sent as is to the user.
> > +	 */
> 
> Odd comment style, why not :-
> 
> 	/*
> 	 * The virtio_blk_lifetime struct fields follow virtio spec.
> 	 * There is no check/decode on values received from the device.
> 	 * The data is sent as is to the user.
> 	 */

most of virtio blk is like this. I don't really care much.

> > +
> > +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> > +	 * feature is negotiated.
> > +	 */
> 
> above comment is redundant to the below code as following code is
> self explanatory.,..

i find it helpful personally - this point is important enough to
stress at cost of some duplication.

> > +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> > +		return -ENOTTY;
> > +
> > +	memset(&lifetime, 0, sizeof(lifetime));
> > +
> > +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> > +	if (IS_ERR(req))
> > +		return PTR_ERR(req);
> > +
> > +	/* Write the correct type */
> 
> same here for above comment...

it's pretty harmless though

> > +	vbr = blk_mq_rq_to_pdu(req);
> > +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
> > +
> > +	ret = blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL);
> > +	if (ret)
> > +		goto out;
> > +
> > +	blk_execute_rq(req, false);
> > +
> > +	ret = virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
> > +	if (ret)
> > +		goto out;
> > +
> > +	/* Pass the data to the user */
> > +	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> > +		ret = -EFAULT;
> > +		goto out;
> 
> there nothing here to "goto out" following is sufficient I guess :-
> 
> if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime)))
> 	ret = -EFAULT;

error handling with goto seems cleaner, easier to add code down
the road.

> > +	}
> > +
> > +out:
> > +	blk_mq_free_request(req);
> > +	return ret;
> > +}
> > +
> 
> [...]
> 
>    };
> >   
> > +/* Get lifetime information struct for each request */
> > +struct virtio_blk_lifetime {
> > +	/*
> > +	 * specifies the percentage of reserved blocks that are consumed.
> > +	 * optional values following virtio spec:
> > +	 * 0 - undefined
> > +	 * 1 - normal, < 80% of reserved blocks are consumed
> > +	 * 2 - warning, 80% of reserved blocks are consumed
> > +	 * 3 - urgent, 90% of reserved blocks are consumed
> > +	 */
> > +	__le16 pre_eol_info;
> > +	/*
> > +	 * this field refers to wear of SLC cells and is provided in increments of 10used,
> > +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> > +	 * are reserved
> > +	 */
> > +	__le16 device_lifetime_est_typ_a;
> > +	/*
> > +	 * this field refers to wear of MLC cells and is provided with the same semantics as
> > +	 * device_lifetime_est_typ_a
> > +	 */
> > +	__le16 device_lifetime_est_typ_b;
> > +};
> > +
> 
> are you sure there won't be any new members ever be added in future ?
> to make it is futuresafe I'd add padding to this structure and keep
> the reserve bytes to the meaningful size...
> 
> -ck


virtio has feature bits for this kind of thing, we don't do padding.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
