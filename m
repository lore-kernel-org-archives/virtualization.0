Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E645629C
	for <virtualization@lists.linux.dev>; Thu,  3 Sep 2026 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423422; cv=none; b=Kyxii09Ib3cXwNc30ixEKTf98BYmmKoS45uxqtrMBoP/sQnM6uC4yED+mJ8n1f3wr2a4fdziZLXRFAwhJ3Kw6yyQ7T1G56WcyzzvVkwwrw4BoshS93ML04WlwuLly3DLKZsw8/KlTbrcLaGEGraeFa+m/NVgclb2yBJCGD7b7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423422; c=relaxed/simple;
	bh=F/nYNZsGTMxhWzzvUohFY6Whct0y3BXt+FoFwDELyu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heWDo7fVz2vKkX8EOxMfYtNWIUNO2TumsWKln3L8Kanocby4e85OB6GPGZH4dBmu/98ybksKF8p6pibOelvl/MAU16TZ7di3fU+4CpPUNF3/lTrWvySNoaIrZQZrZFeds/FJqAnzAieoTHS4n7upg8nuL40ZgTr9qUhdxnZYJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gfe6uM40; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gfe6uM40"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788423419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBi2OGA1RnDTo2IDvDX78amvRnsBN8dzg7HrP+xghMc=;
	b=Gfe6uM40N3YJqAVsgZLHyyE1yP8ecjD25+s14EQP7H5TWLrfmeYis6IDizVdLfSPQ5ZIQr
	Nl68bPnShY/UGPt66mEQGPT226O1INoBFv25obA+o/B/PIbu3jghAYkKDfzndAdVbCYqJG
	+SXfXn/Oi64hvc7D/K8axC8Qn+sJF/o=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-t5OOY7K9N160DBkkE1lf4A-1; Thu, 03 Sep 2026 04:16:57 -0400
X-MC-Unique: t5OOY7K9N160DBkkE1lf4A-1
X-Mimecast-MFC-AGG-ID: t5OOY7K9N160DBkkE1lf4A_1788423417
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-86617faa2b2so25513467b3.2
        for <virtualization@lists.linux.dev>; Thu, 03 Sep 2026 01:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423417; x=1789028217;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qBi2OGA1RnDTo2IDvDX78amvRnsBN8dzg7HrP+xghMc=;
        b=fucQUNXbDdmMPD4CHSbqOcT+cYCayHU3ndlAFeK4vybIW9C7gKcrFmcKfK4VZurRsM
         HLmMQMzqvx/u7S1TLRvtdLm1pRv7Sgh02stVc+5cBJtZQ/0QZFs7yLFa984NakAtRCm0
         AfAOhmr1DWR9FylgiJVfBAqNHpdIzIdOYHxPWVqtYnPhojBTjppnWt5HyCVM8pPhLD3C
         2AIdfepGpnRqBNKIGalrbWT5R/bJqnwI0oAvVXy4/hWlrW8vJI+xg4FjsBAPSn6WpG36
         ADBW9DaY3qi8p7C+K1HSUlyw51UMdH3rpot/kBjGydbQNGFmS50HoyatJEjTXN+GlwBx
         Io6A==
X-Forwarded-Encrypted: i=1; AKwUvBwiYKRPUU2iM28qQ1SeMteGsnM3eu29ONVi/VZd9yHBr5bbvt78S0BTgyQ70KjdOh/E49rwcWfLkv806URYmA==@lists.linux.dev
X-Gm-Message-State: AFuF++lXfiYzqoHVW6WW01u/zxpRsAMHnQ4qyru2hDANYXIUHN7fk4lr
	2dbdt3empq33lRuK1vS7xs1a7A2ApB/wIMNVBkb7ioaPrjdjFK/j5vFN13RMHRLjbBHZIrBM0sY
	nDYjSfyNb0DWXNaIWF+Z7KeeyF0jNBag67p+mcirQB9X3xlSyi3FiwZFt3IDIbOZWHq3/+JenOO
	4KdQR1hEDqb0VhBQFhTVSwjOcqwrLNafZ9XFxPcGiBUfU=
X-Gm-Gg: AYBFou2V59YlMd4+coREvOkrHPEcziBsv0vPvuUJv4BAhKxbCWadnv/SJ6eZ2q+GThK
	FJfVGTvG54pEOXonN1VE20wmNzx5CxIO+Ew8eB0TOsTlAui3yUPDwUKAHGi3ghzD2Dd+AFqEDZR
	Fybx91pm1XHJqvY/LC1SKUTcp5As1HLhaq15xvi572KeeJ7moGkbcwaOhhSOsKnTcwvVpaiFXkz
	W6fIABrSF4j+vQb0dF0P6ktPJIFyK829S4/PaKWjPzHueNcvlZtTAXCL4s=
X-Received: by 2002:a05:690c:e18e:20b0:834:fadf:6085 with SMTP id 00721157ae682-86c4e201d3dmr40719317b3.4.1788423417267;
        Thu, 03 Sep 2026 01:16:57 -0700 (PDT)
X-Received: by 2002:a05:690c:e18e:20b0:834:fadf:6085 with SMTP id
 00721157ae682-86c4e201d3dmr40719117b3.4.1788423416899; Thu, 03 Sep 2026
 01:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260902092459.1983909-1-eperezma@redhat.com> <apgahfkAdwYcu_5a@sgarzare-redhat>
In-Reply-To: <apgahfkAdwYcu_5a@sgarzare-redhat>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 3 Sep 2026 10:16:20 +0200
X-Gm-Features: AcwNN1U8Cyero_j5_fzuPGrKVCe3JL9kEPdI4kDTanDts-9genlh11Ba6z-3HwU
Message-ID: <CAJaqyWcQic2mRTPaXY+jt5Dscvsf4XQ659NNnn+pbaKGmKu0Tg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_virtio=3A_add_Eugenio_P=C3=A9rez_as_Maintainer?=
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, Jason Wang <jasowangio@gmail.com>, 
	Laurent Vivier <lvivier@redhat.com>, jen@redhat.com, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M-FN0uFNgpusN_R6XYyWNTdYXKYoveR_TUaVnC7z_FI_1788423417
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 2:49=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Wed, Sep 02, 2026 at 11:24:59AM +0200, Eugenio P=C3=A9rez wrote:
> >Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >---
> > MAINTAINERS | 6 +++---
> > 1 file changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 3a19da74d00c..a92c5712d8cc 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -28877,7 +28877,7 @@ VIRTIO CORE
> > M:    "Michael S. Tsirkin" <mst@redhat.com>
> > M:    Jason Wang <jasowangio@gmail.com>
> > R:    Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >-R:    Eugenio P=C3=A9rez <eperezma@redhat.com>
> >+M:    Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Should this be moved up before R: entries?
>

Ouch I forgot to reorder this one,

> BTW thanks for the effort!
>

Welcome! :).

> Stefano
>
> > L:    virtualization@lists.linux.dev
> > S:    Maintained
> > F:    Documentation/ABI/testing/sysfs-bus-vdpa
> >@@ -28954,7 +28954,7 @@ F:     include/uapi/linux/virtio_gpu.h
> > VIRTIO HOST (VHOST)
> > M:    "Michael S. Tsirkin" <mst@redhat.com>
> > M:    Jason Wang <jasowangio@gmail.com>
> >-R:    Eugenio P=C3=A9rez <eperezma@redhat.com>
> >+M:    Eugenio P=C3=A9rez <eperezma@redhat.com>
> > L:    kvm@vger.kernel.org
> > L:    virtualization@lists.linux.dev
> > L:    netdev@vger.kernel.org
> >@@ -29009,8 +29009,8 @@ F:     include/uapi/linux/virtio_mem.h
> > VIRTIO NET DRIVER
> > M:    "Michael S. Tsirkin" <mst@redhat.com>
> > M:    Jason Wang <jasowangio@gmail.com>
> >+M:    Eugenio P=C3=A9rez <eperezma@redhat.com>
> > R:    Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >-R:    Eugenio P=C3=A9rez <eperezma@redhat.com>
> > L:    netdev@vger.kernel.org
> > L:    virtualization@lists.linux.dev
> > S:    Maintained
> >--
> >2.55.0
> >
>

