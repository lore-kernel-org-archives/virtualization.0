Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A378206F30
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293412; cv=none; b=fvGeItFTJ6bHANKLXD8McI0m3srrNkl0mWynnICBFgADvsz7C/V3IUra3ohphVVti204WheuNFvhS86C+XZipEYb/ELTVsScFjcEP1lFfAnB1TBXiZk+ne9C8CRSJdVwP+eccuW6mHZtC/smoMgetQd60T2+28Tzes2atpgC3mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293412; c=relaxed/simple;
	bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlQsSCp68fOkJt1fYHRHY3ar3TGAfxDRB37yktibqnOygJEDm43NsV2uhDkHNMJ0JCzykAiJ6EELcN7KQKzIPdxfmichrmPHdQc5yR/U4uUSCAEICPmEarkqh+OEsPeIXTp9bfDP4hmImk6RDZwOLNlP40vlhZIh80JLYWtfLgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ib3c9nwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ib3c9nwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742293409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
	b=ib3c9nwELDYrrI292ukohrF9jF8bTR9WFSKpH0hTtv6pkapFYQGXvGr9QOv8dB13rQyGam
	B4pFiRlrzcKLzFbfhAYqhYF4vqqsCxAAjrrav7rgAN7Gu8khCSwj3c5RQUzE+OnAq+HMtL
	VDycQFxW9t3TV34ZJNi+873DxVmQXR4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-7V3TnM42Ori1Y-ZtrPYN8w-1; Tue, 18 Mar 2025 06:23:28 -0400
X-MC-Unique: 7V3TnM42Ori1Y-ZtrPYN8w-1
X-Mimecast-MFC-AGG-ID: 7V3TnM42Ori1Y-ZtrPYN8w_1742293407
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e6caac1488so6151616a12.0
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 03:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293407; x=1742898207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu/miwHG/5DBOWrVzesxZsGrjR/i09ERA/Qp7bJIj1s=;
        b=pUOCFNyDzfRySFHEXGRtShsXVpg6nrLucJRQMrPur0p64rTc2YAvH0+sPBFMDOJZyF
         H/frRTfRYwN6Wft0wg0DkDtBq4NyJEKgHt9RU2pylTowXkrf1rgVZQJRKGBmRPp0eoGG
         Jj8xljZ6pv1Glv5mbiKXkcik2r2XiOJ3QCOuNsAMM+7hkZP3rIllg9wKsKVBsVFQ8xZW
         zzSH+hoct9JA/nDGfTRdkRicDlXcUrV2RgVC/u9L7yAbnlFUvw7sIp/qnXyVEeg6puzd
         yi1xTifDFeHOmE0GpdkNdf8nC2q4uzMuDfDZxEEdmL/4xODJA7L/r7Sb6eINztcPiqPa
         ADnA==
X-Forwarded-Encrypted: i=1; AJvYcCUerBbAEZ0ExIJqb6C7t3wLCKMvYspHdgUBWEdk8hj6F19gTSqE86aIt857JrVHsxzn1FdYfXz9Dyp+m6F15Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6kB2sPrs5ll5GD/zOlJtdXfUXpko/AqfitTlQHLrlhpri46jY
	d4ki3Ni9ZCuWaxFeBsHDYjpLpuX3MaMfVURQjj9ZzAdCkGBXUeiYlJPn6fLCpgNyM1S8+j9Enzj
	Q1gNNdMtOnreFfIsRHsUoU/Ljspvsmrm1ET33iOXwWCAbzdC7XFan5eykL4/hHiOjSqhT3bkQ3D
	5R6o5goprzXg7A8QQSCPHKYg1x1RbDmapK1aryYVc=
X-Gm-Gg: ASbGncuhHc0Ku++zD5ErLeEpVD1LwylmPVnQEGq5qxBzNTS9ynSy+PuVCfwl8EbefEa
	9yaVIRQygBgKiZMQkGHh6upDTKLtc1TPP0KXkcy9faCBjCyMM1CrhkUwqLssnnuh5l+2pQFLCrw
	==
X-Received: by 2002:a05:6402:2746:b0:5e0:4c25:1491 with SMTP id 4fb4d7f45d1cf-5eb1f0003a8mr2755894a12.7.1742293407108;
        Tue, 18 Mar 2025 03:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjyrDRk1usiBEXrUhkwIqs03+nWpkGjuY57aQwx3IT25kzIUISqmC8GAQ0nzFy+hG1pV9t2z5H2wCr9D8rn8k=
X-Received: by 2002:a05:6402:2746:b0:5e0:4c25:1491 with SMTP id
 4fb4d7f45d1cf-5eb1f0003a8mr2755871a12.7.1742293406690; Tue, 18 Mar 2025
 03:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250313173707.1492-1-quic_philber@quicinc.com>
 <CAPpAL=we6VkyBXBO2cBiszpGUP5f7QSioQbp6x3YoCqa9qUPRQ@mail.gmail.com> <xogief67mb2wonb7angoypj4ddvvecyrcsnncqitggpij6ssim@fo3psnqqhovp>
In-Reply-To: <xogief67mb2wonb7angoypj4ddvvecyrcsnncqitggpij6ssim@fo3psnqqhovp>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 18 Mar 2025 18:22:49 +0800
X-Gm-Features: AQ5f1JrBFyW8xkFgMxVk6GGg-rvzIxamknFWt0oP1OOTPXdljbsO7bXLrfDxGHk
Message-ID: <CAPpAL=xiQ0x7Vk55of1=-Hm0ijsVQkeLixv65WJc-J0sL9Fnww@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add virtio_rtc module
To: Peter Hilber <quic_philber@quicinc.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Marc Zyngier <maz@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	David Woodhouse <dwmw2@infradead.org>, "Ridoux, Julien" <ridouxj@amazon.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Parav Pandit <parav@nvidia.com>, 
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtio-dev@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rLNLc6j1_4hXEFRp_5yMV1nkDpGZ2HJcIgeix-_qlYU_1742293407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 6:14=E2=80=AFPM Peter Hilber <quic_philber@quicinc.=
com> wrote:
>
> On Tue, Mar 18, 2025 at 10:04:07AM +0800, Lei Yang wrote:
> > QE tested this series of patches v6 with virtio-net regression tests,
> > everything works fine.
> >
> > Tested-by: Lei Yang <leiyang@redhat.com>
> >
>
> Hi Lei,
>
Hi Peter

> thanks for the reply! However, I am not sure which virtio-net regression
> tests you are referring to, and how these tests would be relevant to
> virtio_rtc. The virtio_rtc driver does not have any relation to
> virtio-net ATM. Reusing virtio_rtc within virtio-net has been discussed
> in the past, but not done yet.

First let me introduce the virtio-net tests which include
ping,hotplug/unplug nic device, live migration under stress etc
scenarios. This test was triggered because some of the monitoring
conditions of the CI tool are general. I will change the code later to
avoid similar things happening in the future. Please ignore the last
comment from my side, and sorry for bothering everyone.

Best Regards
Lei
>
> Best regards,
>
> Peter
>

