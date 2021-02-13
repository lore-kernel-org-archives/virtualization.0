Return-Path: <SRS0=xhJn=HP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6FC433DB
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 23:53:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86C364E3D
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 23:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86C364E3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F4866F56A
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 23:53:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyNtyLQ436LJ for <virtualization@archiver.kernel.org>;
	Sat, 13 Feb 2021 23:53:10 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 8E8796F50E; Sat, 13 Feb 2021 23:53:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 812536F52F;
	Sat, 13 Feb 2021 23:53:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 208B1C0891;
	Sat, 13 Feb 2021 23:53:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15668C013A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 23:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F126D85F68
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 23:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gfpi-oWoPaf
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 23:52:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8450C85F69
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 23:52:58 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id e5so2820059otb.11
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 15:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bK0xgxiL+zb1btpZavD+h73XXaI3imW5otCu2oYvlfA=;
 b=RLXTBj9U06DKFrZHKIhpA9WApgTF6h8tQYu/AlA3ngWHdxpQmdmljDW4WYu/c8K9Ii
 njjnsKWXDnIayeiCRXcPop7eksnQ3cb+BaRh1hE8STaqELeMfGSBYB7cHDVZ1kH9f8Gn
 pwfAPZ99d/lojsQ6J9UrIopSwl0wtRaOg1g0bCHjyGCkQqyOkugr8zG2gL08489Dvw9H
 QfSNLaLdKwznGDmqqXWtj2Fkx13oIinZy+0j2YQ9XRWaIQ3EaWbsxrIi3Q5xiGpypzA/
 BUyea7yLCPP03JLR+rGGwIpn2T8xahuHAJUqwS0unMP+e0p7i+DcY/FTqE25UHQOpmAM
 s8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bK0xgxiL+zb1btpZavD+h73XXaI3imW5otCu2oYvlfA=;
 b=TYsMIiaIU8hqpNT6mxWf9KIVImagnQrf1HfkHoXeGdEo9fmDJHLsz1D9SC2SthGQTH
 Lj6EF0O0edzIsFSD9hwHh1H2FVB4tV9o4eP14btgfkyF4IYeyFmNjW9vibddd4v5EOS3
 sDkV4iBTWgzUjW+Z9uGRQNKr1z5RaeaI5UdYgfIOdx8pl9PY++vAJbdWPA6/XoAnu7Su
 qG0ikgzLl8EO3MzIiVbBMgVEZvx5JVwNMoBKBN6Z3IC11/GzWjnsBB7n1cChSLdZJtv9
 7cYwC5Sn8QpVZmrQSrk221MaVfOFJtX/uX1Wd9qGt14x3gq556b1irs60CIhYtclHxzG
 VsaQ==
X-Gm-Message-State: AOAM530Mr+K+ZC9zLPijHHrS9D0wuwcmDgAo9bV9gLqxELDwRbsbtI1Y
 VmIjHAjW6c/x1aU8Ut7lTGJMU9+jK98vVKUGsbAd3oq9yRff3UkC
X-Google-Smtp-Source: ABdhPJxtXrt4iUFIjeb5ui6DdvehdJBd6umxbdxzSyuY64s+NOPBpotpjM95Iv2JXm8d2x7s5q47v6bosGUddc3nqIs=
X-Received: by 2002:a4a:2a5e:: with SMTP id x30mr6441051oox.4.1613259979783;
 Sat, 13 Feb 2021 15:46:19 -0800 (PST)
MIME-Version: 1.0
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <e62051f4-e65d-4967-da5c-50ea76f2c783@kaspersky.com>
In-Reply-To: <e62051f4-e65d-4967-da5c-50ea76f2c783@kaspersky.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Sat, 13 Feb 2021 15:46:09 -0800
Message-ID: <CAP_N_Z9UtmzeSjVod=mBwJwHzBEQvnpbSDQ9CmMn1nq-Xif1uA@mail.gmail.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc: "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
 Xiongchun Duan <duanxiongchun@bytedance.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "asias@redhat.com" <asias@redhat.com>,
 "imbrenda@linux.vnet.ibm.com" <imbrenda@linux.vnet.ibm.com>
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

On Fri, Feb 12, 2021 at 7:19 AM Arseny Krasnov
<arseny.krasnov@kaspersky.com> wrote:
>
>
> On 12.02.2021 12:02, Stefano Garzarella wrote:
> > Hi Jiang,
> >
> > CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
> > [1].
> >
> > On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> >> Hi guys,
> >>
> >> I am working on supporting DGRAM type for virtio/vhost vsock. I
> >> already did some work and a draft code is here (which passed my tests,
> >> but still need some cleanup and only works from host to guest as of
> >> now, will add host to guest soon):
> >> https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> >> qemu changes are here:
> >> https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> >>
> >> Today, I just noticed that the Asias had an old version of virtio
> >> which had both dgram and stream support, see this link:
> >> https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> >>
> >> But somehow, the dgram part seems never merged to upstream linux (the
> >> stream part is merged). If so, does anyone know what is the reason for
> >> this? Did we drop dgram support for some specific reason or the code
> >> needs some improvement?
> > I wasn't involved yet in virtio-vsock development when Asias posted that
> > patches, so I don't know the exact reason.
> >
> > Maybe could be related on how to handle the credit mechanism for a
> > connection-less sockets and how to manage the packet queue, if for
> > example no one is listening.
> >
> >> My current code differs from Asias' code in some ways. It does not use
> >> credit and does not support fragmentation.  It basically adds two virt
> > If you don't use credit, do you have some threshold when you start to
> > drop packets on the RX side?
> >
> >> queues and re-uses the existing functions for tx and rx ( there is
> > This make sense, some time ago I was thinking about this and also came
> > to the conclusion that 2 new virtqueues were needed to handle DGRAM
> > traffic.
>
> Sorry, but what is purpose of two new virt queues?
>
The two new virt queues will be dedicated for the DGRAM packets. Current
queues are used by STREAM (and your SEQPACKET) and the credit
mechanism is bound up with current queues. For DGRAM, the packets can be lost
and no need to use the credit based mechanism. Allocating two new queues
will make this simpler and DGRAM will not interfere with the STREAM
or SEQPACKET.

> >
> >> somewhat duplicate code for now, but I will try to make common
> >> functions to reduce it). If we still want to support dgram in upstream
> >> linux, which way do you guys recommend? If necessary, I can try to
> >> base on Asias' old code and continue working on it. If there is
> >> anything unclear, just let me know. Thanks.
> > A problem I see is how to handle multiple transports to support nested
> > VMs. Since the sockets are not connected, we can't assign them to a
> > single transport.
> >
> > Arseny is working on SOCK_SEQPACKET [1], it's similar to DGRAM, but it
> > is connection oriented, so we can reuse most of the STREAM stuff and
> > also the credit mechanism.
> >
> > Maybe you can reuse some of the Arseny's stuff to handle the
> > fragmentation.
>
> Yes, just apply patchset to latest kernel. I've solved problem
>
> with fragmentation at transport layer.
>

Got it. Thanks. I will check it out.

> >
> > For the channel type (lossless) I think SEQPACKET makes more sense, but
> > if you have any use-cases for DGRAM and want to support it, you are
> > welcome to send patches and I will be happy to review them.
> >
> > Thanks,
> > Stefano
> >
> > [1]
> > https://lore.kernel.org/lkml/20210207151451.804498-1-arseny.krasnov@kaspersky.com/T/#m81d3ee4ccd54cd301b92c00b3b1bca6e7bc91fc9
> >
> >
>
> Thanks, Arseny
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
