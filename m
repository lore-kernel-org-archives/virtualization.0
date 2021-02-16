Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464CC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 08:23:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E19964E00
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 08:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E19964E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C1B96F57B
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 08:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wi6hKixQDiWr for <virtualization@archiver.kernel.org>;
	Tue, 16 Feb 2021 08:23:41 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 1F1D3600C6; Tue, 16 Feb 2021 08:23:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8373C6F4CD;
	Tue, 16 Feb 2021 08:23:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FAFAC0174;
	Tue, 16 Feb 2021 08:23:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB6DBC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A0E5386799
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L33unvi8yPCq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:23:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C2C3C8677D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 08:23:31 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id r75so10385428oie.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 00:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LGjd8TAiXVPYrBqvfvH75ic6pQQYWEBAasboEaC57wk=;
 b=j5XopE8b0Z+JEOKEOLnatzV4a3BIBStaFhWJ9m/MIMPzMKU6K7FGolBHPHRQS4ijwM
 Mtca8KYzMJpu3Dai+fZuF56KnIdaKXJa/vVl/nFM7yBzxMwbjNGsqIoWPo0EJAT/M9Rd
 Zvq5avFCj8JBFzTVQYEJg3myTN1R9fxwShUQjZcwOHVJNfUUla0cA8RaMklYE1hFuIc9
 Rw23UzZ5ETsHP3PDE0bCR4dx2syQ5dE3TNIK35eeCXe663T3HVLwVJkxEmQ41pPoCZd8
 bX3KKyaV4d89S6oKIERk9i2xeV9TrKk+iYBOyjCovmOlO856sXm88QqD8gYIWv2K/WgQ
 bfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LGjd8TAiXVPYrBqvfvH75ic6pQQYWEBAasboEaC57wk=;
 b=M2okTqUEyQU8UtfBflkRfS3Vuu2hUxj2hMVz9osuu9cpwVOgEf5g+CSq4wHWmi/ih3
 o8gi+0ptF9q05wB9FqjhqcjPuZ/d33q/gHTq8rm9+xCxXUFxj/YSBB8GEVYNv/fRsrF/
 G3KjOlBXQP9TsY/z8WJYTxFJHD/bxCFpxs9PlcNvBHtCd16oUWUAXNTeOIM+Pg4t9ddJ
 z3YlaxM4F+NKpnAwdR1RabZij53EaeLRbkEUThYxvjuinHZ3F5NtCIlnh6VH25jHRa9j
 hewk9/B8nodKCLGEV8DW5Hqv6qoALhafCeeJZ/hOsTGTg/cqQSWGsM/i0nrafFOeswWG
 lqoQ==
X-Gm-Message-State: AOAM532TbM6o7Lcd1cDQnMpclwCjNJ6i0GcYjgaJIIQ2f1JykYEwaw58
 1kp38nW4R8xlg1o5XI6o8kdsvikXqwfMxTdlB7so6g==
X-Google-Smtp-Source: ABdhPJx7l1vq7zs/fdH52cmzomJWCy3YzHpe/tNbBR6TIZN5oz0e4Od0qr7Gsi6XAKBw0sqZuwtsLrRBwTK+mLNI/nU=
X-Received: by 2002:aca:4a4c:: with SMTP id x73mr1846699oia.97.1613463810729; 
 Tue, 16 Feb 2021 00:23:30 -0800 (PST)
MIME-Version: 1.0
References: <CAP_N_Z97rUvCSNoKAkxhyw9FJWQ2tJ0Wv5srHzR387j_S_6pjA@mail.gmail.com>
 <20210212090230.bai6xkx6gne53p3i@steredhat>
 <CAP_N_Z-4Af_5jE7x5kSi8u=KUVUsbfDTtuD_7numL+vnkisMgQ@mail.gmail.com>
 <20210215083110.xb4cyekutlmlvetg@steredhat>
 <CAP_N_Z9T5nJ37k9Rgoba_SzN9RQrBn7jCKwxO9TLyddzb+jsJQ@mail.gmail.com>
 <20210216080911.lgw7cgo4rvxzaehx@steredhat>
In-Reply-To: <20210216080911.lgw7cgo4rvxzaehx@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 16 Feb 2021 00:23:19 -0800
Message-ID: <CAP_N_Z9yYXqd_j9_Dj94mc-P0Azwos4jhJ3uDSUhuzVuAAnQDA@mail.gmail.com>
Subject: Re: [External] Re: vsock virtio: questions about supporting DGRAM type
To: Stefano Garzarella <sgarzare@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Feb 16, 2021 at 12:09 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, Feb 15, 2021 at 08:50:36PM -0800, Jiang Wang . wrote:
> >On Mon, Feb 15, 2021 at 12:31 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> On Sat, Feb 13, 2021 at 03:26:18PM -0800, Jiang Wang . wrote:
> >> >On Fri, Feb 12, 2021 at 1:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> >>
> >> >> Hi Jiang,
> >> >>
> >> >> CCing Arseny who is working on SOCK_SEQPACKET support for virtio-vsock
> >> >> [1].
> >> >>
> >> >> On Thu, Feb 11, 2021 at 10:04:34PM -0800, Jiang Wang . wrote:
> >> >> >Hi guys,
> >> >> >
> >> >> >I am working on supporting DGRAM type for virtio/vhost vsock. I
> >> >> >already did some work and a draft code is here (which passed my tests,
> >> >> >but still need some cleanup and only works from host to guest as of
> >> >> >now, will add host to guest soon):
> >> >> >https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d
> >> >> >qemu changes are here:
> >> >> >https://github.com/Jiang1155/qemu/commit/7ab778801e3e8969ab98e44539943810a2fb03eb
> >> >> >
> >> >> >Today, I just noticed that the Asias had an old version of virtio
> >> >> >which had both dgram and stream support, see this link:
> >> >> >https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
> >> >> >
> >> >> >But somehow, the dgram part seems never merged to upstream linux (the
> >> >> >stream part is merged). If so, does anyone know what is the reason for
> >> >> >this? Did we drop dgram support for some specific reason or the code
> >> >> >needs some improvement?
> >> >>
> >> >> I wasn't involved yet in virtio-vsock development when Asias posted that
> >> >> patches, so I don't know the exact reason.
> >> >>
> >> >> Maybe could be related on how to handle the credit mechanism for a
> >> >> connection-less sockets and how to manage the packet queue, if for
> >> >> example no one is listening.
> >> >>
> >> >
> >> >I see. thanks.
> >> >
> >> >> >
> >> >> >My current code differs from Asias' code in some ways. It does not use
> >> >> >credit and does not support fragmentation.  It basically adds two virt
> >> >>
> >> >> If you don't use credit, do you have some threshold when you start to
> >> >> drop packets on the RX side?
> >> >>
> >> >
> >> >As of now, I don't have any threshold to drop packets on RX side. In my
> >> >view, DGRAM is like UDP and is a best effort service. If the virtual
> >> >queue
> >> >is full on TX (or the available buffer size is less than the packet size),
> >> >I drop the packets on the TX side.
> >>
> >> I have to check the code, my concern is we should have a limit for the
> >> allocation, for example if the user space doesn't consume RX packets.
> >>
> >
> >I think we already have a limit for the allocation. If a DGRAM client
> >sends packets while no socket is bound on the server side ,
> >the packet will be dropped when looking for the socket. If the socket is
> >bound on the server side, but the server program somehow does not
> >call recv or similar functions, the packets will be dropped when the
> >buffer is full as in your previous patch at here:
> >https://lore.kernel.org/patchwork/patch/1141083/
> >If there are still other cases that we don't have protection, let me know and
> >I can add some threshold.
>
> Maybe I misunderstood, but I thought you didn't use credit for DGRAM
> messages.
>
I don't use credit for DGRAM. But the dropping code I mentioned does not
rely on credit too. Just to make it clear, following is one part of code that
I referred to:

static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
struct virtio_vsock_pkt *pkt)
{
if (vvs->rx_bytes + pkt->len > vvs->buf_alloc)
return false;

vvs->rx_bytes += pkt->len;
return true;
}


> If you use it to limit buffer occupancy, then it should be okay, but
> again, I still have to look at the code :-)

Sure. I think you mean you need to look at my final patches. I will
send it later.  Just a friendly reminder, if you just want to get some
idea of my patches, you could check this link :
https://github.com/Jiang1155/linux/commit/4e89736e0bce15496460ff411cb4694b143d1c3d

thanks. :)

> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
