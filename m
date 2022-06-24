Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F043BC43334
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 06:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7D6C340CB7;
	Fri, 24 Jun 2022 06:59:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7D6C340CB7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9nOA8ti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RAq3yCHfqaIG; Fri, 24 Jun 2022 06:59:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1396A4042B;
	Fri, 24 Jun 2022 06:59:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1396A4042B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8CA1C007B;
	Fri, 24 Jun 2022 06:59:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58C10C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33A264046B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:59:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33A264046B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPS2r72jJhNY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:59:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 451DC4042B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 451DC4042B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656053992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+FWCkGupGlsZhDvUF+chx88Z13TTRnc4OkTdsQ7elnE=;
 b=i9nOA8tidr8vr+EgGLUER/bvbW4tIdNQxluM98Es2W3gAXa4Pf94kxFnFgK7j50tJU6rk7
 X7LuJDBSH2RkKDhCqE4SX1k7Khxm3+jDLIJLeatiqoSvDjaavUlgChSJc9Pexr/r/sgHtS
 VMsSA8hdrDXCzCTB7vB8d0No4TR2gLM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-Gcns41NDPmqXXPUMnxPDsg-1; Fri, 24 Jun 2022 02:59:49 -0400
X-MC-Unique: Gcns41NDPmqXXPUMnxPDsg-1
Received: by mail-ed1-f69.google.com with SMTP id
 r12-20020a05640251cc00b00435afb01d7fso1193981edd.18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 23:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+FWCkGupGlsZhDvUF+chx88Z13TTRnc4OkTdsQ7elnE=;
 b=CMO0l/Ifi2iWcq+0sUWx32f+1x3A63SLokofUxllsAeajvjIdPbiNcwqsNeDFvwxAF
 38A4MMPZBVaZuAgApThbrL8Vp0pAMQoRIAAtlJSitTmiOqtwWR4EfIU3RmwcEQc3PliO
 4DTwElgpDodP/XCsC6aHDdJbFU35vJECQD8iNxgkM7bLUV8ORD5rP/2lrRaw2c2xtn1I
 376OV+o6YPoIoYQKDaf+NyaPNO8jEn1TDtJ40I/5SORAj/5rqLH9kiboI+vySnKzmKDN
 F6V2dUCdSvkBxhxYTH1tmVISqpUPb3SeZ8R8a2ulHKNPZD9Y+qP0OotZXto2Hv/ogqGs
 UuoA==
X-Gm-Message-State: AJIora9Th/CCn3GSgqySkya5q9XQJwlsU8iu2hMcLhA3NviWYb2xIp+e
 tvuP/pOss6a3ROhwj3RWbRFbWYbOgP8Ck9u5bCuoSSB9YnH9htiaYptvRDnxbv/gcfXjzZCL+ln
 56Y0XenQ04bvbBkvE625ift1/U+eZlEDDB0K53ZowBg==
X-Received: by 2002:a17:906:dc8f:b0:725:28d1:422d with SMTP id
 cs15-20020a170906dc8f00b0072528d1422dmr6755873ejc.131.1656053987947; 
 Thu, 23 Jun 2022 23:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1te/UstSdzxfRYfD6/tSqZXRF+jwCBe0/TwLXdOIJy4AlZcp3dqgfDv8QmtvsXyUBUV1p/nQw==
X-Received: by 2002:a17:906:dc8f:b0:725:28d1:422d with SMTP id
 cs15-20020a170906dc8f00b0072528d1422dmr6755835ejc.131.1656053987674; 
 Thu, 23 Jun 2022 23:59:47 -0700 (PDT)
Received: from redhat.com ([2.55.188.216]) by smtp.gmail.com with ESMTPSA id
 ec35-20020a0564020d6300b004316f94ec4esm1262273edb.66.2022.06.23.23.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jun 2022 23:59:46 -0700 (PDT)
Date: Fri, 24 Jun 2022 02:59:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Message-ID: <20220624025817-mutt-send-email-mst@kernel.org>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220624025621.128843-26-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> here https://github.com/oasis-tcs/virtio-spec/issues/89
> 
> For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.

What exactly is meant by not breaking uABI?
Users are supposed to be prepared for struct size to change ... no?


> Since I want to add queue_reset after queue_notify_data, I submitted
> this patch first.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/uapi/linux/virtio_pci.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> index 3a86f36d7e3d..22bec9bd0dfc 100644
> --- a/include/uapi/linux/virtio_pci.h
> +++ b/include/uapi/linux/virtio_pci.h
> @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
>  	__le32 queue_used_hi;		/* read-write */
>  };
>  
> +struct virtio_pci_common_cfg_notify {
> +	struct virtio_pci_common_cfg cfg;
> +
> +	__le16 queue_notify_data;	/* read-write */
> +	__le16 padding;
> +};
> +
>  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
>  struct virtio_pci_cfg_cap {
>  	struct virtio_pci_cap cap;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
