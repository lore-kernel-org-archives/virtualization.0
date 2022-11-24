Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F08C4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Nov 2022 06:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 973C4419D8;
	Thu, 24 Nov 2022 06:46:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 973C4419D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MskzIa6U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUOukCPUu366; Thu, 24 Nov 2022 06:46:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DE001419CB;
	Thu, 24 Nov 2022 06:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE001419CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B43E3C0032;
	Thu, 24 Nov 2022 06:46:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B18C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E357381F3D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:46:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E357381F3D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MskzIa6U
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cBDxpXdzZOJ5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:46:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AE0781F38
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2AE0781F38
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Nov 2022 06:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669272413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ab0P552cPlQ7Sv+Yg97kdpYflOuZ/YcOT0ecrNPX4o=;
 b=MskzIa6UoWTWYKvhHogq0ghgPp+mi6tUXauIDVhvCyUb/TubMIItGvJubz+j8aKZpPTQpf
 n6nxXnishtlkqj8BI4SbUIe3ci1P392N+wm5w0HFE0CDLl2Hk8kSzVGyai2arEcuA0o95q
 XemmNjX3KYrIMrF/zhovSvGNjW2PdFE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-198-atSq3qcsMgqiTdQQdARscw-1; Thu, 24 Nov 2022 01:46:51 -0500
X-MC-Unique: atSq3qcsMgqiTdQQdARscw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l32-20020a05600c1d2000b003cfefa531c9so2609532wms.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 22:46:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ab0P552cPlQ7Sv+Yg97kdpYflOuZ/YcOT0ecrNPX4o=;
 b=i+/iLERUORDuvmVOYsKW0Xe9YecMBSToyM7PfpY94E8gcZbUiHs4S/oEqvhTbvv2aH
 zUiAPlWvhZOaAhcHXslX8Dc0lZu20TPMv1YaejZVD6FZrNgABnA1rywidHjbVS6ai5Af
 CoTfZ6GTUA00Q/xaLbjkVpkJ4P2ia0pPIH/5JwwDn7puU0XBq8suI0O03Lx+XruWfqTC
 4gkV+20g7jxizqLgyemLw6vdHRGEGd/eQ2LXyY9s4fAEMTf7ClAoBdMzgCKpmZSG94Ic
 59DIpt21Xu7aJAGkLZ8JovfPHvmd1Dy5Qk0Cm32fh1LSyJKtYawJQqkI5nQVVylaooLA
 +d9Q==
X-Gm-Message-State: ANoB5pnSp9csWrjUWv5Frn3y4n2tiI8BF9EucJwmercPhuCaZ8lXT4Nf
 +QAqioiBiZwpETjKjPgJvXfuVhj7F44FVYd48+nW17zSLAVIVSEelPpjB+11P+Nhjah+ORErb0q
 dgSRwW8qBe60EpbKZR+sryd98/mxYTSvSFtIVmmGvow==
X-Received: by 2002:adf:ef0c:0:b0:241:e4cc:f03d with SMTP id
 e12-20020adfef0c000000b00241e4ccf03dmr2085763wro.43.1669272410426; 
 Wed, 23 Nov 2022 22:46:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Bq5EhOdxWutZTnhLoPTuGYJKVw0XPqFlaQFJwyNFVpnogjuf8vxEoqK+OlT46/R+fYJIjzA==
X-Received: by 2002:adf:ef0c:0:b0:241:e4cc:f03d with SMTP id
 e12-20020adfef0c000000b00241e4ccf03dmr2085755wro.43.1669272410179; 
 Wed, 23 Nov 2022 22:46:50 -0800 (PST)
Received: from redhat.com ([2.52.16.74]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c4e0d00b003b3365b38f9sm659840wmq.10.2022.11.23.22.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Nov 2022 22:46:49 -0800 (PST)
Date: Thu, 24 Nov 2022 01:46:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221124014300-mutt-send-email-mst@kernel.org>
References: <20221121085923.2717501-1-alvaro.karsz@solid-run.com>
 <1b8d59e1-8702-8b81-f82c-a743116da799@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <1b8d59e1-8702-8b81-f82c-a743116da799@nvidia.com>
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

On Wed, Nov 23, 2022 at 10:22:26PM +0000, Chaitanya Kulkarni wrote:
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
> > +
> > +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> > +	 * feature is negotiated.
> > +	 */
> > +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> > +		return -ENOTTY;
> > +
> > +	memset(&lifetime, 0, sizeof(lifetime));
> > +
> 
> you can remove memset 0 call here and declare initialize struct var
> something like totally untested :-
> 
> 	struct virtio_blk_lifetime lifetime = { };
> 
> -ck

Yes, that's a bit cleaner, but there should be no space between {}:
	struct virtio_blk_lifetime lifetime = {};


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
