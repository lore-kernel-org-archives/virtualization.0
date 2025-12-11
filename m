Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253D2EA73D
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765441955; cv=none; b=jeo58Nv6JmDCvgkB91P5gTH3SpDNEUkcK4XnMXt0pjyEHJhXM0vvM2BYTu3fxppF1S3iVB4IF3zohWetu0quopxfFh7ppiVWqxQ0+sCrvsQNBdhkV62IuVjF/NS1FZWJgmW88Y4v96zvE1C0s7o4Ma781NCE32utrY2VeNYKmLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765441955; c=relaxed/simple;
	bh=MzxGiKLwLX3w8tRIQMUZgvvJ2D2beA3de8tMnDOTW7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pdt1wV4JsAVAM1JVUngpEm3vHtgOHG/UO66RuW2WqHM6RjrYIizsyjWeysc9uZJBMqVkeQGTd5YwRhyhIueu9DDt0qnEwkLZINFCAzGoT2JhNUxQ5wJ+ty8SHc/FGTQGaU6pgDn/69BydO1o0LtL+oD2IuY6Bu5PoYfsCxryZ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtGmyz7D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtGmyz7D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765441952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Cej51WvVG4ms62QA5FaivyIuAcuoDHQe6pwvNAWks=;
	b=PtGmyz7DwUu/h6jSlTNScKoL3l9F0zUQr2UBQpwiIp5pVCLMlp+DCVH3S8nir9vWhgRRJE
	cJXBdIalSgZuUhbksTnsBJLk+BgGwaPm4bcOmpPhXsKI8BkybWaYCJU3PDS4+wv+NmphBQ
	VYGQHZCWWfqKbbciNj5iNO6zP0XcQRI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-pPPtyXXHMHK1wAgPpQCTtg-1; Thu, 11 Dec 2025 03:32:31 -0500
X-MC-Unique: pPPtyXXHMHK1wAgPpQCTtg-1
X-Mimecast-MFC-AGG-ID: pPPtyXXHMHK1wAgPpQCTtg_1765441950
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3436d81a532so1490707a91.3
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 00:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765441949; x=1766046749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p7Cej51WvVG4ms62QA5FaivyIuAcuoDHQe6pwvNAWks=;
        b=Zpfgt3bnbeEArvz1qydYu+Rc5HWYqbJcVEiiKDO1HPRpgfsfa0CuwbEn7S0coUlR7z
         JDkCJFXuRYjpZ03GWyJMMT6L9DEkYhN+opj/+jpx8+OUvKioHkH/iiK5Hh7i4FQRhYXD
         i0Cr3c3xG1Chc37fJ/f0Owc24iXZOvPfzMOIya7QgTPf9lPs1xvcs8wRUpdzXghYX76H
         LVZrw4+8/sn1nIKDF6cwHjhpxDYuzQe3bUHXYhG0/fmabshIgHcVius8gMiZpgg9StlO
         7yXJK4czjG0zm61zTvlblQyYG3Sxtv1wzdC6eY4IcmMj+s1opVyJYPWbHD12j53wOqhU
         MKJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmtuRNxly0D47stLgjwxH2xXd2vymhVrrqhbntbQfhPmOd0LTWwlI/5WS+A7rXNcCFbANKnqhkEdyYIuUhBA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4rfGv4UoR6gJ3dhNQqHb38b2NaW5t/gpbLHdCNT0LA5NBw/eU
	BPujWYGxnfbUsxE+CEXyZJPmvzOSjwz741k1gjJYEnUd7VDtd6/ZJiMYQo9/iJbdAVnqXusdHwb
	RgHuWPZVblLToWRrLa7oTc5RhR0aRcR88BY6CNtXzQPLr8DrhnOVqY8XgD0CUoyhFf/tuf7Vm7q
	YSM8AqRKLeI16Z/GBuvFZEcIiQy11jYrlEe+yY4iP+Gj1Y/U3ozxVqUg==
X-Gm-Gg: AY/fxX5XJ+04jWh92GYuCkrRb3SjBRyqW44u3dyhULDWfu/JIqlinlD6copX9lyr0NF
	mo9Fi343JtER6FLVag3bUJwwLZ1kK5cTcr6C/4NNvf3uXO0blfwF2+fz70HfvaQXvAG37W2VXNq
	SO1XYYWu0FkTA+og1ex8jrGrBUJa0LgUz58niAVS0UdfXD5/6+pVBrDolrclghpGM=
X-Received: by 2002:a17:90b:33c4:b0:349:8116:a2d9 with SMTP id 98e67ed59e1d1-34a72837a13mr5228591a91.19.1765441949527;
        Thu, 11 Dec 2025 00:32:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoFh0uGrwEe+0AlGbTksLtxnw+/4F4kFenTIj5GTrgRToyzKiS6hnwjhyPAHjC5MpLp6r7fBsehgEiHAR/ERs=
X-Received: by 2002:a17:90b:33c4:b0:349:8116:a2d9 with SMTP id
 98e67ed59e1d1-34a72837a13mr5228578a91.19.1765441949116; Thu, 11 Dec 2025
 00:32:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251127032407.33475-1-lange_tang@163.com> <20251210040328-mutt-send-email-mst@kernel.org>
 <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
In-Reply-To: <4820b08f.2d13.19b0b523dcb.Coremail.lange_tang@163.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Dec 2025 16:32:15 +0800
X-Gm-Features: AQt7F2o-RcbdtnQEkgq0YqMsr7M-J-Zr9Y8WKusEVuc8ipZr1R_3IkHQ2McQ8-c
Message-ID: <CACGkMEt-v2RGTbzEgfocpZvZw1SKB8j4MQ6zoMFvGJQXXFuMtQ@mail.gmail.com>
Subject: Re: Re: [PATCH v1 0/7] introduce virtnet_mon for monitor virtio_net
To: Lange Tang <lange_tang@163.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Tang Longjun <tanglongjun@kylinos.cn>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V9yXZZPukiNnfVaTCryR45A3QUX1uWeOuT1YuNaeu3s_1765441950
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 10:52=E2=80=AFAM Lange Tang <lange_tang@163.com> wr=
ote:
>
> At 2025-12-10 17:04:04, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >On Thu, Nov 27, 2025 at 11:24:00AM +0800, Longjun Tang wrote:
> >> From: Tang Longjun <tanglongjun@kylinos.cn>
> >>
> >> hi,
> >> virtnet_mon is used to monitor the data packets of the virtio_net driv=
er
> >> and the related parameters of virtqueue, useful for tracking its statu=
s
> >> and troubleshooting faults.
> >>
> >> pls review. tks
> >>
> >> Best regard.
> >
> >what does this achieve that direct use of tracing would not?
>
> I apologize that my explanation of virtnet_mon was not detailed enough.
> virtnet_mon uses kprobe and buffers to monitor virtio_net.
> To monitor virtio_net, it is necessary to track the member parameters of =
the virtqueue corresponding to each data packet and output them.
> When PPS very high, other tracing techniques, such as ebpf, may not be ab=
le to handle it, resulting in data loss because they do not have sufficient=
ly large buffers to batch export log data.

Can you expand more about this? For example, in which kind of setup
and what do you want to trace and why ebpf can't handle that. Note
that the most lightweight stuff is the counter, have you tried that?

>
> As for the duplicate code, it is only to obtain the layout of the relevan=
t structure, and I have not yet thought of a way to avoid duplication. I wo=
uld love to hear your suggestions.

Thanks

>
> >
> >> Tang Longjun (7):
> >>   tools/virtio/virtnet_mon: create misc driver for virtnet_mon
> >>   tools/virtio/virtnet_mon: add kfifo to virtnet_mon
> >>   tools/virtio/virtnet_mon: add kprobe start_xmit
> >>   tools/virtio/virtnet_mon: add kprobe gro_receive_skb
> >>   tools/virtio/virtnet_mon: add kprobe ip_local_deliver
> >>   tools/virtio/virtnet_mon: add kprobe skb_xmit_done and skb_recv_done
> >>   tools/virtio/virtnet_mon: add README file for virtnet_moin
> >>
> >>  tools/virtio/virtnet_mon/Makefile      |   10 +
> >>  tools/virtio/virtnet_mon/README        |   35 +
> >>  tools/virtio/virtnet_mon/virtnet_mon.c | 1048 +++++++++++++++++++++++=
+
> >>  3 files changed, 1093 insertions(+)
> >>  create mode 100644 tools/virtio/virtnet_mon/Makefile
> >>  create mode 100644 tools/virtio/virtnet_mon/README
> >>  create mode 100644 tools/virtio/virtnet_mon/virtnet_mon.c
> >>
> >> --
> >> 2.43.0

