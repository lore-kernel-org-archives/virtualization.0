Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B48217756
	for <virtualization@lists.linux.dev>; Wed, 10 Jul 2024 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581930; cv=none; b=Myo39lcgVZA4FFAE9hAyHCbfRT9Wd167fhyRTiSwZLz5C7FUvHJv8SCBI9nm9NzYRUAMPPmMxSxNg7cRsJdqFAi3oADuxIJBuJUoUtUeuTlpmBt++oAZt6dlQEQZkUQJ+Ikrxc6XeP83znSSW9w8Dil9EGQHR2vIcMjJXZccobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581930; c=relaxed/simple;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVhtPw6t/tPQD3keXucQyUGFbj2cO27wOj+onEMCQV/60Or/2YZyXfDe+ennI/P+3hrDF42mwUyrhbhpZOl5B7rHI9W258h6jVcK6qGHgPgmHryKvwLyd0H9dc94XSVFXPV1KMkq7oa3hlNRsb8wE546fzlRUUb6gSMLWkt/bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5wjmmmR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5wjmmmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
	b=U5wjmmmRIIAPCPMrf1k6tIIbPQtukgFXYPynadsGAdSEX/NitxsS8qAoew2SjEpsl47Fj3
	PlufNQek5z2hgzAZ6n3gi/hEtLkm0ksnMlM989muqxIaUqFL42IscV3VEPKbjjJCkAD0NG
	rJlbNwOTHxtjhp3T4JbNXsIXAfIpSnw=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-cZFfEPUqPIuR4SjapEz-VQ-1; Tue, 09 Jul 2024 23:25:24 -0400
X-MC-Unique: cZFfEPUqPIuR4SjapEz-VQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-380de513597so59668975ab.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 20:25:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581924; x=1721186724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sbwGihOLkbKRAKocXOlId4hhNDwPbs0zE0X3aDWblY=;
        b=AdX9SbKdcrLfWFMR0+o/4ybzbRSJ0TX62NuXz32B02W8Pus9wyLclEBErlUuzRFJue
         nOXHH7vOGFZSuTHMwA2DvVaEklbyHGqgUU8EiAvLueKxCSuY4X0NHa43pn+itxFjtat1
         +/y6DIl6Efu9UixyInIPTe9wUxLiE7Orw/t6tYcYiPkLhUZOxmoFMn86blFUWjU9Ehqy
         n26QB6eXBVpQJUSCIJhZ6gMK+LMvT1/vxYCrVUc3M3Ju4ej6GN2nJFNSNterM1CaFpba
         jfcV2vCboFs6P2U8/u6mzmdCnsvj5Qiepr/XhLP5IjJEcjEx+NXfX9036Pm9pUbsu+5n
         iabg==
X-Forwarded-Encrypted: i=1; AJvYcCVO5WZ1bdlZ3mc/5hXxaS7qQfmV5fLuXZ9IL4Y3OJwgElBlvnisKzmhu+vMJGcWlDG0YxcrbKydoLgRCdHRj+ojBhl6wzadmDIE/5KacJ4=
X-Gm-Message-State: AOJu0Yy+LJ3aq551jW273Api6U8zYYfitGeXOi8lSXvScEiISjeubJEJ
	/HMo7QBjDeFHYdI+KwGz0rCE8pmgQIuzxYExiJdCW0sWJ51yBcYVvcLuojWVmrNLEoFmzzmYCBk
	x5m3CidAHLIZrNrB34OXnT6Wih2ciPtCYcUmixc/iZGuJijdlZefv/e+pfRkSeNPL8f1bzQUF11
	IConKh87DrDLK3mM+23yFq2ruCBIYcvuNZUMluh3M=
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id e9e14a558f8ab-38a57bcd755mr44254595ab.11.1720581923964;
        Tue, 09 Jul 2024 20:25:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8tp760Eusr7cpOewOOzt8KywljVE5imblpi4EA9nOMhtnhRxpdbKT5KwR6ZV/XXWj53jrT/VMHmkMmslXtc=
X-Received: by 2002:a05:6e02:170b:b0:382:b436:ecbb with SMTP id
 e9e14a558f8ab-38a57bcd755mr44254435ab.11.1720581923592; Tue, 09 Jul 2024
 20:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
In-Reply-To: <1a5d7456542bcd1df8e397c93c48deacd244add5.1720173841.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:25:10 +0800
Message-ID: <CACGkMEsg0+vpav1Fo8JF1isq4Ef8t4_CFN1scyztDO8bXzRLBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio: fix vq # when vq skipped
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	linux-um@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> virtio balloon communicates to the core that in some
> configurations vq #s are non-contiguous by setting name
> pointer to NULL.
>
> Unfortunately, core then turned around and just made them
> contiguous again. Result is that driver is out of spec.
>
> Implement what the API was supposed to do
> in the 1st place. Compatibility with buggy hypervisors
> is handled inside virtio-balloon, which is the only driver
> making use of this facility, so far.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

