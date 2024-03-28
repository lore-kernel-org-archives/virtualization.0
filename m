Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A51DA5E
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598124; cv=none; b=naBS7apMJreU1yRsndTQ1CsCCRRn/FGbvPuC6ET3sUOZDIUm1NWzp0AEPdp2302OILKoYLvlmNESGMJdk2uO43YGpQKH1+nvE03NF5R8csLrGDt9CS+qrSzXN6AkPhljLjL3jCQ3khF8ncZ/5C0jbivvBHtc/3Br96/4cn0mIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598124; c=relaxed/simple;
	bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXcSgKp5kaRW82bBYhOpxiwH1auKZuenlgfRPDd/RFiX0etl/xMZKqezY4dRebhRbht1xn2RhMxMRPXth73e38LRSLUEbtx273WCXpbqupJ/qrrTpxOQDPypCZAZ+aT8TQGWWjSXKJ6dNqSs2eoVaC7dzTfVy4vWMU7oIYQzGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSYVSlAz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSYVSlAz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711598121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
	b=BSYVSlAzmNk5aum9OLomBUUD/JMwa8nx1WMjz2yegoUpXrbJ9dH8gLmaxEKyIFroUd83vE
	oGVHlDPsf9Jd57y8fBtjkhFGzURLIcjMAlywHohxVPW8gxfxA2GSGnW6euEMBscuOH08UP
	yoiSqQF30OLW+AiYeGE5vuSYRAyPs7E=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-Mk9HUHhLP0iIHWdWBgWKuA-1; Wed, 27 Mar 2024 23:55:08 -0400
X-MC-Unique: Mk9HUHhLP0iIHWdWBgWKuA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29dd9bfd4fdso546359a91.0
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 20:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598108; x=1712202908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO7qxQbB/W08umKliTUVY9ZKtNLKCFZsGJELh9kwmPc=;
        b=NhmiJaphaVL8/FRuSWwcm/EuRjFebQyFANlPviZ+pU+RJxVTHzqKeLkQr4+c+hOMrV
         WvprX5h6n4W3+Vgd6Lrzq729jI64/34uP0G/d6QAT9iZ/AxElBolxRNdtruKWrlW270f
         IXJV9Xsuskiqbx4EHq7mfpRQ0eCvrcBcZQPEnYjdTd8yJ4iq0dHGGE0LAak4Tf+1GX1Q
         JJlMqd093A2C1rTT+IqUccwRxXwlOnNiNJLC8xkwju/UrmIfV82Sd9eMuS1gSV5rWZxn
         Ld/jB4bvlJhfzKff7BKYXh9GJcmnlXMRHQBsmzM0/0GY0fAI6AchndgrSBr3W1feFPx7
         qYyQ==
X-Gm-Message-State: AOJu0YysHGqaFrZgNgVwjXeDslH52MLfl+NEoSRUIPmQeVeQyvCUFQse
	Gy+hWdUVvSq5XMZc1rtxtJ3SXnKXKWKYcT4UTDArMqQ8SJbMjkgj09L6MKyPVHxlFgJicAIcBSM
	ZyfWuGt6Keq7oY4ADtXuN9G6hhpdJHXeh7QeeX4aRXM5dg4bdtDCGcoac8Tj/BhsW2XqMLtEt+M
	2bWCyTeOGOYKYSP0P6SQGp9rKXwg+Xxz/yc5p2ByQ=
X-Received: by 2002:a17:90a:f493:b0:2a0:98c5:fba5 with SMTP id bx19-20020a17090af49300b002a098c5fba5mr1465803pjb.14.1711598107977;
        Wed, 27 Mar 2024 20:55:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx8M6X9k7I/i9OsfTwP8yasMzBtlJG+nSmhmhraZLACoKJt8ceIYZ4+2nqucgJU9r+l6DISx3nMdn4qnfupE8=
X-Received: by 2002:a17:90a:f493:b0:2a0:98c5:fba5 with SMTP id
 bx19-20020a17090af49300b002a098c5fba5mr1465793pjb.14.1711598107659; Wed, 27
 Mar 2024 20:55:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240328002149.1141302-1-gshan@redhat.com> <20240328002149.1141302-4-gshan@redhat.com>
In-Reply-To: <20240328002149.1141302-4-gshan@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 11:54:56 +0800
Message-ID: <CACGkMEt5fz9mhZ4YK=Oe+n0kx0YKe4hOnGvVQwh-w4rSfs7uRg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] vhost: Improve vhost_get_avail_idx() with smp_rmb()
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mst@redhat.com, will@kernel.org, davem@davemloft.net, stefanha@redhat.com, 
	sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com, shan.gavin@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 8:22=E2=80=AFAM Gavin Shan <gshan@redhat.com> wrote=
:
>
> All the callers of vhost_get_avail_idx() are concerned to the memory
> barrier, imposed by smp_rmb() to ensure the order of the available
> ring entry read and avail_idx read.
>
> Improve vhost_get_avail_idx() so that smp_rmb() is executed when
> the avail_idx is advanced. With it, the callers needn't to worry
> about the memory barrier.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

