Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE124175A8F
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401506; cv=none; b=ifDaECLasq3bnh2BeDUdClpgFvxPvu+0wC+fsYN5+YseuEfZ/fBDGf1BBzm3Hz8lQp/B44ixek2yNqF+hCdTH1J0vF53yxFHaKHvlsXg7jHipmEFH+4Xu5WTX53Ld5XepqhCPgiOG/MbEbFr7yB3VGOZ593xmoOiHKAEo+/aKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401506; c=relaxed/simple;
	bh=xP/7JZ+XjD3qrKPjvidDM+PYQ1wLFXsiYp1jYElw+u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VU6VC75yIKearbBAntkCm8p5z4Y+yZNeT9HZNto+0XOSIYhvx1/wQIf2Hia6HbWyNlBRSPOUlJjitgjwCuZeiFUJhIuaSnC8ixd+T7Jb1vq+KdJhr/icFjXbg4fuy5xfDx03A9NmRVwEBrccGgCRUDZbyGQp7Vqzi3nRHfBP8pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfvwAxZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfvwAxZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773401503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xP/7JZ+XjD3qrKPjvidDM+PYQ1wLFXsiYp1jYElw+u8=;
	b=hfvwAxZ6aFyPijF+cBKRRadcH2k1nox1l30PxX8lkq5TK6bEDAFMKU4iGlgOLZ2jxAmv8I
	f9ZWXluprFqE1tTZHv6GERLESSRDJ/15s+aosmyx/gXyFHmmWlUjkglEPRUSYE3Gf/G0Oi
	zwnRBnORY+WRcNno/iG6x1xtdQGfdNo=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-VXZZTSLHNlOg7iCYqYPeHA-1; Fri, 13 Mar 2026 07:31:42 -0400
X-MC-Unique: VXZZTSLHNlOg7iCYqYPeHA-1
X-Mimecast-MFC-AGG-ID: VXZZTSLHNlOg7iCYqYPeHA_1773401502
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-64ca2fce86bso5573760d50.0
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 04:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773401502; x=1774006302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xP/7JZ+XjD3qrKPjvidDM+PYQ1wLFXsiYp1jYElw+u8=;
        b=EH2XHl3y/wMaIHe36Zv0lA1hH72YeCf5IXlx4iraPSNaPmlJvnZuUzkEMLyxKv5aOh
         71r7uCoN65/a8HMh/kUL6vx6lCA7oKpYFVvI4RWUN8dTRg5T4Xn5JJWIjXgFcs4CxOiy
         Z8bj2ZAQCguZoImdC/Ptxgj7sRKEbMjwybDeVaJVnyLWUPutPnycBUL/BZSv0TCH9sR0
         VBP0HyyOKZH6TJENTwQHdtAOtz8Qjp8srlE3iiXJi/go+wczfH5zEqrVmHSGoIx07b6Y
         SZ9bu9uhv7O+DUs81DTdGF/zP82ZPDFsEOUM+o++KiJRdkxzb9cyU541nVQLRUxqh2yA
         uAWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhRWefxqPEwxa/mtLzRRdAfrqYvqKbZBaIyPbUxMX79FxuUJznX2/etBcNJGk7Ue9Yn87C8JQLyK5U57ytow==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywz+9DtnJlu1gmg6M4MjB5bhwzQ6iAfOm3x+YZogO7GqSIBi+LT
	SjHyzUxvodtLC0a95w/Bc2guYZpnGs34IW5HZI45m91MZEkW8LT+wXIbqcGpBPOmOrR7sEZlJjN
	tPljzrqK6ynpPvoE+dy8YhvDmcGLoYS6rQec1gZ6/jfof2T7PJ7Ud+o1jETcoIIpNsVKcFnKGHU
	rD6+KihwxAe+agjAjsBeIARo1PgKyoxX6MJZ/XxI3nP9w=
X-Gm-Gg: ATEYQzwq6YLCEaSwmiowCUEXYWriMTGw7cLh7nsG+R4KlZcOnsw3g/pHhUb1u45iin0
	+wg8zboJdT18dtoSbRicK97NEeEtnutExNzk8h+n9RZRAsPY1zRKew2C5JiIBgc1zl9v3jS6UjP
	CY9d8JMbyhAk+GFHkjNazSLkP07v109ZCHqtiTekiFLDeJp7R47i8KCHk3NVUXeU3j02DYj1UD+
	VQ51A==
X-Received: by 2002:a53:ecd5:0:b0:64d:54b2:9b3e with SMTP id 956f58d0204a3-64e62f79a9cmr2176912d50.19.1773401502012;
        Fri, 13 Mar 2026 04:31:42 -0700 (PDT)
X-Received: by 2002:a53:ecd5:0:b0:64d:54b2:9b3e with SMTP id
 956f58d0204a3-64e62f79a9cmr2176885d50.19.1773401501564; Fri, 13 Mar 2026
 04:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com> <20251109164528-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251109164528-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 13 Mar 2026 12:31:05 +0100
X-Gm-Features: AaiRm525TlbrJnF1ROkMV5cONMfHrk7HXeyrLg_rCBCboBBjBgNsMakLqTTeOOw
Message-ID: <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zW0Zmie33fqJI5xH-j8ZM9Ykq1sUlz00chWWlbK74No_1773401502
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 10:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrote:
> > On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wrot=
e:
> > > > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst@r=
edhat.com> wrote:
> > > > > >
> > > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Martin =
wrote:
> > > > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin <m=
st@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez Mar=
tin wrote:
> > > > > > > > > Let me switch to MQ as I think it illustrates the point b=
etter.
> > > > > > > > >
> > > > > > > > > IIUC the workflow:
> > > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_VQ=
_PAIRS_SET 1
> > > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > >
> > > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command a=
t this point,
> > > > > > > > > so it potentially uses the second rx queue. But, by the s=
tandard:
> > > > > > > > >
> > > > > > > > > The device MUST NOT queue packets on receive queues great=
er than
> > > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_MQ=
_VQ_PAIRS_SET
> > > > > > > > > command in a used buffer.
> > > > > > > > >
> > > > > > > > > So the driver does not expect rx buffers on that queue at=
 all. From
> > > > > > > > > the driver's POV, the device is invalid, and it could mar=
k it as
> > > > > > > > > broken.
> > > > > > > >
> > > > > > > > ok intresting. Note that if userspace processes vqs it shou=
ld process
> > > > > > > > cvq too. I don't know what to do in this case yet, I'm goin=
g on
> > > > > > > > vacation, let me ponder this a bit.
> > > > > > > >
> > > > > > >
> > > > > > > Sure.
> > > > > >
> > > > > > So let me ask you this, how are you going to handle device rese=
t?
> > > > > > Same issue, it seems to me.
> > > > > >
> > > > >
> > > > > Well my proposal is to mark it as broken so it needs to be reset
> > > > > manually.
> > > >
> > > >
> > > > Heh but guest assumes after reset device does not poke at guest
> > > > memory, and will free up and reuse that memory.
> > > > If userspace still pokes at it -> plus plus ungood.
> > > >
> > >
> > > I don't get this part. Once the device is reset, the device should no=
t
> > > poke at guest memory (unless it is malicious or similar). Why would i=
t
> > > do it?
> >
> > Friendly ping.
>
>
>
> OK I thought about it a bunch. A lot of net drivers actually
> just queue ethtool commands and finish them asynchronously.
> Thinkably virtio could expose an API on whether it is safe to
> wait for buffers to be used. virtio-net would then either
> send commands directly or do the asynchronous thing.
> Hmm?
>

I think it's the best solution too, yes. The series [1] implements for
set_rx_mode. We can do it for all the CVQ commands and then whitelist
them in VDUSE code. Am I missing something? Does anyone foresee any
command that will not be possible to convert?

Thanks!

