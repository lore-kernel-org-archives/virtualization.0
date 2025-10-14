Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162E305E37
	for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760409694; cv=none; b=TxDnqxl8bGQfUFVZPvKj5egLUqem44mAKjUWFk5cB0TQ7S03IY5nnM8/vaMfiU96Ejspv48ygM4VWAAoEHNoFOBEUxjHhTxPoYe1PcO9lrHo6Wrwz2DKO8yO+YhyB2lTuNNAvfk73wieALQcwopgVtl3oJM4duD0PIrKWwuOaHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760409694; c=relaxed/simple;
	bh=FesAsJKYMIp69r5jNUmgk2+yCV5fpSg+id8ZUd4wHRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGBRghPpSEJLQWuf6rFgGPf7fh3G6Or7hla5byKekVuZFl9hBpp5QhWJUsn3IpeouaUDfXuHtFPjyJ3kaXKUVi+HuC403BZfLVPEk5v8titbWL6H/sXyugNyD52lqZdECCEFTt5mGncLhq33zRmjl+iRlY6E3FGbMDo9aQQXSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f27ua9fB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f27ua9fB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760409690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bEHVj37748wlo1Rr9T+KOAhMaCHHGe0IX7mzFNTp1RY=;
	b=f27ua9fBFiufFU5vkX4FTGMFiUaRdJQpT9qcXAY8LCHevP8x7vxOPfYqHVbh6hkTEP4cTR
	vkhPOEzgQeEcrPxHQRHGO8K21BCUBvzxdJqAw1IpJq2jdHa9gCrr8WbPaRFWHtlU2UYIOT
	uQw6VMhP4r/L0Y9+tXhjSwN0c51oIRc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-8tZUpronPOyEXz2bKhu0Qw-1; Mon, 13 Oct 2025 22:41:28 -0400
X-MC-Unique: 8tZUpronPOyEXz2bKhu0Qw-1
X-Mimecast-MFC-AGG-ID: 8tZUpronPOyEXz2bKhu0Qw_1760409688
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-334b0876195so10823053a91.1
        for <virtualization@lists.linux.dev>; Mon, 13 Oct 2025 19:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760409687; x=1761014487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEHVj37748wlo1Rr9T+KOAhMaCHHGe0IX7mzFNTp1RY=;
        b=TsxQeMdreyc9oVUGdbCxl3UU3MeeuOrC3Rv647SPuCud3GSTaHK8OGkkxH3Qday/qV
         RvZRNuMQV6m3gF0Fpxoq6q9paotJh9FyGxnuT9EDBBtjKN61+VJr3gDdjazsatuD8snd
         zFYphibORGsMbaifqC7ARPN+RlcoJjfZwAhAdxo1hc/K2x2yPnndRheIfmykK1WbVQ6g
         TvM9S2iQIIX9KoeRjL0hnJeRHe7ZxV5syJirnehXZZr5q8cloo/9sNosJ+I0bDShzVen
         wpD8TuNy1ZekGbu7hbOk8ckf9JmfXrF6Onk/HnxRAHbrngW1pN1Wfs9pArrFm6ACKvqy
         eF/A==
X-Forwarded-Encrypted: i=1; AJvYcCV5mw+sentCvBPtFqg731clUM63/n+WMpKtNjwLJ/Q4TP6yAGNuQ9xTfbyfiiwde6ZPGeP5TAAjUjzJTJEPaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGHX9YcEztMNK3C7sULKKYPF3MQ3pXB0KpTS7FT8+7iIg2i81O
	PMDmavdO7yWfPmlrLaRfJDSOm0ubv/2XwAyo3K/JYONH3q1HKR7/88fJb+0qKqH4jnDva9JLmha
	wuZV8ceSk6pxLVGM9OTbHUjJx/offtki2HXY7PF+MCW1XLsIn2qmDuZ0/OQ7YBb7LfFjjHgbO3Y
	N17b6jMMc7l0ays+yhODicXHnMkE8GsCQKE9tOSth1mPPTglbxMLjJUQjs
X-Gm-Gg: ASbGncscljM08s8L80E+3efc+T9CI5B6C0TyW7C9DROhXJo2Nv+2sxIurIBIyZaC1az
	rzUc4HBBq91bqZOKhZ7duekJXzNUCk0aWz8ypGfp/FGsGiOUe7JyX8OPnUDOmh0pksv0cXxrWza
	Hx+1wtWeX90xZ5Z4viGA==
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-33b513b4be4mr27494960a91.36.1760409687337;
        Mon, 13 Oct 2025 19:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVyXKijoZhCbhaM1uVxKyL4j+fxECZx9zvv301QvM9TvPOtRuf953kdpJIsVLBO4PqCK6k5TW9iqdaCuQsZ14=
X-Received: by 2002:a17:90b:4d8c:b0:32e:9da9:3e60 with SMTP id
 98e67ed59e1d1-33b513b4be4mr27494937a91.36.1760409686869; Mon, 13 Oct 2025
 19:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com> <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com> <20251013040810-mutt-send-email-mst@kernel.org>
 <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
In-Reply-To: <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Oct 2025 10:41:15 +0800
X-Gm-Features: AS18NWA4EsxWvwBl_demfRui_W5z61fQiTX7YBDfYDzXzEmfq6AzT5KekgTc338
Message-ID: <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in vring_map_one_sg
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZpKBYMPFZ_8axzmYYoH437tXUJXX87_T-HwRW_QKKVs_1760409688
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 4:17=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
> > On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
> >> On 10/13/25 9:20 AM, Jason Wang wrote:
> >>> On Mon, Oct 13, 2025 at 1:29=E2=80=AFPM Jason Wang <jasowang@redhat.c=
om> wrote:
> >>>> On Sat, Oct 11, 2025 at 3:40=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> >>>>>
> >>>>> #syz test
> >>>>>
> >>>>> On Sat, Oct 11, 2025 at 4:38=E2=80=AFAM syzbot
> >>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
> >>>>
> >>>> Paolo, it looks like the GSO tunnel features will leave uninitialize=
d
> >>>> vnet header field which trigger KMSAN warning.
> >>>>
> >>>> Please have a look at the patch (which has been tested by syzbot) or
> >>>> propose another one.
> >>>
> >>> Forget the attachment.
> >>
> >> I have a few questions. The report mentions both UaF and uninit; the
> >> patch addresses "just" the uninit access. It's not clear to me if and
> >> how the UaF is addressed, and why/if it's related to the uninit access=
.
> >
> > I'd like to understand that, too.
>
> Somewhat related: the syzbot dashboard reports that the issue is no more
> reproducible on plain Linus' tree:
>
> https://syzkaller.appspot.com/bug?extid=3Dac856b8b866cca41352c

Interesting.

>
> """
> * repros no longer work on HEAD.
> """
>
> Possibly there was some external problem?

I think at least we need to make sure no information as we did in
virtio_net_hdr_from_skb():

static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
                                          struct virtio_net_hdr *hdr,
                                          bool little_endian,
                                          bool has_data_valid,
                                          int vlan_hlen)
{
        memset(hdr, 0, sizeof(*hdr));   /* no info leak */

Thanks

>
> /P
>
>

