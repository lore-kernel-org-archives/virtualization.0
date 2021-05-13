Return-Path: <SRS0=J7l7=KI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C8C433B4
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 23:26:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2764161421
	for <virtualization@archiver.kernel.org>; Thu, 13 May 2021 23:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764161421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DBFB340444;
	Thu, 13 May 2021 23:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0I9quf3et_xJ; Thu, 13 May 2021 23:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 749F7400F1;
	Thu, 13 May 2021 23:26:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5912DC000E;
	Thu, 13 May 2021 23:26:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6142C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 23:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 903C1845CD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 23:26:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dgpU-J45xw2v
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 23:26:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7594F845CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 23:26:15 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id n184so26830644oia.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 May 2021 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KYRi0W1JL0Trrsvcj7nKJqtfflCe8+xTkgp5rtfp1H0=;
 b=l2vVY47PK9dHZcZe0WaOetJ8JAW/hutB0V+7afcSDuKzZEMIUrpY/jvUsZGYmW5cJp
 sElHCqYQiJIZSvVR9bUprsODmaUFHgGJOoEdM0HPeRyUmZxJKsxp459xxYBrRTUAuCwd
 l5iR7OAsd+M+RY1eTmZKemYgbnJFMyftWe80+q9HL8L9Up+wC01jGPjHoUigbiyxQIcd
 Vy1MQRs7wDNRPkpPwThZ6p6sKha3VYgswcPaJXqu+Cgvr+1Ihf/dvyGUROs3/CIuBk0U
 EfGgcLnqgRaAhs4dzQzk1kThuNfIKgJvsZqxwu1PwMN9BfdOssR4DGvOIvAuUw57+VlI
 Zt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KYRi0W1JL0Trrsvcj7nKJqtfflCe8+xTkgp5rtfp1H0=;
 b=Hos9+PEdmYKj0uWY+Aw862+FFH3ZEpLx6Gj0dxG6lKV5skoLhP3tGEm2HcMchy5Mog
 IuL5CqzaS6FSvvK/WCFG4/nEageV5iNSBYK6FUM3/TkhS/Seg9dJrlITml9cAGd8Yhts
 BgJG+l8qkG6EPLn0vuJy26Bvyc9X/weJwwBi+aGUK8gW1oVOyiU4MV19Ov6NuMHRg4Nf
 TJIjuW+Bj8FFaf+RWA/WlLgbe6rqUjBX5dx7/d0ED9hCWn5VwCLJQK8ci3MFGieQw1fr
 p1ymo8rom+vcQca13AjEYJmFRNNPMFDuARdPU13jB6lnWbSSViYiU4es3IStaJ58I1Jj
 HRSg==
X-Gm-Message-State: AOAM532Tb71ZeJpcHxoujHuJjxfzgh6EqiObTwRMVAIXR/lAV5E4X+Py
 OgO0Vb26cSrqQuqNwvNhKsDicA0ZzfuRlgjZ0nDLPA==
X-Google-Smtp-Source: ABdhPJx+sck5x27lPeOMKzUx5UME6k9UmbT4bCT1PJmGtVvDfWUgk8GsHspdp7dWzL8BfbM9lt7FG8pgsB2YN9NvAJI=
X-Received: by 2002:a05:6808:1c9:: with SMTP id
 x9mr11486128oic.109.1620948374334; 
 Thu, 13 May 2021 16:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
In-Reply-To: <20210510145055.y7mxqaq4zggajz5a@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Thu, 13 May 2021 16:26:03 -0700
Message-ID: <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Mon, May 10, 2021 at 7:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, May 07, 2021 at 09:53:19AM -0700, Jiang Wang . wrote:
> >Hi guys,
> >
> >I have one question about adding two new virtqueues for dgram. One new
> >thought is that we don't add two new virtqueues but keep using existing
> >virtqueues for both stream and dgram.
> >
> >At the beginning when I first thought about supporting dgram, I thought
> >adding two new virtqueues would be easier and have better performance.
> >But now, after the prototype is done, I think that to keep using
> >existing virtqueues is also not complicated and could in fact be simpler.
> >The performance difference may not be very big.
>
> I honestly didn't think it was easier to use two new queues, quite the
> opposite.

Got it.

> >
> >Original code has about 3 places which have assumptions about the
> >virtqueues are only used by the stream. But we can change those codes.
> >One place is to check pkt len. We can check only for stream pkts.
> >Another two are in tx and rx code path where if queued replies pkts are
> >too much, the code will stop the rx queue and resume later. We can keep
> >that same logic. The dgram will be affected a little bit but that should
> >be fine I think. Are there any other places that we should fix?
>
> Did you take a look at Arseny's series?
> I think he's already found the places where to check the type and it
> seems to me they are the places you listed.

Yes. I checked his patch. And that helps.

> >
> >In short, the virtqueues are in a lower level and can support multiple
> >flows and socket types. Use existing virtqueues also make it more
> >compatible with old versions.
>
> It's not clear to me how compatibility is improved. Can you elaborate on
> this?

I was thinking if we don't add two new virtqueues, then maybe we don't
need to add new feature bit too? If the other end does not support
dgram, then the packets will be just dropped. What do you think? Do
we still need to add dgram feature bits? I can have a feature bit for
mergeable buffer.

> >
> >What do you guys think? I remember Stefano mentioned that we should add
> >two new virtqueues for dgram. Stefano, do you have some specific reasons
> >for that? Could we just keep using existing virtqueues? Thanks.
> >
>
> My biggest concern was about the credit mechanism for datagrams. I mean
> avoiding datagrams from crowding the queue without limits, preventing
> streams from communicating.
>
> If you've found a way to limit datagram traffic, then maybe it's doable.

I see. I will add some limit to dgram packets. Also, when the virtqueues
are shared between stream and dgram, both of them need to grab a lock
before using the virtqueue, so one will not completely block another one.

> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
