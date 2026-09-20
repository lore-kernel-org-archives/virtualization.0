Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D463403EE
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 02:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870772; cv=pass; b=uhml4tilr4FYdBy9DRWGZ5/rpa1kAP3XI30WTeAIWCtr8VC04HbT80prBWWFNbOsFKuxUmDt6lfRYHWg20EMqQXehXCYGtXfshpba4QhAIQeqamnSNUk6eVsx387gRM1/qzK+kcxrMFn3ASjqoJ1oA8pi0oQ5hi0Bnhb8cy2EI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870772; c=relaxed/simple;
	bh=Oj5sg9PCyDUl3TeOjKEQSeMqK8FhKnxaUFXuz/wNJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMCjRqozKPlbZHj/VqXKmKo47zh1zh0JXIFnqUKaD7sCB2ynsC0NLhzWu7sZ5YG5M+NQIkShM2lARl5+Fh0OPkCwJd9Rfr9KW06s7p5RyZtFALhAbM85JiZ28mmap65litCoSjBN4qOx27HVqXqJmUtGgYFfsbJkKnV/DHzd5o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvoExloP; arc=pass smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvoExloP"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso18197316d6.1
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 19:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789870770; cv=none;
        d=google.com; s=arc-20260327;
        b=VHlaP8/2lVHqllNKwKzfBskv/C/XoD6JoWjviPzTnC8o8scBSp8R8oci0OpgimOF8P
         IiSV0M00iB5DxpOHreR8udNqoJ0s/gYZFMbQHKBGgIzb9qYLCHnU4dyVWIUgj0I1agI4
         xqbIqok6eWcGxSrNGk2NRdQWi7yCxpGPFyi/+tnvM4H8Ml3/twrhOi59mo4B8rAQRC9G
         21h0dSaY9nm2gsCYGsm+UZ8DuOrwaur36MhTLH6OG/quTAw1/OdtjXl8ych13d+U70JB
         0mbKCzzgaweuTvLdUrKAFdZP/mmyPJ0xiW2YzRk3s+vB577ld1OvhOcEU1mT2z+f0CAW
         WWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        fh=kuSq6ctCk54WAS3Fw7IKkecbYx9h7eeQCdPv6HY9kpw=;
        b=CbXpSrfqFfAiYHhqMAk6taRlnVkTDHBlnqJ76zp/lTbfRDGkh7b+KwMY08b9xpCURq
         SvmIiIPaERwkHdSVhFTLhozSrBcW4TfFojtayKYv/S9la9Zi0JwqV0rKFm60B7xP/mrd
         loseY8VLu+L1fXKkfJqj8WRfgNK+gJ315FG2tPtRHQQ78jx3jZcaAHiKZH/Bfhm2zOeT
         FjlSFuFq2YKpSck0m+M5//EZRkYIhXiu5qnmLb3+ExIoiefg2pmrKuMzBCwKuvoLKGhd
         rdVCoG3KC4/8fI3CjSiSS2zBUb+35EQ5yNkKrfCokgvo+/cGeKUvYcuBs4FwHkBU9EHT
         U5Zw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789870770; x=1790475570; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=pvoExloPbxfTcooemqRthlJkwN3fRuiRmvm1i8/4t2NyY6g1htP8lLa5OKqnXnHOv8
         A7IfPrLRCXRX5hXfmkEKW6A9bxKv6ksh+SaxiwYhCYZEOB34hI/NtGjUogq1g0ahjQgB
         SuHnqVrCN/lvcD0rgI8JUuRBhIdM8G9dv60s+cDJuP4ZgHOOJ135qLb1ECLPr0fXwOpN
         1EbTfEZdBPnerhzJdEf1JAtF/PtQV5/DGxCPKfUhGewZ/bMOWu1HOyZjrYP/6e55G/5w
         kJhIyA/HZIzcm1WQbvAjaMwlW4LCFsGlEnDxPvkqppaD7Wme4h9ZSQpx9ZTtA8zXmgWa
         XhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789870770; x=1790475570;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t1jf+n9Y/HXbw9hy+wSRUxXx+QGd/8tyjA6GiwXlHUQ=;
        b=ChDChm/RFk7iavqAs+0fhyz8LcuqYbLQWTWZ2BelfxqJY2Krpks++3L/Gv3inL3Um/
         HPrSfOc9VS7pMdAhkOYTHFEAsAX6m52uenqPryQ7scqwvgMIGnnPNeT6PoJ9GZdWFh/s
         M2Yd2GOPAinm3q3Iv4Tr7ni5DTD445oQK/qwMhYi7H5Sz84d64KdnbunsBY0+EGhjiLT
         Xeq0zietQ8Vak+aDVoqGM7erfRSpQZQriq/xqK5GtaXkxX/4FurOYjIDSEDM9Fc9Yl2L
         kk+3l3+kZwIMyYNBDcrEPuSjUiL9pSwQmJKN1KmLUgKCDA8ZAm4YpHOxaMscR1Ng8s6c
         mRjA==
X-Forwarded-Encrypted: i=1; AKwUvBzWey3UHUXy/+YyUfTQwCbV1xyto+IjKRnxWbbGCHnUhEDT3ojyXAHyl4zHJhPyagtWfI2MJNM3WRZwtVrUSg==@lists.linux.dev
X-Gm-Message-State: AFuF++nW5vZHJ41WHaqpPQ8VexlBFqpUN3P5W2Hs40wQDppzssDqKIwi
	1jCk9greLcO3GKWJlZ+Hf9bX1O5VlL1u+SvTIgtWpjaAOeh05xwMdQniKcW8DYthIMx/e/JWAyH
	85X6TP/NSyfbV2eA3Wh08DcM2RNrdoqc=
X-Gm-Gg: AYBFou1nvZBLiPwNQVgL0DX7GUXCvpdurj7bEJivOEwwqs+Ew+ERhsTihJryv4+soc+
	nTuGEbyAwxE6hM1FRya+vVB+Rl7ZnuFCc9g2BQDW1scYJyGH38FmgF/AIoiFx3VwNn6ChKX1Qz1
	xaUFqoPbpCSQ/UNysrHSjdPRxqG5Uus+Q90ZoMwpGcvfHcjMfMa8b6QBVXCmv5xsKC0cPFo0TyD
	LAq+szHWqT9HeZLNgxEZdS8OtpaSQueoBHMz2O3HBIqt3FUEAQPzNZ4iArQdGSoQDj1YGy9mb9h
	tpk+6e2nqsZ0UuselNh3cauKYvNJ0n2r7pT42yfw4W9rF8lk6vU36+Wl
X-Received: by 2002:a05:620a:a0ce:10b0:93b:d58f:4fab with SMTP id
 af79cd13be357-93bf5595417mr270410785a.25.1789870770127; Sat, 19 Sep 2026
 19:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919131744.131030-1-physicalmtea@gmail.com> <20260919152336-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260919152336-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Sun, 20 Sep 2026 10:18:53 +0800
X-Gm-Features: AcwNN1VkMN-0syiFYPeuWa4rISLvm99vUAZPB8bHXDefFB9Y34rSJVqTJuxGaqo
Message-ID: <CAJwVaM+BmE_HoN_hSYL28nhZh1ZStqH9Od3pizAb_fyTZAS+5g@mail.gmail.com>
Subject: Re: [PATCH] vhost: keep vring addresses stable while the backend is attached
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sat, Sep 19, 2026 at 09:17:44PM +0800, Jia Jia wrote:
> > vhost-scsi keeps the response and bounce-buffer iovecs until the backend
> > completes the command.  If userspace changes the vring addresses while the
> > command is in flight, the completion data is copied through the old iovecs
> > while vhost_add_used() updates the new used ring.  The guest then no longer
> > sees the completion.
>
> I do not get what all this is trying to say. if you break it you get to
> keep both pieces. when is this a real problem?
>

Before running the test, I checked the virtio spec and vhost UAPI and
did not find an explicit rule
prohibiting changes to vring addresses while a backend is attached.
That is why I ran the directed test.
I see what you mean now. I'll drop this patch.

> >
> > Reject changes to the vring addresses while a backend is attached to the
> > queue.  Keep accepting the current addresses so userspace can update
> > VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
> > that have not been attached retain the existing setup behavior; userspace
> > must detach the backend before changing their addresses.
> >
> > Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> >  drivers/vhost/vhost.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 44cac11b68d2..074590838de5 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
> >                               a.flags & (0x1 << VHOST_VRING_F_LOG),
> >                               a.log_guest_addr))
> >                       return -EINVAL;
> > +
> > +             /*
> > +              * Commands may retain iovecs derived from the current ring
> > +              * addresses.  Keep the addresses unchanged while the backend
> > +              * is attached.
> > +              */
> > +             if ((vq->desc || vq->avail || vq->used) &&
> > +                 (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
> > +                  vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
> > +                  vq->used != (void __user *)(unsigned long)a.used_user_addr))
> > +                     return -EBUSY;
> >       }
> >
> >       vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
>
