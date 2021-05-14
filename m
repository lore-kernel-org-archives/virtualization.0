Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00857C433B4
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:29:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98991613AA
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 07:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98991613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F0EDC40154;
	Fri, 14 May 2021 07:29:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cdl0DjB4OMG0; Fri, 14 May 2021 07:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B1494012A;
	Fri, 14 May 2021 07:29:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49B5BC000D;
	Fri, 14 May 2021 07:29:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3777EC0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:29:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 182DC60634
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:29:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WZUWDNdRlsj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:29:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDBAE606EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620977378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vLaSX75gXckI8Z8WzprraSW9kYtncj9z6b/WJYFwkBs=;
 b=GFNcpoQb2VF8JLSdxnDmCwVMRXXIjgcqCy69KlkjjGP5YdcQ6MN0PD154UdjCHbi2WkuBP
 Jkv1wDMrh3wYVmbMt1MAIUehnWNKOKXl+i5NqDJCp6lMTAii9E6eKzkr0lcrPZ1YFKrD8i
 b1wcLddMQUKH3LowXJEx+Aei5ZRxtNw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-w0DEqhKLNS-5sIIqqns0hQ-1; Fri, 14 May 2021 03:29:34 -0400
X-MC-Unique: w0DEqhKLNS-5sIIqqns0hQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 a14-20020a2e7f0e0000b02900b9011db00cso15659126ljd.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 00:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLaSX75gXckI8Z8WzprraSW9kYtncj9z6b/WJYFwkBs=;
 b=Vh/G0KhSjfsBbVrHz9fb2QL883aX4e1bUrs7ZBWvWQE0GpD1XJL7s/thCiMEd8fJGq
 qkFlWOjTDTwoaq2eSvfQx76JVqEylxdaoRavW0Z+ThvSmHhmGv42RocBxdQ5dCpcXz2j
 OCVJ8+KkgBnUJg482tzokDpRTYiajygZUyzzN/pOt25efQJHNovZhR75w3NMHxC649KH
 ObIcoED3OaRtiBlfO1DAtgTwuYtTf+Mb8Wiej/jFhn9WJOdijEEDGtnJ6XXGcC7ARkuY
 q6yZbVNUqFnlwADaC9X9tivsntLSMHZ0YGukgA+I/hqx3zXqRvpYHyGXlGQHBnXvl+Ti
 MNQw==
X-Gm-Message-State: AOAM5324E8qVUWfNLkSDZyBQcgScCpwgAX7mjQqAZPwbPWrWfLoitq0s
 zFCVJm10sXHI7KRjREEQuTSJqECRm5k2NjcitVj3dBJEC6EI0E7DhI+a9F4nllx/S/djwb4YzJP
 /jSWE0PR6oxuUONl9FV5L5cWXI2tEgsQgIP/+uBa+MH/RmEO0kNEhqejGtw==
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31104404lfl.258.1620977373359; 
 Fri, 14 May 2021 00:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4Gls0aXdzkjmHbhas1oEWoz6vOBmT2YTHRf29pZ421C71h5IAXzfqDqoCC/Q7e+ENngkENKWuM+lhgqOXZzk=
X-Received: by 2002:ac2:43ac:: with SMTP id t12mr31104385lfl.258.1620977373195; 
 Fri, 14 May 2021 00:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210423080942.2997-1-jasowang@redhat.com>
 <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
In-Reply-To: <YJ1TgoFSwOkQrC+1@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 14 May 2021 15:29:20 +0800
Message-ID: <CACGkMEv0uWd+X87cYoG-GGjTXBvRztp2CY3RKyq9jFbSYK1n0Q@mail.gmail.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
To: Stefan Hajnoczi <stefanha@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm <kvm@vger.kernel.org>,
 mst <mst@redhat.com>, konrad.wilk@oracle.com,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>, hch@infradead.org,
 xieyongji@bytedance.com
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

On Fri, May 14, 2021 at 12:27 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 23, 2021 at 04:09:35PM +0800, Jason Wang wrote:
> > Sometimes, the driver doesn't trust the device. This is usually
> > happens for the encrtpyed VM or VDUSE[1].
>
> Thanks for doing this.
>
> Can you describe the overall memory safety model that virtio drivers
> must follow?

My understanding is that, basically the driver should not trust the
device (since the driver doesn't know what kind of device that it
tries to drive)

1) For any read only metadata (required at the spec level) which is
mapped as coherent, driver should not depend on the metadata that is
stored in a place that could be wrote by the device. This is what this
series tries to achieve.
2) For other metadata that is produced by the device, need to make
sure there's no malicious device triggered behavior, this is somehow
similar to what vhost did. No DOS, loop, kernel bug and other stuffs.
3) swiotb is a must to enforce memory access isolation. (VDUSE or encrypted VM)

> For example:
>
> - Driver-to-device buffers must be on dedicated pages to avoid
>   information leaks.

It looks to me if swiotlb is used, we don't need this since the
bouncing is not done at byte not page.

But if swiotlb is not used, we need to enforce this.

>
> - Driver-to-device buffers must be on dedicated pages to avoid memory
>   corruption.

Similar to the above.

>
> When I say "pages" I guess it's the IOMMU page size that matters?
>

And the IOTLB page size.

> What is the memory access granularity of VDUSE?

It has an swiotlb, but the access and bouncing is done per byte.

>
> I'm asking these questions because there is driver code that exposes
> kernel memory to the device and I'm not sure it's safe. For example:
>
>   static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
>                   struct scatterlist *data_sg, bool have_data)
>   {
>           struct scatterlist hdr, status, *sgs[3];
>           unsigned int num_out = 0, num_in = 0;
>
>           sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
>                             ^^^^^^^^^^^^^
>           sgs[num_out++] = &hdr;
>
>           if (have_data) {
>                   if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
>                           sgs[num_out++] = data_sg;
>                   else
>                           sgs[num_out + num_in++] = data_sg;
>           }
>
>           sg_init_one(&status, &vbr->status, sizeof(vbr->status));
>                                ^^^^^^^^^^^^
>           sgs[num_out + num_in++] = &status;
>
>           return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>   }
>
> I guess the drivers don't need to be modified as long as swiotlb is used
> to bounce the buffers through "insecure" memory so that the memory
> surrounding the buffers is not exposed?

Yes, swiotlb won't bounce the whole page. So I think it's safe.

Thanks

>
> Stefan

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
