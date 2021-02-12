Return-Path: <SRS0=ygFP=HO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF97C433DB
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 09:02:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C35664DF2
	for <virtualization@archiver.kernel.org>; Fri, 12 Feb 2021 09:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C35664DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3367787168;
	Fri, 12 Feb 2021 09:02:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ElAaTVvBC385; Fri, 12 Feb 2021 09:02:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1FC2D8706D;
	Fri, 12 Feb 2021 09:02:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D99B1C0174;
	Fri, 12 Feb 2021 09:02:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DBC7C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5C0E486D6E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r9qk6mUX7Wfe
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:02:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D112986E51
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613120559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tuhyr8wvoo6m97EFmFwgT6bEyVInhUeL0KJPqyNf2+M=;
 b=eIwRblS49bk1MAFPEB37AoOXM07L+Q93MHFANJfu80gNzfu3op6dNIdqRcd9ki+dvx+SD/
 0Dc0gP80PxVM6qW+4a8CUlH/RX1keb/BURbyfRqv9VIjMSTDWvzfKqiu2gidyoVwayxaxB
 e6UEGvhZsNYxx0Fpoxd8VxyLRRc++UE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-A_cKOfU5PSOoQ4jY0lgLyw-1; Fri, 12 Feb 2021 04:02:35 -0500
X-MC-Unique: A_cKOfU5PSOoQ4jY0lgLyw-1
Received: by mail-ed1-f70.google.com with SMTP id i13so6162788edq.19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Feb 2021 01:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Tuhyr8wvoo6m97EFmFwgT6bEyVInhUeL0KJPqyNf2+M=;
 b=UlYk4O0ZbR8L8HII/kIqiD1Tx+9SAmr2+IIYbWA/YBumMeeVh7SzijxmPw4XsJNmq7
 dIVhySlPuX6ps0hPSRFeEe6e2wvvsGgkYeTFVspCa5fJMd08Y3VLBjI/dEA5HcWIpfSr
 9NloSI1J+QhzSbTGYVwgAbSu+GHJ72TP0dTmWl6uR2Qp7+B8oDPRsEwtmXvJoZAHehfg
 TfGr+RxOdQwud05ZD6JdXycp0YHI8eYLPsgt7msXDJG92zbFWxpPNPIaJ81b0iKYUV+U
 4s5aKeTmsiqvCBhpYofMjI+YCE4iBKGB3s3o4sPLZvBpzEcQxUdHG4Ox8fdHN6aZDfk8
 /QRA==
X-Gm-Message-State: AOAM532NsXErxteESXX6H5ikNnCwKmPH5zYPJGBRNiR5vzQx3bSjypIq
 kNBhvJwuM+UP5bUNLAdtYhmvjU93W1FYKdQti5twoJEtjQM0EW1oKoOd1UC0Myb2unDfz+hTLvu
 U7bXI2mTFuojrgAMoW6HVtz9GoBydRZV3WOo9QhAIUg==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr2251224edk.377.1613120553885; 
 Fri, 12 Feb 2021 01:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5vd1Xcczzc4EKsburjCeUTPpXfSKRDx5+tPW0yK+MYsWNs8QZbknCL6xm+OlzhqJT1/y1hw==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr2251207edk.377.1613120553698; 
 Fri, 12 Feb 2021 01:02:33 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id y11sm6185049ejd.72.2021.02.12.01.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Feb 2021 01:02:33 -0800 (PST)
Date: Fri, 12 Feb 2021 10:02:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: vsock virtio: questions about supporting DGRAM type
Message-ID: <20210212090230.bai6xkx6gne53p3i@steredhat>
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 mst@redhat.com, imbrenda@linux.vnet.ibm.com, xieyongji@bytedance.com,
 stefanha@redhat.com, asias@redhat.com,
 virtualization@lists.linux-foundation.org,
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

CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock 
[1].

On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
>Hi guys,
>
>I am working on supporting DGRAM type for virtio/vhost vsock. I
>already did some work and a draft code is here (which passed my tests,
>but still need some cleanup and only works from host to guest as of
>now, will add host to guest soon):
>https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
>qemu changes are here:
>https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
>
>Today, I just noticed that the Asias had an old version of virtio
>which had both dgram and stream support, see this link:
>https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
>
>But somehow, the dgram part seems never merged to upstream linux (the
>stream part is merged). If so, does anyone know what is the reason for
>this? Did we drop dgram support for some specific reason or the code
>needs some improvement?

I wasn't involved yet in virtio-vsock development when Asias posted that 
patches, so I don't know the exact reason.

Maybe could be related on how to handle the credit mechanism for a 
connection-less sockets and how to manage the packet queue, if for 
example no one is listening.

>
>My current code differs from Asias' code in some ways. It does not use
>credit and does not support fragmentation.  It basically adds two virt

If you don't use credit, do you have some threshold when you start to 
drop packets on the RX side?

>queues and re-uses the existing functions for tx and rx ( there is

This make sense, some time ago I was thinking about this and also came 
to the conclusion that 2 new virtqueues were needed to handle DGRAM 
traffic.

>somewhat duplicate code for now, but I will try to make common
>functions to reduce it). If we still want to support dgram in upstream
>linux, which way do you guys recommend? If necessary, I can try to
>base on Asias' old code and continue working on it. If there is
>anything unclear, just let me know. Thanks.

A problem I see is how to handle multiple transports to support nested 
VMs. Since the sockets are not connected, we can't assign them to a 
single transport.

Arseny is working on SOCK_SEQPACKET [1], it's similar to DGRAM, but it 
is connection oriented, so we can reuse most of the STREAM stuff and 
also the credit mechanism.

Maybe you can reuse some of the Arseny's stuff to handle the 
fragmentation.

For the channel type (lossless) I think SEQPACKET makes more sense, but 
if you have any use-cases for DGRAM and want to support it, you are 
welcome to send patches and I will be happy to review them.

Thanks,
Stefano

[1] 
https://lore.kernel.org/lkml/20210207151451.804498-1-arseny.krasnov@kaspersky.com/T/#m81d3ee4ccd54cd301b92c00b3b1bca6e7bc91fc9

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
