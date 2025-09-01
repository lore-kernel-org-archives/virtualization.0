Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92191C8604
	for <virtualization@lists.linux.dev>; Mon,  1 Sep 2025 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693692; cv=none; b=IDbVJ93FJBRu/qnWJiMegQuZ0V1BbOiHuD0VnTb+dQgdBshGmXTtHHCFAmohuo9/SEeOQcAqh7YELFN50hTuiCYclrP3aYTwLiIlckU9TS3ytI4524EDodNuVPS8ObkcMoQY0U09CDPjZbMORBEWepKv/+my+TVvYOhfdoFnfc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693692; c=relaxed/simple;
	bh=Py2A8RiduT0WX3K9RjBXxRcDBRvzu01D05c+OGIsoNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyPQOT/LbCUOHulu0vai6mDj5hil2Npt6UnnPRD+kCtzdfQ8NA8JOTFuHRF3d1NOpf/qIRU4JMEVfCdryjx2NZfObAo6ROaEWBF2bDT6zgX6jnaf3sJDzq8gvIZJr54e5ea4ELgHZEyKZTOJjYbP4Am3U6pqE2+11cJ1lflfmHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DB1Py8wZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB1Py8wZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756693690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXJokDPos0nKm1zfHnhLzwyRYR4oCXMJNHGtY+hKQ1U=;
	b=DB1Py8wZdg8AONCNeDNlQDcizfuMRnNtJJ4uty/lb00Pez5iQtmc6lE8bf9iv4xjNrd9j+
	5yMEYvx3hKqdhuznZeZVTig1pgwhWN0s64wbC84RGuZ3+lNJ7OIgj37NO+NUrrxSdzdCcx
	TBj8flQ0ZfM1vieHpLwmFXqGW5kdssI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-flxGO-lZNhyRwU3HImBqSQ-1; Sun, 31 Aug 2025 22:28:08 -0400
X-MC-Unique: flxGO-lZNhyRwU3HImBqSQ-1
X-Mimecast-MFC-AGG-ID: flxGO-lZNhyRwU3HImBqSQ_1756693685
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3280d0d4d11so2465160a91.2
        for <virtualization@lists.linux.dev>; Sun, 31 Aug 2025 19:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756693683; x=1757298483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXJokDPos0nKm1zfHnhLzwyRYR4oCXMJNHGtY+hKQ1U=;
        b=D7g5BcXYIhryPEVsoDWr2+AOPaBM5sI/L+cLm5ARpEsuKgRlfBviDSHJrYnh2nOMNv
         MSXBddbYJE/DVVLqNrvCu0BWMS4QbI77FjyhMVINmahAA9WhdVVVlc5epaCp22K3c/qj
         thiM0zTV+6Oskb1z9RWL8Cg5d08wWiUP6syJxuhiHBF1R9NvSeYJQKBYWgYdGOxANGNN
         iDwxtUgMwBNa/0oW89Vz3gxg9Bg4Y13Ehcjxe8MtVbl0Mjq1u9ZfJIWkbrv2WjBoASdD
         HyEyc1TiVvAkCo0ornkY/2efLl7lrZDwUKBA3J4pNQAeAYkt8SmaeHUwVBxFTMQMci87
         mGvw==
X-Forwarded-Encrypted: i=1; AJvYcCWd7DosTP8DedquMh1euohiHKSY3BKl3CNVqNxAEkliWpsHzXPwWwRyzEZRBjMAUHwc5gfLTuQ6Twk23bdFyg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzq2ZsTioiyzu8h15E/6zc7GiiyuGBd9iZ5pPtef5qwA+PL2kxd
	WU3ZIAHIGWnpFMzG+CcpIr0aKqfFk3vfVB82C9GxYpmziA6pBOdIVF5zm37EGMIdwSKtGZbp4BB
	ONK32modn7XVtGrlRQHStaBi8O3ai6Hcf1I9IakdZOUorZ9EgbLVjOfmH0qkKlkOb1l86ivU8HP
	rJDtytdIW8+xooJ4kq5acI+XSBRuaMkCOOG+ERGsy0uGU=
X-Gm-Gg: ASbGncvpnrsrUL8A3gMw3vmTjke2CuQSjLXxXG6yIFWngXwG1lz+UbPBkUUDECsJTOa
	Nv1eZ7gRJDr+ovA50v6N5sfVd2CwemfkCup7MmuAczw3tuWGQIeljJ3k/Nzm/vMgm43QLMp2cXJ
	ws+f84HKpMgPG61J09L7Vsww==
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id 98e67ed59e1d1-328156e3815mr7104440a91.31.1756693682639;
        Sun, 31 Aug 2025 19:28:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUaKN6UXluy29/F+dllwNkQH5s1R60oXrZmMH950RWWU803/YD+qBnqlF6FdoKrHFnYLN6xdG1JqlH061AyU=
X-Received: by 2002:a17:90b:48c1:b0:325:42ad:29d2 with SMTP id
 98e67ed59e1d1-328156e3815mr7104413a91.31.1756693682199; Sun, 31 Aug 2025
 19:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250826112709.1051172-1-eperezma@redhat.com> <20250826112709.1051172-5-eperezma@redhat.com>
In-Reply-To: <20250826112709.1051172-5-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 1 Sep 2025 10:27:51 +0800
X-Gm-Features: Ac12FXzdv-h23IXc14dM4bQKB8o4sC_53xLf6KUcXeaogY5iF9KPgzgWOswds0g
Message-ID: <CACGkMEshp5HaRPchAkYGD2vi7xPBBi=w0H4DaUXOXas4SQ3WDQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] vduse: create vduse_as to make it an array
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2fOxnfo_CBpuuu8Kq99MnTkp-NVI6STNGX5pYxznkQE_1756693685
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:27=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> This is a first step so we can make more than one different address
> spaces.  No change on the colde flow intended.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

