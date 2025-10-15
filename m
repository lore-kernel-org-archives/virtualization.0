Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB513C8EA
	for <virtualization@lists.linux.dev>; Wed, 15 Oct 2025 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760508554; cv=none; b=nFSWxoCcvt5hRGsIqX4KAoWjygqJXOjvT9fiwflanLYSLjHf9uzG8ZNeqVONAfrSa0fOL5B/3yXMqvupWOTaoL1XWMiKhDREJD3sZksdCmMhKFBZxaZJKJo96PDv3Aozi6ZwceOdTZUSAiOXkmJBDjf13esGzu/IB46iXgPPAWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760508554; c=relaxed/simple;
	bh=7yHb7V7FxR4Anis0rw9S3yBVPwoAcym+T5NuHmX3i+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKN2Y03ywWM6NHyglmZPYRew2rUmr6u3Pyn+ltptyMUSDejWUzvk/OUTvpPgl5Rg8fyZDfgu1bZnQen1EUdRViln9Co40BbQSzn+yIrO7JQYXeGk7Kn2wJBxjAqKEXJhu1c0Fr50Hb3nSCrW5pIX8pLH0/py/MAgLwzVmh/SeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfgb7eu9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfgb7eu9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760508551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBi3qvybR9EFvEz+7rVsJKcgMhvZptbfiLDD5q6qnlg=;
	b=gfgb7eu9HMF5nLKi4ppo/cdpBgSKc1ibUwNqAHFFnAVty8fmMrhy8np9VT1dBvGvbWIPlp
	A8+FSNCDSgci3WsrQ2NuEKMUt4Saf9iaX+B67F4P3H5++0zai5w9068n248cLBcg7Zi2lp
	wOKXeaHMln8OBwKCh4ULkeZ4oig4CF8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-QDClZl9NOQOj0oPvWq5CUw-1; Wed, 15 Oct 2025 02:09:10 -0400
X-MC-Unique: QDClZl9NOQOj0oPvWq5CUw-1
X-Mimecast-MFC-AGG-ID: QDClZl9NOQOj0oPvWq5CUw_1760508549
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-780d2956a2fso123989387b3.0
        for <virtualization@lists.linux.dev>; Tue, 14 Oct 2025 23:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760508549; x=1761113349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBi3qvybR9EFvEz+7rVsJKcgMhvZptbfiLDD5q6qnlg=;
        b=vKwzttK+4npV+p6w1USl9LIWcQ/RuJHsQkacRJjVnFSwtACHthv410TNmTI8pcHtaL
         aYM23rNaHGBXjnu1dddi2GYc419rc/vl1wayawZ6xzhyOBsEIxzTXcGuWvdgmSiAkdob
         4Tn3iqssQDR8hx81W/1+cPRvVxGQAGoRCa2/Yi0lWcet+YF+50a8KAHYpuh8XDeeRCNT
         ubik/sVIKsblSZ9ZUiMClWo4IAoXG6MBjfbdvSxs8y8RQ2qXTiM5JomOHDCYsefxXx3Z
         BHmBxTDu1q7wmgAIwZ0ORwqCJVM4r1SJ+SBvaOQ+siGkYxqrE9yRXK+c4ZNk+dQSiy9j
         28EA==
X-Forwarded-Encrypted: i=1; AJvYcCXGej7UCa41wuDQBEM985KXXpcTIDWudZKehmlCg+c3/CtqrVlMfGcsN4s9mPmpq0vTVltGcEsG70LaYlnE4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzw8EEamm3JgGcg4qbFRz+CES24+SLM9lRqvgKau1CvncvMKCKH
	yMRjtjt/kpKE49Ili3eZ4w1X7sDU92DScEahlNhgNSCZUJAP12Vfi8bKLvnz3//ZQyk9wdmmMIP
	3sWcyfE3pJj9b1bIF9v7eLpWf3KvVmx2Zka2ria8JK+ZJB2ILp0U3FRQJtCIOe3isyefqv5ASDd
	vRyzH0J4TxzWY4ADt0yOjlRoo579i7NOVt5DhSUz9+z7Q=
X-Gm-Gg: ASbGncsUJ7cC9aHVdv/V4hZbhi7uZ0l4Ez3Rc7fih3GvA8wk3c99oFooQUmRnUUOBy+
	msvPjkLoJbIPb4BnxkbJ02Gt3kWgJBrgeBZys09IKZsT26+KOR6pBV/9B0rBToHiTmObmQ+A6Q3
	mE+EMvtY4ym9Hsp6SmFKhZ6Y6BlkWoXkc4DoUqeaKZltUx/IsvqpXqOc6f86S7SNQv67ieqrBON
	72xk8Ix
X-Received: by 2002:a53:8650:0:b0:604:3849:9bd1 with SMTP id 956f58d0204a3-63ccb851a6cmr18577926d50.17.1760508549360;
        Tue, 14 Oct 2025 23:09:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7NrkJrmsbjMLLIbQGJdNBHE3ddxwQ7lrfGtO7MVJtAW5Fm9WJ0LeQC7cXH02MDz8p0wTJ+RfvcMHcPMLKJOI=
X-Received: by 2002:a53:8650:0:b0:604:3849:9bd1 with SMTP id
 956f58d0204a3-63ccb851a6cmr18577914d50.17.1760508548996; Tue, 14 Oct 2025
 23:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251007130622.144762-1-eperezma@redhat.com> <20251007130622.144762-2-eperezma@redhat.com>
 <20251014042459-mutt-send-email-mst@kernel.org> <CAO55cszGtuqL9qfs8SVB=Jjghefn=M0Rjw65f2DGPrjLQFFtqg@mail.gmail.com>
 <20251014051537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251014051537-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 15 Oct 2025 08:08:31 +0200
X-Gm-Features: AS18NWAssLwaCeDys0qGLVAgspxlbGwh6Vs-twVmCChXDZBs4fMs1s_gyf1-be0
Message-ID: <CAJaqyWe-mn4e+1egNCH+R1x4R7DB6U1SZ-mRAXYPTtA27hKCVA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-KGXe-Xe5OEaU-u9UqBK3pTzvqgM2FGI1Inx2yoXN0_1760508549
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 11:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Oct 14, 2025 at 11:14:40AM +0200, Maxime Coquelin wrote:
> > On Tue, Oct 14, 2025 at 10:29=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Tue, Oct 07, 2025 at 03:06:21PM +0200, Eugenio P=C3=A9rez wrote:
> > > > An userland device implemented through VDUSE could take rtnl foreve=
r if
> > > > the virtio-net driver is running on top of virtio_vdpa.  Let's brea=
k the
> > > > device if it does not return the buffer in a longer-than-assumible
> > > > timeout.
> > >
> > > So now I can't debug qemu with gdb because guest dies :(
> > > Let's not break valid use-cases please.
> > >
> > >
> > > Instead, solve it in vduse, probably by handling cvq within
> > > kernel.
> >
> > Would a shadow control virtqueue implementation in the VDUSE driver wor=
k?
> > It would ack systematically messages sent by the Virtio-net driver,
> > and so assume the userspace application will Ack them.
> >
> > When the userspace application handles the message, if the handling fai=
ls,
> > it somehow marks the device as broken?
> >
> > Thanks,
> > Maxime
>
> Yes but it's a bit more convoluted  than just acking them.
> Once you use the buffer you can get another one and so on
> with no limit.
> One fix is to actually maintain device state in the
> kernel, update it, and then notify userspace.
>

I thought of implementing this approach at first, but it has two drawbacks.

The first one: it's racy. Let's say the driver updates the MAC filter,
VDUSE timeout occurs, the guest receives the fail, and then the device
replies with an OK. There is no way for the device or VDUSE to update
the driver.

The second one, what to do when the VDUSE cvq runs out of descriptors?
While the driver has its descriptor returned with VIRTIO_NET_ERR, the
VDUSE CVQ has the descriptor available. If this process repeats to
make available all of the VDUSE CVQ descriptors, how can we proceed?

I think both of them can be solved with the DEVICE_NEEDS_RESET status
bit, but it is not implemented in the drivers at this moment.

