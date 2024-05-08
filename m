Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE7513FF2
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715139253; cv=none; b=SFeVFQoLIs4cb9GX7QGmyVPGBcpZk+/IOblixAwQUFfc5h3x+RUsgmuqo+L8KU3GwW4YOgvjjwFCX6aTAry0HGK2eT2Thc1AFg0nlRpuame7nb3ilJvErDyNcvQmUNGBbSPsDlJnWgA8ukqa/ShGvbj2putu8jyexKJvKHsFdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715139253; c=relaxed/simple;
	bh=DP6Las4iyZG1q0MTdVif5tZZCnRfjH1q6IbNjmsqxYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gk5HohubdX/PljTXijZeg2B1+hRd6KApnKnR2Zkf1BVGb8mF5PUAKhOlt5dzqa5H1yRDhz86+W16O7qkSH5IC1E0Lm2Nin2t29vjDd6wG/ju6B3PIZjkUP9lhaUr0zDrmDZ7lXxEljTtMNhyn8w64CJfmh5odbCTrcQMTtzr42Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3r6jiB6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3r6jiB6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715139250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVoTuCtEO04UuXZtxxmuRZe0x7MbxM+VBY2AhWXNg4I=;
	b=B3r6jiB6b0Kqi3aicXJ+g6IsLCSdH2Ckalr3+Zy8+cvdkFerl5mWisj+1cHkJpD4J7ydq2
	JWP2V2zFo8taqzp6FPm7ecGEKgIYRCEucpVO1Uif4yE+5Uzo0r4tbMU47Wx5ns8VGjw19Q
	j8jF5TGAdt1NaHWc7ovLNodkrqQ5NOA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-SNat8ReVNrm4ZrbnaSbMBA-1; Tue, 07 May 2024 23:34:07 -0400
X-MC-Unique: SNat8ReVNrm4ZrbnaSbMBA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2b4330e5119so3230381a91.3
        for <virtualization@lists.linux.dev>; Tue, 07 May 2024 20:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715139246; x=1715744046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVoTuCtEO04UuXZtxxmuRZe0x7MbxM+VBY2AhWXNg4I=;
        b=Y/RTMyP/ehomZmBlc+2ohoHyppsSHr8zPpK+CZYRrnjlzDHpseaqJGptr/hzNP8iTT
         UkLsZZ/9JvRKXT5ESMGbN72O5ecjBmIrWeFXQ2cb5c9FTDksL+rPRxMC8/7JTVjM/h1C
         +HjJQ7gxpPb5IejsBdvkdOPJ2cELA3Wqe0/OmVLxP14eiol8cuNR4ERVeZGLZ6vKjgeQ
         7y9qw9x5Hc2vrKtNgsKTuYK7AhBncHHO9HANhjve/MJEUhxjt3HHfFN41qDbTnNbvNz4
         FgSAqZ/H1YAm7e+SbGPK8s/v+17P8lTTn0aN7M6zpoXoNcP0SOEZZf+cVPlKOew5Fa5N
         rHag==
X-Forwarded-Encrypted: i=1; AJvYcCXUxfVv1ot8k8dt9NoCiqfQk87GDCLwZcrGV32yeqTUCGbblklOGUm+ZUh0BNp/VNodw/0b8861l5FM+tRnnH/9zLuhgdUDbjf4i9312SU=
X-Gm-Message-State: AOJu0Yzw1ly3TpXdkIZLIltc2bmKkTAeGXgiEqZ9Qdq+EkV81XQ3p/Gz
	5PrOkU5qJuBYrYBe3qIQqSccjESbbJlWW7/U8PY3+AwkYbwVUWE9jDolLTYG7raSriu21cgaeBt
	089T1W8h+WCCN1wFPV6D0RqjNiuAG7sOKPJTHjadipgJpgzvriw/3IA8fQxZ2qk3l4Y9c8eAVI6
	v3viBvyPz5lp+PQ6Re7xwT8mvXwqyLDW5nV0/JOj8=
X-Received: by 2002:a17:90a:d389:b0:2b6:22f0:844c with SMTP id 98e67ed59e1d1-2b622f084b7mr792386a91.36.1715139245894;
        Tue, 07 May 2024 20:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENt6vTm33UPU1sy7DBoAxP6qJq6T11Q72VgjODyJxDUQJbMYjoUQ+ibtt99fcAnsizkczIuoJeHi+xqDRM6Rw=
X-Received: by 2002:a17:90a:d389:b0:2b6:22f0:844c with SMTP id
 98e67ed59e1d1-2b622f084b7mr792374a91.36.1715139245577; Tue, 07 May 2024
 20:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
In-Reply-To: <13a313c7-c214-4d49-9029-c79b503c17dd@canonical.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 May 2024 11:33:53 +0800
Message-ID: <CACGkMEtZEeObDxcVBnvczLFGm1=13=tz_4mJGeXMw+4JgGWRpA@mail.gmail.com>
Subject: Re: [REGRESSION][v6.8-rc1] virtio-pci: Introduce admin virtqueue
To: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: feliu@nvidia.com, parav@nvidia.com, jiri@nvidia.com, mst@redhat.com, 
	yishaih@nvidia.com, alex.williamson@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Francis Ginther <francis.ginther@canonical.com>, John Cabaj <john.cabaj@canonical.com>, 
	Catherine Redfield <catherine.redfield@canonical.com>, 
	Ankush Pathak <ankush.pathak@canonical.com>, Chlo Smith <chloe.smith@canonical.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 2:10=E2=80=AFAM Joseph Salisbury
<joseph.salisbury@canonical.com> wrote:
>
> Hi Feng,
>
> During testing, a kernel bug was identified with the suspend/resume
> functionality on instances running in a public cloud [0].  This bug is a
> regression introduced in v6.8-rc1.  After a kernel bisect, the following
> commit was identified as the cause of the regression:
>
>         fd27ef6b44be  ("virtio-pci: Introduce admin virtqueue")

Have a quick glance at the patch it seems it should not damage the
freeze/restore as it should behave as in the past.

But I found something interesting:

1) assumes 1 admin vq which is not what spec said
2) special function for admin virtqueue during freeze/restore, but it
doesn't do anything special than del_vq()
3) lack real users but I guess e.g the destroy_avq() needs to be
synchronized with the one that is using admin virtqueue

>
> I was hoping to get your feedback, since you are the patch author. Do
> you think gathering any additional data will help diagnose this issue?

Yes, please show us

1) the kernel log here.
2) the features that the device has like
/sys/bus/virtio/devices/virtio0/features

> This commit is depended upon by other virtio commits, so a revert test
> is not really straight forward without reverting all the dependencies.
> Any ideas you have would be greatly appreciated.

Thanks

>
>
> Thanks,
>
> Joe
>
> http://pad.lv/2063315
>

