Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA552D620
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fw/7IhDR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3923182159
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 13:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3923182159
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fw/7IhDR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhqrl238_EfW
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 13:32:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F03E80E67
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 13:32:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F03E80E67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703079159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VMzfUMpfCRySKV14r2ACq/M+O86IvQcMgWeUukBTaDE=;
	b=Fw/7IhDRA+57AMeTrk8LZo5kM3Rg7Lf/+v5HcPuYUrxY/HH5nFJn485jT+9qpo399TlduM
	nLHet7/U2fHlaXbz7vy0JjMaOT9attxDnyAuWzeRk3LkPywjopWt7oVRcGHlsSPYcezfEX
	3dAf5MKcvtnpxDRULIJ9tNim6yl+GyU=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-In1brmmyM7-MEmFWb7c0NA-1; Wed, 20 Dec 2023 08:32:37 -0500
X-MC-Unique: In1brmmyM7-MEmFWb7c0NA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5ca26c07848so77070497b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 05:32:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703079157; x=1703683957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMzfUMpfCRySKV14r2ACq/M+O86IvQcMgWeUukBTaDE=;
        b=A62OcWboDRV63zjvCTo6F3IwOHw5Vxla8O+8Hnxf4akvkY5nQdj1HmxtdRXEUKh0SY
         TO2huHYwV+fz67wmwvtQ30t/5MXRAD0z87xcrsGno7PY17p2iauWqNG4WHQ+zKp5Meu+
         1CV8ihbdkxeRXOmnwgksTzitOWUD6VuMaWN+6tFDDCddUViahUkIGKnk41a5bDTHvNGG
         aCXQFDUMa1xsC+2FZ9J7uSWGBPGPcEWu3VuiLmM48KCfYbD1q0gJxOHhaupqnr18PF5E
         +3CTizw6mOdd5kc7cIrO+Aq/VjbQ90Zm7CyRkAzx/yhnV8kkQUmaYkBrkJJ9n+YHLrEr
         X21g==
X-Gm-Message-State: AOJu0Ywn0gzyHtTg4CC+B7DBvopiYSJtXW6FlcZCMt18hIFzGj2I6tbu
	znghKlMYukQde5gXhm+ner639bwEaf7VGKHhP1elDEdoMvmOwP7qvR7gdNDK8KDvCeF6U5POzU+
	L4RZAT02Fq1WZTQRI4NTWd87dazHMvuxDb5IRgQukTDUOenBf/dihheEXQA==
X-Received: by 2002:a81:7104:0:b0:5d7:9515:6ae3 with SMTP id m4-20020a817104000000b005d795156ae3mr14296457ywc.33.1703079157221;
        Wed, 20 Dec 2023 05:32:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBizLEtuC1w25WSPAQRdmgfmzbhlgoBE+Ri28WemJThaBvVsn/cvQCI5dtZtYAosoVwA/ga7C8ipUzBYNV8OQ=
X-Received: by 2002:a81:7104:0:b0:5d7:9515:6ae3 with SMTP id
 m4-20020a817104000000b005d795156ae3mr14296452ywc.33.1703079157026; Wed, 20
 Dec 2023 05:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-3-dtatulea@nvidia.com>
 <CACGkMEv7xQkZYJAgAUK6C3oUrZ9vuUJdTKRzihXcNPb-iWdpJw@mail.gmail.com> <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
In-Reply-To: <CACGkMEsaaDGi63__YrvsTC1HqgTaEWHvGokK1bJS5+m1XYM-6w@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 14:32:01 +0100
Message-ID: <CAJaqyWdoaj8a7q1KrGqWmkYvAw_R_p0utcWvDvkyVm1nUOAxrA@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/15] vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
 flag
To: Jason Wang <jasowang@redhat.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 5:06=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Dec 20, 2023 at 11:46=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> >
> > On Wed, Dec 20, 2023 at 2:09=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > The virtio spec doesn't allow changing virtqueue addresses after
> > > DRIVER_OK. Some devices do support this operation when the device is
> > > suspended. The VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
> > > advertises this support as a backend features.
> >
> > There's an ongoing effort in virtio spec to introduce the suspend state=
.
> >
> > So I wonder if it's better to just allow such behaviour?
>
> Actually I mean, allow drivers to modify the parameters during suspend
> without a new feature.
>

That would be ideal, but how do userland checks if it can suspend +
change properties + resume?

The only way that comes to my mind is to make sure all parents return
error if userland tries to do it, and then fallback in userland. I'm
ok with that, but I'm not sure if the current master & previous kernel
has a coherent behavior. Do they return error? Or return success
without changing address / vq state?

