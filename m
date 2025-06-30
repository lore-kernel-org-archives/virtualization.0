Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510323E35E
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270311; cv=none; b=KuM18CwUhT9CGeif6yVtZUFZEMxWmfNritu9TXOxenhaj+sZT15LE+PEscu3ecU18ahA2351U5LoKSMsd3MtU0BG5qPAFL4HXbUZQRauDcmMNrpnUkq2P7PJEaVQKEoQGDreKVERQDpir8ixxFEXK2a31APK4c/qkKUkyvDjxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270311; c=relaxed/simple;
	bh=cIWLQj7tWvL2O1cLTwZUfAKHg4ehQSOPXhaj0k60wmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQWwkxU7PXwWToojnY5B3iLwa8CAxNiTBqbTje5SnptFEg2O0ITq1xQw7eKKBNJYoIDktFKqPM4B2+SaYFpXqBYjUqnWauEIgLsFnkd9CxdlHyEctFZAR4IfD4VvxwIkN9YHdjsSSpXAyVeE8agnoEAm5X0lH7LhNCl+DiFrQOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4XJUUPa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4XJUUPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751270308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEWcWVX6y9scJKOQscqFoJ6thnfYTOA+0wFODJOjNQ=;
	b=Y4XJUUPas0e5H3XTlOJL/qmtdeANAWX9XKTit0wLMD2kLwc5Z2lxZdOhlYcvy7d7v4b3j9
	Z9yYYDnEErncpoojo0AJK17YJN/JgophLyzcVbUxnu2/zeB4vKibmJ7wWO7DLD2u4gT4F6
	kgWe4B3xwgGPaEF8gFma1IuvxWozp58=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-akq0QKRDO52Jmcxlgf0bHA-1; Mon, 30 Jun 2025 03:58:21 -0400
X-MC-Unique: akq0QKRDO52Jmcxlgf0bHA-1
X-Mimecast-MFC-AGG-ID: akq0QKRDO52Jmcxlgf0bHA_1751270301
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70f92ed6c95so63918657b3.0
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270301; x=1751875101;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgEWcWVX6y9scJKOQscqFoJ6thnfYTOA+0wFODJOjNQ=;
        b=NXhIqgiDCH7noh3nvSzXrJPcrcYXmneJSuAdvu3/7AzpbpRltwTFw3cqsKJinxxy3o
         BC9Uy9WlM30p39fgg8HW5YH8Wrkk28QGCYiB56cCFLqadIsH7/IDCWNKr2cTcthDKf7F
         z5uycyN+B1fnlXC7nn3qYz+ZhGuOpD9HyfK5aKaa3o30imhHEvxgL560pOPW9T59Ox6F
         9BjM22Ik27VZIUByoVqTgbUKsM0B5eq1AeDPRLJLsNKKpIBtLg5qj9Fgtl1yej3UgI9v
         lYYRtv3Zv1mm9UG3rPwkm63LY0rE0E9J5GZwhAFtbDF9/r2OT2xsYzir28BksZ0gM6p5
         GNcA==
X-Forwarded-Encrypted: i=1; AJvYcCWcISnjJTCrQipwtCCPYLuQHDY6/tfbktGEH8oUzO5WFoOuijTJp/gLfY7QJBiSTQgPC0Tn6Gi3cn4aVYZDeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVTGEICw5M5xE8jqBerfc2BLeuo6836oa+a+vdVG3E3E1LOoMx
	pz8tZzMj9gn8YQ5wsqLvUe2fu1STQJQq1hgC9sy2r1BfkehUMgCT/HLCaoZNOB1/eaCdDpgjN9W
	ak9iarOBhow5w9JWsOuFnxVfRHPW4b+qIiT889+FtBVPNTwsGDJswzNBaEj6R8GhtmVEJuGSlGU
	X6aPdHQThIYu7rHVA+L6E68M0ZgMjrNhXpHzO7AC0i7cM=
X-Gm-Gg: ASbGnctoHYN2XFRf9OimVclAVdRRSD9heYpyQArvpjP8NnnSbawpGBnaVJHnpPpEH5B
	j7Vn2Zda6lLhxNK6puotuygxpdtN8K9E/PfzI4kQKoX2cntro+OwYZq+HsVzEnKxqo72ukoZw0M
	AVZa+rZw==
X-Received: by 2002:a05:690c:388:b0:712:d7dd:e25a with SMTP id 00721157ae682-7151756eb18mr172064607b3.6.1751270300720;
        Mon, 30 Jun 2025 00:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9hk4iM8gEid0K715PQkHr7wTuzImJqjNS2fyvGLxyh0PAObiNySZ92qlNHU9LEDZn5W6cNeMfqE7U/ldpN9U=
X-Received: by 2002:a05:690c:388:b0:712:d7dd:e25a with SMTP id
 00721157ae682-7151756eb18mr172064347b3.6.1751270300278; Mon, 30 Jun 2025
 00:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <gv5ovr6b4jsesqkrojp7xqd6ihgnxdycmohydbndligdjfrotz@bdauudix7zoq> <20250630075411.209928-1-niuxuewei.nxw@antgroup.com>
In-Reply-To: <20250630075411.209928-1-niuxuewei.nxw@antgroup.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 30 Jun 2025 09:58:07 +0200
X-Gm-Features: Ac12FXzM2abZAiLuWcV3HSuStmkPiQEYR_Hk5CCqlcO4nWGeNMcgQRF0jjd6Ui4
Message-ID: <CAGxU2F41qFrcTJdk3YeQMTwd0CP8nCqTCPpOn3ezQv=tPVx_WA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] vsock: Introduce SIOCINQ ioctl support
To: Xuewei Niu <niuxuewei97@gmail.com>
Cc: davem@davemloft.net, decui@microsoft.com, fupan.lfp@antgroup.com, 
	jasowang@redhat.com, kvm@vger.kernel.org, leonardi@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	niuxuewei.nxw@antgroup.com, pabeni@redhat.com, stefanha@redhat.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3knNr75O8_76SZ-5h2EZYdABGRtn-gzhfNsvO_wqmv4_1751270301
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 09:54, Xuewei Niu <niuxuewei97@gmail.com> wrote:
>
> > On Mon, Jun 30, 2025 at 03:38:24PM +0800, Xuewei Niu wrote:
> > >Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
> > >bytes.
> >
> > I think something went wrong with this version of the series, because I
> > don't see the patch introducing support for SIOCINQ ioctl in af_vsock.c,
> > or did I miss something?
>
> Oh yes. Since adding a patch for hyper-v, I forgot to update the `git
> format-patch` command...

I'd suggest using some tools like b4 or git-publish for the future:
- https://b4.docs.kernel.org/en/latest/contributor/overview.html
- https://github.com/stefanha/git-publish

>
> Please ignore this patchset and I'll resend a new one.

Please send a v5, so it's clear this version is outdated.

Thanks,
Stefano

>
> Thanks,
> Xuewei
>
> > >Similar with SIOCOUTQ ioctl, the information is transport-dependent.
> > >
> > >The first patch adds SIOCINQ ioctl support in AF_VSOCK.
> > >
> > >Thanks to @dexuan, the second patch is to fix the issue where hyper-v
> > >`hvs_stream_has_data()` doesn't return the readable bytes.
> > >
> > >The third patch wraps the ioctl into `ioctl_int()`, which implements a
> > >retry mechanism to prevent immediate failure.
> > >
> > >The last one adds two test cases to check the functionality. The changes
> > >have been tested, and the results are as expected.
> > >
> > >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> > >
> > >--
> > >
> > >v1->v2:
> > >https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
> > >- Use net-next tree.
> > >- Reuse `rx_bytes` to count unread bytes.
> > >- Wrap ioctl syscall with an int pointer argument to implement a retry
> > >  mechanism.
> > >
> > >v2->v3:
> > >https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
> > >- Update commit messages following the guidelines
> > >- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
> > >- Move the tests to the end of array
> > >- Split the refactoring patch
> > >- Include <sys/ioctl.h> in the util.c
> > >
> > >v3->v4:
> > >https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
> > >- Hyper-v `hvs_stream_has_data()` returns the readable bytes
> > >- Skip testing the null value for `actual` (int pointer)
> > >- Rename `ioctl_int()` to `vsock_ioctl_int()`
> > >- Fix a typo and a format issue in comments
> > >- Remove the `RECEIVED` barrier.
> > >- The return type of `vsock_ioctl_int()` has been changed to bool
> > >
> > >Xuewei Niu (3):
> > >  hv_sock: Return the readable bytes in hvs_stream_has_data()
> > >  test/vsock: Add retry mechanism to ioctl wrapper
> > >  test/vsock: Add ioctl SIOCINQ tests
> > >
> > > net/vmw_vsock/hyperv_transport.c | 16 +++++--
> > > tools/testing/vsock/util.c       | 32 +++++++++----
> > > tools/testing/vsock/util.h       |  1 +
> > > tools/testing/vsock/vsock_test.c | 80 ++++++++++++++++++++++++++++++++
> > > 4 files changed, 117 insertions(+), 12 deletions(-)
> > >
> > >--
> > >2.34.1
> > >
>

