Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2D4E60C
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="vUuc+1EO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso1021166a12.3
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 04:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703592865; x=1704197665; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=vUuc+1EOolEn81OR1Yptb6RD+4fmrxNCE/OHb33rPidlg7bJaQ8QYZRcemi79ZIol5
         zE5nWjs9rydUzWFTBYyqq4VW428jhIkpTKvwpGQNCWWhWH0ZHsN20zwPoHdVGUIv5I4O
         qCAoab0JjSQm6Hza8a2MFStSy3nuPJVWYKs9VjgAxYYx6MTb0/cTHGRow3xTLiSsdenW
         cO+iamTv/ZwLYAkNKPNgjdGETnNTKk3Dm9cRbnFp4395dJYitnsJTxaNHQpdastvHCb0
         ElvyN7OySFOJCxsCm+zkussP+YPXb3FPgfhFw1xzuTxpJmloS4nTBtFiLfinJ74lP6ha
         6Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703592865; x=1704197665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgFlNYVpTW4/LSUdsscecibsDCHhy6INDSaJkTsHmeY=;
        b=d79cmcCARiSGvxF14rDpyImnnYtLUHrmlOdj+EoWZu7Ti+zAhtgMEx4IEg1FvwW+Ik
         NJOoPzvb65r+B2Fr5iT6L/XXyDrbwfz5BBhRs+wcrb3CxrXLQnHCEDdj1fECdci30Ccl
         SWRwk7hMixx4gzjQSoJTcom3cCyDGIUrQA8fHearDj1UIP0rctbNKB5MY2kTmg4IwdS7
         5yca39rg5FYsPG+C9KMCkzTUmLZx01O3swOAeGX6szS5F5mwb7WUSx53OtTs4FOFpBn9
         YMx6aG4qft+HJ6j9oxj66Dc0X7R3XubOXyQfMY/zioYaEFMnti99dqGLVhoa21USmLIB
         KY6A==
X-Gm-Message-State: AOJu0YzDFKKBxdP/mW3WL/Vbtzj3PgzSFKyGaUYIvuMqYE4uh2DDu+/O
	6GhsL58y9G4+QZgEkfsDMfCMhpf5iPVcHfUCH+MFzdN8AClH9A==
X-Google-Smtp-Source: AGHT+IHxzCgO2oCLfPXnR4/Me1mMAqfQos7RB3BFSZ2u3yzZCPtF4kJmY71gWFuDLOAwlb8zPxryR79r59mCSy96caI=
X-Received: by 2002:a17:907:1b12:b0:a26:ebc6:eb7e with SMTP id
 mp18-20020a1709071b1200b00a26ebc6eb7emr965572ejc.194.1703592864489; Tue, 26
 Dec 2023 04:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com> <20231226040342-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231226040342-mutt-send-email-mst@kernel.org>
From: Li Feng <fengli@smartx.com>
Date: Tue, 26 Dec 2023 20:14:13 +0800
Message-ID: <CAHckoCyBxHd6Lc8UPh_3urSHz_eDj6jrm+c80+wKBmypzjvz+A@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 5:05=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
> > Hi MST and paolo,
> >
> > mq-deadline is good for slow media, and none is good for high-speed med=
ia.
> > It depends on how the community views this issue. When virtio-blk adopt=
s
> > multi-queue,it automatically changes from deadline to none, which is no=
t
> > uniform here.
>
> It's not virtio-blk changing though, it's linux doing that, right?
> Is virtio-blk special somehow?
>
Yes, it=E2=80=99s the common code path.

Each block driver has a chance to set the default none scheduler, like loop=
,
it has set the none as the default scheduler.

https://lkml.kernel.org/stable/20230809103647.895397540@linuxfoundation.org=
/

> > I don't have ideas right now to answer Christoph/Paolo's question.
> >
> > Thanks,
> > Li
>
> --
> MST
>
