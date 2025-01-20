Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1DB9454
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737333674; cv=none; b=cwYP7CEmLN9doQ2WliFQdeyCayIlp3MjEpe9M64/UvrMatJcP3bTuioNg/bJQuKh1HfTs6iI6aPdwnR2Pc+JOLQ2ZN1txE2iU0Yi+55EyCsQtheuItr8H2acYzqqARrbfZ+plJfeB5pGsPLDmJJLqLOTORgwZVhpTbSMB4OjIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737333674; c=relaxed/simple;
	bh=aA1N/FCwEJWzfKwIbQDHaCbEggvd2ib8Yz4yJXSDdJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYkqSwZSvEAkruancnC3giVacWd3AMFL7ZfH3VhEoZhvgBWGqGw+pMFG9F1h6N6yPW6NgrMg9O2YxucoR3wCmdUDmPpJtnIRtojHxDfqA2tIJBoKqkeK07qtad1nvameQEm024nY0Xr8uylz6cQZ89tj1l2DiVNENMXBWakl5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLHT4FjS; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLHT4FjS"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CA4D8419B
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:41:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id msWZW1rmhP_C for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jan 2025 00:41:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 802CC84198
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 802CC84198
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CLHT4FjS
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 802CC84198
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Jan 2025 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737333670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoODFoEJ/D6WHGy7MOEpfhr94tOI/fDa1CVKWtBtZbg=;
	b=CLHT4FjSYf+8qFsXwMyPLWQIGkBTZyDPZkXpFhLSo3zxD33sIJeyPY3yV+IhFDOUCoLXtV
	9BGG7oqCN8JYNSiMrKPlti3v6uJ3W8+xL3d81O9Un9nUQnfDw9X6ULzkW8yyeKbLfVcAHT
	I+r/2zdWaPiJUf26HnU6duDk6oE9k3s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-MXiplrllPJmlp3IsZWcftw-1; Sun, 19 Jan 2025 19:41:08 -0500
X-MC-Unique: MXiplrllPJmlp3IsZWcftw-1
X-Mimecast-MFC-AGG-ID: MXiplrllPJmlp3IsZWcftw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so7209329a91.3
        for <virtualization@lists.linux-foundation.org>; Sun, 19 Jan 2025 16:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737333667; x=1737938467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoODFoEJ/D6WHGy7MOEpfhr94tOI/fDa1CVKWtBtZbg=;
        b=nQzGbzSVU7TWy2Dn9YzeV59J6DBVB/dp9FkeoIu4/IF6CyttajRQfDnmWPAVzlrP9O
         Xauk8BnHwofiwmMkSp1SctfHYxFXXnFA0+HWWwQ2FqcmU3WJ6ajrRmQmxo2oaMNeUaEU
         9ry+Ax2le0BcQEyJrsBM5n76eYudEyEOjA99Y0/KA9a03jsqayOsRcojHpWGDjO4qCm2
         WY0dJSh3j+iALx82YNQvzal3FY0P9YWSMaeb7lDYT/ZDTGCMlLiHaRPHNbXfHX5Hv+9f
         dEUok2Ja/EP5WtXr6ZO5kDa1/3uuHIDlPJ8yT3XWIbLs2Qmq+KcPHoOnhIQAcPVp15Aj
         6sRg==
X-Forwarded-Encrypted: i=1; AJvYcCV36cKdSoBfnSYqGY9y35tTRoRk4VMl+S31vJvFKSwYeNF39IMgTwt7ug2+gcHX89LrNCDaZlP9Kcbsopxp2w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzHrSGxscU4l5FyHx+w8P4LRoJ/yWDsLgMI60JEeKvaEiIclDNd
	VsW5HHuSepj9OvArVq0vKp1sHlGcxAWDYnK7tcBDBg7WElCIP6R+VAwLIfDn4ed7NU3ObOYW/Ex
	WBz5umvYxmXT4tJ1MU4FlNB5zaP5AOL+CyTC8KfBPK0mo8uZ9XxvKbc2i0PSZP0S0TUcj/VLw9Q
	15L216QGSkA1bl84y/DoKcmLOrUuqsAO2Xk/ZviTY8jctBOqBR4YNKog==
X-Gm-Gg: ASbGncs8NGSZ+DXRmGUHpZ+xM3Wfm8Lvqm/ivpwkpkjYiyqs2CZoVLQEAC4GlgehFi7
	ffwcNO8huspwgpOA1/7sgj9sGJysmoC0t1SQuP6qnRn4vPrGQO+jW
X-Received: by 2002:a17:90a:d003:b0:2ee:a04b:92ce with SMTP id 98e67ed59e1d1-2f782d8c844mr13718673a91.32.1737333667416;
        Sun, 19 Jan 2025 16:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvOsgeJvjTzqlxcpcXrDzMSHfJqhVYBVkIV2UaUnhj4GnP64AkNHuirJUh0W/boBZuXQpajGMQJ+ugWEd6ZBA=
X-Received: by 2002:a17:90a:d003:b0:2ee:a04b:92ce with SMTP id
 98e67ed59e1d1-2f782d8c844mr13718637a91.32.1737333666967; Sun, 19 Jan 2025
 16:41:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-3-388d7d5a287a@daynix.com>
 <CACGkMEsm5DCb+n3NYeRjmq3rAANztZz5QmV8rbPNo+cH-=VzDQ@mail.gmail.com>
 <20250110052246-mutt-send-email-mst@kernel.org> <2e015ee6-8a3b-43fb-b119-e1921139c74b@daynix.com>
 <CACGkMEuiyfH-QitiiKJ__-8NiTjoOfc8Nx5BwLM-GOfPpVEitA@mail.gmail.com>
 <fcb301e8-c808-4e20-92dd-2e3b83998d18@daynix.com> <CACGkMEvBU3mLbW+-nOscriR-SeDvPSm1mtwwgznYFOocuao5MQ@mail.gmail.com>
 <cc79bef1-c24e-448d-bc20-f8302e341b2c@daynix.com>
In-Reply-To: <cc79bef1-c24e-448d-bc20-f8302e341b2c@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 08:40:55 +0800
X-Gm-Features: AbW1kvZySvRTtG6CQaeo9DOkWdfLmhPa3wBjyc1FO_e-8MjSnO1jhzJ2Si8rLnw
Message-ID: <CACGkMEsJUb3ZLm3rLuaayDAS4kf-vbY03wL4M9j1K+Z=a4BDig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tun: Set num_buffers for virtio 1.0
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wTyGsZddFdLmI3tlA3uvrqdFu0H4kDSPQ_bl11SoO8Q_1737333667
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 1:30=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2025/01/16 10:06, Jason Wang wrote:
> > On Wed, Jan 15, 2025 at 1:07=E2=80=AFPM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> On 2025/01/13 12:04, Jason Wang wrote:
> >>> On Fri, Jan 10, 2025 at 7:12=E2=80=AFPM Akihiko Odaki <akihiko.odaki@=
daynix.com> wrote:
> >>>>
> >>>> On 2025/01/10 19:23, Michael S. Tsirkin wrote:
> >>>>> On Fri, Jan 10, 2025 at 11:27:13AM +0800, Jason Wang wrote:
> >>>>>> On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odak=
i@daynix.com> wrote:
> >>>>>>>
> >>>>>>> The specification says the device MUST set num_buffers to 1 if
> >>>>>>> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> >>>>>>
> >>>>>> Have we agreed on how to fix the spec or not?
> >>>>>>
> >>>>>> As I replied in the spec patch, if we just remove this "MUST", it
> >>>>>> looks like we are all fine?
> >>>>>>
> >>>>>> Thanks
> >>>>>
> >>>>> We should replace MUST with SHOULD but it is not all fine,
> >>>>> ignoring SHOULD is a quality of implementation issue.
> >>>>>
> >>>
> >>> So is this something that the driver should notice?
> >>>
> >>>>
> >>>> Should we really replace it? It would mean that a driver conformant =
with
> >>>> the current specification may not be compatible with a device confor=
mant
> >>>> with the future specification.
> >>>
> >>> I don't get this. We are talking about devices and we want to relax s=
o
> >>> it should compatibile.
> >>
> >>
> >> The problem is:
> >> 1) On the device side, the num_buffers can be left uninitialized due t=
o bugs
> >> 2) On the driver side, the specification allows assuming the num_buffe=
rs
> >> is set to one.
> >>
> >> Relaxing the device requirement will replace "due to bugs" with
> >> "according to the specification" in 1). It still contradicts with 2) s=
o
> >> does not fix compatibility.
> >
> > Just to clarify I meant we can simply remove the following:
> >
> > """
> > The device MUST use only a single descriptor if VIRTIO_NET_F_MRG_RXBUF
> > was not negotiated. Note: This means that num_buffers will always be 1
> > if VIRTIO_NET_F_MRG_RXBUF is not negotiated.
> > """
> >
> > And
> >
> > """
> > If VIRTIO_NET_F_MRG_RXBUF has not been negotiated, the device MUST set
> > num_buffers to 1.
> > """
> >
> > This seems easier as it reflects the fact where some devices don't set
> > it. And it eases the transitional device as it doesn't need to have
> > any special care.
>
> That can potentially break existing drivers that are compliant with the
> current and assumes the num_buffers is set to 1.

Those drivers are already 'broken'. Aren't they?

Thanks

>
> Regards,
> Akihiko Odaki
>
> >
> > Then we don't need any driver normative so I don't see any conflict.
> >
> > Michael suggests we use "SHOULD", but if this is something that the
> > driver needs to be aware of I don't know how "SHOULD" can help a lot
> > or not.
> >
> >>
> >> Instead, we should make the driver requirement stricter to change 2).
> >> That is what "[PATCH v3] virtio-net: Ignore num_buffers when unused" d=
oes:
> >> https://lore.kernel.org/r/20250110-reserved-v3-1-2ade0a5d2090@daynix.c=
om
> >>
> >>>
> >>>>
> >>>> We are going to fix all implementations known to buggy (QEMU and Lin=
ux)
> >>>> anyway so I think it's just fine to leave that part of specification=
 as is.
> >>>
> >>> I don't think we can fix it all.
> >>
> >> It essentially only requires storing 16 bits. There are details we nee=
d
> >> to work out, but it should be possible to fix.
> >
> > I meant it's not realistic to fix all the hypervisors. Note that
> > modern devices have been implemented for about a decade so we may have
> > too many versions of various hypervisors. (E.g DPDK seems to stick
> > with the same behaviour of the current kernel).
>  > >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >
> > Thanks
> >
>

