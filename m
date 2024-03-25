Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C2F156F22
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 06:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348186; cv=none; b=XOrCM7tLdidNyHD1WxZ7kzNWwxJIaL2AJvThHX+C5uoguIC6D+x1dvUQ8adceLjX09+o/06EHIxgO/ZDZkANNk+m63m+e7Vg8NAcRL4UDKOBL5JiEmyks2ZMKxjZIfCHHv73UH8Tlj58CC/obO9QJ++uvmLCBsfwf5ydtN64t0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348186; c=relaxed/simple;
	bh=kZZ3nRF+Zxf6lGkAZahLRBxEqX9+XhF3TpFGqRFvXpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVG/bKEmNLO7tpvasjjf08V46LhjjXPTwWu/KoWfPwYRQlfj94EmLtMnrjgKkpYcfjluvxSV0mT3KM2WsqQCK4qaa6qtkOlXTbl6WeLa4/MoopUVbHTa3UDtaLei1IaizT6aFlv8+X4ib/6WkW6M+KcHuUI78beE8+NLOcBc0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8HTNBak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8HTNBak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711348182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmUXm4ncHueirLlVukeTUtsWlGWpKrR/EAFJ17idPmI=;
	b=Z8HTNBakP9nefsfR+7cnaJH7EzAVpcisadQrDdgJgo//Gqu72jpa2ygmJ/UzQssRziFUZ/
	RPFAt3p9OPAr8aecricvW/O6+mAn3BUUZ0/101FwK7S0RQjC9woxZhNzqXfrJRsA7UemPX
	M1EeUlSneVFCJ89/ogA28nluOFQjj0A=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ItsiwGP0P-ipx_k-HOSOsg-1; Mon, 25 Mar 2024 02:29:38 -0400
X-MC-Unique: ItsiwGP0P-ipx_k-HOSOsg-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1e09e32e5a2so15874925ad.0
        for <virtualization@lists.linux.dev>; Sun, 24 Mar 2024 23:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711348176; x=1711952976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmUXm4ncHueirLlVukeTUtsWlGWpKrR/EAFJ17idPmI=;
        b=BpYy+6JDLmOwyRUAJ10h5TlDS1DPIAYV9WzXNGVd8YY8ViIESXZf++wQtsbSNFP2Xt
         77AMQNqZHVsEunrBfj6MEa7QzL/cNwPV+HJCLmXT1C0y0R2yQkV11j/H9Ej13aj3ZbSR
         8fNGL4yDaBa/t5mZnWt2SwDvQmMmC1WazjRvUhMLkvc2zWjyV6PO1PUXFb9ri0ef5RRY
         wpwRB4hq1vbcrHQrfbBYHYXNzhasdLM8dpQ0LBO72Dm8fy+E3zxPol6chfXcBms5mn9r
         KE9KYJPFzDj4qn1H28iin1l6J/9CPTm0R71y9XdigQ2ToUqnP8BFsocdA7060nmFmzru
         biqg==
X-Forwarded-Encrypted: i=1; AJvYcCWwsDHJCpaZqGTbxMoURVCp+F3oI+rZwz+hbBBfDlGzhGw6pQQ9uI/VoeXbhbsVLKpe6Ww6rZsol4+3Q9wioLxkAob28bLHcAV8uPNCp4M=
X-Gm-Message-State: AOJu0YwsaNZbTcHR3rYiAVzXlhOE9Tn1MyEC4lKNbV/A+OblTre+VWqJ
	DZidjQIj39GRAQckSRbhHh2e4y+OjugyhNvWrQN0PQQZ2iJPBahk7ZINnriaCVN2QH8Dlg49Dr7
	j83BG7WElV6wwCyFpsAKLblW8B0Nz+QbF+s6cDZLP4Mx/x29/jWpSrXPIlV5CHht+Ffd3iXWY0N
	ScXggqmPHmdnk7/kDxwSSa0bM/jCEY7TgHhq170dg=
X-Received: by 2002:a17:902:eb8d:b0:1dd:d0b0:ca86 with SMTP id q13-20020a170902eb8d00b001ddd0b0ca86mr6902509plg.59.1711348176386;
        Sun, 24 Mar 2024 23:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1qsTTLgML0tM8VWrcjTYz0S0YxyaeiYmoln0LfAi4uQ85q+QaIwg8B27H/hFotSkBi4HB7q9ALjDSXiUzUsw=
X-Received: by 2002:a17:902:eb8d:b0:1dd:d0b0:ca86 with SMTP id
 q13-20020a170902eb8d00b001ddd0b0ca86mr6902495plg.59.1711348176086; Sun, 24
 Mar 2024 23:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com> <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
In-Reply-To: <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 25 Mar 2024 14:29:24 +0800
Message-ID: <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
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

On Mon, Mar 25, 2024 at 10:11=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/3/22 =E4=B8=8B=E5=8D=881:17, Jason Wang =E5=86=99=E9=81=93=
:
> > On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.c=
om> wrote:
> >> When the dim worker is scheduled, if it fails to acquire the lock,
> >> dim may not be able to return to the working state later.
> >>
> >> For example, the following single queue scenario:
> >>    1. The dim worker of rxq0 is scheduled, and the dim status is
> >>       changed to DIM_APPLY_NEW_PROFILE;
> >>    2. The ethtool command is holding rtnl lock;
> >>    3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
> >>       to acquire the lock and exits;
> >>
> >> Then, even if net_dim is invoked again, it cannot work because the
> >> state is not restored to DIM_START_MEASURE.
> >>
> >> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> >> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> >> ---
> >>   drivers/net/virtio_net.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index c22d111..0ebe322 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_str=
uct *work)
> >>          struct dim_cq_moder update_moder;
> >>          int i, qnum, err;
> >>
> >> -       if (!rtnl_trylock())
> >> +       if (!rtnl_trylock()) {
> >> +               schedule_work(&dim->work);
> >>                  return;
> >> +       }
> > Patch looks fine but I wonder if a delayed schedule is better.
>
> The work in net_dim() core layer uses non-delayed-work, and the two
> cannot be mixed.

Well, I think we need first to figure out if delayed work is better here.

Switching to use delayed work for dim seems not hard anyhow.

Thanks

>
> Thanks,
> Heng
>
> >
> > Thanks
> >
> >>          /* Each rxq's work is queued by "net_dim()->schedule_work()"
> >>           * in response to NAPI traffic changes. Note that dim->profil=
e_ix
> >> --
> >> 1.8.3.1
> >>
>

