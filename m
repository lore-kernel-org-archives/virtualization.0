Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870B2BA27
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804283; cv=none; b=HeL+T0Ud/4XR5U9ZHJ4mlEVxW4eGpvR/7Af/vlV3yDuM8SQSemKu+936eLP7mllm4yfMsdj8vOHVehhZ1Q1+Zp6WOgYjccRmdkqAd6HPTDXzDtkXlh/uLB0VloS5hXWZpPjILzVN9CwAvAG7loCX6TQTGVQhWdSaycEujHvN4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804283; c=relaxed/simple;
	bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLZmDi8DLyblnYFW6pMYEgTtJSwtFP9GBnS5t8Gx915QzThBcm8WyWW7BuClTiyXM0MMxakI0sLjXNnmdB5BB/wWc/RS8MTrpPzszWKNFuDr5nC8qO4fy0XX7SWfzf3HtxdVkoTvKbRQ3Pu6ayX0dbF7IFnUKRjkOIEqigSZ44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOexmGRa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOexmGRa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752804280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
	b=IOexmGRadnjAUK6Z7heu3u1IsRm3bpl1qAgqRGo9eV0WxN3atdUSjf84OEcr6mr7Je9Pgq
	5O/FCZep0LJDMalPbfMUvpCNdl0ms8pYx5boN9MYgIwj81YMJhsZAttIkd8OjfwLwLR8Z6
	+39nuANSoJ3/TdM3axhTZz09FehBmxM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-6L0AJIwsOeu6P3l0LloU_A-1; Thu, 17 Jul 2025 22:04:38 -0400
X-MC-Unique: 6L0AJIwsOeu6P3l0LloU_A-1
X-Mimecast-MFC-AGG-ID: 6L0AJIwsOeu6P3l0LloU_A_1752804277
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so1700777a91.3
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 19:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752804277; x=1753409077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9KoY0fWAyT0ZBg+rowE+1s3YIsLeaL/832ZnoeP1Wc=;
        b=JUsUVfqTViqsRsPTL+Lt8Xn2z1XUu9deoeLo1h0EIBXDcueOyVfMPeG6EebmRfAobQ
         6+a321i454IOuT2TmUlj+PPRyxD9ec7GLfuszgn+0eLxacMN2GnaJyoh2lofzY68XZSn
         YyZo6BOsWc+rBGkZHYp1XwfHyRjkjx1fB2UluHzJogH4VIJ00LR3pfxJq1Q+GEv1HjV6
         YZUxqZx9t1YJAh2ue8XreXiTnBww05s+DLVrHl5qqN5kzR+cz6KBbsY3n1QYe/sDFVGs
         glUkA0Jg02v2cW0B5DaJmCTpnnX0hepCkftwDM4PI/XCi0Q9wPSgzWTu3Do5GOcK2aoo
         aDnA==
X-Forwarded-Encrypted: i=1; AJvYcCXRVCYLoXnTiwFPNEnOGEVcgGwtD9Z/KHiYTecIbLcL2z/Vb923njog8EsPCOWDZc2QqH13dg7NWisTN9aisQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzqx9Col5EMhdxMkDz3QJCfUGvQOC//zR/9MdKuvHDobwtmdgac
	j/S6ECTwpE4YVQUpng8jAF/TnptRjXE8J/PUs+Ma8jVC/oe2sIxefLtjlofEO2oG4SBiv2CwSFO
	jH+jRYmSARhG15rehgJlNqx5IDJZiaIVmJYuGtpdi/jkfiLIMSG7kEi/5+zkhUEpb39UEmv6yfr
	YrV51yas3CBCYyydDVl5fKNkQrnAAtAKucR3PGmCJ7LGY=
X-Gm-Gg: ASbGncscEZCUsgfNktYJ50o6Lia2F/FuJ0G3IhyT/Y3VLCVXcaj9gBoP37gRA3eKmkT
	a9D5pC4ZnWocZeU1RoDNVFW/PZtIJryi5ctvuwb0EFckP1br0B+/HfiUNXCCiTiz2BFlO9xLmjT
	EhX8I1x7O4JvtywzbMnvrw
X-Received: by 2002:a17:90b:1b05:b0:313:fa28:b223 with SMTP id 98e67ed59e1d1-31c9f3c3538mr10850938a91.3.1752804277407;
        Thu, 17 Jul 2025 19:04:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8KqrUIVNAEyJPRiT2OM9FATHXOwO2SqN0Txk9K1dB4PdC1uDpWK6ggmwhD+ohejDdUwFOfVzzFbUMJaFde+g=
X-Received: by 2002:a17:90b:1b05:b0:313:fa28:b223 with SMTP id
 98e67ed59e1d1-31c9f3c3538mr10850916a91.3.1752804276960; Thu, 17 Jul 2025
 19:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250714084755.11921-1-jasowang@redhat.com> <20250716170406.637e01f5@kernel.org>
 <CACGkMEvj0W98Jc=AB-g8G0J0u5pGAM4mBVCrp3uPLCkc6CK7Ng@mail.gmail.com>
 <20250717015341-mutt-send-email-mst@kernel.org> <CACGkMEvX==TSK=0gH5WaFecMY1E+o7mbQ6EqJF+iaBx6DyMiJg@mail.gmail.com>
 <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
In-Reply-To: <bea4ea64-f7ec-4508-a75f-7b69d04f743a@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 10:04:25 +0800
X-Gm-Features: Ac12FXy68XSJi1v7t16tcsLyYegSvV6N-LmJH3rh-wlnh3moxbcvqEtUDzYQPos
Message-ID: <CACGkMEv3gZLPgimK6=f0Zrt_SSux8ssA5-UeEv+DHPoeSrNBQQ@mail.gmail.com>
Subject: Re: [PATCH net-next V2 0/3] in order support for vhost-net
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jonah.palmer@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eA8_d1mOqpC3IopUXsLAj4nN4OGk_pxO9XO2VNQrU9c_1752804277
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:52=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/17/25 8:01 AM, Jason Wang wrote:
> > On Thu, Jul 17, 2025 at 1:55=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> >> On Thu, Jul 17, 2025 at 10:03:00AM +0800, Jason Wang wrote:
> >>> On Thu, Jul 17, 2025 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.o=
rg> wrote:
> >>>>
> >>>> On Mon, 14 Jul 2025 16:47:52 +0800 Jason Wang wrote:
> >>>>> This series implements VIRTIO_F_IN_ORDER support for vhost-net. Thi=
s
> >>>>> feature is designed to improve the performance of the virtio ring b=
y
> >>>>> optimizing descriptor processing.
> >>>>>
> >>>>> Benchmarks show a notable improvement. Please see patch 3 for detai=
ls.
> >>>>
> >>>> You tagged these as net-next but just to be clear -- these don't app=
ly
> >>>> for us in the current form.
> >>>>
> >>>
> >>> Will rebase and send a new version.
> >>>
> >>> Thanks
> >>
> >> Indeed these look as if they are for my tree (so I put them in
> >> linux-next, without noticing the tag).
> >
> > I think that's also fine.
> >
> > Do you prefer all vhost/vhost-net patches to go via your tree in the fu=
ture?
> >
> > (Note that the reason for the conflict is because net-next gets UDP
> > GSO feature merged).
>
> FTR, I thought that such patches should have been pulled into the vhost
> tree, too. Did I miss something?

See: https://www.spinics.net/lists/netdev/msg1108896.html

>
> Thanks,
>
> Paolo
>

Thanks

