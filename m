Return-Path: <SRS0=eOzH=J7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E62C433ED
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 16:17:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79958613BC
	for <virtualization@archiver.kernel.org>; Tue,  4 May 2021 16:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79958613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0DFAE4016F;
	Tue,  4 May 2021 16:17:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CWbTDVoFBatU; Tue,  4 May 2021 16:17:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4AED4010D;
	Tue,  4 May 2021 16:17:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D3D2C000E;
	Tue,  4 May 2021 16:17:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EA5AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 16:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3CA7840158
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 16:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yQxmvrOV-Wlz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 16:17:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8303D4010D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 May 2021 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1620145019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wP9ZXRKFRrcYNfXsCl7rVDwQV/fOx/6qqWYEPu1BZWI=;
 b=AA53XJKOs1DiHysduceoTnANOg94TcWuTWTjz/rJr90ayBB4svULsVGcq3eBVaHsXzzhRD
 rFJNZOeRYoclkmWubqy90sm6Ihxwm9gDHSWgGVISxL1yoK8KS//qFC61yBNlxgzvJBoN7/
 1df+2F0/jFyJc8Btz6lpwlWggu57KLU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-mQLump_LNnCgO3Mz5D-CWw-1; Tue, 04 May 2021 12:16:55 -0400
X-MC-Unique: mQLump_LNnCgO3Mz5D-CWw-1
Received: by mail-ej1-f72.google.com with SMTP id
 v7-20020a1709061807b02903a3d1724659so3342754eje.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 04 May 2021 09:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wP9ZXRKFRrcYNfXsCl7rVDwQV/fOx/6qqWYEPu1BZWI=;
 b=N/F0XVFiT0k7tEdrhMsIt8LsqM95EYjyTf41kdmWUiSaZao1rwzU4bW1H8U3KvbIoN
 MzRMHOJPDouPcSYwdljV3r+yN3IIWAvOl2qsO3djpNuR43fYjWGSs+IPxNHwV/Rh0yuZ
 uGS6bWiozrRkogdgJATrJTWr1GBCKtZtO2ywOFJlM+awwUKIqK2E1bJqxurh/TYS1orz
 ML3RZASasUBn88KUmvQkE8NfPtxQEO2uQpPjul2lJSIJaU32WhPMastRLGrMG9kIublb
 +73+5W9K9MhDQftiwST/6NmISz+eJZEmRfg4lZR1ReFU7AhV71MU+O08D7RWq8+vKCAA
 3x9Q==
X-Gm-Message-State: AOAM530JjXOfaBDc6NhAOzZnzX7xyMfFSctQCzyl1iRTbShLjSCSyCus
 aEL2JE7KcJAyB4qP9zTdXB+RW4XRSSn/O78QeXA3Acbtx2c4yEBVXykdx89ZCuUT/5BW0RZHM79
 gp7Rjhi/mN4tc5K4qMBjOQCXioiJ6ttu58V0jHBBGLw==
X-Received: by 2002:a05:6402:17d7:: with SMTP id
 s23mr27097459edy.66.1620145014419; 
 Tue, 04 May 2021 09:16:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1wSMhxJviC4Qd4ukjh1jx9L6VULBQdBxWu5X57iph3UY20HifBYDo/gfB7VgOuGBt3Je66Q==
X-Received: by 2002:a05:6402:17d7:: with SMTP id
 s23mr27097436edy.66.1620145014208; 
 Tue, 04 May 2021 09:16:54 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id i8sm14455151edu.64.2021.05.04.09.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 May 2021 09:16:53 -0700 (PDT)
Date: Tue, 4 May 2021 18:16:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210504161651.3b6fhi64d7g3jui4@steredhat>
References: <20210413091251-mutt-send-email-mst@kernel.org>
 <20210413133852.ebkrlbyetiqu4uje@steredhat>
 <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
 <20210413155635-mutt-send-email-mst@kernel.org>
 <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

Hi Jiang,

On Mon, May 03, 2021 at 08:40:46PM -0700, Jiang Wang . wrote:
>Hi Stefano,
>
>I checked the VIRTIO_NET_F_MRG_RXBUF feature bit and I think vsock
>dgram can use that feature too.

Cool, thanks for checking!

>Do we want to make this feature a must-have or optional? One idea is
>to make it optional. When not

I think optional is fine, and we should support it for all kind of 
traffic (stream, dgram, seqpacket).

>supported, dgram rx buf is 16 KB which should be good in most cases.

Why not 4 KB like for stream? Or we could make it configurable.

>When VIRTIO_NET_F_MRG_RXBUF is supported, the rx buf is 4K and the max
>packet size is 64 KB.
>
>Also, just to make sure we are on the same page, the current vsock
>stream code can also split a
>big packet to multiple buffers and the receive side can assemble them
>together.

Yes, sort of. Being a stream, there's no concept of a boundary.

> But dgram cannot
>use that code because the dgram may drop a buffer in the driver code
>(if there is not enough space).
>That means dgram may drop some buffers at the beginning, in the end or in the
>middle of a pkt. And a packet may
>not be received as a complete one. Therefore, we need something like
>VIRTIO_NET_F_MRG_RXBUF.

Yep.

>
>If we want to leverage current stream code without using 
>VIRTIO_NET_F_MRG_RXBUF,
>we could add a total_len and offset to the virtio_vsock_hdr. Then when sending
>packet, the device split the big packet to multiple small ones and
>each has a header. They will have the
>same total_len, but different offsets. On the driver side, the driver
>can check the total_len before
>enqueueing the big packet for the one with offset 0.
>If there is enough space, all the remaining packets will be received.
>If not, the remaining packets will be dropped.
>I feel this implementation might be easier than using
>VIRTIO_NET_F_MRG_RXBUF. But either one is fine with me.
>Any preference? Thanks.

This is very similar to what we discussed with Michael. He pointed out 
that it could be complicated and we could have several problems.

For example, we should also provide an ID to prevent different fragments 
from overlapping. Also we might have problems handling different flows 
at the same time.

Mergable buffers allow us to avoid these problems and also bring 
advantages for the other types of traffic (stream, seqpacket).

It also allows us to use a single header for the packet and all its 
fragments.

So IMHO, if there are no significant issues, the best way would be to 
implement mergeable buffers in vsock,
I think there are only advantages to using this feature.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
