Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310C2DA749
	for <virtualization@lists.linux.dev>; Mon, 15 Dec 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765780922; cv=none; b=rxcecL6BLv/GDxZ/m42I1X3A0q5oEJynPBBFguQV/MTrghWYkTxCQycDIbYK+cjHDFDXY5XxuoAARgvD5WjYYjF6wGuG767AMmfXoHn26UdRmMg9TLQHQRBTMNBe9v4iRarVh/rpdhvt8yp7Sm7YJUQRPcVIblvHW6A+oOSas84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765780922; c=relaxed/simple;
	bh=806QJwueHcRIX9UowK1c2xkOwntC647EqLAJ80g7HYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIP0rzYs+CJGb/bANO79VKrGVzHP+/7nnzlAenuUqsFxV3MWSu2ldL2XePruLNA3hPpyifinKjjKQoVjWN8u0cLyx1DGuYxXAO9u3qbq4RboUn9qQAgjDfR1sEXqWkIhfa1obxaJx7axue485RheT8zYWt74n2t/RnQQ8YF0f0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xok3mSsy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xok3mSsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765780919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b13OnUYDcLnPc+T52EwC1q4bWFFgtcvxl6ViyNRPTbI=;
	b=Xok3mSsyC6RCPeTMtU8vPFChM6koBCnfeej7QI47kR95gE4Pg11Q/Qb8Nj5MWjxIxltWKx
	AJrTWEXW8RqP5Rcp9KDnO7htrpZueSdjSVkKBGiSuMKMQ7xUYK3wvLI9czTfHKE5JxWGde
	YMHrhtexl1gbZJsC3EO2fxyHLSnx9rk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-9QbquKMOOPK_vyNsDKDdBw-1; Mon, 15 Dec 2025 01:41:55 -0500
X-MC-Unique: 9QbquKMOOPK_vyNsDKDdBw-1
X-Mimecast-MFC-AGG-ID: 9QbquKMOOPK_vyNsDKDdBw_1765780915
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so20371395ad.2
        for <virtualization@lists.linux.dev>; Sun, 14 Dec 2025 22:41:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765780915; x=1766385715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b13OnUYDcLnPc+T52EwC1q4bWFFgtcvxl6ViyNRPTbI=;
        b=W8EUTZcxhZg2Sj0oSUXHy2W6Zrxe61IjaDeyYPDuFQERHApx68PLHfzjYAty4bTqZq
         7m2w0HFeIVlXcsZjfDow9sFAQiNKgTcDh57JtH0wuaNYRjTU2IDKtKuK3WoREWBoMOM8
         3ZgWCIU4J6kQFn0YpFRRY76S8xoyXh+1TNNTc1rhWAPvxsOg7GiB12rOqjcvXTxiqEha
         HhKVu50adF8k9D3xfN6yz0W/5kL18dUpzMIZfmQwuy/p8iOYmKUvflWl6RKIvH15qRJq
         NyK/B5V4a4h8vpQiYW0v2coHI0nZMJusR1EDQZY9PtdU5f8L18X32i+lcAS0nS8bhEtW
         LWWA==
X-Forwarded-Encrypted: i=1; AJvYcCVH6D9SUGwgKCFs+JLyJ/qqrcAWPW6QOvitatNRnENCqGdxuW/9k63zCa+y8FXRWSaSVdO5yb58W39D0MIsFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKJuw59ejx6n8Pp31IpB0IJhbyaXs8QW2Jt9hQD/r4M4KeWcN+
	QhUg2Vz053fTyPBurZ+qD578xMe3p90VSYw6GlpP+mVZesPsQ5lEPsyQPhtiV4ls8yP/OEM/gbQ
	xUfrfyqWQHHh+wnAkybO6GKSLi1pxcXWlS6tnZbkq6SaweAW4xrduJfO+BWXx2ZGtAyVdPAl7dk
	swxzSnTQXG3CV8Srb0F4CIKylTsi1zqrHPSgBMRAoOCao=
X-Gm-Gg: AY/fxX40oLIRI/qnH/wua3BN3v5rJrrEf8bRjLeU7cfFgu4ngKytre7Yh4zws2O2Uqj
	+TlD5rG3r4PdngWNGRZju29Yko9HrrjzIpQnfYEgw6HnXjrs5p3Ym5lCvQ7F/Z5N4bmJeg7KbzU
	wN9F/6UtdX8il248BW+a5CDipoQqX6quc4RceNCahJgga5OBUgbmZM5KLbCR49pGouDiM=
X-Received: by 2002:a05:6a20:7350:b0:366:14ac:e1df with SMTP id adf61e73a8af0-369b05bee25mr10718442637.69.1765780914654;
        Sun, 14 Dec 2025 22:41:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmCVbqM2oRpypIW3Na/iJKSRukQNFptPvN3ajHBw/3EYsohzEaN1b7r+jHyaklUQnS3BFawAPfFocl+ylPrYQ=
X-Received: by 2002:a05:6a20:7350:b0:366:14ac:e1df with SMTP id
 adf61e73a8af0-369b05bee25mr10718417637.69.1765780914143; Sun, 14 Dec 2025
 22:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251127032407.33475-1-lange_tang@163.com> <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com> <CACGkMEt-v2RGTbzEgfocpZvZw1SKB8j4MQ6zoMFvGJQXXFuMtQ@mail.gmail.com>
 <64d63e98.e7f.19b1595bd4e.Coremail.lange_tang@163.com>
In-Reply-To: <64d63e98.e7f.19b1595bd4e.Coremail.lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Dec 2025 14:41:42 +0800
X-Gm-Features: AQt7F2r3wElRUH0jxp_Gu-tRozuUPlsSFkFR9RUKVpEm5QYJvjREgC80zVYl2y0
Message-ID: <CACGkMEvZQb1ADyEM73jE8_OdeU8YtSbR8YCJ+3anDg8VhkpBLg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
To: Lange Tang <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Tang Longjun <tanglongjun@kylinos.cn>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: esSLMYhf0B5XfsLQzGy890KimSpIipMLd1HDTJB-0zM_1765780915
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 13, 2025 at 10:41=E2=80=AFAM Lange Tang <lange_tang@163.com> wr=
ote:
>
> At 2025-12-11 16:32:15, "Jason Wang" <jasowang@redhat.com> wrote:
> >On Thu, Dec 11, 2025 at 10:52=E2=80=AFAM Lange Tang <lange_tang@163.com>=
 wrote:
> >>
> >> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >> >>
> >> >> hi,
> >> >> virtnet_mon is used to monitor the data packets of the virtio_net d=
river
> >> >> and the related parameters of virtqueue, useful for tracking its st=
atus
> >> >> and troubleshooting faults.
> >> >>
> >> >> pls review. tks
> >> >>
> >> >> Best regard.
> >> >
> >> >what does this achieve that direct use of tracing would not?
> >>
> >> I apologize that my explanation of virtnet_mon was not detailed enough=
.
> >> virtnet_mon uses kprobe and buffers to monitor virtio_net.
> >> To monitor virtio_net, it is necessary to track the member parameters =
of the virtqueue corresponding to each data packet and output them.
> >> When PPS very high, other tracing techniques, such as ebpf, may not be=
 able to handle it, resulting in data loss because they do not have suffici=
ently large buffers to batch export log data.
> >
> >Can you expand more about this? For example, in which kind of setup
> >and what do you want to trace and why ebpf can't handle that. Note
> >that the most lightweight stuff is the counter, have you tried that?
>
> For example, when there is occasional latency in data transmission betwee=
n the
> virtual network frontend (virtio_net) and backend (such as vhost_net),
> we may need to track the time taken for each packet received and sent in =
the virtio_net driver.
> Typically, we accomplish this using eBPF, such as bpftrace. The pseudocod=
e might include the following:
> """
> kprobe:skb_recv_done {
>         printf("%ld skb_recv_done Cpu:%d ...\n",...);
> }
> kprobe:skb_xmit_done {
>         printf("%ld skb_xmit_done Cpu:%d ...\n",...);
> }
> kprobe:virtnet_poll {
>         printf("%ld virtnet_poll Cpu:%d budget:%d ...\n",...);
> }
> kprobe:start_xmit {
>   ...
>   printf("%ld start_xmit Cpu:%d type:%s seq:%ld ...\n",...)
> }
> kprobe:gro_receive_skb {
>   ...
>   printf("%ld gro_receive_skb Cpu:%d type:%s seq:%ld ...\n",...)
> }
> kprobe:receive_buf {
>   ...
>   printf("%ld receive_buf Cpu:%d name:%s avali_idx:%d used_idx:%d ...\n",=
...);
> }
> """
> Using the above bpftrace code, we can track the timestamps of the data as=
 it passes through these functions,
> along with skb and virtqueue information, and output logs via printf for =
further diagnosis of the causes of the latency.
> Interestingly, a significant amount of logs were found to be missing when=
 executing these bpftrace codes.
> Below is the testing environment:
> VM: 8G8C=EF=BC=8Cvirtio_net mq=3D4, kernel 6.18-rc7, iperf3 -s -p 1314
> HOST: iperf3 -c 192.168.122.218 -t 100 -p 1314 -P 4
> It was also found that when testing with mq=3D1, there was no log loss.
>
> Compared to mq=3D1, the reason for log loss at mq=3D4 is suspected to be =
due to data being sent or received
> by different CPUs. Additionally, under the 4-thread iperf testing scenari=
o with PPS > 150,000,
> the log data is asynchronously output from different CPUs, leading to exc=
essive IO pressure that causes log data loss.

I think what I don't understand is how the things you introduced here
may help in this case?

Thanks

>
> The above are some of my personal thoughts, and I would love to hear your=
 opinion.
> Best regard.
>
> >
> >>
> >> As for the duplicate code, it is only to obtain the layout of the rele=
vant structure, and I have not yet thought of a way to avoid duplication. I=
 would love to hear your suggestions.
> >
> >Thanks
> >
> >>
> >> >
> >> >> Tang Longjun (7):
> >> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
> >> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_d=
one
> >> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >> >>
> >> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >> >>  tools/virtio/virtnet_mon/README        |   35 +
> >> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 ++++++++++++++++++++=
++++
> >> >>  3 files changed, 1093 insertions(+)
> >> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >> >>
> >> >> --
> >> >> 2.43.0

