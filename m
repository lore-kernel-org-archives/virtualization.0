Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34241F16B
	for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213709; cv=pass; b=b6R9iUNb9rV78ymc0ocR2gMCuZv3e3S9L5CotpAw91fuGO3HjmhEveCeBBZMhua6otXMo1BaKB+acbpZOqP1ayj9our8kPC5Qd3FKl/n/5U5LcfR+UqkYkerOThVYnNe04CNh9/aexnxzBIU5f4dEGh0CxcGCpw4juqYAuM2610=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213709; c=relaxed/simple;
	bh=Zwg+noBXHdwoWppOTk1ykTcWejWhjNqV8qGKndySdk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plIwYvTQnDXRca94DaPKg7/rkKXlnz+jfvUDEUU82t2NlP3Srk75tfCTZMGeBxJNpzxO07govzlLToVJJ9KfwdRjZsZYQfy4S19HmBl6/KdJVZwFCTagve97MZPpjAiMI+RORpGYAItZ+1eLT4Sob80+5shFflqx14gpHXBj8lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com; spf=pass smtp.mailfrom=openresty.com; dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b=Or2oZNfV; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openresty.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openresty.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openresty.com header.i=@openresty.com header.b="Or2oZNfV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-35e576110adso6379593a91.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 07:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777213707; cv=none;
        d=google.com; s=arc-20240605;
        b=JGIP+BdayjSfJA87VvwAbKsvz2TQQU1bierbSWkoKx0d6ofSYiHhYP1xkF2Q8XdK0h
         vrgu8CM8WbLV0sneyJWxaTdgKEHjc15xW41y4sOUBDLYiOKSs3vKVAV62cT4cs9XlP48
         qLjruiSrBSMNlobxDDdrnTlsD2gzfToa4cyLsr48fzuKeEGobv2ypP9DTfcgfrL5N1pm
         BZtCU5vs3Qjm2m6q4Btpgucsiko+UzqneqOqiOWvTFqW1RHoqfaGpi/3NFm7QMfbShnu
         Y+MMaYDo6jaOiVmT60S1ec7NpPHjuJxyz1rpZDL/JJPSFAaYIHXIJsaAse584tllb4Tf
         Supg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zwg+noBXHdwoWppOTk1ykTcWejWhjNqV8qGKndySdk8=;
        fh=8gJqNHxUeP2wGLQlhvONHJncHHIdG+LTwVGwUhm80TA=;
        b=Oee+JcW6ggtitPJYG6PR5kZ5R4Snv/O/vCYFQfXYKxiU9b56vFsyRiYpljSRv1m87M
         2jiVTkJHlAy/ivtmGNlt0Xf6/4FsK+bON2qBgSFkzSxYfRM8Mu7Etl5P7JEVknbZxdx3
         ygOlddGHfVWsqP5nBTn/oJG74+OYCP0FjW9Od7uj9AREyrLbHtzinDLmXCIy8BcL3ZUx
         HnLSbhwd9BvIoOQo31f7tKeGkiKH9tWrUxQbZLIKX25PB0i9kLcT18bz4X9stM32kXR8
         km3BcUeC8Xq68akCf5NitTdEOSJSNkBybEpxiH+NT5WD+/HY5VhJDDDzAILVGX3xVHs3
         Axbw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openresty.com; s=google; t=1777213707; x=1777818507; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zwg+noBXHdwoWppOTk1ykTcWejWhjNqV8qGKndySdk8=;
        b=Or2oZNfVP8QCcNchbJhqnjjZ9QCRki5n1IxsgKuvgD06uWD9b4z3flPKjbixZOdFsx
         aB/Z4GIvigmXfsQbEdqPUMfRKOtJP7LG0YLZ/FjBm7u/Hh6txyN/7WzVvcEecbGIyT1D
         en/Zf0fYJvwzPkCSUmdnV2FN0Wf66n6/yOLmZu6aLBOYOY/D6JBZk/jq16u1ysuSdTZO
         zGr0kAUDbYqFDNQodo3LA51OsxaSNK1Rg+3kRGFTRVX4A48zL3+InFrSbFiszyxcaQUX
         1HmEMAHNKMVQeaoqAmPISa/ebKvck5YPV0MJRJhpf3l+kcZOSZ79nk5nqvxQEe8v2fhL
         4Fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777213707; x=1777818507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zwg+noBXHdwoWppOTk1ykTcWejWhjNqV8qGKndySdk8=;
        b=rldzAfZTue1QggiuWT096pqZHLixx3ZiGcePXvvNvU11IaIxpDB52uLm1ifA8h9Cve
         7mzZ2GRxcg/AMbtUcXvZsGl6/JMlDUxmjHE1qRh/znfZNqLP+lt8NjWzFZod580wp1DT
         /GLWhRrKuK8qCScJIh2G3mk5cqCefzKAjFHxPXhlRMRQIOxCopR4vN5+ro1dD1EidtUW
         dcCFbFX12ML5c9eik2/3Xx3pYHpJK3PCyMYSRzASH1TIoDq+cmpqVWkzbPaOaRUiepZn
         sDk3ekHuaxI3t95Fbf27MOzqq1/kYFHwkOX+byzYq+K7WhvJAWpFfNzWZESushBDMV4h
         8JcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NnDMqqx8s2c0z93J+4YGxpt0KoLe9SaMWubRlORYT9SBwrw3ODkoKyBfnSsZdq3ap8us5wYZPOu5tjc/PQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+Ek5yxN0nzaureMh3mYR16T09XBFMuedYbVkHlN98LnGlihMg
	RqWR29FlW8TCqETXPyeuCKy0UrpN+0+wwz+gurBrAvV6rKPLeG80lKsGo1q4C3Xhx16Pj6Uatgw
	9TULXfmis8WotVuJ2y/q5c7bo9NNCdr0QHSlrmV8Ayw==
X-Gm-Gg: AeBDieva3aPWQbuEutKqpaYKTKdlkkwL59lJKmLCSr5z8oaNbCAOaomfLLW4gFhVCbU
	hww/paTUbYTzJC2QDOLoJfF+6C8Ikzq519CQKqLRTnBc08b13sEFe9oJ2nuYK485FkbpCPo3BQk
	Ys5PPWQu8vrGBcy4aD7JV8tTx6pJl4q3fGgoQusZD4m9GgHcDYUwmN3+hAcMBY/W2c+97qml1/3
	bOK469LR6LRA452UCBkTxCNNOlElmjU5nVeLALeTg9qXUDHNCo2ZZ0ZKlfSrmdFQNfQX7bcn82I
	VkaAndC5UxjPwIyYSKgw7Qvxg115Go76QGzPB1q3/p4S7+XrxoCG8D1rxMvLCK4=
X-Received: by 2002:a17:90a:da87:b0:35f:b1ae:d0ee with SMTP id
 98e67ed59e1d1-361401e2edfmr34695433a91.5.1777213707417; Sun, 26 Apr 2026
 07:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260407212521.934620-1-linkl@google.com> <CALUx4KQKNYZm5AZzQXNqLRdGAT0nQOpmn_Lz6WHie73w1d9JQA@mail.gmail.com>
 <CALUx4KTPcRCGvyvJfHSU_t61UJOuTBaAGxJ6nhUuaghE0_ZfUg@mail.gmail.com>
 <20260421175107-mutt-send-email-mst@kernel.org> <CALUx4KRuJcW+ea7wrupQAd_cFJvzRxcrYq93DTYMDyB2vkf96Q@mail.gmail.com>
 <20260421181640-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260421181640-mutt-send-email-mst@kernel.org>
From: Ammar Faizi <ammarfaizi2@openresty.com>
Date: Sun, 26 Apr 2026 21:28:15 +0700
X-Gm-Features: AQROBzCZmAIueVqdSHggl8xdy2AuFhjxUmXtKUB2PTBlQ7PpQujWnRmVgBTop08
Message-ID: <CA+KFgX68PJqhHg1-DHwxEZVj_Dn7m4jqUHUnuvWyQajDrkZV2g@mail.gmail.com>
Subject: Re: [RFC PATCH v1] virtio_pci: only store successfully populated virtio_pci_vq_info
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Link Lin <linkl@google.com>, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, jiaqiyan@google.com, rientjes@google.com, 
	weixugc@google.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 5:16=E2=80=AFAM Michael S. Tsirkin wrote:
> On Tue, Apr 21, 2026 at 03:15:55PM -0700, Link Lin wrote:
> > Quick follow-up question: Do you know if this will make it into v7.1?
>
> I'll try.

It seems it's already too late for the 7.1 merge window. Maybe 7.2?

--=20
Ammar Faizi
