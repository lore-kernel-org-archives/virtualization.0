Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265B53AB
	for <virtualization@lists.linux.dev>; Wed, 27 Dec 2023 07:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Lz3M+W47"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-20389f2780fso4234037fac.2
        for <virtualization@lists.linux.dev>; Tue, 26 Dec 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703661912; x=1704266712; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=Lz3M+W47bSDGwax/Ob6UloHpcsbRPNJ5vthpU1z1HL/OA8IuTcUNKvLQXy7nBP6/zi
         HemIs7IEO6rG3HNkz4pA4ksrOVJ+vdZfEadOt2/myRmgy5tUrnVyFAbBgA54cbaRZlHv
         l3QRv7Fq9Z++f9aA1Ta+z+1slTDz16gy1yEde4KTY+RwPy54zMU3aXVCbLh3+u82grWQ
         pn9LFzmNL1azi4j9aHQiv432DLenjv0Gf1MfSx+ssySBJicfLFCbdA0HxDAbtDwvp8S5
         kbKtPYBoqQ3Fm38bQQOztE1NYHahxRT2bcpl1X8NXaJTFIDwR2OBntzkgv4Xr9kyKY4C
         WvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703661912; x=1704266712;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlmtxuw1kYY8GVgYzzd0HTJPJ+7vbZfSEFgBhzg17jo=;
        b=FoE21+7mkSjXtrQpXLfQM4UORWKuX3zfOjLQN0Uf+ckeE6w/lJj6v+1McBQCAmcext
         aYw9bMiL5VJlBnJ849nKWJ+VP27+H0FYb0DrA6CvDEfX7iz6f7dI4lURT20nrxA+YPiH
         vOdP7WqBWIRZU8piKEzYrjL5e42fMru2w2uhPivUPfjqPRF9zTAFUCZHypUT4hX0yYkK
         aGFP8CdyndEm/tlM6k/n0OZgqkAagqb5yj8edyfOQMfFPznwHPJ2+FzbRlXrKjk4Zumd
         bM+/YopvDxb62fv8lTjVQi//mXQKnQCF9nGelGaknHP5izJv4AQhnPFtHsr6rYNsR4pd
         JP6A==
X-Gm-Message-State: AOJu0YxaS5N4HuM2vSU82QnBOzzC+Sqn+vgJDJEJaHrrh0/Piq/lJmVI
	ECGFKurVrL2Wu5WsM9TrlHA3ht85VtLkUw==
X-Google-Smtp-Source: AGHT+IF7znp/AwmYDdxA7jyqY9qzWPLuT8fC912Ygsnhfb3tdSVxmeAabe4WmnIQOm1u2EUdKy1faA==
X-Received: by 2002:a05:6870:219e:b0:203:27f8:b5e6 with SMTP id l30-20020a056870219e00b0020327f8b5e6mr10860036oae.117.1703661911136;
        Tue, 26 Dec 2023 23:25:11 -0800 (PST)
Received: from smtpclient.apple ([8.210.91.195])
        by smtp.gmail.com with ESMTPSA id g33-20020a635221000000b0058ee60f8e4dsm10657162pgb.34.2023.12.26.23.25.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2023 23:25:10 -0800 (PST)
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
In-Reply-To: <20231226103743-mutt-send-email-mst@kernel.org>
Date: Wed, 27 Dec 2023 15:26:30 +0800
Cc: Jens Axboe <axboe@kernel.dk>,
 Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2E148FC5-F9A9-4A86-99F1-8D0B93412181@smartx.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <20231225092010-mutt-send-email-mst@kernel.org>
 <AB23804D-FF38-47B8-ADC6-C0A19B7083CC@smartx.com>
 <20231226103743-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)



> On Dec 26, 2023, at 23:38, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Tue, Dec 26, 2023 at 05:01:40PM +0800, Li Feng wrote:
>> I don't have ideas right now to answer Christoph/Paolo's question.
>=20
> Paolo did some testing on this thread and posted some concerns.
> Do you disagree with his analysis?

Paolo gave a very detailed data analysis. Indeed, in some low queue =
depth
scenarios, the data dropped somewhat. However, I suspect that it may be=20=

caused by other problems (such as test fluctuations) rather than the =
benefits=20
brought by deadline.=20

BTW, I think 128 queue depth test is a very important and common =
performance
test item for storage devices.

Thanks,
Li

>=20
> --=20
> MST
>=20

