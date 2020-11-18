Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91837C63697
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:39:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AA921D7A
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 11:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4cajgCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AA921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 588E887220;
	Wed, 18 Nov 2020 11:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iy38TSyDhtfP; Wed, 18 Nov 2020 11:39:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8F2987183;
	Wed, 18 Nov 2020 11:39:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9030EC0891;
	Wed, 18 Nov 2020 11:39:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E628C07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:39:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 35B1E871BE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:39:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w4CWTlAUyU2R
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:39:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76A4187183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605699577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6R/6pwwpmuxG0MDZ4yvt0MqGRHPil6xB7qtVxel0gLg=;
 b=X4cajgCdFap8AddpVm6mBcxKBnfPrT98XeIuByHs3q1rc4gNAcxNEbnJpgXPtBWgqWp3cN
 HEVWFh2GRUXOImllN1pKov7lmIVTXtkc8Z+TfBPDecVbnXkjQUKoJSsk+7Eu/6tVSeiTTf
 9tFbH0c/TsMNWJzylMSN3YCizThmf94=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-1UNIpVJ-Pq-rSGyCJabA-w-1; Wed, 18 Nov 2020 06:39:35 -0500
X-MC-Unique: 1UNIpVJ-Pq-rSGyCJabA-w-1
Received: by mail-wm1-f71.google.com with SMTP id a134so739968wmd.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 03:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6R/6pwwpmuxG0MDZ4yvt0MqGRHPil6xB7qtVxel0gLg=;
 b=Ets9jaTgRHnFgGKyNP8ePvh0sA5DYbgMS0Cf6Y4mdsAUyAjZfcQSvLE41hase9evsB
 NnHp1O7RzETKDsCgrwFJUvq7LsX9yNUE5JALH2hxsCdTCn6gBwJ3Otoz540tnfMCCLDf
 2T1RDrHLIC+5nXnRWckStuTWDeZKIfrfEcw6ZqQi1npkZ5EGR/mbH3mVRKgh/OUCoea+
 Z4ffOdKFYL6J4TF6R+vt0iv967yghKgl0Ui+10o2oV9ToIIiBlMj0+pvmUYwvJ40yoJs
 1T/aOHX17E1xiQa+IpqFBUc+tIX0Zq3WEwxiKvyKhQ86tJEuoUXFcI/onz+s7Wig/YjG
 Tj8Q==
X-Gm-Message-State: AOAM532sYHN8kOAMPKMhUz/zX+8M0bka5rAG4FgyggwbcN5quoPdIKI4
 3DU/k7YJIfc/AKsIGV+9NCSvSA4fFqfX/NTE2N/1DooxDSQhwRFmRWXqfiDYmXiKLnWfSnr3Epa
 JkcZhWuoyyoaTgYC+QCR8WcKQ1Wr51hrDZvsxxYys0w==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4098637wmj.126.1605699574083; 
 Wed, 18 Nov 2020 03:39:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrPLqC5uRTn2T9zd6p9hbLUkX2tNzGSzrjqO2hEeUwzwzrRTmKFuYoh+KPvYKlSgz9RTE61A==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4098620wmj.126.1605699573741; 
 Wed, 18 Nov 2020 03:39:33 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id y16sm31384125wrt.25.2020.11.18.03.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 03:39:33 -0800 (PST)
Date: Wed, 18 Nov 2020 12:39:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201118113930.p7uigootcb42wqix@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
 <20201117141620.ytium7r6xpxi4and@steredhat>
 <20201117164342.GT131917@stefanha-x1.localdomain>
 <20201117173811.lw4nwicoykhnn3tt@steredhat>
 <20201118112355.GE182763@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201118112355.GE182763@stefanha-x1.localdomain>
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

On Wed, Nov 18, 2020 at 11:23:55AM +0000, Stefan Hajnoczi wrote:
>On Tue, Nov 17, 2020 at 06:38:11PM +0100, Stefano Garzarella wrote:
>> On Tue, Nov 17, 2020 at 04:43:42PM +0000, Stefan Hajnoczi wrote:
>> > On Tue, Nov 17, 2020 at 03:16:20PM +0100, Stefano Garzarella wrote:
>> > > On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
>> > > > On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
>> > > > > +static void vdpasim_blk_work(struct work_struct *work)
>> > > > > +{
>> > > > > +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> > > > > +	u8 status = VIRTIO_BLK_S_OK;
>> > > > > +	int i;
>> > > > > +
>> > > > > +	spin_lock(&vdpasim->lock);
>> > > > > +
>> > > > > +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> > > > > +		goto out;
>> > > > > +
>> > > > > +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> > > > > +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> > > > > +
>> > > > > +		if (!vq->ready)
>> > > > > +			continue;
>> > > > > +
>> > > > > +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>> > > > > +					    &vq->head, GFP_ATOMIC) > 0) {
>> > > > > +
>> > > > > +			int write;
>> > > > > +
>> > > > > +			vq->iov.i = vq->iov.used - 1;
>> > > > > +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>> > > > > +			if (write <= 0)
>> > > > > +				break;
>> > > >
>> > > > We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)
>> > >
>> > > The crash could happen if the simulator doesn't put the string terminator,
>> > > but in virtio_blk.c, the serial_show() initialize the buffer putting the
>> > > string terminator in the VIRTIO_BLK_ID_BYTES element:
>> > >
>> > >     buf[VIRTIO_BLK_ID_BYTES] = '\0';
>> > >     err = virtblk_get_id(disk, buf);
>> > >
>> > > This should prevent the issue, right?
>> > >
>> > > However in the last patch of this series I implemented VIRTIO_BLK_T_GET_ID
>> > > support :-)
>> >
>> > Windows, BSD, macOS, etc guest drivers aren't necessarily going to
>> > terminate or initialize the serial string buffer.
>>
>> Unfortunately I discovered that VIRTIO_BLK_T_GET_ID is not in the VIRTIO
>> specs, so, just for curiosity, I checked the QEMU code and I found this:
>>
>>     case VIRTIO_BLK_T_GET_ID:
>>     {
>>         /*
>>          * NB: per existing s/n string convention the string is
>>          * terminated by '\0' only when shorter than buffer.
>>          */
>>         const char *serial = s->conf.serial ? s->conf.serial : "";
>>         size_t size = MIN(strlen(serial) + 1,
>>                           MIN(iov_size(in_iov, in_num),
>>                               VIRTIO_BLK_ID_BYTES));
>>         iov_from_buf(in_iov, in_num, 0, serial, size);
>>         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
>>         virtio_blk_free_request(req);
>>         break;
>>     }
>>
>> It seems that the device emulation in QEMU expects that the driver
>> terminates the serial string buffer.
>>
>> Do you know why VIRTIO_BLK_T_GET_ID is not in the specs?
>> Should we add it?
>
>It's about to be merged into the VIRTIO spec:
>https://github.com/oasis-tcs/virtio-spec/issues/63
>

Great! Thanks for the link!

Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
