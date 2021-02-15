Return-Path: <SRS0=6TmO=HR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7FC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 08:31:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D7464E00
	for <virtualization@archiver.kernel.org>; Mon, 15 Feb 2021 08:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D7464E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0DFE18688B;
	Mon, 15 Feb 2021 08:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E92gI+bT7BlE; Mon, 15 Feb 2021 08:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF658867FA;
	Mon, 15 Feb 2021 08:31:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B904C0174;
	Mon, 15 Feb 2021 08:31:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77F94C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 08:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E561858B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 08:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RCO_zmOr-7NA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 08:31:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D62BD858A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 08:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613377879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BS3SsR4P+q5+lklIzJzQe7eSC0Cx6H0EoiFBYp9fmvQ=;
 b=PoJaa1LP8Jwna359j9qjVscWJFxTtkIvECZzIVuxL8ihJa0CXUrNCGa2JABdD1DVhuFuiH
 Q0fArIP4EQjYPKsDVEsUvkYS+JIKX4gR5JdVMZBsrYSSMtiwz+45+weFg9HL5VbyW6uR9c
 DwE4+W+vHsCSiV8gnMPxmLA4s/KLseY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-dgTufvUBM7u4Z-iExb7KUA-1; Mon, 15 Feb 2021 03:31:15 -0500
X-MC-Unique: dgTufvUBM7u4Z-iExb7KUA-1
Received: by mail-ej1-f70.google.com with SMTP id hx26so3952152ejc.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 00:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BS3SsR4P+q5+lklIzJzQe7eSC0Cx6H0EoiFBYp9fmvQ=;
 b=BPXT7WFRNMt+t3s75xWRr4LknrIHDQIXXa5HoEBhJSPsC61ldUcZw2KrQaGoLNy2ED
 fBa9644OuFhbmTZ4nEZOZEczn7tRerDn+McBSN2tcylM3tRjOX46mMmLGJqu7Tpxp+KJ
 bYJme2rkBvQNATXH3dxtQp7LbZKGOczDQavhAh+EEsmSGVsokH76vsV2HXXy+xss19oJ
 DmYQAgXfFFuZNrapupyFYljGRdvPfhH8pseLDXyEk8yRRZhrsI5bby8sHoHpkXfPMD9X
 OXTroz4vtBr0HiubpKvQ9Wydq7A5pIzUPistmVlTYPct5EpfLgJUum7AlJFJUCfHUPMS
 hPEg==
X-Gm-Message-State: AOAM532bklbZ3yqTT6COeGlB2iEwks+aL3yv6T+/09zdafzvZszdYDyr
 //8T73OeFSB0IQz5odZ39P1PEfFGrKNSWluL6GAo/Mxk8c/DE2nnwe1y6QphNI1N1r0pA9wUx0J
 9UAg21WHn8Z7uXjUpVhQMpFA/RedTKGclkPWKcJUNbw==
X-Received: by 2002:a50:b765:: with SMTP id g92mr14560182ede.317.1613377874400; 
 Mon, 15 Feb 2021 00:31:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzlILVwSJUCYhiVf5/1Opyb2HOkafog+S5gOg6qrs/zUsQxLItlKtPD9qn3PekpxlXgSGh29g==
X-Received: by 2002:a50:b765:: with SMTP id g92mr14560169ede.317.1613377874165; 
 Mon, 15 Feb 2021 00:31:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a11sm209172ejt.112.2021.02.15.00.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 00:31:13 -0800 (PST)
Date: Mon, 15 Feb 2021 09:31:10 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
Message-ID: <20210215083110.xb4cyekutlmlvetg@steredhat>
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <CAP_N_Z-4Af_5jE7x5kSi8u=KUVUsbfDTtuD_7numL+vnkisMgQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-4Af_5jE7x5kSi8u=KUVUsbfDTtuD_7numL+vnkisMgQ@mail.gmail.com>
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

On Sat, Feb 13, 2021 at 03:26:18PM -0800, Jiang Wang . wrote:
>On Fri, Feb 12, 2021 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> Hi Jiang,
>>
>> CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
>> [1].
>>
>> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
>> >Hi guys,
>> >
>> >I am working on supporting DGRAM type for virtio/vhost vsock. I
>> >already did some work and a draft code is here (which passed my tests,
>> >but still need some cleanup and only works from host to guest as of
>> >now, will add host to guest soon):
>> >https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
>> >qemu changes are here:
>> >https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
>> >
>> >Today, I just noticed that the Asias had an old version of virtio
>> >which had both dgram and stream support, see this link:
>> >https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
>> >
>> >But somehow, the dgram part seems never merged to upstream linux (the
>> >stream part is merged). If so, does anyone know what is the reason for
>> >this? Did we drop dgram support for some specific reason or the code
>> >needs some improvement?
>>
>> I wasn't involved yet in virtio-vsock development when Asias posted that
>> patches, so I don't know the exact reason.
>>
>> Maybe could be related on how to handle the credit mechanism for a
>> connection-less sockets and how to manage the packet queue, if for
>> example no one is listening.
>>
>
>I see. thanks.
>
>> >
>> >My current code differs from Asias' code in some ways. It does not use
>> >credit and does not support fragmentation.  It basically adds two virt
>>
>> If you don't use credit, do you have some threshold when you start to
>> drop packets on the RX side?
>>
>
>As of now, I don't have any threshold to drop packets on RX side. In my
>view, DGRAM is like UDP and is a best effort service. If the virtual 
>queue
>is full on TX (or the available buffer size is less than the packet size),
>I drop the packets on the TX side.

I have to check the code, my concern is we should have a limit for the 
allocation, for example if the user space doesn't consume RX packets.

>
>> >queues and re-uses the existing functions for tx and rx ( there is
>>
>> This make sense, some time ago I was thinking about this and also came
>> to the conclusion that 2 new virtqueues were needed to handle DGRAM
>> traffic.
>>
>Good to know.
>
>> >somewhat duplicate code for now, but I will try to make common
>> >functions to reduce it). If we still want to support dgram in upstream
>> >linux, which way do you guys recommend? If necessary, I can try to
>> >base on Asias' old code and continue working on it. If there is
>> >anything unclear, just let me know. Thanks.
>>
>> A problem I see is how to handle multiple transports to support nested
>> VMs. Since the sockets are not connected, we can't assign them to a
>> single transport.
>>
>
>I did not consider the nested VMs when I started working on this. I
>just checked your
>nested VM support patch, and I agree it is harder to support it for DGRAM. One
>idea is that we can also prepare two transport layers for DGRAM (
>similar to STREAM)

Yeah, or just remove the VSOCK_TRANSPORT_F_DGRAM and use the same flags 
used for STREAM also for DGRAM. If the transport does not support DGRAM, 
we return an error.

>and assign transport for every DGRAM packet. The downside is that it 
>will
>introduce some overhead. I will think about it more.

I agree that maybe we should check the right transport for every DGRAM 
packet.

>
>> Arseny is working on SOCK_SEQPACKET [1], it's similar to DGRAM, but it
>> is connection oriented, so we can reuse most of the STREAM stuff and
>> also the credit mechanism.
>>
>> Maybe you can reuse some of the Arseny's stuff to handle the
>> fragmentation.
>
>Sure. I will check Arseny's patch.
>
>> For the channel type (lossless) I think SEQPACKET makes more sense, but
>> if you have any use-cases for DGRAM and want to support it, you are
>> welcome to send patches and I will be happy to review them.
>>
>Got it. Thanks. We have some use cases for DGRAM. Basically, we send some
>kind of non-critical logging data from guest to the host. It is one way
>communication and does not require reliable delivery.  I will continue
>working on the patch and send it out for review when it is ready.
>Thanks again for all the inputs.

I see, in fact DGRAM might make sense when we have a single receiver 
(host) and many transmitters (guests).

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
