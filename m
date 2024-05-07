Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA5381C4
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 06:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063367; cv=none; b=sbEnchlYo/vEbmtyk54uoCA1eH0fXRJnK5ZIkaI9Eid7HI0U/W5RFBaS3Re6X8Ixqk81Enn8gS5KlGrpv7x+jL0Orji4smJB57j/4uvUH9yipYvlrnSU4CcyK5FoI0aXV6UX8tDACLfUTwl/WD5RF8kj9i22Er6Yb76lC9oX4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063367; c=relaxed/simple;
	bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8XDkK9pwktcIKwOt1SN3cbHRdgCbywU3NeeMwm2p8yM7UwhmxyPvyH83cU9+yRCuKVrrKU3QqR49EXOAxPlfLSdqJjqv0HQs+oicRkFbnRxXTq0qI4yIDmTeMHNChYUlNdWKjJI6/ZtaQpcD6mZygS3aL/HYmiQtsB/EYJsCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8IcKmXq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8IcKmXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715063365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
	b=K8IcKmXqFst6fBWNo/nlsqc8IGRPMSwJyQMYvsdOogQwhka1xgkybC98sUkxJcKQGNAVqu
	VBRSLiMLzOYVquCJsHfHWVAhTkys8l44FS3tgvrkDwngIAVqgWgxrnz+NApeDYeqatzRzn
	LGqlU3GHus8dcirkXwYAjF07+UG9CzI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-C3-Rh0WXPvWzdYQmgxNVBg-1; Tue, 07 May 2024 02:29:22 -0400
X-MC-Unique: C3-Rh0WXPvWzdYQmgxNVBg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c65e666609so3146435a12.1
        for <virtualization@lists.linux.dev>; Mon, 06 May 2024 23:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063361; x=1715668161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHZm8TISDHrpjof8Twbn5U/Ko/qWUNJWpQZANyBMqeM=;
        b=lZdrWcpQyntCJwf85ErQeohGijo4wtAXH9w765jTMhtcDEw2Jtq3FFBvK7KhGtP8eI
         oae8zieCQ/vT0XTZWF2IwIpiDMIOt+KmMxbC5HnV3fjnMreXGIB2JjAz0VwcLw6p8Af/
         hAhtE+of60Si9+Jt8DIaL0xq4itp1wAcJJiQXhjdg1/oKOZc3laL0ZN7e9BdR8hm7QXr
         kfE3eDUH1gbCx4ktYFZ19r03mRbO55h6vyZ8qsMUDlAJmV6NzQBflu7/I5QtApzIlnQA
         5Tv7HnUFSjC1Is5WfSnTCuuL/OGkxJAmm+KRNKI8/fT0VFbEfDz9ZZ4yR9IWQfHmqUGn
         Pj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6WJI5IgAq1579UhIU9Wjy58lLgruReD7+CqwQL6cMA2BtVAJbND+T/KLvmRbVLiFPVFI5jQZgE2wmH2dQkySUJ9nQQ68WXk1uiWcnMZo=
X-Gm-Message-State: AOJu0YwP3xL0Sz215tG2vhV86sjdxs3STJxkeyI+K62uXERUX9bo5gia
	dpinEMhqR1G1iJt8g6tuOgap7oU0XEBZMu45unFSWs9NVmXY5USKk0ERHvfBHB3jKmf2TDdsIyl
	ZoBMZSO3wv4vOwvFJHc1iZObZy6FdG8sonRErUrF8NnODnhO/AIzVillxf/Is8Cn08oU3OfAa4W
	TclcS9EsFrYi4ugyOrkFs92mfSkFXMMpDHA9vyt68=
X-Received: by 2002:a05:6a20:9d90:b0:1ae:3812:945e with SMTP id mu16-20020a056a209d9000b001ae3812945emr16600632pzb.62.1715063361659;
        Mon, 06 May 2024 23:29:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEau7qXr2ROZrlqu5ZAhJM3ZigbzDbHsrm8pZqf6knZQNd/Yb0kztQ6agTSako5xF/rXdcv9NN3dcTVY8IlWxY=
X-Received: by 2002:a05:6a20:9d90:b0:1ae:3812:945e with SMTP id
 mu16-20020a056a209d9000b001ae3812945emr16600622pzb.62.1715063361332; Mon, 06
 May 2024 23:29:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503202445.1415560-1-danielj@nvidia.com> <1714976172.0470116-1-hengqi@linux.alibaba.com>
In-Reply-To: <1714976172.0470116-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 May 2024 14:29:10 +0800
Message-ID: <CACGkMEvAEu1TaPEj6x2A2J0EdrJj_CkHM5-qBM9_OHo2O5uKzA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/6] Remove RTNL lock protection of CVQ
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 2:20=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
> On Fri, 3 May 2024 23:24:39 +0300, Daniel Jurgens <danielj@nvidia.com> wr=
ote:
> > Currently the buffer used for control VQ commands is protected by the
> > RTNL lock. Previously this wasn't a major concern because the control V=
Q
> > was only used during device setup and user interaction. With the recent
> > addition of dynamic interrupt moderation the control VQ may be used
> > frequently during normal operation.
> >
> > This series removes the RNTL lock dependency by introducing a mutex
> > to protect the control buffer and writing SGs to the control VQ.
> >
>
> For the series, keep tags:
>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> Tested-by: Heng Qi <hengqi@linux.alibaba.com>
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

