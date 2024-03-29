Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F739AFA
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 03:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682426; cv=none; b=K7vM6NXnI4Nar3tcwM8lrY6f+y2MIDFzmFzpCzjMkXD4+sf/70PZ9wPEB/Bhz1ShiWP7cVZR7Upuss372vdIw7ZLD/ABewZTooUkiQNJTWMXgSizXON8kjFuwzkXsHXB+y6FdJ/5SvHucbB8wFv3lXIoBhyHeu0ZRfPFjOHGqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682426; c=relaxed/simple;
	bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+MEoNJrrEzsL0VInwg8piz3wZzOFgFtBzDJcIGegAEaDkJwEZ9UQcaj11uaoOY4eJOz3uPyWaZrmrKVpiFSdWJ4IB/xNWyBMZo00NRoq6/t+ywT8tbUKRnXfUlCSDWSfjuuVEP830/9AeyvVFLL1we80GHkKVxLgRP3WRyXbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwYXjBrW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwYXjBrW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
	b=dwYXjBrWg9l1ek4BZBk1B0Tuah01qWLBo0i9mYVFD4lZ/BSbVaADL5MNz1h/SXhdSVrEJ7
	IedBfftXcKCyIgHHlzHsIsxlF2pXOCpPdIWbOm6ZxZI4iFFBJK3D4ewZrHUKOaUD+xr7x5
	ythZqOvl1mSSCjAbO5itJDSC0On+Gwo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-1hK8jMckNAWF966B9gKGHA-1; Thu, 28 Mar 2024 23:20:21 -0400
X-MC-Unique: 1hK8jMckNAWF966B9gKGHA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-29de3646c56so1314018a91.2
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682420; x=1712287220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPes8UssJf0wpUv7k1OXdBRzHVFUGxaERQIXqWiW164=;
        b=Kc9nd//iOIIkTpcSBBFa7XnduS63RgMYJZOzk8bGTXmI/L88ik3Yj7XnOvjmwLkaTV
         Q3Ay7zF0sGJR/S42fOYqb7GODoJOFjCmVhqAMtCrMYilOVQQajNjpZeHwO5Ndx1qQ0n0
         /zckGiuHue/DdDjbrOjh4DTGnJgkoRuiL4K4fhikYXrTS3EO1WjUu5lagyeEAfq/TqXt
         L43sWOS+Y4UmM7UQjOCRlL30eEczugK/t0q+A3P9QOSh7DVbZexEnWjX+4VkiwbnJ24x
         RU6P4pEkvr4uYaB88Kixz6yfhP7JVNzsSsOif2yJH3gIYmgeKAU1PiV/FQaXod+L5tfR
         mTGw==
X-Gm-Message-State: AOJu0Yzh60R4p0REKjDO58BjmTZGG5RqMRg1APlbR6v17Qf955UzZ8/4
	GxzJgJ4dT5WfybJ8UfZAlL20ylu6fCKtUuj6QmoJk29uNzmg40QOWDhXS1zkhAeOWc9jhlJ+0KP
	je8HHaOVT9hn6/cGA2+pKkYLWgpADJcy4yxM6J/5T5j5GJDnvnkT7ONjh0YzFZP06/PuNaJG1cA
	B5dEYtJXXlvxLhBbm2FlKoppMvZJCoipR/xdwj+Ik=
X-Received: by 2002:a17:90a:b784:b0:29c:7701:bbe1 with SMTP id m4-20020a17090ab78400b0029c7701bbe1mr1195695pjr.28.1711682420306;
        Thu, 28 Mar 2024 20:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLFlTvxRS+moINK4pF+4OyZLos3uKx1aCQpB+PaMG2JDkOAVbT80rpeJgJ3hFmOo7yKS42b5cBs1na3WeoaVw=
X-Received: by 2002:a17:90a:b784:b0:29c:7701:bbe1 with SMTP id
 m4-20020a17090ab78400b0029c7701bbe1mr1195679pjr.28.1711682419994; Thu, 28 Mar
 2024 20:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com> <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:20:08 +0800
Message-ID: <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > Now, the virtio core can set the premapped mode by find_vqs().
> > > If the premapped can be enabled, the dma array will not be
> > > allocated. So virtio-net use the api of find_vqs to enable the
> > > premapped.
> > >
> > > Judge the premapped mode by the vq->premapped instead of saving
> > > local variable.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> >
> > I wonder what's the reason to keep a fallback when premapped is not ena=
bled?
>
> Rethink this.
>
> I think you are right. We can remove the fallback.
>
> Because we have the virtio dma apis that wrap all the cases.
> So I will remove the fallback from the virtio-net in next version.

Ok.

>
> But we still need to export the premapped to the drivers.
> Because we can enable the AF_XDP only when premapped is true.

I may miss something but it should work like

enable AF_XDP -> enable remapping

So can we fail during remapping enablement?

THanks

>
> Thanks
>
>
> >
> > Thanks
> >
>

