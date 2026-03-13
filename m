Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBF28BA95
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 11:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401581; cv=none; b=dtAMzU4XqPlzxxxZAYrUL8Y2Dmg+BSQKJ73B/jSSmqoeYHPE/q7LgbIFtbosJYFktK6ehVGto2W+tBV7uUsRupRWuMhDBmIMPTtR9otCP8VDtZ/GhhqqekTCSKVvxQFs0XJguHqXZraMTucOTxYuuOO0qbNj4qFEpd+jfJLIjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401581; c=relaxed/simple;
	bh=zKtdrdxq5C6K3MGFuN4idkbi6nSWjGx60uJOHWU7Ceg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKiRjnnD6lZ/FDcJ1LTrCyD7/UO1SwZvUxGy6IFcKGZ0AwlqcUn++qRe0ND1JfMd2JkSA914I89Eb10857cqtv2XBRbCWjxFQk568gJGdPZ/Qg5cGuxH4vU+SdiQrFO5mCgz+B0Ngo7qMy3hU8Vp2A6Oo1Vc6/JfBt0l72fheLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEOp5nUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEOp5nUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773401579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKtdrdxq5C6K3MGFuN4idkbi6nSWjGx60uJOHWU7Ceg=;
	b=XEOp5nUzxz7A7WNzg35az87rUmYqE/k2RoxzdTziDwre/fV9vsxXHN1a6St4yCqt5s3wbP
	fsWTNgJ8nehokh5klGILlzg9K2siihMgO7VTastfs5+yhdBji+dY14KtULgh1R917IUucL
	yoL4tPAh+r1aHjEP/tzU/bI6h21Vht4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-RZEGrrlQMqeHWRs_Rhd6VA-1; Fri, 13 Mar 2026 07:32:55 -0400
X-MC-Unique: RZEGrrlQMqeHWRs_Rhd6VA-1
X-Mimecast-MFC-AGG-ID: RZEGrrlQMqeHWRs_Rhd6VA_1773401575
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64c9a6d733cso3528472d50.2
        for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 04:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773401575; x=1774006375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKtdrdxq5C6K3MGFuN4idkbi6nSWjGx60uJOHWU7Ceg=;
        b=s3KwiXhlXb5Ynp27ONZJqWrJqc5OF6XW8UxDAYA0Dm+doa3RbwITsSg0AEoNFOa/3w
         aKryVElttIzoyNFQal6nTW5saO3OP3gL3vxxkg0kdQTDkTDyWJ1uc5H5u4W4LhT4lOus
         QWJmO3llsu4PpdTBWweAoFDLOJzf8UeZS/RPY+nrazRM7c7PvKKfhecAR9yW2bSAJ+2Y
         gqrmQ2s0de+4/Najpeijo9fQjn1SJStRX7mzMXdHkIowbw5qNqfM1JzLJ82tOF/5gduZ
         ymddEuwIB90Fd6ZUOl6jm98XvBdCzquAOAWI9MnspOg/plevegsJJUbbb/zD6H1iXpGI
         q1Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVH/qfeb6qRbdCJRjwcRjXCllKgDTWxdP9fNSazaRFzP2gueHvTGLs0aPgO0/pVteebmwuYt7CSOnE1hJSz0g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzv08yhB919RbDZMebc1xY2MfsHT+mtsAhc+gJict8RjLUyb+Bq
	T2bojwM/vD4V5kw4ryLu3MwYnUcc99aQmakGabf8BlLb0/ZBxvTLSxn1w+k60Yck3BRiKfqg2dQ
	bJ1UigXw2oAQUjjHQ2CHe6vTyoKNvNwfBmPL1kI9RRVv3zcE9yGz0n3UoPBL19cSFDHf+xDwFyS
	CQtp/ve+hfgab/DrWr1cjPmqBTGT7QSz1SPXryUWVM76I=
X-Gm-Gg: ATEYQzxMG38D2+bOpifN7lNuZNd3PS87LxO660nb8BPEG8E7YpSLewsPHOVmrtM5oGQ
	2c//HgoI96DYrUnY9GyJuOeGhGljGFfeFOsxo/mLPDiud7Qhg0/1XC0O4HmwWaPB6qitKO7paJN
	EJ4tQ2+dhRVCms6ErysGBw/U+xYheAlHFTH/PcRJWfHxsaCEbyj8oMapLD1buCVswLz8KyektaN
	LPrug==
X-Received: by 2002:a05:690e:4394:b0:649:e501:21a6 with SMTP id 956f58d0204a3-64e62f2f1c6mr2190060d50.16.1773401575150;
        Fri, 13 Mar 2026 04:32:55 -0700 (PDT)
X-Received: by 2002:a05:690e:4394:b0:649:e501:21a6 with SMTP id
 956f58d0204a3-64e62f2f1c6mr2190033d50.16.1773401574724; Fri, 13 Mar 2026
 04:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAJaqyWcf3tz17q6G=123Xb+warf8Ckg=PLaPkzLU9hYHiUy9Zg@mail.gmail.com>
 <20251022060748-mutt-send-email-mst@kernel.org> <CAJaqyWdRN3C1nOHQjWroBPWKjc5efNfVbecpruL=Cgsk6i1FXg@mail.gmail.com>
 <20251022073231-mutt-send-email-mst@kernel.org> <CAJaqyWeDcyKKOvVdqUkpTuH3d-Tb9rBHG3ym+LC0fcmhrN_FJA@mail.gmail.com>
 <20251028100923-mutt-send-email-mst@kernel.org> <CAJaqyWePMtM8vtgm8UnGAv+_XNTnVNFSNuoqzt_Cn-CpZg46mA@mail.gmail.com>
 <20251028104154-mutt-send-email-mst@kernel.org> <CAJaqyWc=Fhp2+m8P6cctkqG+oeXUgiGhKAsR5Ns20JMun=wvbQ@mail.gmail.com>
 <CAJaqyWf1Sn7CE+VOptZprDgniRNo=8-ZzmcS5YMOeW=tP4nfBQ@mail.gmail.com>
 <20251109164528-mutt-send-email-mst@kernel.org> <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
In-Reply-To: <CAJaqyWdwF5UM+rS7EB9gG5VJMPW0MvwtkNWXdDAkdurFO3zHRg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 13 Mar 2026 12:32:18 +0100
X-Gm-Features: AaiRm53Umh_2QpX2BYlRbt0drnmr-P3ChO_ZxcBl8aSj7q46ULwgh0_xyNw8Cb0
Message-ID: <CAJaqyWcCF0bzwMhQk6L=LPvc=S7yHoWB7xZ+MmPWwhi4kqGEfA@mail.gmail.com>
Subject: Re: [RFC 1/2] virtio_net: timeout control virtqueue commands
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, jasowang@redhat.com, 
	Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: azwtxwY0QqDZcvvaUnj0c4ZaZLnmZrAa40SCIdI_DZo_1773401575
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 12:31=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Sun, Nov 9, 2025 at 10:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Nov 05, 2025 at 10:02:48AM +0100, Eugenio Perez Martin wrote:
> > > On Tue, Oct 28, 2025 at 3:57=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Tue, Oct 28, 2025 at 3:42=E2=80=AFPM Michael S. Tsirkin <mst@red=
hat.com> wrote:
> > > > >
> > > > > On Tue, Oct 28, 2025 at 03:37:09PM +0100, Eugenio Perez Martin wr=
ote:
> > > > > > On Tue, Oct 28, 2025 at 3:10=E2=80=AFPM Michael S. Tsirkin <mst=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Oct 22, 2025 at 02:55:18PM +0200, Eugenio Perez Marti=
n wrote:
> > > > > > > > On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Michael S. Tsirkin =
<mst@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Oct 22, 2025 at 12:50:53PM +0200, Eugenio Perez M=
artin wrote:
> > > > > > > > > > Let me switch to MQ as I think it illustrates the point=
 better.
> > > > > > > > > >
> > > > > > > > > > IIUC the workflow:
> > > > > > > > > > a) virtio-net sends MQ_VQ_PAIRS_SET 2 to the device
> > > > > > > > > > b) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > > c) VDUSE CVQ sends the command to the VDUSE device
> > > > > > > > > > d) Now the virtio-net driver sends virtio-net sends MQ_=
VQ_PAIRS_SET 1
> > > > > > > > > > e) VDUSE CVQ sends ok to the virtio-net driver
> > > > > > > > > >
> > > > > > > > > > The device didn't process the MQ_VQ_PAIRS_SET 1 command=
 at this point,
> > > > > > > > > > so it potentially uses the second rx queue. But, by the=
 standard:
> > > > > > > > > >
> > > > > > > > > > The device MUST NOT queue packets on receive queues gre=
ater than
> > > > > > > > > > virtqueue_pairs once it has placed the VIRTIO_NET_CTRL_=
MQ_VQ_PAIRS_SET
> > > > > > > > > > command in a used buffer.
> > > > > > > > > >
> > > > > > > > > > So the driver does not expect rx buffers on that queue =
at all. From
> > > > > > > > > > the driver's POV, the device is invalid, and it could m=
ark it as
> > > > > > > > > > broken.
> > > > > > > > >
> > > > > > > > > ok intresting. Note that if userspace processes vqs it sh=
ould process
> > > > > > > > > cvq too. I don't know what to do in this case yet, I'm go=
ing on
> > > > > > > > > vacation, let me ponder this a bit.
> > > > > > > > >
> > > > > > > >
> > > > > > > > Sure.
> > > > > > >
> > > > > > > So let me ask you this, how are you going to handle device re=
set?
> > > > > > > Same issue, it seems to me.
> > > > > > >
> > > > > >
> > > > > > Well my proposal is to mark it as broken so it needs to be rese=
t
> > > > > > manually.
> > > > >
> > > > >
> > > > > Heh but guest assumes after reset device does not poke at guest
> > > > > memory, and will free up and reuse that memory.
> > > > > If userspace still pokes at it -> plus plus ungood.
> > > > >
> > > >
> > > > I don't get this part. Once the device is reset, the device should =
not
> > > > poke at guest memory (unless it is malicious or similar). Why would=
 it
> > > > do it?
> > >
> > > Friendly ping.
> >
> >
> >
> > OK I thought about it a bunch. A lot of net drivers actually
> > just queue ethtool commands and finish them asynchronously.
> > Thinkably virtio could expose an API on whether it is safe to
> > wait for buffers to be used. virtio-net would then either
> > send commands directly or do the asynchronous thing.
> > Hmm?
> >
>
> I think it's the best solution too, yes. The series [1] implements for
> set_rx_mode. We can do it for all the CVQ commands and then whitelist
> them in VDUSE code. Am I missing something? Does anyone foresee any
> command that will not be possible to convert?
>

Adding the [1] link...

[1] https://lore.kernel.org/netdev/20260112181626.20117-1-viswanathiyyappan=
@gmail.com/

