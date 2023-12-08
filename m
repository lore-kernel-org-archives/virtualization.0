Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48F14A89
	for <virtualization@lists.linux.dev>; Fri,  8 Dec 2023 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9chQko5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702033670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
	b=T9chQko5C6eDGklrJgzJvpyV1fAp0WTLfK0bHXHJBerwzDLqqu65gf2Z4JSwSKHofv6cK3
	3aR99wEYD3IN6g3ZF9ijsDB3l1FlHAAJnLdc9t5bVwHDpDi/UmAzpay9f05LhneACHxFYJ
	e0Kw3svKlisookus3A6v6EcB3VYdtiM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-u31k0aUwM52sDyGMSD6Zcg-1; Fri, 08 Dec 2023 06:07:47 -0500
X-MC-Unique: u31k0aUwM52sDyGMSD6Zcg-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4b02c393e25so533629e0c.3
        for <virtualization@lists.linux.dev>; Fri, 08 Dec 2023 03:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033666; x=1702638466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ68z0Zmw8ZgsbDmEzD6URQldfv+XNMK6DMNEIcDVTU=;
        b=oKpDOdS0bfpdy6ipW5iK1o3nbKVWsNetSDXWY3qoNapudYBkashNWGfETywVII9+38
         EUZzVwCN4K50h/3W0BwQ3usBeIlMcI5OC67aCzt/Kckjmy8G1Q11LMmUcgMA48W22jHi
         zZKLMpDq5lp3r9ZvMh8C7gUlkR9AViuXfE+KtywBoDg/0Pk6D0GoQ9d0yeVTXVQBQwu3
         DsXgyhKyf9YtEIeKaSaAsx67NLJjCbQqvRMtxqZ2gijXZgIkR5BkHq8asdROKSZxhMJ3
         FnS3O7ila6Cdy/tBFrKmLBIA3o+BdRLnvWegMOxz3wyrC52BG+5M2Fwbeaedk3yzIPju
         U3KA==
X-Gm-Message-State: AOJu0YywBwQ4I3ZUO4TVNgqJrZ80vZrwcs3IUdHMKuQXEwtPyjj86OnV
	cnVuigsUfJJEPPJwu95Ze8PNE/5L9yDrRemzvunzpAALbWm0oBXSoQP7Qvle16Xly/odMyDPw3+
	OAM9B42/1nPTTJ2Fk/6pcc47JG+Xf5imQZODIx68dqI8=
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id fx9-20020a0561222a4900b004b2891e225amr5351324vkb.11.1702033666413;
        Fri, 08 Dec 2023 03:07:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrUEvJUaFrYyr5PGOydD15wueB/vwO/OYhbev5UD7asruhM4Q4Ek5B68h+qhR0sIfIIlM2RUFm2TU+UMtSssA=
X-Received: by 2002:a05:6122:2a49:b0:4b2:891e:225a with SMTP id
 fx9-20020a0561222a4900b004b2891e225amr5351317vkb.11.1702033666140; Fri, 08
 Dec 2023 03:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207043118.118158-1-fengli@smartx.com> <ZXJ4xNawrSRem2qe@fedora>
 <ZXKDFdzXN4xQAuBm@kbusch-mbp> <ZXKTW7z3UH1kPvod@fedora> <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
In-Reply-To: <6CB024E3-337C-41F9-9DA1-B54B6E19F78E@smartx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 8 Dec 2023 12:07:33 +0100
Message-ID: <CABgObfatL_NaPxU4RmmGsx9rz=8EVkpro=7Tpw_nLjKguzMDUQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
To: Li Feng <fengli@smartx.com>
Cc: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 6:54=E2=80=AFAM Li Feng <fengli@smartx.com> wrote:
>
>
> Hi,
>
> I have ran all io pattern on my another host.
> Notes:
> q1 means fio iodepth =3D 1
> j1 means fio num jobs =3D 1
>
> VCPU =3D 4, VMEM =3D 2GiB, fio using directio.
>
> The results of most jobs are better than the deadline, and some are lower=
 than the deadline=E3=80=82

I think this analysis is a bit simplistic. In particular:

For low queue depth improvements are relatively small but we also have
the worst cases:

4k-randread-q1-j1      |    12325  |     13356  |   8.37%
256k-randread-q1-j1    |     1865  |      1883  |   0.97%
4k-randwrite-q1-j1     |     9923  |     10163  |   2.42%
256k-randwrite-q1-j1   |     2762  |      2833  |   2.57%
4k-read-q1-j1          |    21499  |     22223  |   3.37%
256k-read-q1-j1        |     1919  |      1951  |   1.67%
4k-write-q1-j1         |    10120  |     10262  |   1.40%
256k-write-q1-j1       |     2779  |      2744  |  -1.26%
4k-randread-q1-j2      |    24238  |     25478  |   5.12%
256k-randread-q1-j2    |     3656  |      3649  |  -0.19%
4k-randwrite-q1-j2     |    17096  |     18112  |   5.94%
256k-randwrite-q1-j2   |     5188  |      4914  |  -5.28%
4k-read-q1-j2          |    36890  |     31768  | -13.88%
256k-read-q1-j2        |     3708  |      4028  |   8.63%
4k-write-q1-j2         |    17786  |     18519  |   4.12%
256k-write-q1-j2       |     4756  |      5035  |   5.87%

(I ran a paired t-test and it confirms that the improvements overall
are not statistically significant).

Small, high queue depth I/O is where the improvements are definitely
significant, but even then the scheduler seems to help in the j2 case:

4k-randread-q128-j1    |   204739  |    319066  |  55.84%
4k-randwrite-q128-j1   |   137400  |    152081  |  10.68%
4k-read-q128-j1        |   158806  |    345269  | 117.42%
4k-write-q128-j1       |    47576  |    209236  | 339.79%
4k-randread-q128-j2    |   390090  |    577300  |  47.99%
4k-randwrite-q128-j2   |   143373  |    140560  |  -1.96%
4k-read-q128-j2        |   399500  |    409857  |   2.59%
4k-write-q128-j2       |   175756  |    159109  |  -9.47%

At higher sizes, even high queue depth results have high variability.
There are clear improvements for sequential reads, but not so much for
everything else:

256k-randread-q128-j1  |    24257  |     22851  |  -5.80%
256k-randwrite-q128-j1 |     9353  |      9233  |  -1.28%
256k-read-q128-j1      |    18918  |     23710  |  25.33%
256k-write-q128-j1     |     9199  |      9337  |   1.50%
256k-randread-q128-j2  |    21992  |     23437  |   6.57%
256k-randwrite-q128-j2 |     9423  |      9314  |  -1.16%
256k-read-q128-j2      |    19360  |     21467  |  10.88%
256k-write-q128-j2     |     9292  |      9293  |   0.01%

I would focus on small I/O with varying queue depths, to understand at
which point the performance starts to improve; queue depth of 128 may
not be representative of common usage, especially high queue depth
*sequential* access which is where the biggest effects are visibie.
Maybe you can look at improvements in the scheduler instead?

Paolo

