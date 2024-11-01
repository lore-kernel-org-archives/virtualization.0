Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E9136338
	for <virtualization@lists.linux.dev>; Fri,  1 Nov 2024 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427322; cv=none; b=TmCU/xrQgWpftOwXQNyM19ls3O9Kw5LjpXhOwsOpc/hj/vJeMBM6n4gvDydY6ke06TQ7DtJIBoyJaQc0qsOo79hN/LTlOzRNmop51R5n6YzL2qnmGdkD7mJtmJDln9V4UucJ35rZLzePpsgbucUiwnVemSP8d0Z7Tt3IQ+veU2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427322; c=relaxed/simple;
	bh=yJdGIwUEYPOmEs8ij3kiy6zzV0QYlQFlQfm8YmlYIbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP0smNJukbm+vBLrCQWgcMWeR7Q63m+GWBBnmvyWcfpEewitKpaFxJ6jo2YeDHH/jcMltrM124jRnTytwEnVhIBns/hdgjGYAmwJq0jeGoR4IOOFuN9VYjPrn9ls+xY7TYtmb3TNyhM0hEhmdt5AJGSLY7h6NiG3Bdp2hvuOw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EV3sOP6l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV3sOP6l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730427314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJdGIwUEYPOmEs8ij3kiy6zzV0QYlQFlQfm8YmlYIbg=;
	b=EV3sOP6lowtne1+EkhjTwKTQl/4VJxSqhA4kb83dl3NzBgvY4aT0SbjOacOfXoNrgZXlBI
	uW89e+oabvEonSh6Cd1BdLfecj4spWBZBK8vpeDDfc250OgcJvZA4RmJ3EwCvIlvzRvLLm
	HX4Y9Ctqlw/tmUGI8+K0fbNqeoK9qb8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-MtjUtHW1PvGF__asAPKXlw-1; Thu, 31 Oct 2024 22:15:10 -0400
X-MC-Unique: MtjUtHW1PvGF__asAPKXlw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ec0d56d624so1693961a12.1
        for <virtualization@lists.linux.dev>; Thu, 31 Oct 2024 19:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730427310; x=1731032110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJdGIwUEYPOmEs8ij3kiy6zzV0QYlQFlQfm8YmlYIbg=;
        b=DZ5Hm7PCcapWL42pxnrPBOwIPktCp6ZZrSv3MBbIloC5ltt4S5k8abp2AAWYicWFnS
         kVFfmysxJ6w0jfPunjJbzrk2mDJ078TR3kCj259Io9en0Pv53GD5T2bD07ITC9DS8kYK
         Pj/8bX6cKLTIW6fzV5Ng3fDlNA1qkk2cogVilk3aEW/pBg5jjJil1RqrAZiEMd/BRqXt
         bB+lrtbo84xFmGANpMpaH00d/Mb7cqCIXFzsFtRankwJnFfByGCBl6V1fVE8KQGDLUYC
         fqZDFT58MbfJ59tzoE754VEBuHZ0t2lApXIyteuysO2sZ5JjePe2X0cLJ4JPEGuLyK4g
         iKhw==
X-Forwarded-Encrypted: i=1; AJvYcCX3v5i/3rJ8HTIGu2wtNXObIjAgcZvyCoYsaPSFCPG5qLX5PFvIP9Nqk0Smd6IjozXogr83W4OPgWujzKhVbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxI7Gb+CG8KQ53Oa+nBKgHSd3kQ6HT0yWYAjzjQMXLZM/e2Ki6Z
	n2Hr9W2m+qbcKnYZ6SQA2uOJzSentkCtpuRgZhPc277dRCFsd7O6Bmm4VX4P2A76lyD2uZ+1YsE
	4wrcuOwclZjk9kT4bR1m7sOAM1pN9gZ+K5fAgCXSQZMax1q+xz7zDOTG4nxHRwPwZIQJBjMgPSz
	f4C+1QIJq+U0Ucd15wxVDbhlyxHQ4qSyAISWGFXq4=
X-Received: by 2002:a17:90b:2d92:b0:2e2:e159:8f7b with SMTP id 98e67ed59e1d1-2e94c29f2cemr2655465a91.3.1730427309722;
        Thu, 31 Oct 2024 19:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy16t0It8M5wuxzMCN0u7b3KxhGxysg7D6J/QWKdLqLpcbAtWiRV69Dq4QwYxCS/HPdiOkYmqXnbjdd/QPCCE=
X-Received: by 2002:a17:90b:2d92:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2e94c29f2cemr2655410a91.3.1730427309206; Thu, 31 Oct 2024
 19:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031030847.3253873-1-qiang4.zhang@linux.intel.com> <20241101015101.98111-1-qiang4.zhang@linux.intel.com>
In-Reply-To: <20241101015101.98111-1-qiang4.zhang@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Nov 2024 10:11:11 +0800
Message-ID: <CACGkMEtvrBRd8BaeUiR6bm1xVX4KUGa83s03tPWPHB2U0mYfLA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: only reset device and restore status if needed
 in device resume
To: qiang4.zhang@linux.intel.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <viresh.kumar@linaro.org>, 
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Qiang Zhang <qiang4.zhang@intel.com>, 
	virtualization@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-sound@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:54=E2=80=AFAM <qiang4.zhang@linux.intel.com> wrote=
:
>
> From: Qiang Zhang <qiang4.zhang@intel.com>
>
> Virtio core unconditionally reset and restore status for all virtio
> devices before calling restore method. This breaks some virtio drivers
> which don't need to do anything in suspend and resume because they
> just want to keep device state retained.

The challenge is how can driver know device doesn't need rest.

For example, PCI has no_soft_reset which has been done in the commit
"virtio: Add support for no-reset virtio PCI PM".

And there's a ongoing long discussion of adding suspend support in the
virtio spec, then driver know it's safe to suspend/resume without
reset.

>
> Virtio GPIO is a typical example. GPIO states should be kept unchanged
> after suspend and resume (e.g. output pins keep driving the output) and
> Virtio GPIO driver does nothing in freeze and restore methods. But the
> reset operation in virtio_device_restore breaks this.

Is this mandated by GPIO or virtio spec? If yes, let's quote the revelant p=
art.

>
> Since some devices need reset in suspend and resume while some needn't,
> create a new helper function for the original reset and status restore
> logic so that virtio drivers can invoke it in their restore method
> if necessary.

How are those drivers classified?

>
> Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>

Thanks

