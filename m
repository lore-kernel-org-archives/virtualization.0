Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C07C61DA4
	for <virtualization@archiver.kernel.org>; Sat, 11 Mar 2023 19:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B79FF41A2A;
	Sat, 11 Mar 2023 19:06:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B79FF41A2A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DREJUMPt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iad2Zz6eVtGd; Sat, 11 Mar 2023 19:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D015241936;
	Sat, 11 Mar 2023 19:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D015241936
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B72D4C0071;
	Sat, 11 Mar 2023 19:06:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BF8EC0032
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3723781F33
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:06:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3723781F33
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DREJUMPt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XYmiFFQGSNLn
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:06:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3385281F1A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3385281F1A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678561579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXhS4PQX3wVArulcezcMAGCXkG7mibhdYkPT4z0wqv0=;
 b=DREJUMPtu3m/W1vPgtUD7+f9EpcwZqMpLwx0ehyqebKGcOEGrAUPvLqQhq7KctISZLHcZd
 WIrK5N7RgO5RxLXyT/uJ3cPydnQRKS+zhfXRd3DJ8GI/roDOhzM+OXr0k1bdKsD/t47S6/
 wfPAjHdHm261/Ke97gO3CZ9gIs2Z04Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-aGLGTVRlPQCv0yceEjC4WQ-1; Sat, 11 Mar 2023 14:06:17 -0500
X-MC-Unique: aGLGTVRlPQCv0yceEjC4WQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 m7-20020a056000008700b002c7047ea429so1566106wrx.21
 for <virtualization@lists.linux-foundation.org>;
 Sat, 11 Mar 2023 11:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678561576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXhS4PQX3wVArulcezcMAGCXkG7mibhdYkPT4z0wqv0=;
 b=7+3NxPxm5sayFE+/JxUEOt8E/fQqYYPV4MZnUTKwvayXtNGXJdnQLtQyaghnaMZ7tW
 YeB0tO6mSupsQ+PPJZYBNiF13crDQxaZ44NcU+3jKEHmLhqRilkTslBtcMNnHr1Bs/ws
 hK+rsVCXeZcKugeVC9tm50hd8nu2Ne/Z5Y0owdEf+lVIjE6DFaMDKvVEdL9SmGsALLLm
 n6Dz8YRTB5GcYJjAAegkvRQXAKn6Coj+q1r7f0I5WnRM/jNkgnQ3D4qvGD2DfVzC7/py
 nfynxKv/d4Y++jGlTMoresPrO5NQ7NrqaJdmPcll+r7J4rp1y20S09Fvb1PJOl5CezFF
 WKKw==
X-Gm-Message-State: AO0yUKXYVYPQ1zPCQpSeiCUpRcKi5cTlNiWfB/EnxUfw755kyyYAnEG0
 tp2cqrzVWKvLEekWCBfLqd4nb9nQbCsd0Un8kjmx1Yvmlk0rlnAd8nlVBTGkK7zE3iyB3lO8LSN
 fLSdJDB8isqtWMJTia4G2n9sAyT5m6LyucAE2AEUG+g==
X-Received: by 2002:a05:600c:3b11:b0:3eb:f73a:cf89 with SMTP id
 m17-20020a05600c3b1100b003ebf73acf89mr6146371wms.8.1678561576482; 
 Sat, 11 Mar 2023 11:06:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/ngcs3HMnkSKQwCA+Z5WE6XdWN8/Re5+eumEiFUTGAmY6QAXnS8lQKneLYqEhl/a3RLCpmyg==
X-Received: by 2002:a05:600c:3b11:b0:3eb:f73a:cf89 with SMTP id
 m17-20020a05600c3b1100b003ebf73acf89mr6146361wms.8.1678561576228; 
 Sat, 11 Mar 2023 11:06:16 -0800 (PST)
Received: from redhat.com ([2.52.29.35]) by smtp.gmail.com with ESMTPSA id
 s9-20020a5d5109000000b002cea8e3bd54sm808472wrt.53.2023.03.11.11.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Mar 2023 11:06:15 -0800 (PST)
Date: Sat, 11 Mar 2023 14:06:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH v2 0/3] virtio_ring: Clean up code for virtio ring and pci
Message-ID: <20230311140528-mutt-send-email-mst@kernel.org>
References: <20230310053428.3376-1-feliu@nvidia.com>
 <20230310030624-mutt-send-email-mst@kernel.org>
 <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <fb824fb0-1704-daeb-eb02-fdcfe1686902@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Fri, Mar 10, 2023 at 08:21:31AM -0500, Feng Liu wrote:
> 
> 
> On 2023-03-10 a.m.3:06, Michael S. Tsirkin wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Fri, Mar 10, 2023 at 07:34:25AM +0200, Feng Liu wrote:
> > > This patch series performs a clean up of the code in virtio_ring and
> > > virtio_pci, modifying it to conform with the Linux kernel coding style
> > > guidance [1]. The modifications ensure the code easy to read and
> > > understand. This small series does few short cleanups in the code.
> > > 
> > > Patch-1 Allow non power of 2 sizes for virtqueues
> > > Patch-2 Avoid using inline for small functions.
> > > Patch-3 Use const to annotate read-only pointer params.
> > > 
> > > [1]
> > > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.kernel.org%2Fdoc%2Fhtml%2Fv6.2-rc3%2Fprocess%2Fcoding-style.html%23the-inline-disease&data=05%7C01%7Cfeliu%40nvidia.com%7C08831607a6fb4f58881408db213f8638%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638140328946332918%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=FnD4GINUds2HLLo47aY5Ps%2B9nKWPW2XRI35z1Hp0yx4%3D&reserved=0
> > > 
> > > All of the patches have been verified based on the kernel code
> > > commit 44889ba56cbb ("Merge tag 'net-6.3-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> > 
> > verified how?
> > 
> Hi Michael
> 1. Applied the patches on lastest kernel source(44889ba56cbb), compile and
> install the kernel, and use iperf to test traffic
> 2. To validate this change, we tested various virtqueue sizes for packed
> rings, including 128, 256, 512, 100, 200, 500, and 1000, with
> CONFIG_PAGE_POISONING enabled, and test by iperf& ping -f and all tests
> passed successfully.

Given split ring does not support non power of 2 how exactly
did you configure non power of 2?

> 
> > > Feng Liu (3):
> > >    virtio_pci_modern: Allow non power of 2 sizes for virtqueues
> > >    virtio_ring: Avoid using inline for small functions
> > >    virtio_ring: Use const to annotate read-only pointer params
> > > 
> > >   drivers/virtio/virtio_pci_modern.c |  5 ----
> > >   drivers/virtio/virtio_ring.c       | 48 +++++++++++++++---------------
> > >   include/linux/virtio.h             | 14 ++++-----
> > >   3 files changed, 31 insertions(+), 36 deletions(-)
> > > 
> > > --
> > > 2.34.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
