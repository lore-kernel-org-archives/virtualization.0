Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D58495
	for <virtualization@lists.linux.dev>; Fri, 22 Mar 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711084788; cv=none; b=QqK/Sdtfk4Kc53h9cpHhY7wHKwZI1g2/hlpqLhNBEnpifrCIKONe3NFfdm4RwKC9NTk/yXiUAge96ud36OrDIsGm1tt1NHkUfp6CCXZNr64fHAknY+z/nQ5bW9z2lWQMXQhNHpzaA/rXb8Do/CX2gkj6CsE6+n7SDyAqtTrcnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711084788; c=relaxed/simple;
	bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiY8mIDu0rVe5yZvM8EUga055eOqQMsug0an9tVoRf/hz8LTGI842W6OSwzDLtPjHY6w1fdWrTx6rcRZcsZ6uQc6HT623fekfjouT4XOPGM3qaFkeRALJtq72wSGZqjVABBKBs6Z69fr1tyZZhcpDNivCS4k3AST3ySq9j6aSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bv3H24bz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv3H24bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711084785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
	b=Bv3H24bzbHnWrow5nl0oPvsJ6+IHidSY0uVJedQ5RBY72QHftQB1hsHPhFNhZVEwOcxUnV
	SOhf8PcRw+gBcL9ocymh9SXIu1vDFWPd59bbj4hMkZOwdXBuc2aPLq4JSjWJQzDX3EjpcY
	3s89PsUGvTyrRjM9/3M4dnWwbEBBNKw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-y3N2zrz8PpSQJHAs9f9SqA-1; Fri, 22 Mar 2024 01:19:42 -0400
X-MC-Unique: y3N2zrz8PpSQJHAs9f9SqA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-29de3646c56so1196464a91.2
        for <virtualization@lists.linux.dev>; Thu, 21 Mar 2024 22:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711084781; x=1711689581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WljUklEtnqgFdT0/2aUVbLCn9e8lCLCn5JN6nZDEas=;
        b=Wt4pQhGqsJcUd63GMFHSP5H7otGgRHpg/BgoZjwR78rqvxIxJM/rRryY/dlJnEqzor
         yyDNLqVdxI7Q89Ui5xJTttZEE7r/U4Y4MfUu8bLMYrIVi0LCXSiPaLN+fMnV1r6NXhgX
         utOpQ2viGZKrKHD98+cWHRFirVeHLkFETBKVuU8ZsLt766VpmZDlPt0Cxk23slCv2CSH
         JtY2QXvN1isMgxvNPg+rmJTxcTWs+29mcsP1GhIuhs3M6XLlVIySWrNpN8oA16gJ4kxL
         6VbhqB6X71o4T2DcHlc+UUUZRi6tL4K0s08qqiFTQJrcIQ7cbTplyZfcp3qHFAYpwPet
         4fDw==
X-Forwarded-Encrypted: i=1; AJvYcCWwRQTtRlIAcd06ofvX7Bs1eIXj5Ajn/+QIEr9nGpLLrUFiPemG7IeDXvCb+VUMI52FJFnLYKrF/T7olXGXvdF0CKdBQ0KG28rLnl1yGMo=
X-Gm-Message-State: AOJu0YzXKcBF5lYasxc0NoaGq8bSleExDWFtFFOYoFqmTINTgpRy73gB
	NzvG/oL18Gjcs/iT0IwAM+RAI5Hd/ZZ/6RD9B6WsJywxZoV2Z2ADlwFyWo5Qye98FmNp7Qv1wuA
	h2qFwI9R0EfxyGv3C+5d1iyCVJx+V/+3i7DgtZD0Jf5l2nqALqFtHicK3h1+4twkQ4XYprrEgcU
	BuT4xvtXhOm7jxM+8kTusR9RmbfQ+TxmokH1ED828=
X-Received: by 2002:a17:90a:e54f:b0:2a0:39e9:bbff with SMTP id ei15-20020a17090ae54f00b002a039e9bbffmr800511pjb.8.1711084781620;
        Thu, 21 Mar 2024 22:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEqlxvXagJuFEUOF4z/T7yo9ZWXfypHCNh8PgRY3CFCwWph4hQ9De6Peq6FbRIVJmZmGRYpZVicf0gqBNYJMI=
X-Received: by 2002:a17:90a:e54f:b0:2a0:39e9:bbff with SMTP id
 ei15-20020a17090ae54f00b002a039e9bbffmr800493pjb.8.1711084781374; Thu, 21 Mar
 2024 22:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com> <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
In-Reply-To: <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Mar 2024 13:19:29 +0800
Message-ID: <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 7:46=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
> Currently, ctrlq processes commands in a synchronous manner,
> which increases the delay of dim commands when configuring
> multi-queue VMs, which in turn causes the CPU utilization to
> increase and interferes with the performance of dim.
>
> Therefore we asynchronously process ctlq's dim commands.
>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

I may miss some previous discussions.

But at least the changelog needs to explain why you don't use interrupt.

Thanks

