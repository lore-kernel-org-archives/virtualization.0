Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499141;
	b=QnrYp1lynoxZRFCWWq/H+TumDP75NEAPSl3qhRdOJgAwDF787dOtuyU8xiovqKqxuLTJ
	 iK9wVo1CqlqQtyoxEShMChHEKGAdx0dsUAMs4Azt5I2z9GOWo+tUYzs14RvGn/XIO75Z5
	 tQcRKo6TZQz8InA7TAl/tVSo7MVEIzo8qHc0ION5ZU7UgAeRm+wGOdJaWkk/q5n6Y+wRY
	 i7y/4+pDABtvf4sq/PPfPBBwtoes4XA4QG9yJj7n8/KyeDO9FRJk+ylEuPr00OUuObQEv
	 DB730/mm/5JAhxL3Cjxk7lwm5/Q+0SD+uivqpA4j/UBWWrhOUK7lCzcANPqJ99s/k9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EToOYHBqGwgtyDkqIQcDhA4CxlT1wDNVLj3GFZUClsE=;
	b=Mm4pOqKwm8L7EpdVFJaSzu+W4gVEwXlijB1nJ6V/XTAVgIMR3+6CIY0C7NTxyfHlx7lv
	 ZBJ8r1or/2qp2GHZIG3KHA6UZ+dxD+7ES8Zv0YS5z/6hxcdgKdzkpu23lvORBhZhN5oSJ
	 4Wj769sXPwazW0BIqUyxSs+lGtszHuLHenBlEOJyCQTCXkoq6dS0E6GAzuuWULmF8m4if
	 JmTcKba0DmYvCc/aA4XtI8U5P7/oNE4RPrTG9h6eUGAb00V9H7P68XcsXuM3amBjD98WI
	 ua3aPCDUEBwi+4WWVgc946w5m6jKujTwnVYs46MP2Zz0RwyPxJeKihNEamdu4cXbs8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9zLmDyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4099606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4099606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U9zLmDyj
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c169ae1cb26so188309766b.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 07:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794499139; cv=none;
        d=google.com; s=arc-20260327;
        b=O1/C9xDCJBpK2SF1BACI//cZbW+2LXPVcq5CBwQke2gUwTaW1seNqQuj65rXtM8j02
         LDmU1DsNi9ciNyaxWL5WcITvSCxo8snzkRiIHAnlVfO3+zZoAgBduR+LIbKypaRYJXSo
         RGd4n7Q+6VlCMD7cUSbg/ZsXrpj63gmTHiY0kB9FOZ5WnCHML+LgPcbwKqCbKzfcKxfs
         A6w4dKfz5k/vF3u6RcVa2JIQeYYDy2++xkrbRuYF67GB2aZ8u1OMnUNGhHA5Iw9HmJNX
         W7JIzhK4UDgtV3ayMnwzm5FsMsU3/zxPPouNlC42pOHXdzV/4AaoZiz+PGAqkCuXFtrN
         XOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EToOYHBqGwgtyDkqIQcDhA4CxlT1wDNVLj3GFZUClsE=;
        fh=SGVKWgqCg+0zaP8dZ838jKqaoDwF4YRm2BLggDGEpNM=;
        b=PYW7VdhM9EPHt+lwhanmLtzRGSyK27t93xINJLZ5jizeWalN1Otd166dADCokXmZTn
         4xBkdo/MrcJfC3mQ9xtrynz8RmX6NaaPgw+Bn1pRR2KGWsdKZuUnz5/E+uVtXtyV6iK9
         eYuw47s3TVUSAf9uSDc5J0/b4sMJyGrZyFQgFxZwwdgXP3fXJorgF8cQ0IYi4/7KztAw
         eSeGvo2vo+xIAReZSniUHy+8czH4/U76LN+VIOVdJXIDmyFIrisJL699Y8w6uuiGeQde
         Eun3MYe96PIqD+XAU4TtOJ6NN5qFDkjhx5Q2gq2wj2JbNAEODN0ycnbRVBw1bRRLu+jo
         RpKg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499139; x=1795103939; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EToOYHBqGwgtyDkqIQcDhA4CxlT1wDNVLj3GFZUClsE=;
        b=U9zLmDyjyVhOtzkiUOs+ZnduLi1e4gVhoV5jlMEHP1bG7D2A8JCRlvRd/66SqYmqqm
         GJjqlypeuxaNP/2VE/fZFCd8UgNlbhDKwf/yXmZqwYBQQp8LuFS1bJberBkScTIlIcDq
         Q87Z47nNdn5BkK5KjEvRJvp0MTYcsnVtb7wSuz+rU5J/6Jp2UOhToix4JERq51x9VIpa
         G4RdIRmgZ8HU8NvWypKIXlHq4WF+ccvG5vkWeiIGL0rBYtzwk0r4Y7kHx4PqiyjmpMuF
         QpldVULMvdMJuxeMKu0O9VE39BLnMKRPXoyw2DMYFqSKO1X4A4ysz630hl5feqoJQJNh
         Ivwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499139; x=1795103939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EToOYHBqGwgtyDkqIQcDhA4CxlT1wDNVLj3GFZUClsE=;
        b=yN7QbpLMCD/aEZnsMSBQrsxkHsUAGPfkVdjuQyYAU1nY0DUmSj6LsBrPyK3G7WF9au
         J1Sh8kYMGfYB+RoFhln/Lh26Vr3FLBzFxBi994aSWN6sJ1AWSfyS5V5KtxAZAgxwyuB2
         MUHkimHZnvRq2d2nBRDO8X+bar3VVcg4/17jFVEnfUhw3GzEBiN75q7QSOxHjqecWC7d
         y2x0wvwRMr8CAE2pZsM+XuqMTXvSL7V1JrpC6slJBohOhKSKLB1yCu++ynCWlqxSkOKp
         u+1tYkLR/4a3HGksRUCVU4NhrJsucbcinDS1lVWfIQrUaM2vkFucF1YFTh4vKCm6kdo9
         zfSw==
X-Forwarded-Encrypted: i=1; AL+hErFqcVmMPVHBdg7xHG+FQ7j7Y5KEFRrfuF0Ub7ihh4wIj82J1EvBsAZowtbYlbCzrU0iIoiuLRE++0NsxwKYtg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+gneDwm+5pUnxydGWn8+cke1NThPXCQND3ESGHrIulFT8YgPjb
	HfV6niJHNwyXzWniG/gkqjiRZEXuQCrcQNn0cf8g2GpZmZjC9UxWNioLH7xCS5OC3fIZikCL51D
	KcEigMKWksUllqKAPn0DdWfzrkw58y1I=
X-Gm-Gg: AYBFou1HlV10uF0sytcK/AMtXhlKxnmKX9kezdQjXgyQ2p2KAhRVbmemEQONVAtY9p8
	Lq2pXwsiC8anjyy0Rkqtm8YasODLxliLVwiCmRF/PP6bjy25vElh8A13vpSakEFQ04x1BdWfwSL
	ekJMtXH0sX6arx6Mcs9GcRQdMOcWxskaUs9buYD99v5ZV8SMQiR2mi4ZPUgaJ9M7vxl6CI6AFcX
	UaZDB6xNZ+wexPhz2F6eH2hkkto6lv16uKM/4Nol50tyMR1+x3xIVt9NVy30ZI7W29HQkfgEc4E
	+Flb417KSFdo8SBxDcVWplq+dq7+yf5m762oCdnm3Vek0aiLXqgLpuuDVW7YFfxIZepRLhHKaFe
	iZ+A7ofdp4PpkwB79c8omOTlVgoBv59K2/p9a+RIU7sW9vonaKm6UrAsSun2vAK/KDd3m
X-Received: by 2002:a17:907:8e96:b0:c2e:616b:6763 with SMTP id
 a640c23a62f3a-c507b2cc1b7mr331620166b.3.1794499139114; Thu, 12 Nov 2026
 07:58:59 -0800 (PST)
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
 <20261111172947.3579982-2-stjepan.poljak@gmail.com> <avThD0u2WQx8drWl@bywater>
In-Reply-To: <avThD0u2WQx8drWl@bywater>
From: Stjepan Poljak <stjepan.poljak@gmail.com>
Date: Thu, 12 Nov 2026 16:58:47 +0100
X-Gm-Features: AclHuK9hu2IpdVTiqRNx47radQxfPWpOJNlyZZoNO2fwaqJTR4WiC67svYMPEKw
Message-ID: <CAKVkeTyjZmNsyT4D_evW6pikwnNEtTY66HvOi4KKwB0aY+a+XA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_ring: reject a split ring size that is not a
 power of two again
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andy Lutomirski <luto@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-remoteproc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

On Wed, Nov 11, 2026 at 10:51=E2=80=AFPM Francesco Valla <francesco@valla.i=
t> wrote:
>
> This is definitely and error, and should be logged as such (I know, the
> same message is printed as a warn in vring_alloc_queue_split(), but we
> have no ABI to align to here).
>
> Also, consider to adopt a message a bit more descriptive; maybe
> something like this is sufficient:
>
>    "Bad virtqueue length %u (not a power of two)\n"
>
> > +             return NULL;
> > +     }
> > +
> >       vring_init(&vring_split.vring, num, pages, vring_align);
> >       return __vring_new_virtqueue_split(index, &vring_split, vdev, wea=
k_barriers,
> >                                    context, notify, callback, name,
> >
> > base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
> > --
> > 2.53.0
> >
> >
>
> Thank you!
>
> Regards,
> Francesco
>

Agreed on both, thanks. v2 uses dev_err() with your message:
https://lore.kernel.org/r/20261112154927.4004184-1-stjepan.poljak@gmail.com

Stjepan
