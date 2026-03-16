Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE938654F
	for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653246; cv=none; b=GQhlW5kuK/yixnPgvIc4LR5TFeGACx2dPnOdOoh9vJ57Mpqlo2BtUFSDfx3ld472RnWIvCeMuqGinxKLnju/U2bmccula29+6R8s/ALxS2u2SpSmzykSInmQ2NelnLzgmCFB8tPguDP4CYjFFaZp3npD5RkDdIDL2QloklzIsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653246; c=relaxed/simple;
	bh=oEzQZNVQj4Ess56EQ81ZEXoD+V5m1Tf4lLkZ0RWYjR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Q/kze1hhTR0R6p7JC3E0A3uBI5bc2sCH0arwrsibYqktJN/84bZiHbalvJ5srmetu+1FLbyv6nHDbFLYmG9UsJSIO5RFSIQwA3lzYcRlyqH99bLigu6jgrjuWQGK4mIBVi2ZqRiPZMe8nmSvFj4wEAwxOdW0OkgR+7RbP+eaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSA/nWcf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSA/nWcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773653244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEzQZNVQj4Ess56EQ81ZEXoD+V5m1Tf4lLkZ0RWYjR0=;
	b=QSA/nWcfH3p3Qceb73MDMQEOXgeNujhGAX4giQH8l4Xxe0eBDJPGyz4u2ppWkqco0rT1Aj
	w1jrwrlscDlj4XXW2YIp1PnSaM1f+HU88vAAmAqYrbI+wBWsp1spKgw+2Fz1zzhteanTCu
	Tn0cuOuEsIji+l/cWDwzVjORKYzF0lg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-cYTJuG2NMWWnM_1n0CWucA-1; Mon, 16 Mar 2026 05:27:23 -0400
X-MC-Unique: cYTJuG2NMWWnM_1n0CWucA-1
X-Mimecast-MFC-AGG-ID: cYTJuG2NMWWnM_1n0CWucA_1773653241
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca6895833so2240439d50.2
        for <virtualization@lists.linux.dev>; Mon, 16 Mar 2026 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653241; x=1774258041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEzQZNVQj4Ess56EQ81ZEXoD+V5m1Tf4lLkZ0RWYjR0=;
        b=PB/ohOy83WNZpKxpwWuz3W5CQCtt84d+KIwsjtb7g5kXe5evJUityX6+vf2Nriq4BQ
         JSBY540qi6tByISGsVjxPZgURWfBfrqsKvoqJ9EkrLRa4TOej6WGuYIu2cJsw3b855Pt
         hxn0gCW+eYN78X9oNt6By2yOrQn9GMtiQfgxqJ19+ut1n0FQ5AUNdCNybGEeAGc+oE6i
         jnUT9cfNH6AyW85+Z1oHFHUgGP4V0cQLLFmFlYnsl/yye0Agph9y/BPUaeDUOFWA4MRe
         iBaKNZNEvBlSPNwz3udAZwh1HmZKSm3qWQvOqVyY/2YEpcE0TgB99hO+zHDfunwc/dgD
         bmow==
X-Forwarded-Encrypted: i=1; AJvYcCWPkN0WmbwQHbSHCL5kDl4G3DyFwM0S1XgBDRaxzM7BhKZUlld/T298oQt8q82KJvkXWglE4uuwNxbDBiY8kA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8Fh9IpPyBaK7pMvT66LHax3Pku9gqCpLClgptKQCd1TI9xdIv
	7cZNoieRS0eqKfkk7AM24GR0TAAm5SMoDahZQ7lx2KLmu+15iwNofUavZVeEKnFIcZEyXQ/RDxT
	BXsOW2zyWWMYoJo2g+D4eys0fDwL4QicfnbgRUqSve9c0c86fYIvC/L9Y5URdff1soKnWXpb7l5
	bYQOTMDpBJDJskYbXhV844yOaV2T0tgvdllnpEXVnWtN4=
X-Gm-Gg: ATEYQzykwT070W0z3Mr7q6OzTV5kj9Fb/IZlL5YPoACbjVHpteWYWPfHPIfdd+Xw2bY
	cZnGhSwVbNnN01juTKYUJmS/iMYz3qz6Z+qh0yGKmr0YCjhPPEQI7flLiHwMCP7120ysrxKaW7K
	ihWja6Ib4c8OyjsDodBkF/aDq01hU0NrDx8eaehtFK61Cz+0iuh8cuuhvAnXg5q8/4DKgxpoSY0
	zZD1g==
X-Received: by 2002:a53:b45e:0:b0:64c:e890:fbb9 with SMTP id 956f58d0204a3-64e62f6fa92mr9915378d50.20.1773653241407;
        Mon, 16 Mar 2026 02:27:21 -0700 (PDT)
X-Received: by 2002:a53:b45e:0:b0:64c:e890:fbb9 with SMTP id
 956f58d0204a3-64e62f6fa92mr9915366d50.20.1773653240998; Mon, 16 Mar 2026
 02:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251022073231-mutt-send-email-mst@kernel.org>
 <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
 <20251109164528-mutt-send-email-mst@kernel.org> <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
 <CAJaqyWcCF0bzwMhQk6L=LPvc=S7yHoWB7xZ+MmPWwhi4kqGEfA@mail.gmail.com> <20260313080611-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260313080611-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 16 Mar 2026 10:26:44 +0100
X-Gm-Features: AaiRm50HXiCBT4aDQFPMzfSd6YuThLg3fKktaWI5n9972hGCjIdF4WTlT56cBJw
Message-ID: <CAJaqyWdaMb0EABOL4WB8+PVKPeU4vzD3V22z63N10jzNESO1sQ@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a5fwC8Z3xWif-FlyJiC5U8WludUYITCcH5_zn44xh3I_1773653241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:06=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Mar 13, 2026 at 12:32:18PM +0100, Eugenio Perez Martin wrote:
> > On Fri, Mar 13, 2026 at 12:31=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Sun, Nov 9, 2025 at 10:47=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrot=
e:
> > > > > On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Marti=
n wrote:
> > > > > > > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez M=
artin wrote:
> > > > > > > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsir=
kin <mst@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Per=
ez Martin wrote:
> > > > > > > > > > > > Let me switch to MQ as I think it illustrates the p=
oint better.
> > > > > > > > > > > >
> > > > > > > > > > > > IIUC the workflow:
> > > > > > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > > > > > d) Now the virtio-net driver sends virtio-net sends=
 MQ_VQ_PAIRS_SET 1
> > > > > > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > > >
> > > > > > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 com=
mand at this point,
> > > > > > > > > > > > so it potentially uses the second rx queue. But, by=
 the standard:
> > > > > > > > > > > >
> > > > > > > > > > > > The device MUST NOT queue packets on receive queues=
 greater than
> > > > > > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_C=
TRL_MQ_VQ_PAIRS_SET
> > > > > > > > > > > > command in a used buffer.
> > > > > > > > > > > >
> > > > > > > > > > > > So the driver does not expect rx buffers on that qu=
eue at all. From
> > > > > > > > > > > > the driver's POV, the device is invalid, and it cou=
ld mark it as
> > > > > > > > > > > > broken.
> > > > > > > > > > >
> > > > > > > > > > > ok intresting. Note that if userspace processes vqs i=
t should process
> > > > > > > > > > > cvq too. I don't know what to do in this case yet, I'=
m going on
> > > > > > > > > > > vacation, let me ponder this a bit.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Sure.
> > > > > > > > >
> > > > > > > > > So let me ask you this, how are you going to handle devic=
e reset?
> > > > > > > > > Same issue, it seems to me.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Well my proposal is to mark it as broken so it needs to be =
reset
> > > > > > > > manually.
> > > > > > >
> > > > > > >
> > > > > > > Heh but guest assumes after reset device does not poke at gue=
st
> > > > > > > memory, and will free up and reuse that memory.
> > > > > > > If userspace still pokes at it -> plus plus ungood.
> > > > > > >
> > > > > >
> > > > > > I don't get this part. Once the device is reset, the device sho=
uld not
> > > > > > poke at guest memory (unless it is malicious or similar). Why w=
ould it
> > > > > > do it?
> > > > >
> > > > > Friendly ping.
> > > >
> > > >
> > > >
> > > > OK I thought about it a bunch. A lot of net drivers actually
> > > > just queue ethtool commands and finish them asynchronously.
> > > > Thinkably virtio could expose an API on whether it is safe to
> > > > wait for buffers to be used. virtio-net would then either
> > > > send commands directly or do the asynchronous thing.
> > > > Hmm?
> > > >
> > >
> > > I think it's the best solution too, yes. The series [1] implements fo=
r
> > > set_rx_mode. We can do it for all the CVQ commands and then whitelist
> > > them in VDUSE code. Am I missing something? Does anyone foresee any
> > > command that will not be possible to convert?
> > >
> >
> > Adding the [1] link...
> >
> > [1] https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyya=
ppan@gmail.com/
>
> what's the status of that one?
>

Still under review.

Aleksandr Loktionov <aleksandr.loktionov@intel.com> added the
Reviewed-by tag to most of patches but he spotted a sync issue in the
realtek 8139cp driver.

https://lore.kernel.org/lkml/IA3PR11MB8986856F0C1BC5A02F29B32EE540A@IA3PR11=
MB8986.namprd11.prod.outlook.com/

