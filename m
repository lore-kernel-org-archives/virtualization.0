Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5345217711
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740536194; cv=none; b=iHIEd+RyrxPCVnB1LhlU43CbudY6G3nnrblVgl6jJrLTZiwZZ+xJkTHeFjbq+VCQzGhnL9kzZPqGx5KI8FfDgvdEG71rbU/tCeKLwGc1SFDbrBgLF8rXdRhq35QMXEDM7nle4pPlr3UKOn1jaVzpXW89Kmv1wNI7bLmlOKK0UH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740536194; c=relaxed/simple;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6shscdkbUBdYcX8ZoT2Dy0E4pX6wz1DlEUPhwIbyMli5I4cVKxiYDC7xiDfsygbQdFwvMZ3ntGkxf3Mux98phjzRFgUgkmbvTDuFpvOcRy5wPhS0sumOZogVSDmGkQ0FXNSQetjAzAEZ61qRuIBmcqY3yTNwuU1IdYirl1Ls64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGw09wxK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGw09wxK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D715405C7
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6I2WwnsMQQ2M for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 02:16:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 577494059E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 577494059E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iGw09wxK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 577494059E
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 02:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740536190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
	b=iGw09wxKccKioqoIimFGFC/kS+iJCEnXxIE6QQPd9hX0U3AvT3YoaM2fWcnJDctAW66NCB
	dpY85CztCU0X4ANxr/ZicgYRca15aoifHeSjgEhQ0jU2Et+Hr5lmMfrcOgKxitpFgg+TsG
	BCGTaAhOq7xvbPfWqJvBURxj5CUzDi0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-xcFFuPoPOUm8USO2uDgk9g-1; Tue, 25 Feb 2025 21:16:29 -0500
X-MC-Unique: xcFFuPoPOUm8USO2uDgk9g-1
X-Mimecast-MFC-AGG-ID: xcFFuPoPOUm8USO2uDgk9g_1740536188
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e0eeb26955so3408236a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 18:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740536188; x=1741140988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlVpnj/gX66X00az1sfETkigSAYSYIzGfUGSuYMht7c=;
        b=XaSeMJuA7rgbmyjyrgoO2UQlvJxcTTHKGHLXXp0VarqUYJchyuSx2KMrYy9R99w7q2
         9eisPm7Two3AZGOjD8XKbx77ZQ5xmkjo+qNMhmQ5l6Ioo9z3oOSdHJlP+mot9Cq8nU1T
         xDcoswQFHC8lwiQ42+EzirM6FwdBIIuw5Iil2ltFHw7VOkSAMArQQWWrR9lrn04ugCHk
         qPK3nkh30ZGr2uyTpcDByPgYc9Hz4OniVScGGpmOELdVXvOgvqwhlq5Ejl4q2+jhk6qt
         OuYqWgmFCuTIkrcn0cJiPOBECrXnGKu8d4iE2UpIi8tF61YFfPW417Ttsg7ukU2hErgm
         9vuw==
X-Forwarded-Encrypted: i=1; AJvYcCXDMO4Ntl0xKaBEcMyBLLQHBSc/yrw4GRX7racUhJUqWz9TbXV0Y4/IHiTlk9SCHJ3hLT05zDxCFznpv8/gvg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxwfvY0Q32de4nid2RyN0NRyqAYIIQUzvrMOGSkK6LOBUGkWlYd
	YP9/D9uL584HJ8Wjsvtx+dyO7Gv5dGlQ+DsVCciFqbhaSIwc6BuIaOn/LbMgIgOvIENU29jVZ5v
	dch2DiRlc/rVSmN2GYIOtf+RkjBOrFKrpKxqcMBnXLoUE0eWroXVHFBQq1UL30q6fwb/2pm+XJr
	FUvgMKSZe3DgMZqwedACz3b1YxrYKGB0dEdS6a5/DZqKc50RjxzyZGGg==
X-Gm-Gg: ASbGncu4yWUGa9D9/zz3XsSBDDPvAbGW5E/73XoHbQ65Y5fEG3bAPgTR4kewDsDgHOn
	IjiliY1URspeW9EXnFsd0rm2Q6jbx1aQM1/rxH75SToMEQqCMOqg97znKMsVsqzw5kg5u+pctnA
	==
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id a640c23a62f3a-abed0dc9452mr553605166b.33.1740536188073;
        Tue, 25 Feb 2025 18:16:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhDcZYBxYTCIPyqQmJDzTI8escqv2G/xUepMmTfzT/MW2sRWZSvR7tUcN9f1IoR9eS9p/9t9NJQgWekG117/Y=
X-Received: by 2002:a17:907:7814:b0:ab7:e3f4:51cc with SMTP id
 a640c23a62f3a-abed0dc9452mr553604566b.33.1740536187769; Tue, 25 Feb 2025
 18:16:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-4-lulu@redhat.com>
 <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
In-Reply-To: <CACGkMEt7bkpOXNff6Ve+3nR0xN=zzjm7qZNsZOV2HcnuGvVgig@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:15:50 +0800
X-Gm-Features: AQ5f1JpCVVTdAD7in4OYX8nBzFHVlW0XKfuEec4cZsngVbG26UwAUfOQRbaJMlI
Message-ID: <CACLfguUpbD2LMz+yn6zK16yto4X1UUjV_1dRa_VJDsx0fXmi2w@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] vhost: Add the cgroup related function
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mIsvObjRnnWguBzTyTDUBKN1XHW6K20gjBcmzDJE6UU_1740536188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Add back the previously removed cgroup function to support the kthread
> > The biggest change for this part is in vhost_attach_cgroups() and
> > vhost_attach_task_to_cgroups().
> >
> > Reuse the function __vhost_worker_flush, but in this situation, the
> > attachment_cnt is 0. Therefore, add a boolean to disable this check.
> >
>
> How about just tweaking its value to INT_MAX so we can avoid this new par=
ameter?
>
> Thanks
>
sure, will change this
thanks
cindy

