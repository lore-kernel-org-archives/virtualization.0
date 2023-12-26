Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707B4C632
	for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="X0Ru69Q7"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so618651a12.1
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 01:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703581219; x=1704186019; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciIW1eEWiX3+BIMc+04M65OlmBRBFOwzSxY74rwr6UI=;
        b=X0Ru69Q7o9fdTXzvPUV5wTYej6vRQt22qOJP/e4mD6g11iZka1ouYhKj/KxpA62Rib
         BIAIDlXiyLy0RgDFAm44adBspQdSNd9wVUO4/hKs7y2pl+LfVBpzRhGsmgB5EGl8HfOE
         /SNuY/72S8tY+QIiHWo0O5Dmo7Z20boHEA0BwJpmbvdqVrtw4Zep6XTZrVpMhBcNuq5+
         MMV6RkgBp4b+0IyCArfR11ZUAnnvV+1Njfn43hdtMoqTKjhVel/NNwCmzComtsWFaZJ3
         k6hbVnSkuE5zcv59XA9kV7Rdmn4VG4J4D4QZJG737IIx98ABA/0lbsm7R6fNJQIKOrVK
         BPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703581219; x=1704186019;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciIW1eEWiX3+BIMc+04M65OlmBRBFOwzSxY74rwr6UI=;
        b=qCioDGzc8mlqzLqxaxDWOPIvlxUyx7AsflZs5lQTYS5uhN6DDjIZyZezNV1FpKx9CI
         +M+n4P7yKsSElTyaGam9pCUUvWDnYXO27LlFRrhDWMH8TyXuOw0+jGIq3S8pvzha1jPH
         6M/EcUAYxNbewTkBmomtWwCZdRSZo2JcXaqH1SJjb64BpTT901jwX0eupkvH0/mFCRy5
         08+JkLU3TTLnuRf7n2HIN3N8KcppEUK4vqtR+wtn3nmRKRLgV6FptrQm7zQbzCZE/JzW
         eFjC1zVLqLiH0R+RvJ5uIKDv2lojsleuHVu6Oea3fIkSx726UtEmhhVtMDBMLM++Wplb
         CTdQ==
X-Gm-Message-State: AOJu0YzkQuiqjpfUS0tl5beiSk/MeS8IU40C4xM7gKNTYfCWCQH5kAdi
	mGEwC8ag4lhUsHQAPMaok3UCu535OpgHGQ==
X-Google-Smtp-Source: AGHT+IFo+TlFAxPGIaMC6ckFkREHygYopoFgva5SosFYSHy9AdgjsN5p/YSOefLrWKS6+ubequg+uQ==
X-Received: by 2002:a05:6a20:2714:b0:195:3520:632c with SMTP id u20-20020a056a20271400b001953520632cmr1638097pze.15.1703581218306;
        Tue, 26 Dec 2023 01:00:18 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001d05fb4cf3csm9567645plb.62.2023.12.26.01.00.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2023 01:00:17 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
From: Li Feng <fengli@smartx.com>
In-Reply-To: <20231225092010-mutt-send-email-mst@kernel.org>
Date: Tue, 26 Dec 2023 17:01:40 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi MST and paolo,

mq-deadline is good for slow media, and none is good for high-speed =
media.=20
It depends on how the community views this issue. When virtio-blk adopts
multi-queue,it automatically changes from deadline to none, which is not
uniform here.

I don't have ideas right now to answer Christoph/Paolo's question.

Thanks,
Li

> On Dec 25, 2023, at 22:20, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Thu, Dec 07, 2023 at 12:31:05PM +0800, Li Feng wrote:
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
>=20
> I dropped this for now, pls try to address comments by Christoph/Paolo
> if it's still needed
>=20
>> ---
>> drivers/block/virtio_blk.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index d53d6aa8ee69..5183ec8e00be 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -1367,7 +1367,7 @@ static int virtblk_probe(struct virtio_device =
*vdev)
>> 	vblk->tag_set.ops =3D &virtio_mq_ops;
>> 	vblk->tag_set.queue_depth =3D queue_depth;
>> 	vblk->tag_set.numa_node =3D NUMA_NO_NODE;
>> -	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE;
>> +	vblk->tag_set.flags =3D BLK_MQ_F_SHOULD_MERGE | =
BLK_MQ_F_NO_SCHED_BY_DEFAULT;
>> 	vblk->tag_set.cmd_size =3D
>> 		sizeof(struct virtblk_req) +
>> 		sizeof(struct scatterlist) * VIRTIO_BLK_INLINE_SG_CNT;
>> --=20
>> 2.42.0
>=20

