Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E39299929
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437810; cv=none; b=SS6HQfvMzzYkNJizvEgBj3s2vpd7+lT8u/e28Dy2jwNe6gOc/Ax389SIA1hIFtIk3PRnqEAo/5Jl7cDnmPmMmS6FngJfWAodDWPhjhnq//0k4iQTgYUHNqokZ5GdSnNMGqTm0zXKsxk0Nncjc3/2BDH2CS0KwbWqT95bG/pccgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437810; c=relaxed/simple;
	bh=oxCXgHPdTIcE7dKk84d4NUt0SHeeAJFPhLZfaggoBc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1mBQN24zKgxHgnMyn2k/ZTsBPEPXQh3l83ZsCdsm5UTuKmmFlGJHt+/l64eGTutlM5eHkBMw72ndOQnCkF7gchhJK8yFxTeZpl/xFmzgLRf7PfJU5HeLohd6bggkGgutwFt1dKecN+ylHkaxHx13A6CF6LV1XKMEoQX+txW8Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpJuJAZv; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpJuJAZv"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC854607F5
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CriXEL8kHPAL for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Dec 2025 07:23:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C038D6072A
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C038D6072A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UpJuJAZv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C038D6072A
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765437806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFxcFaHV8siIFothWPMRxdEXe4x3KJcgkBVa+1of9ho=;
	b=UpJuJAZv1Nc/crzLGNgu3RzKZRrZTo4Q0jhwxLPGx9IOR6mHgqiaBtUsQ4V/7CLOfJD+JG
	KLo8WdKC6/rrphZgf/iZyqgRd+ep7fOi4BH9+w9BY5w5whavjrjUfmZqtVxukzoS6NIAmo
	REQaU6VeJvkSZRPj8FxrgFSyzBHp+Gk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-hZyHHK7dPRCTg7C8Pu7Nqg-1; Thu, 11 Dec 2025 02:23:25 -0500
X-MC-Unique: hZyHHK7dPRCTg7C8Pu7Nqg-1
X-Mimecast-MFC-AGG-ID: hZyHHK7dPRCTg7C8Pu7Nqg_1765437804
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-349a2f509acso1420562a91.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 23:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437804; x=1766042604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HFxcFaHV8siIFothWPMRxdEXe4x3KJcgkBVa+1of9ho=;
        b=jYoT1FZ+XdxvUngnlCJPLF3oQY6Na2mVYkUTiR4kAUsQqwJixbOlCsQCNi7fJtGVE8
         peahPJk7oxgX4CeUQw1CgviJBYEYbt/QyHZXcdAe08FGmFtnTRaebvi6dZnL+TOhS5o9
         nOAElHgoxPVr3ri4sNschc5qjEhjVs2Bcb4sabrYP5WSkrjyWZ68rf9d1D+XnjpbvzqD
         BTcCQiTrpxDW7MkpyEMlUmkkV7yR5syS7p3uNYj/0g2SspKmTd/xfIZYlLo3WUbE3Rz5
         EZq633cdOrYwe2/Zyddea+xbvVHJvq1nlXN8KqLHdkSosp5DQhINbnIfpVjx6HRe88gP
         brig==
X-Forwarded-Encrypted: i=1; AJvYcCXfvfoB0JKfI956CrRuHqXTSb0FcD9hk29nOe/5DtmF4AKTAQRtIKXesGZrTiSu2WqycrZPwDNfal72u2ou1g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YymuUjfe7qPKd2UHWxHfqgG6OVHXgXA9cOJE2zIdUnL1/YC1SSm
	MndW08bgnFwd5nkNsl5JWayHwxEdTQeDB+iQDbWSdFVJflXUf9zOLJ0BD3DAUSitT3mjxrOd7bu
	I0HdzmGJW9O7i8Bx4J0T8plXN5nc82kKrdn100j3SoM0umzzqPoX92LXnbzyM2pSavXMtpk2K2+
	poYTRduS51RDib452xu+jTVnlztzox3AEyeYSB7beHCuteG+8CJHYl9P9sGQ==
X-Gm-Gg: AY/fxX7KdvyF1C0s+Wx/ibiSETQLTGDsUFNY0787nqM/uZzYzeOiXoRCAHpTKfeiNEg
	1qKvGRbz7jD37h+6cQAzl/FB8eEm//Wn0Nl9r0Nh1PbikBxq62epCle+O0+2Q/7ro6UzjpMCGSV
	n7FOHWlt5egYD4CKHaothYGoyBUHWoCoU1SO9dqjpNFxgqXnIXo55myQwlqW9honM=
X-Received: by 2002:a17:90a:d444:b0:340:c4dc:4b8b with SMTP id 98e67ed59e1d1-34a727cfd7bmr4593614a91.10.1765437803995;
        Wed, 10 Dec 2025 23:23:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqh3WPnFHPnHjFwetGPqhgCVkWZig0NXkv0gXjckzw89w12sN3mRs3QTBQ1clBFKRrNZsmx5jSKxEsLCsA+B8=
X-Received: by 2002:a17:90a:d444:b0:340:c4dc:4b8b with SMTP id
 98e67ed59e1d1-34a727cfd7bmr4593145a91.10.1765437787128; Wed, 10 Dec 2025
 23:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1764873799.git.mst@redhat.com> <20251209080926-mutt-send-email-mst@kernel.org>
 <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com> <20251211021233-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251211021233-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Dec 2025 15:22:53 +0800
X-Gm-Features: AQt7F2rE4sJqy53Tg0Hg30KCjrvJ8KZtQbdvRd0K3Xb_UMMtckmrAgyREzrseoI
Message-ID: <CACGkMEsKJTVWBMyQkNE6n2LP_5hLrcXH8bZDBNXDrGDgkc9M4g@mail.gmail.com>
Subject: Re: [PATCH 00/14] tools/virtio: cleanups, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _C61XVh9p9j8ouTnFVweCpdMFLOt_7fZ6rH5bj9Gtiw_1765437804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 3:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Dec 10, 2025 at 02:24:02PM +0800, Jason Wang wrote:
> > On Tue, Dec 9, 2025 at 9:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Dec 04, 2025 at 01:46:01PM -0500, Michael S. Tsirkin wrote:
> > > > Recent virtio changes brought about build errors for tools/virtio,
> > > > as usual. I did some refactoring to hopefully reduce maintainance
> > > > load going forward.
> > > >
> > > > Adding stubs is tedious and seemed a perfect fit for cursor -
> > > > so I used it for that, then rewrote some commits and accepted
> > > > others.  commit logs I've rewritten.
> > > >
> > > > Found and fixed a couple of minor bugs while doing this - that
> > > > part's all mine.
> > >
> > >
> > > Jason, any feedback?
> >
> > Looks good to me.
>
> Can I get an Ack then?
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

