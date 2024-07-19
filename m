Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688222CA6
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721350937; cv=none; b=i4v5FKDMyts9XCMbcd7KxJjTFs7sNuLQt4O5dS/+HQbcAHZ5Or0mfkaubcrd9zZsWXb6hTomnVmtGM40sCA/TW4mOpIfiS6maE/DTiJHHmkyc1AK9haZFM4MDzTgD9S01Hc3SOTiAWEzzTO0dd2d6Kyr/Iu8Ss3pah3zxFUca04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721350937; c=relaxed/simple;
	bh=egPWD6SvkPUOxMbhJVXX/ZmlFwvqOXO8b8h7S1FD3o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJxyYQRP4yumIt0K8FhYZJCxXdxwARL+OnTcFJCV/ytSc1rJ8QIMo7ADHauZjlsYGzNBYxp3dP59oYE+AqOO7bW3wNgt/SkS00k7FlkX5Xa9Cp0R3zWa3hRTcRZtRwajbd1XBVRmhb6kaxiy8yO3nczD+4/ugwyfkZlI2/BN7Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iq9NnMdw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq9NnMdw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5C784094F
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:02:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XLezAs0IiWxE for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Jul 2024 01:02:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8D48540929
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D48540929
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iq9NnMdw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D48540929
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Jul 2024 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721350933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Juhk1rxXqcv0LvjBmmBek/yRx3F0GQ+A2PArt9J+ciU=;
	b=iq9NnMdwi5blWniQX7AW6SwfEjroBweI+CEbahidY6S1co786zw/Bh4vHsCBQBMJEoxlo4
	iUwnBj5U4FjUKwjxdw7Ev+NM86HODzI72vfh3b9ommDF8L7awY1ZCGfDVf7nWdKQoOMZoE
	w8zdtQ4L9PLSC3u8Xi+XQNlJdAYuW/8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-zZ2rMAv1PhKmARiktfEH2A-1; Thu, 18 Jul 2024 21:02:11 -0400
X-MC-Unique: zZ2rMAv1PhKmARiktfEH2A-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fc52d3c76eso14059605ad.3
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Jul 2024 18:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721350930; x=1721955730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Juhk1rxXqcv0LvjBmmBek/yRx3F0GQ+A2PArt9J+ciU=;
        b=SWqAVXvDLGwf+LZAMZqmRlFK42U5aP23JBgD/gN0l6saXBmc+L7FsUiCikgRKJetqQ
         NLx6N6341gKiaIrpAZ3vKf8PLRFfXVHTcDGYOUvzLysG2wd10MzqW2P6hrCI9r3dl9Ws
         h5r2RgXbDrG3GmN5eNA+NHmjsChN5QmSQ0cjz5pHYUtSSN5lDZy13pNo2L8CNNE7uNce
         bC3eE85MRrCoMMBIKijDVD4wNTRE3Ba7LqV7MCMWA6IsislX81c12UwrIXsScohHsLSF
         TgesVEjH95UyxCvX4OTNntc+roGb/sAN/oQmF1ManXW8ysthSWWIKiEWMiVtgEe7QrYZ
         pOVg==
X-Forwarded-Encrypted: i=1; AJvYcCXFJuxKYJpKa2KD0aimwi9fJiUX3OykoQHI6KmCulqkoZ68gMEOJI7b9iw2jAewaefgg66+/B4kWdbZnn7iFT3VF8Sgt76saa42vhWO9F/lwVyx7ShERXC5cg==
X-Gm-Message-State: AOJu0YyvOiXHa7mYIrhqIO7Y3yE6yI9CXKnLND/dssdwpYghP0XJRpv9
	u/CaVAd4B782h+aQgRwtY7RyqoI0DcJP57wTGhNpVzW1gMtOqsWh7BihJ0nfLkZTeSctWVHrkKc
	qREuxf+jnsumOuNzj4xvcgMIod86TbiVo6fdLuqT/OTH42MWY4zdivWC3WovdmT+JrrzYZ1pvv9
	bqYADT6mjLTKAFWvCXdNTEH3M7vUybYYQiwVyJAtnmjZoi1AqNo+jA1w==
X-Received: by 2002:a05:6a21:39a:b0:1c0:f529:af05 with SMTP id adf61e73a8af0-1c3fdd4d914mr6793196637.43.1721350930346;
        Thu, 18 Jul 2024 18:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIRWijrC51r9BOXUiE6Aug7hDC6Lr0jyTkTo6KMrQRu/t6/fcr6+L8+BQ4wl7rzCezfYFnYOWyCyo72nnIjgU=
X-Received: by 2002:a05:6a21:39a:b0:1c0:f529:af05 with SMTP id
 adf61e73a8af0-1c3fdd4d914mr6793160637.43.1721350929827; Thu, 18 Jul 2024
 18:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240717053034-mutt-send-email-mst@kernel.org>
 <CACGkMEura9v43QtBmWSd1+E_jpEUeXf+u5UmUzP1HT5vZOw3NA@mail.gmail.com> <20240718152712-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240718152712-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Jul 2024 09:01:58 +0800
Message-ID: <CACGkMEtTVmKYMdvjzE753+czmEcts4caG859_jW7nHQt7ATgkw@mail.gmail.com>
Subject: Re: [GIT PULL] virtio: features, fixes, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, aha310510@gmail.com, arefev@swemel.ru, 
	arseny.krasnov@kaspersky.com, davem@davemloft.net, dtatulea@nvidia.com, 
	eperezma@redhat.com, glider@google.com, iii@linux.ibm.com, jiri@nvidia.com, 
	jiri@resnulli.us, kuba@kernel.org, lingshan.zhu@intel.com, 
	ndabilpuram@marvell.com, pgootzen@nvidia.com, pizhenwei@bytedance.com, 
	quic_jjohnson@quicinc.com, schalla@marvell.com, stefanha@redhat.com, 
	sthotton@marvell.com, syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com, 
	vattunuru@marvell.com, will@kernel.org, xuanzhuo@linux.alibaba.com, 
	yskelg@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:28=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 18, 2024 at 08:52:28AM +0800, Jason Wang wrote:
> > On Wed, Jul 17, 2024 at 5:30=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > This is relatively small.
> > > I had to drop a buggy commit in the middle so some hashes
> > > changed from what was in linux-next.
> > > Deferred admin vq scalability fix to after rc2 as a minor issue was
> > > found with it recently, but the infrastructure for it
> > > is there now.
> > >
> > > The following changes since commit e9d22f7a6655941fc8b2b942ed354ec780=
936b3e:
> > >
> > >   Merge tag 'linux_kselftest-fixes-6.10-rc7' of git://git.kernel.org/=
pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-07-02 13:53:24 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/=
for_linus
> > >
> > > for you to fetch changes up to 6c85d6b653caeba2ef982925703cbb4f2b3b31=
63:
> > >
> > >   virtio: rename virtio_find_vqs_info() to virtio_find_vqs() (2024-07=
-17 05:20:58 -0400)
> > >
> > > ----------------------------------------------------------------
> > > virtio: features, fixes, cleanups
> > >
> > > Several new features here:
> > >
> > > - Virtio find vqs API has been reworked
> > >   (required to fix the scalability issue we have with
> > >    adminq, which I hope to merge later in the cycle)
> > >
> > > - vDPA driver for Marvell OCTEON
> > >
> > > - virtio fs performance improvement
> > >
> > > - mlx5 migration speedups
> > >
> > > Fixes, cleanups all over the place.
> > >
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > >
> >
> > It looks like this one is missing?
> >
> > https://lore.kernel.org/kvm/20240701033159.18133-1-jasowang@redhat.com/=
T/
> >
> > Thanks
>
> It's not included in the full but it's a bugfix and it's subtel enough
> that I decided it's best to merge later, in particular when I'm not on
> vacation ;)

Understood.

Thanks

>
> --
> MST
>

