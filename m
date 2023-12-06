Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FE1A711
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVuFSieT"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4AC540120
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 09:11:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4AC540120
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DVuFSieT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BkU46L_LT7gg
	for <virtualization@lists.linux-foundation.org>;
	Wed,  6 Dec 2023 09:11:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 33D44400EA
	for <virtualization@lists.linux-foundation.org>; Wed,  6 Dec 2023 09:11:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33D44400EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701853878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXI9sUJnTAuH5o4spKWiLopVZdAAXUNFoXFFeQ8snuE=;
	b=DVuFSieTGmvl04SyuSZbYPWHIAqe3fnfkLlrJOvmAVy7vQ1F+qQLHAPis3RhsA/gw9NsRW
	E+O1tZTq3nexXDk824O9QyUhfidSbNZ4UaLXEJzcWThNAR7W18PSpUMKAkZoZQHn11uzmZ
	ZwJGyUWKCtScymVB0AkLLKhSGoMnEPU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-hyA0zBY1MOOXFkJJ0IgSNg-1; Wed, 06 Dec 2023 04:11:15 -0500
X-MC-Unique: hyA0zBY1MOOXFkJJ0IgSNg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50bfae5b114so2875188e87.0
        for <virtualization@lists.linux-foundation.org>; Wed, 06 Dec 2023 01:11:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853874; x=1702458674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXI9sUJnTAuH5o4spKWiLopVZdAAXUNFoXFFeQ8snuE=;
        b=Dwbu98YJHy8UIzw/eSmKFiTS6aAVm3Eb8RrEttW0cEfXIQoZ8ho3ac+KbOOb8jJ8Cz
         Cd1xpT4g39mso4fzhYK70pSljsfmRWF3EzihTz1n8uXyeTACpJmfnmD5lP0MH1G7RfDm
         sPU0U3X12/MVQ620dYNQczcCOwbaj0fpo+EhLyonSA8CM/HUwjpr5wBK+zlWm7opXIev
         3fXiL9RQMqvulRe+KQg55U4QsOwkOsHzMi5ysbw36cuk7zbUuXOf+Zk4h935eMsKJfH4
         VB5ICSjblbKUadUVKZf9dOpFCuoqIb2MP0r4YekHZJm+zYui22vSxkcyR4FmrURMUhxA
         2rkA==
X-Gm-Message-State: AOJu0YyOJxLcPej+6EcZXn2J9YALBrLfng8XPFPV1ErFFtclqITBFhXD
	SClzwXnzmcI5kAJPGqYKriewKD2zI+NXLa8QaDIgSM+xC+lVy68Awv1JOfHs6g4fBuyWLurOnc6
	OPDaIY86Y5x/One2ZMPs0A1mIEZvW2NOyW4DRUKexwjEoWcnCK9hhM8vUfg==
X-Received: by 2002:ac2:5486:0:b0:50b:ef21:7de4 with SMTP id t6-20020ac25486000000b0050bef217de4mr147839lfk.181.1701853873953;
        Wed, 06 Dec 2023 01:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnlHzU9sS65aeZa1sMgyX7CZTG0031E6RKQwdQI2ftq2TEJGgAwCsPHOK5SE5N3zhzEj9h14UUjDOWhGMiKJ4=
X-Received: by 2002:ac2:5486:0:b0:50b:ef21:7de4 with SMTP id
 t6-20020ac25486000000b0050bef217de4mr147827lfk.181.1701853873618; Wed, 06 Dec
 2023 01:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1701762688.git.hengqi@linux.alibaba.com>
 <245ea32fe5de5eb81b1ed8ec9782023af074e137.1701762688.git.hengqi@linux.alibaba.com>
 <CACGkMEurTAGj+mSEtAiYtGfqy=6sU33xVskAZH47qUi+GcyvWA@mail.gmail.com> <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
In-Reply-To: <ad02f02a-b08f-4061-9aba-cadef02641c8@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 6 Dec 2023 17:11:02 +0800
Message-ID: <CACGkMEsf=c_fodNUgX1idwRa9Jsd1_rsYgtZaYH3DuASJvfTog@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/5] virtio-net: add spin lock for ctrl cmd access
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	mst@redhat.com, pabeni@redhat.com, kuba@kernel.org, yinjun.zhang@corigine.com, 
	edumazet@google.com, davem@davemloft.net, hawk@kernel.org, 
	john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org, 
	xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:06=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/12/5 =E4=B8=8B=E5=8D=884:35, Jason Wang =E5=86=99=E9=81=93=
:
> > On Tue, Dec 5, 2023 at 4:02=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.co=
m> wrote:
> >> Currently access to ctrl cmd is globally protected via rtnl_lock and w=
orks
> >> fine. But if dim work's access to ctrl cmd also holds rtnl_lock, deadl=
ock
> >> may occur due to cancel_work_sync for dim work.
> > Can you explain why?
>
> For example, during the bus unbind operation, the following call stack
> occurs:
> virtnet_remove -> unregister_netdev -> rtnl_lock[1] -> virtnet_close ->
> cancel_work_sync -> virtnet_rx_dim_work -> rtnl_lock[2] (deadlock occurs)=
.

Can we use rtnl_trylock() and reschedule the work?

>
> >> Therefore, treating
> >> ctrl cmd as a separate protection object of the lock is the solution a=
nd
> >> the basis for the next patch.
> > Let's don't do that. Reasons are:
> >
> > 1) virtnet_send_command() may wait for cvq commands for an indefinite t=
ime
>
> Yes, I took that into consideration. But ndo_set_rx_mode's need for an
> atomic
> environment rules out the mutex lock.

It is a "bug" that we need to fix.

>
> > 2) hold locks may complicate the future hardening works around cvq
>
> Agree, but I don't seem to have thought of a better way besides passing
> the lock.
> Do you have any other better ideas or suggestions?

So far no, you can refer to the past discussions, it might require the
collaboration from the uAPI and stack.

Thanks

>
> Thanks!
>
> >
> > Thanks
>

