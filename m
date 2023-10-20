Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C08CDB47E
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 10:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7957432C3;
	Fri, 20 Oct 2023 10:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7957432C3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZqGpHdH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bQWjIDXeGgol; Fri, 20 Oct 2023 10:08:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B5896432BB;
	Fri, 20 Oct 2023 10:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B5896432BB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88044C0088;
	Fri, 20 Oct 2023 10:08:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AACFC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:08:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25ADA4ECDF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:08:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25ADA4ECDF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QZqGpHdH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZGoHkWXPa0w
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:08:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5201A4ECD5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 10:08:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5201A4ECD5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697796502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8DPd11sc2uBsWrWlYeP8kGG0jI+Vgzqkk7sKu4E6ndQ=;
 b=QZqGpHdHF61uq0aGdNOFT5Hmhiwgq1g2jzJvsqRtvOAWuUMs7B1V9eMrcrNwSjue4AsbDm
 2fNruy6xv8rPvTwzNK2a1Y4LYtVfWyibwpfmUKxxZL1DUypSGI4Se40uDpP2s9Lyff/0er
 yZXJ03IUJFz24Hq1CAOHnx8oQ/4Cm1g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-u-vHXaSSNAegffbIyRGlug-1; Fri, 20 Oct 2023 06:08:11 -0400
X-MC-Unique: u-vHXaSSNAegffbIyRGlug-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d83fd3765so342632f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 03:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697796490; x=1698401290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DPd11sc2uBsWrWlYeP8kGG0jI+Vgzqkk7sKu4E6ndQ=;
 b=bKeOQAX2Q5QsRLDdKay95ofT8vkUZF1j/Dl53u5wNizriQHRho8QzX52BSnJmtrc0d
 ZNeK08mMmcmcF0AjjCPCr92YEpoimZU5CAtKcT1JDubHjQQEzhawRFsxaD+6RZVVwACu
 JQx8AAn03rZi80dbqfEIw6Tgoy2lP9R7+ACMxUxga/KyXi2+fmxRgY2MHbO6Wf+mS/ao
 js4epSwnIYFzTJhzuZM8IK8JLg+jTUeGpd9vADgMoPWHUFDLb/2iep/JkasdRNlgpabf
 Pm6Y6a+OdCmya4xsNd5npu5ERDNhbLvosELW95/1TsOMxZN2bBnBbIuAl6qO+mpE0JBF
 U2Zw==
X-Gm-Message-State: AOJu0Yy16lvcbbF8+bvkbFCW6JAMXL7oRid1VsswwCAqYWFThJZCyFD+
 1Nw63TbF4g7o/D8b3uMCa0cuDxb0/pQvu3HejAb/DHIyMrYPZx7vlQS9rJQCcywPyS8cEeB7fIq
 tAEDYn/p1LSulnCzSIvj84EKXRl0E5qmQdR8ubaz/Mg==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id
 l18-20020a05600c4f1200b00401bdd749aemr1214856wmq.18.1697796489826; 
 Fri, 20 Oct 2023 03:08:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNE9FiNbwpYdXqLcZIJ4/1YwoFZJFhOvQpn5AauT7Zhc0SVoOEu1TSydQNnfcIKDvas2A+cQ==
X-Received: by 2002:a05:600c:4f12:b0:401:bdd7:49ae with SMTP id
 l18-20020a05600c4f1200b00401bdd749aemr1214829wmq.18.1697796489458; 
 Fri, 20 Oct 2023 03:08:09 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040813e14b49sm6583115wmo.30.2023.10.20.03.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 03:08:08 -0700 (PDT)
Date: Fri, 20 Oct 2023 06:08:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020055943-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
 <20231020054140-mutt-send-email-mst@kernel.org>
 <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697795422.0986886-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Oct 20, 2023 at 05:50:22PM +0800, Xuan Zhuo wrote:
> On Fri, 20 Oct 2023 05:42:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> > > On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > > > error code if failed, so add a check for this.
> > > > >
> > > > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > > > ---
> > > > >
> > > > > I'm not sure that return directly is right or not,
> > > > > maybe there are some process should do before return.
> > > >
> > > > yes - presizely what virtqueue_enable_after_reset does.
> > > >
> > > > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > > > For some reason it overrides the error code returned.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > >  drivers/virtio/virtio_ring.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > > > index 51d8f3299c10..cf662c3a755b 100644
> > > > > --- a/drivers/virtio/virtio_ring.c
> > > > > +++ b/drivers/virtio/virtio_ring.c
> > > > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > > > >  	else
> > > > >  		err = virtqueue_resize_split(_vq, num);
> > > > >
> > > > > +	if (err)
> > > > > +		return err;
> > > > > +
> > > > >  	return virtqueue_enable_after_reset(_vq);
> > > >
> > > > So I think it should be something like:
> > > >
> > > > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > > > 	BUG_ON(err_reset);
> > > >
> > > > 	return err;
> > > >
> > >
> > > How about WARN and vq->broken?
> > >
> > > Thanks.
> >
> > Well, what are the cases where it can happen practically?
> 
> Device error. Such as vp_active_vq()
> 
> Thanks.

Hmm interesting. OK. But do callers know to recover?

> 
> >
> > >
> > > >
> > > >
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > > > --
> > > > > 2.30.2
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
