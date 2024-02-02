Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CD1774C
	for <virtualization@lists.linux.dev>; Fri,  2 Feb 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856820; cv=none; b=r+KzmztkdEOLIWgOfOHqWZc+rFbuhzUjqQS8nrM/yyQJ/SEh4SFOH7Pqm/H/HWC8LZMg8p8OFTcPOAD5Uj6VI2deokjxyg+yX1OjlB3vKurQ4goewEj8Shfp0G+WbScejzTchTQUxA+OaitQB+Z85FjmI1btVIGMhVSOg3YBVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856820; c=relaxed/simple;
	bh=ytxKKoH6m1FpvOOP2xrdqPW7rQRGcgbpp2Hofo4i82g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yqp+0yWHk0lNPcngAoTQqI9N38j+KGTi89Mcio9FTpP/ORJNOAiKq1+ItIj1G1UA3QU6p/W7/GnW39ZITptyGvZiHXvBuI95+BgBOfQYq2hRqOy/WyR8j6si9qMaz6ou8+GBb3tOgOUiXllIon4H7EUSkoDmHOnF4t8fbgX6Wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2pwjFt5; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2pwjFt5"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so2336045a12.2
        for <virtualization@lists.linux.dev>; Thu, 01 Feb 2024 22:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706856817; x=1707461617; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAf503YgteKPE3E8ZXGS7zG1wXVaCsQDoyqCH3wVqBs=;
        b=j2pwjFt5hj57O95B7P13pPrlohyAOsjU8uc3ccEyHcqaIFIN3Z+EUW0mitk7Iluy+b
         VL8p5wO5gOhzPzFKYSaOuQLAQJ4OtBmRqOZH6xPNq8Dp18eg/yzq7DpadeO3jRjvnxif
         JaFcd1knZkHkouvaj08gTqMC8ord0cvEgQd4WL+LBS2QusW97pNaGq8QWqziob2Kyldc
         laza5VMxsLqJTEZ3HzTZKRqfOkuPWLSVGd95hP3ZMVI6jLiypJFG3vet/4LJPIom7UA8
         8P+woDqVYUTEsdSz5ocyheHqIbSdzrdiwgAroV6aJXwXlt0Q9gzDv9KyvDJrpA74Oamc
         xaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706856817; x=1707461617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yAf503YgteKPE3E8ZXGS7zG1wXVaCsQDoyqCH3wVqBs=;
        b=Mw6Ag9KPij8I0MiII8qDkFCW62lHLhMw0trczcyGFY4DPY+kiYKFMHPNxwHKuIBJPd
         6sjcmQ9w2oWWwt8IP0fJkz7/xGAVlf9J+pS6+uAvPJV+x335XQbnqFV2GALjfVrWcSFr
         aE95ck86tOCzqz08GfcjZulIwRyjFsGy5avnRMQmeWf6EarL+AqGww1hB7yAA81ds4T3
         4aqLnhWHjMzybw0p0+8N+nQwLWmhB8fiR8cJrHddsP12KfnMNfJuhfrVdxTu2IVtf95L
         CLovmk5Lc11qg5bLtp3UE80/S2Oa0ffl/2RROnfDF0CqdxgFnlBL0ML4dJJrUP3ti0nb
         Uf6Q==
X-Gm-Message-State: AOJu0Yxh2KN7wZZZn+2lvy280EktRepIV/kVgZrSddW+gv10hMdr+CPw
	aJYWiLQawBJOG2Z8/mqtKcw5Vrs10ZrDL6l5r+mU3noyHUSyXoqe9StX6I327/yw3UvFDL1kG7W
	sj+0XdlgrHu3HaHx2+X+fv9zycL8=
X-Google-Smtp-Source: AGHT+IFSnJi2norEH5W/UpLjlPsSq2FcH7Nrf5O3rTb2MutI1ES6hpawvaZT7z+uaATyDRcDLlC4fFluOy1XAaFM9PY=
X-Received: by 2002:a05:6402:164e:b0:55f:a1af:a1eb with SMTP id
 s14-20020a056402164e00b0055fa1afa1ebmr662798edx.23.1706856817038; Thu, 01 Feb
 2024 22:53:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com> <20240201202106.25d6dc93@kernel.org>
In-Reply-To: <20240201202106.25d6dc93@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 2 Feb 2024 14:52:59 +0800
Message-ID: <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 12:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 31 Jan 2024 10:54:33 +0800 Jason Xing wrote:
> > > [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep 'stop\|wak=
e'
> > >      tx_queue_stopped: 0
> > >      tx_queue_wake: 0
> > >      tx0_stopped: 0
> > >      tx0_wake: 0
> > >      ....
> >
> > Yes, that's it! What I know is that only mlx drivers have those two
> > counters, but they are very useful when debugging some issues or
> > tracking some historical changes if we want to.
>
> Can you say more? I'm curious what's your use case.

I'm not working at Nvidia, so my point of view may differ from theirs.
From what I can tell is that those two counters help me narrow down
the range if I have to diagnose/debug some issues.
1) I sometimes notice that if some irq is held too long (say, one
simple case: output of printk printed to the console), those two
counters can reflect the issue.
2) Similarly in virtio net, recently I traced such counters the
current kernel does not have and it turned out that one of the output
queues in the backend behaves badly.
...

Stop/wake queue counters may not show directly the root cause of the
issue, but help us 'guess' to some extent.

Thanks,
Jason
