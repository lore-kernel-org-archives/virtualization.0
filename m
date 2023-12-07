Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19154125CD
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOqB31eQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701928970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
	b=EOqB31eQj4eW2AWO2+ga7q3M/b/dYM3NW0AJ2LiWA7voWfBE3SSEedLs8jUmVhnxDOxtlC
	9UdfiplptD/DIfJuYGCLwetDDpsMTMFWybH+rl/I0uOnNIGd090JbgQGklqXQ605FcDOhC
	kGfZKLFyUlnva4FaQXDEkvcVfygTRBM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-ZgcKXaSgMWu4abUOFsvlSA-1; Thu, 07 Dec 2023 01:02:48 -0500
X-MC-Unique: ZgcKXaSgMWu4abUOFsvlSA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1d1e2283b6dso6620805ad.2
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 22:02:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928967; x=1702533767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/XqCkGwetPERlH8LTIVNcKw64vcUuQSwWmVxlaN7SM=;
        b=nJRsWoEnUAhKEkelztf8odVYeMt/kmdSvv8MazglXgYqH5uzucnQdB/36y6hLr72C3
         5xIZvPP+D3478rSck36Q/Q0uA+pNC6Fnkt+Gz1ejMZhiSp6WS7CffCvc0m4uVoplwHp1
         ingyOSfiYznGFehPmyhsLeP8ulsaT9xxFbLfUPOq/LA8s3cWtdhevjImXpDdc2V8duZP
         Wuy7FkLcmq/Fx5MwLMSjhw7AkBrZWHu6/Nshj+LPECtw28L+o5hMmR8cVCuc/3Uwzt5w
         WYChytqU8z7CjXrK56rt8ym/2WtlBww0xtm9ZvP1E0odXmak1Eq5VuhrOy2lZ6SsN1Gc
         6Z5A==
X-Gm-Message-State: AOJu0Yy+HeGRngDkZIqLAZ4xAlq/PPcdEzabhu9TEDzYp6clYPyvtfx6
	YoO4o55pUzvrcbdX6rVJvb+AsuSqlyhfwtyF7UgIPgjd6peB7AQHFmF53i1Itm+gsY8QXn3BTJq
	duNuz526SA30Zj//jys+5Iu3CfYew0VQAA2do73lg1Bg=
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id b14-20020a170903228e00b001d09c539ccamr1954631plh.96.1701928967273;
        Wed, 06 Dec 2023 22:02:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGownq1ugLEOsfZ1cOJOiCkaYo93T8MWTSEJJFK0j1YeFaEDArhl552qEMO2cfTnbzOgcp/3YMGRbZyZbgPil0=
X-Received: by 2002:a17:903:228e:b0:1d0:9c53:9cca with SMTP id
 b14-20020a170903228e00b001d09c539ccamr1954622plh.96.1701928967048; Wed, 06
 Dec 2023 22:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com>
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 14:02:36 +0800
Message-ID: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Li Feng <fengli@smartx.com>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> wrote:
>
> virtio-blk is generally used in cloud computing scenarios, where the
> performance of virtual disks is very important. The mq-deadline scheduler
> has a big performance drop compared to none with single queue.

At least you can choose the scheduler based on if mq is supported or not?

Thanks

