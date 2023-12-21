Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D0E17983
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HF9vObFn"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8A9284090E
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:23:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A9284090E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HF9vObFn
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7HQ6uUhBbMv
	for <virtualization@lists.linux-foundation.org>;
	Thu, 21 Dec 2023 03:23:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 999AB4013B
	for <virtualization@lists.linux-foundation.org>; Thu, 21 Dec 2023 03:23:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 999AB4013B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703129026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbz0RtyO9KbO9AfFH7tnTj5KptRhevPtw20Tw3wqpzA=;
	b=HF9vObFn/udIpAQA0ARc5nwZcJ/Y2dDSyRZ8dcMR1U0DYJwzusfEoofXwVWeQDxDX/twab
	GLgsfVUCo7aVOZHwxh7mvzFiN+6astLmVoLcPMaj6EL4vxUQ+1owi4fxqUbWP2Rl1TqSJx
	BnabQ0lqsHd4KSg4SdybC0oVZY9XtGA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-2BrX-fWiNuS0CoBYCcjTDg-1; Wed, 20 Dec 2023 22:23:44 -0500
X-MC-Unique: 2BrX-fWiNuS0CoBYCcjTDg-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b9eeff9f7bso415722b6e.1
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 19:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129024; x=1703733824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbz0RtyO9KbO9AfFH7tnTj5KptRhevPtw20Tw3wqpzA=;
        b=k/caTzi2YG5/O5GuLg/8Z/CBT1TrCICXsYJWTC1g6ksx14JxolCTNV6n2L3I1hiBrF
         ocEPnuOrohpiifRgeERWYgqTCIRiavxxOsvd3tvINrCzldTbLscAP2Oh3ujpxSYZZwLL
         KLsYo2MTOY3szzHiEjBKYVLH4mKyrEMpA7X2Ebj8NVyMAWMMdz6FjFN6oAMU1LlSdhVC
         ltZXT3s1TG+p8KG906qwxx8zGf+LMW6htGXxWN7lc9AjHA0omcXT1x57B/wz9fW246/S
         hKNGz+lljiVKiTNP+saLvdQ+PB+ou7111x03rLgu2Kpxr3kF4OBjJXlQUgEltO9MNkTU
         RPmg==
X-Gm-Message-State: AOJu0YxvPSBerHS0Kyhh6NaZsUyqmiTQoOd8kPy+7kzk1iMHjkNO99eU
	NOoo1XaanvwxKrY0ZZSToYK+XYbvQ5wUZN9lh+GUNJBZ7F0lVm2aq1AYb6vfJK0t5JvGu/h9mVl
	aUIu5L5GDbF7JC5sAm/sSe+kJOrov3aO9Gij85KTZRCd8UKT2T2B9hqfF+A==
X-Received: by 2002:a05:6808:1526:b0:3b8:b063:adf8 with SMTP id u38-20020a056808152600b003b8b063adf8mr28096033oiw.85.1703129023835;
        Wed, 20 Dec 2023 19:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfQH4j9u8fb6dQhgofyjfFj4peFSokYM86U1TsXtWFZx03NRmOkK3o5Z+24aO/jxAX4GVB6buE0hGoeAZt/x4=
X-Received: by 2002:a05:6808:1526:b0:3b8:b063:adf8 with SMTP id
 u38-20020a056808152600b003b8b063adf8mr28096023oiw.85.1703129023589; Wed, 20
 Dec 2023 19:23:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com> <20231207080353.6575-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231207080353.6575-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Dec 2023 11:23:32 +0800
Message-ID: <CACGkMEvehpEXpDbuJ5yAV20zMrcMLTQM6v55ewpaNYmakGY8Yw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] virtio_ring: introduce virtqueue_detach_unused_buf_dma()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 4:04=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> introduce virtqueue_detach_unused_buf_dma() to collect the dma
> info when get buf from virtio core for premapped mode.
>
> If the virtio queue is premapped mode, the virtio-net send buf may
> have many desc. Every desc dma address need to be unmap. So here we
> introduce a new helper to collect the dma address of the buffer from
> the virtio core.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Looks good to me.

Thanks

