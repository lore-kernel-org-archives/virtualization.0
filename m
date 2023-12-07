Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A991E496
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="gVrS867Y"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c230c79c0bso395844a12.1
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 22:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701930714; x=1702535514; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=gVrS867YcwOqrJ3Tutx7giAxVf1LPMvA12d7PqMIjB2SPmB6qjB/l8LSoK+NLCJgQR
         LgicL9SWIGuAXhLyScJRGS15pKYyviLOx5UcCYU/wLbNbEsUQ2xPHkvO6L9ajkPL/bzI
         NpdIqWS2SxBl9HOT6miDBKftltkAa8SXkEvLZBCEMduIWVQzHjh8C56yqraImDazhByj
         JZ1pj55+1DbVoJ9yV5LDBN7EI/GeymtXP8Vvknb6QTmXYJw03QqISY/1pUUZELcXmpv1
         JTp8vcOr7M0n3yzT0NMfjIHjOhnB3THL0nHGHz/AYda1FZ4we9iokwECxZle9eDfdnQ8
         ee1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701930714; x=1702535514;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sR3A/v+kbUHDSu2DdKsZWsAH0wB0wI+BlWPsNGRqLQ=;
        b=m0PoPDGANDPai3fDnbzGXWZKtUjkq5IFDsPFSd8Hk4z2V9VO7pvbZiwYbbntcSIA2H
         Ngj/NYSSGl2K+liyEQop7Q+9bjO/kyhp/Axv1n8cZ+o3mvtL9jKKcGRVieuhnAqEOzcN
         Oq8iZxsHqlH/Magx9Oq8wPmRvNlcFSEpKRHib2Y+dLTkIW7uaYFW0L6Lqh1SdxExr/nb
         GLHpHqCEMDSceFBckSq+yCNndvmuwj7OyyMz1Zq3x2fRpDKy2H85GTBcvX3TmV8n85ZJ
         cI12Du4wBydqTI/GU/MWbiailLDyLwFt+yK73Bpf64XjQpn81zgf27m7kUyjzdpHGcKY
         2vyg==
X-Gm-Message-State: AOJu0YxsVxHn6+i+QkiZLyoPfc5eTRqaIhICpocz975PYxkgjuCnOjKq
	SWem+dqLsqdtlrzenRMWADbxsQ==
X-Google-Smtp-Source: AGHT+IHWsp+cfB9xi7HfXzH6TBDYcA1Sv3F4kq9Lyt5FMc318rXqB8lIbQ2rOqVehb755XG/q1yIjg==
X-Received: by 2002:a05:6a21:3102:b0:18f:97c:ba21 with SMTP id yz2-20020a056a21310200b0018f097cba21mr2387789pzb.123.1701930713440;
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Received: from smtpclient.apple ([103.172.41.205])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902b68700b001ca86a9caccsm521331pls.228.2023.12.06.22.31.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 22:31:53 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
Date: Thu, 7 Dec 2023 14:32:43 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ABA117F8-58AA-40EC-B3DA-4AB000A72BAD@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <CACGkMEt4_T5-aArkS4LOQsndwrMkjm_K-uPjdFnNRvwknQPaPg@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 7, 2023, at 14:02, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Thu, Dec 7, 2023 at 12:33=E2=80=AFPM Li Feng <fengli@smartx.com> =
wrote:
>>=20
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue.
>=20
> At least you can choose the scheduler based on if mq is supported or =
not?
>=20
> Thanks
>=20
The "none" scheduler has better performance regardless of whether it is
a single queue or multiple queues. Why not set the single queue =
scheduler
to none by default?

Thanks.


