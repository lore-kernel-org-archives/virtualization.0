Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D25C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 05:43:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9AB64DDA
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 05:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9AB64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7040E8677C;
	Tue, 16 Feb 2021 05:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5SCqVNqrL6ZL; Tue, 16 Feb 2021 05:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 04B278675F;
	Tue, 16 Feb 2021 05:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1604C0174;
	Tue, 16 Feb 2021 05:43:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0CB4C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 05:43:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 972B086FCF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 05:43:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uskh9piGyCsl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 05:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0119586FC5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 05:43:33 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id b8so3437073oti.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Feb 2021 21:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vLaOmyWerhDCl2CMqrRMahvwTCrlWoRUqeIUY2hTrRE=;
 b=ao0dAj2nsKu/2USitSe3jF+lCvuITA7krm4bT446sHhTbW30u8tKBVAEzpFxtrW1MP
 z1hNCLyAvySo57lVpUEqWal66TyXznP+m/kTsuUwwhoDo6wE0tMBcLvt/OSB6g8Uyc8a
 MUWHw7cIy6NFzwzgNeUpAke9256Utu7kdTBXVm9wZL1k5DWyZziKBtVBvEzFMyR3/luV
 BqQEsdsxRl5vqC7cnvniNJpPbwavNxReake0w+2+i4w1NnSrJhVDHktPjlExp5FMX7mL
 oNWltKHObvyHo2cF968QO2jnKX+fFQ98ZUnBwevhHCYWQlNQ2Tf+UX3BF7qzHLzkxar5
 mJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vLaOmyWerhDCl2CMqrRMahvwTCrlWoRUqeIUY2hTrRE=;
 b=AcKoiQVW9EQrO3eT+yXNkKTnwsWVR2Zczcj6qivqa6HvtguidCPybUptVFtPCAuRUX
 E3fVSigw01LwQ7lvNGpxGnUz7y7SUc2KRK/iT9dhReO4a5SsEYn7PwWnpgahcD8G9vgG
 QCIn9JDWD0nLupD8QTr7El8sKcWZrZMDlC5M0zmhJqhmCXpqkKwS7EVHOL95MdK31DS/
 S1Wqh7RMuabf3jwarMmMSi5uAlBKjM8o/wdH+eI/DOsvsRD+hMEtuXNNfnD54dk/F0d9
 /FR3TVD9fD1pDxonIPidJpUYUB/tY8b2YDcZ1IFYsCJi7hCLa4rBxk7eed2bCpKkW+6V
 GvZg==
X-Gm-Message-State: AOAM533La+WXbbKyd0NcmMHkJYVF40CZYoxuxpxBwrirIeEz3nrzThK0
 sshIJikoUVg3Z4G6zWap4OgzLEiACNL0Oq2mZUIHIw==
X-Google-Smtp-Source: ABdhPJx+q+mS3+T8eA3mylkAvVzVHW8JNqrCLyptn5xCTJH9TVXHM9mah51wIaVjwB74HPr5rzNttqXiQh/CEaZDQmY=
X-Received: by 2002:a05:6830:902:: with SMTP id
 v2mr13915906ott.56.1613454212948; 
 Mon, 15 Feb 2021 21:43:32 -0800 (PST)
MIME-Version: 1.0
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <e62051f4-e65d-4967-da5c-50ea76f2c783@kaspersky.com>
 <CAP_N_Z9UtmzeSjVod=mBwJwHzBEQvnpbSDQ9CmMn1nq-Xif1uA@mail.gmail.com>
 <f6dd1500-53cf-afb0-ec3c-47de57f8490f@kaspersky.com>
In-Reply-To: <f6dd1500-53cf-afb0-ec3c-47de57f8490f@kaspersky.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 15 Feb 2021 21:43:22 -0800
Message-ID: <CAP_N_Z8xH-EkeKg7XYsizeMuLpfVAT5Dz2WV3yZyrTp=w8kEBw@mail.gmail.com>
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

On Mon, Feb 15, 2021 at 12:53 AM Arseny Krasnov
<arseny.krasnov@kaspersky.com> wrote:
>
>
> On 14.02.2021 02:46, Jiang Wang . wrote:
> > On Fri, Feb 12, 2021 at 7:19 AM Arseny Krasnov
> > <arseny.krasnov@kaspersky.com> wrote:
> >>
> >> On 12.02.2021 12:02, Stefano Garzarella wrote:
> >>> Hi Jiang,
> >>>
> >>> CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
> >>> [1].
> >>>
> >>> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> >>>> Hi guys,
> >>>>
> >>>> I am working on supporting DGRAM type for virtio/vhost vsock. I
> >>>> already did some work and a draft code is here (which passed my tests,
> >>>> but still need some cleanup and only works from host to guest as of
> >>>> now, will add host to guest soon):
> >>>> https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> >>>> qemu changes are here:
> >>>> https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> >>>>
> >>>> Today, I just noticed that the Asias had an old version of virtio
> >>>> which had both dgram and stream support, see this link:
> >>>> https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> >>>>
> >>>> But somehow, the dgram part seems never merged to upstream linux (the
> >>>> stream part is merged). If so, does anyone know what is the reason for
> >>>> this? Did we drop dgram support for some specific reason or the code
> >>>> needs some improvement?
> >>> I wasn't involved yet in virtio-vsock development when Asias posted that
> >>> patches, so I don't know the exact reason.
> >>>
> >>> Maybe could be related on how to handle the credit mechanism for a
> >>> connection-less sockets and how to manage the packet queue, if for
> >>> example no one is listening.
> >>>
> >>>> My current code differs from Asias' code in some ways. It does not use
> >>>> credit and does not support fragmentation.  It basically adds two virt
> >>> If you don't use credit, do you have some threshold when you start to
> >>> drop packets on the RX side?
> >>>
> >>>> queues and re-uses the existing functions for tx and rx ( there is
> >>> This make sense, some time ago I was thinking about this and also came
> >>> to the conclusion that 2 new virtqueues were needed to handle DGRAM
> >>> traffic.
> >> Sorry, but what is purpose of two new virt queues?
> >>
> > The two new virt queues will be dedicated for the DGRAM packets. Current
> > queues are used by STREAM (and your SEQPACKET) and the credit
> > mechanism is bound up with current queues. For DGRAM, the packets can be lost
> > and no need to use the credit based mechanism. Allocating two new queues
> > will make this simpler and DGRAM will not interfere with the STREAM
> > or SEQPACKET.
>
> I think that credit mechanism is per socket(e.g. every socket has
>
> its own "free space"). If socket has free space, but queue is full,
>
> packet still inserted in tx list. Otherwise if queue is empty, but
>
> receiver didn't send credit update to make sender happy(free space
>
> is 0) - sender will sleep. I think both of them are independent.

Thanks for the explanation and I agree with your above description.
The data structure for credit is
per socket. But there is a subtle assumption for STREAM or connection
oriented communications. When the client sends the first connect message
to the server, it does not know the credit of the server. Current code
relies on the pkt_len == 0 to send it out, as the following:

/* virtio_transport_get_credit might return less than pkt_len credit */
pkt_len = virtio_transport_get_credit(vvs, pkt_len);

/* Do not send zero length OP_RW pkt */
if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
return pkt_len;

DGRAM will be different. DGRAM does not require a
connect call, and the first message will have a non zero pkt_len.
We could somehow improve the current credit mechanism
and make it work for DGRAM too, but I don't think it is a strict
requirement for DGRAM.

Going back to the original question about why adding two more
new virtqueues, another reason is for better performance and
performance isolation. If DGRAM and STREAM share the same
queues, and both have heavy in-flight data, I think the throughput
of the STREAM will be decreased. Also, if the DGRAM server
somehow does not process packets for a long time, the packets
will be kept in the queue and also interfere with the STREAM
packets. I think adding two more queues without a credit
mechanism is the best option for DGRAM. If there are other
reasons to use credit or not adding two more queues, please
let me know. Thanks


> >
> >>>> somewhat duplicate code for now, but I will try to make common
> >>>> functions to reduce it). If we still want to support dgram in upstream
> >>>> linux, which way do you guys recommend? If necessary, I can try to
> >>>> base on Asias' old code and continue working on it. If there is
> >>>> anything unclear, just let me know. Thanks.
> >>> A problem I see is how to handle multiple transports to support nested
> >>> VMs. Since the sockets are not connected, we can't assign them to a
> >>> single transport.
> >>>
> >>> Arseny is working on SOCK_SEQPACKET [1], it's similar to DGRAM, but it
> >>> is connection oriented, so we can reuse most of the STREAM stuff and
> >>> also the credit mechanism.
> >>>
> >>> Maybe you can reuse some of the Arseny's stuff to handle the
> >>> fragmentation.
> >> Yes, just apply patchset to latest kernel. I've solved problem
> >>
> >> with fragmentation at transport layer.
> >>
> > Got it. Thanks. I will check it out.
> >
> >>> For the channel type (lossless) I think SEQPACKET makes more sense, but
> >>> if you have any use-cases for DGRAM and want to support it, you are
> >>> welcome to send patches and I will be happy to review them.
> >>>
> >>> Thanks,
> >>> Stefano
> >>>
> >>> [1]
> >>> https://lore.kernel.org/lkml/20210207151451.804498-1-arseny.krasnov@kaspersky.com/T/#m81d3ee4ccd54cd301b92c00b3b1bca6e7bc91fc9
> >>>
> >>>
> >> Thanks, Arseny
> >>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
