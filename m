Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED54273D9A
	for <virtualization@lists.linux.dev>; Fri, 26 Sep 2025 04:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758862168; cv=none; b=qw4v8dcvV7AK2+IZDVvRs1apneRDQmAgY1+QxxxjSam+hkfeTVTxps6eL8PTNKCE0kCYHAyYKBTwY5EPOFDXJEouWJfj6Wxu6POhvoYzQTgYZwHH8dxsJorNiBepa7CWcUvZOXZgpdBHvsTCOe+2ac5wshwUeWPTwJ6AJwzmpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758862168; c=relaxed/simple;
	bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rULTt6nQ9owwJNZhPyzioC1CQzuiBjHmHXJeZa53j30zMcvj/jwlRwMkTFvckEzAvdiSeJM+eWdycW1PzjDOCL35c/JAqSYyTvL6WHaWa/6oWMeqwgAIIKit5UQ1pbNMtH1YnbBOxBUgiUiSrz1InFmh6FyNwYf++hsesSQ60KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAa0cxoD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAa0cxoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758862165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
	b=SAa0cxoDiQpubh2WdJKbyQ9gh6z+B+hJZf7wbCzi7wDDR0c72+ejagnyycs76/4vnurYGH
	5gevkYRK6w3feBKPBDgn9v15m9rnt2Dc9ZNoyJ7IhKchYlqOTauTfbVYunHCePSk0u6HDD
	CMqw8/0y72b0+jf5N/UMUxs7A5pAbJI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-WCmJ-fx2OlyuEBpe9NrW8Q-1; Fri, 26 Sep 2025 00:49:23 -0400
X-MC-Unique: WCmJ-fx2OlyuEBpe9NrW8Q-1
X-Mimecast-MFC-AGG-ID: WCmJ-fx2OlyuEBpe9NrW8Q_1758862163
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2433374a91.3
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758862163; x=1759466963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIhcWvqxRIRycbeTshnZg2xOAxTIkwI70kvcP3YynVk=;
        b=EUlKKIaIqrgtyZ24WuprbR19KUscDRVRvNus0rIvEfWMLZKLb3+ewSE1Axejhk0411
         S8Aa13MaYZXH2ohOYi27CFjOcmzQ4YqHUt+WEZ/QrBItIRSgqMyOrZlrYtvQAet8aaW5
         EYit25PKcLbEROC+BTWuvy0pBDCE5FKS6a5PbM+izDkQSpLTLJa4X6VuCWPOWAlao7Wn
         /NyiZodM+BpfYyiCArW3MWhouDbGJ1IP44IyJkOhz7G/lLVfEgvKXKMxMHNwgJMtWx/O
         1pRBtPEvn3+QL3uCwgvqwr6/Fi5TarDw2ZKIeINoNNYlWBb1l/Rs8RapH1bEi8sM12d7
         UzeA==
X-Forwarded-Encrypted: i=1; AJvYcCU28DZxAePZIWHXHOrvHuRT6gOTwd3dWzoPdNaIRsZQv1CW67Xe4AfbkWZM/ju2yk9q9w7eaMt3lVbtbcreSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YycRdUpxBUny9/AMSwkr3iXq42Z9uBqaOmPAZ7j/FdYJeWg48F5
	uudIMRt6G/SamV+Vo2XZGuy+ECwedj1/V9rzcfy/XhIyUg93QPJ7lCcrrFwohiLO/zpQAPlGQEP
	RfW2+vrNazfIqz///T0ZZovj6uS1UUp001voiAkuyanDhp0t9kbOaFPj4aOnbwUgyYTJr57jFD/
	lIEXGPBTKsgeuktE0vdfN7XJdKLYwkJVkPlj9Ra2alG8Q=
X-Gm-Gg: ASbGnctHbEZYwxl4Li/15AqjO4snA2/bX9lbjL16zU8+bDdx3Fh86IaG4GpsMx+Mv/4
	NpaNK2HAX0aGg9NYeIiwxgmqgvUxL99nrv9j/YLOA41geVNkNmRmALhA5MalKEEYCmlqNg69wGz
	kJ6+8+AahFHMgCFzRV5Q==
X-Received: by 2002:a17:90b:1d8a:b0:335:2eef:4ca8 with SMTP id 98e67ed59e1d1-3352eef4edcmr785214a91.33.1758862162753;
        Thu, 25 Sep 2025 21:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn6k3kq9sVVva4dN1McfeOpleDDrCstJDmgNlanrCdFV4h/Y47Fetlu+ZhZyYwuS98kkIwPmYbSl6J5Ec8fR4=
X-Received: by 2002:a17:90b:1d8a:b0:335:2eef:4ca8 with SMTP id
 98e67ed59e1d1-3352eef4edcmr785170a91.33.1758862162271; Thu, 25 Sep 2025
 21:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250925022537.91774-1-xuanzhuo@linux.alibaba.com> <20250925022537.91774-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20250925022537.91774-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 Sep 2025 12:49:10 +0800
X-Gm-Features: AS18NWAknuXvqmH17Roh3DbojuU3mFxgOLBnnEOYJvvtgv3NlblLdhapB8Zi7n8
Message-ID: <CACGkMEuBOzXQghp_nGt2t+cm6Ph3SVpjXyuBL0hfdw-3dreAmw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] virtio-net: fix incorrect flags recording in big mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jiri Pirko <jiri@resnulli.us>, 
	Alvaro Karsz <alvaro.karsz@solid-run.com>, Heng Qi <hengqi@linux.alibaba.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jGOnVGTAKmDgKEBoiCGqY7ndRldRNdalPRcKVP6Oo8g_1758862163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 10:25=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The purpose of commit 703eec1b2422 ("virtio_net: fixing XDP for fully
> checksummed packets handling") is to record the flags in advance, as
> their value may be overwritten in the XDP case. However, the flags
> recorded under big mode are incorrect, because in big mode, the passed
> buf does not point to the rx buffer, but rather to the page of the
> submitted buffer. This commit fixes this issue.
>
> For the small mode, the commit c11a49d58ad2 ("virtio_net: Fix mismatched
> buf address when unmapping for small packets") fixed it.
>
> Fixes: 703eec1b2422 ("virtio_net: fixing XDP for fully checksummed packet=
s handling")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

