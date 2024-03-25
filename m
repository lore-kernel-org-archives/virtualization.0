Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EFF17D243
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711350411; cv=none; b=nifpFsj/5QKWRGcqgE6aNMToZnf/IAVcmnjSW3jSPMliXz1rfzIHpIEUj60QyIMqeUaPZVd5sU+7+IO+60aTU3S+YoDmf24Vb+Hr33xdkueu9VuaebbXVNeMIaItEzvt8QmhIEYK+ns5XG8utPbMWb3ziLX2iKhP+V4OoQ/mjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711350411; c=relaxed/simple;
	bh=4+T6Fw5kJ5qTnZFBUHaK+QAVtrjjtAgBCLgSidabXqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sz00iZD15UOmvRg/hkAcU8H3n2b2ahctqePm3XiHrLDFvm+D58kdNOBCBfCiuO4Hz5PpDhcvabgb+8OC0EQHF/n/lRIFnZ6zo5CBQyE6P2ZVBvX9KgPm0K4NvoyfkAMA+w06dUiFG20jEdGAzw+CnGXNIaF37DEOHQmn98dAPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibw12/ze; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibw12/ze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711350408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=51pQDyFxYaSVn69uXtRlpc0U/V2gUslEK629TuIAH7k=;
	b=Ibw12/zeg9cvG6aamA6Agpp1TgNdyOE5HMe0rak/3Ps8XOc2vOX6zH/S5NQgPg7DqQMB9a
	399wO6G0uktzC2cpHVtGS83Dn03n6zbez0bOAgJb7M5oMrv+6o54Tysxd0S/zCkSvcN1cx
	ANm+nah7afIQdfrTWHF1Qnkc80XcIvI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-ivd7fy9yPIiaxdRsthW_xw-1; Mon, 25 Mar 2024 03:06:44 -0400
X-MC-Unique: ivd7fy9yPIiaxdRsthW_xw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6e73833c7f6so2462036b3a.3
        for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 00:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711350403; x=1711955203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51pQDyFxYaSVn69uXtRlpc0U/V2gUslEK629TuIAH7k=;
        b=aOkK1O8JLJ6fISb2sTPCqnw3BA5WlvsP3tJ4CkeoKY3ypR1hDN9IRnTAEEvZzqzXeK
         IV/wsXXR1ca2SQO+u+uCDsJJStoiavve9AF+fWO1HUT9zL0XGaKjXYJlMQcQfgc0sIbm
         tKCmSt/KBsCBtNN0GohGtWq00VpHNhkSA+n/ZM+qCOU2jyAzB783ZnsxLSN8JjIlKvc8
         5ANvDz1oxpThdKT7X/WS3ec51tKeMHM0lbSbnJ3mX59ZiDD3Pdw9Ecwkg+t0zvNeZSuc
         a+XqnTUC9zUpZ3nW3M3eOeSXAFkYkEECnpFb+CiXvO1eOJ4yKwhrj4c7WSTPYEmbU98V
         N9uw==
X-Forwarded-Encrypted: i=1; AJvYcCWvpnxGa7T611hjlCmKPsEoszFEoN5NyAVWbsITPY92SmiceCJscsb6Bs9zb8DaLubRSA+D6p/THWMbIQUYy9+iZANq9l9hg5J0sM72HbI=
X-Gm-Message-State: AOJu0YwTIIjmRxk1vAqanNYjbrQGyFz7m/x44GGSa5iFO2GfT4lY5dI7
	dfTaHUEceZlbU6C77ZazN5YEZHtFOiNNEbNjQdCmVFDx/cH9OTFFu7mr9XNXhqS+0n2X7uJUv77
	i4uY/dmnskPWECv4A1EvqiI8HW5CJ7T3bvWPtndG3hnhL+FrpB5M6QnK+o0QRqTuPPsSR65Eedo
	1DA72aF3mqqwRPMUUIX5JAvd05Ozn7veQCmtSeUQ4=
X-Received: by 2002:a05:6a21:a598:b0:1a3:af03:6b0 with SMTP id gd24-20020a056a21a59800b001a3af0306b0mr6698294pzc.7.1711350403209;
        Mon, 25 Mar 2024 00:06:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFt9XnVzAoDIuJWXHyslSXREhmiNfJ/P4OyG0+MvlUUa2SquZgoSA0VrhWpgpDf9mkq3QLzLWYQuBbJcNzJYw=
X-Received: by 2002:a05:6a21:a598:b0:1a3:af03:6b0 with SMTP id
 gd24-20020a056a21a59800b001a3af0306b0mr6698280pzc.7.1711350402928; Mon, 25
 Mar 2024 00:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
 <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com> <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
 <8f1a722e-a16d-4c17-a5bd-face60b4cf4d@linux.alibaba.com>
In-Reply-To: <8f1a722e-a16d-4c17-a5bd-face60b4cf4d@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 15:06:31 +0800
Message-ID: <CACGkMEs0K1YE3vBYht4LTsuF8_RUvZ0ZtBB3DUDQyujsB08JjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:58=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/3/25 =E4=B8=8B=E5=8D=882:29, Jason Wang =E5=86=99=E9=81=93=
:
> > On Mon, Mar 25, 2024 at 10:11=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.=
com> wrote:
> >>
> >>
> >> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:17, Jason Wang =E5=86=99=E9=81=
=93:
> >>> On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba=
.com> wrote:
> >>>> When the dim worker is scheduled, if it fails to acquire the lock,
> >>>> dim may not be able to return to the working state later.
> >>>>
> >>>> For example, the following single queue scenario:
> >>>>     1. The dim worker of rxq0 is scheduled, and the dim status is
> >>>>        changed to DIM_APPLY_NEW_PROFILE;
> >>>>     2. The ethtool command is holding rtnl lock;
> >>>>     3. Since the rtnl lock is already held, virtnet_rx_dim_work fail=
s
> >>>>        to acquire the lock and exits;
> >>>>
> >>>> Then, even if net_dim is invoked again, it cannot work because the
> >>>> state is not restored to DIM_START_MEASURE.
> >>>>
> >>>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> >>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >>>> ---
> >>>>    drivers/net/virtio_net.c | 4 +++-
> >>>>    1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>> index c22d111..0ebe322 100644
> >>>> --- a/drivers/net/virtio_net.c
> >>>> +++ b/drivers/net/virtio_net.c
> >>>> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_s=
truct *work)
> >>>>           struct dim_cq_moder update_moder;
> >>>>           int i, qnum, err;
> >>>>
> >>>> -       if (!rtnl_trylock())
> >>>> +       if (!rtnl_trylock()) {
> >>>> +               schedule_work(&dim->work);
> >>>>                   return;
> >>>> +       }
> >>> Patch looks fine but I wonder if a delayed schedule is better.
> >> The work in net_dim() core layer uses non-delayed-work, and the two
> >> cannot be mixed.
> > Well, I think we need first to figure out if delayed work is better her=
e.
>
> I tested a VM with 16 NICs, 128 queues per NIC (2kq total). With dim
> enabled on all queues,
> there are many opportunities for contention for rtnl lock, and this
> patch introduces no visible hotspots.
> The dim performance is also stable. So I think there doesn't seem to be
> a strong motivation right now.

That's fine, let's add them to the changelog.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Thanks,
> Heng
>
> >
> > Switching to use delayed work for dim seems not hard anyhow.
> >
> > Thanks
> >
> >> Thanks,
> >> Heng
> >>
> >>> Thanks
> >>>
> >>>>           /* Each rxq's work is queued by "net_dim()->schedule_work(=
)"
> >>>>            * in response to NAPI traffic changes. Note that dim->pro=
file_ix
> >>>> --
> >>>> 1.8.3.1
> >>>>
>

