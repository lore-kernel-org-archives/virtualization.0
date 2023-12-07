Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57FDDDE
	for <virtualization@lists.linux.dev>; Thu,  7 Dec 2023 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="UySbQr4G"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d0c4d84bf6so4197705ad.1
        for <virtualization@lists.linux.dev>; Wed, 06 Dec 2023 23:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701933647; x=1702538447; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j53nqNU7jMgvgRvYSWrD1Dh7t93e+rnrWj/PotqK0BA=;
        b=UySbQr4GIAjfohohN/on5xY1U8Pr20Ff4ztTNOg8LfzErUQkuzV9dI6NHUc00KZJLp
         MtfIRPepmhjN87DkoP/Ku8cDQeloDNPmIeefFkoFJJQDpV0bEXWQaX1yyxF4PYKoyfgE
         lFocw6e1yJel+3qlNxz80TKSEXD6O+igXOH3cx0uM2JSuZoaVCM5aB0v2E/lECCqNpiN
         FLhxVBCf2XXRf6u820FfpIJ5A5fZ8VN3Txnu2Sd5bBYAK6qwOFovC7yDxIgzKpA8VhQP
         nR1hDocLc/5rPKNMdmxDjkoeP227dIaskvprUuD8pqHArUq474swvEAN6UUlV5B1paio
         Kqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701933647; x=1702538447;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j53nqNU7jMgvgRvYSWrD1Dh7t93e+rnrWj/PotqK0BA=;
        b=DaYDUxNCJ4HEP8zBfC7IK4EUSXUfHtSLUP7BxZCmBrmQcHNy1UsF3u3Gx2Nx92Rxbw
         pkdcqLZ3TpqShx4LS1MaazgouEOB3lHsipiEGNaW8TlITie04dyU5fgBDA2CUPl9ZLeW
         b59bOUD0o6ji7U2V5Pet2HAhUHj5SkFlV9KLCu4OatvV2FD2cXzSO3hxvXK9U4VNwbq6
         OZoRQrZ2/sdAvcoZUiF9Bqirotku2ZoIw7OXyr6Tx1QyMzUI/z5m5/4DJ4p6Q9YbCI6b
         8X4PQhMMwvkaRZJnq8kV4KyNPjxcZxNRJKTCLOBYRSbqLaLHErh5Hige1N8+cUNJV9YU
         nhWQ==
X-Gm-Message-State: AOJu0YyI3A0n/9dcdiheaTCJl+QadtbSUYXHPjFmTiRd2YVPestMun2e
	MDHyYL44NAvQTV9AhxikMBzlew==
X-Google-Smtp-Source: AGHT+IEcHwrgZ609ib1Kc+VIk23LvoQqX7Hw9/y0DIrVmUjiSFR5zAD8EnbsROb67jMnfQsP0p39Qw==
X-Received: by 2002:a17:903:2448:b0:1d0:9416:efec with SMTP id l8-20020a170903244800b001d09416efecmr2048898pls.74.1701933646273;
        Wed, 06 Dec 2023 23:20:46 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001d04c097d32sm624915plf.270.2023.12.06.23.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2023 23:20:45 -0800 (PST)
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
In-Reply-To: <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
Date: Thu, 7 Dec 2023 15:21:44 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ADCE81A1-D65A-41C4-A485-66E1B056B1CC@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 7, 2023, at 14:53, Chaitanya Kulkarni <chaitanyak@nvidia.com> =
wrote:
>=20
> On 12/6/23 20:31, Li Feng wrote:
>> virtio-blk is generally used in cloud computing scenarios, where the
>> performance of virtual disks is very important. The mq-deadline =
scheduler
>> has a big performance drop compared to none with single queue. In my =
tests,
>> mq-deadline 4k readread iops were 270k compared to 450k for none. So =
here
>> the default scheduler of virtio-blk is set to "none".
>>=20
>> Signed-off-by: Li Feng <fengli@smartx.com>
>> ---
>>=20
>=20
> This patch looks good to me, however I'd update the commit log and add
> performance numbers for the non-mq case also, just in-case to show =
that we
> are not breaking non-mq setup.
>=20
> Being said that, in case we want to be future proof, we can also think =
of
> adding a module param so if someone comes with a scenario where =
NO_SCHED is
> not providing the performance then they can just use the module =
parameter
> instead of again editing the code, irrespective of that :-
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> -ck

Hi ck,

What I put above(450k vs 270k) is the data of single queue(non-mq). I =
think
we don=E2=80=99t need to add module parameters because the scheduler can =
be modified
through sysfs.

Thanks.

>=20
>=20

