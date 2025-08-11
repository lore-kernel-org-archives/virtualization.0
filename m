Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46072BE7AF
	for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910260; cv=none; b=t4auIpMdT+35/CkRNUMGWr69jVQlIKuSl3laJX+SliTfeFbGZsWtwN74iTvirnB06g50S3EV3nfVqgIB7a80HGMiXkfwICawXK8V/O7u2c37eit0rb3rkgqfbiVxEMI531w5vF3i634uwMOSdmPoAtBqtoBYPUW9KKv3tXGCnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910260; c=relaxed/simple;
	bh=7swBeyj25GpPy2B4vm5DrwjXt8XVNNkLZpz1CZp3XHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSusxBP+9ZUhwMH1Lv04GsYQzX0daMv9QvXkcEjf6nexZsmBErEkbyemUyXZtqYtHSG8Qhro7xHgQK6+NM4QB2q2sRUBlpzATojYx/k34S2RMe9SeZozXeF46p/mOzWisFZmRftsXGHczI+JyOpfQafgNrNMM7Ib2t+awIxQNV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qo6SCscf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qo6SCscf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754910257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbtrlWAXKnBqFTiIwDQ3ZgGXj2AWGHBhEhOwNJt/ZYk=;
	b=Qo6SCscfwLF/pzHHWnoP+dukN45rTpBtJl7TgtjUb7E+BjZuCDu6l5QXvMBa9pYWs3qbgf
	RRzNZEZrp4IQ5iNfOarVOmFm8JiELzvqIvZKyK+VS18MxUHgrIhIFAa5brY2yp677LC3Zi
	5CByrTIrvFLvIQ6VN2KPsrpQDnOAeBI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-_MWYfilNOPC0aB7GH9MlLw-1; Mon, 11 Aug 2025 07:04:14 -0400
X-MC-Unique: _MWYfilNOPC0aB7GH9MlLw-1
X-Mimecast-MFC-AGG-ID: _MWYfilNOPC0aB7GH9MlLw_1754910253
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31eec1709e7so7337746a91.0
        for <virtualization@lists.linux.dev>; Mon, 11 Aug 2025 04:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910253; x=1755515053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbtrlWAXKnBqFTiIwDQ3ZgGXj2AWGHBhEhOwNJt/ZYk=;
        b=XxfeKBgpxWI+eXc1joWxl5ZAQ7AZ5Dm6OA49FU3HU29UyxhNM1l/Ka4g+3J7g95NRT
         d+qIg/xX5C4HXX7+Rx9pnDSnMNyXQiZrWrg85UAo3CSWjBJ8AsJDSeSvw/xSLShfggjD
         VnWlhZBVuu51hFVY7B0CIVF2wIIl7efa5bgn9TwhfVpQdYBn/ZuP420m1Lee3srnP/oi
         WwfcTPCNhvW24sBxCNWEL4HV1ON1OFYXJqFISezLgbPrDAdUTyJliKVhJShM4AltwbNC
         HtlzdH3egJUo/1gcsYq9u42kDerSXtnIeB4Tuqcsz8HtOLPapZc0vGiCDc4VmJ5m+ecB
         8RIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0DgBr4qOBhPn+j9+nZJH5qaaxwZ4oOl/d1Ka6yqrYWbwvSc0eVvC8ZzNdZqSnAAWk4LLrUhLbk+mB24p7fQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCGAkmE9ioRNDcmFKCGMMPemMY2A+DlERIfDZSVknVVZmNZK/b
	2bAfPOO7Es8bneILAgRF/SgPP0KZiQ5CkhHD/CR7j/AHDhSXTNYZ+m4NHpVXDylcK2sH22GePfK
	7C/drreQAVJd3B69UKMRhSXNzixJ/7cDhzW1kEhZFxeP0n33K5tHKSBPSFT2AKQon3DHjV9fBkk
	i9og28J0WBkNiG1TPEIQT452PASpz0mDfC0DGIN7mLokE=
X-Gm-Gg: ASbGnct8YaUGio4ZkdnCCzgeDMM3X/pd5tUYvixP7zkMRpArluOk6itB+mHNd9HoW6j
	xd0hVjW5WbkLdKx9sEElMAU6/JGkp0gcXZ3vg6xxicvne/dqZP01zfgkvyipr8RSYTh/ofsyQ1i
	jZO+Y62I5RiDcgM4Dwdw/n
X-Received: by 2002:a17:90b:3d4c:b0:321:1682:2d49 with SMTP id 98e67ed59e1d1-32183e53bc5mr14049814a91.32.1754910253477;
        Mon, 11 Aug 2025 04:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xV7eQmtVr29Dvkrf19Z0RpYiJKfehsxKGeyuyfepW7qEzpFPEIZ90g+ShPrigpIu8heBQhMEISWgVc3nZvU=
X-Received: by 2002:a17:90b:3d4c:b0:321:1682:2d49 with SMTP id
 98e67ed59e1d1-32183e53bc5mr14049792a91.32.1754910253179; Mon, 11 Aug 2025
 04:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-5-eperezma@redhat.com>
 <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
In-Reply-To: <CACGkMEurTUOb6t9g+nVdzwU8LrZ=eAAxzHYVCTH1XkQkRtAUXQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Aug 2025 13:03:37 +0200
X-Gm-Features: Ac12FXz-ElJczrAcsWwjTE4HF8afkl2XnLnlhag32dbWIT1lsmlWc3ma_13wMhA
Message-ID: <CAJaqyWfh_3_J3+rq_7pa0YMUQSQHfeHn7Tvurz=PAmWoqV5vNg@mail.gmail.com>
Subject: Re: [RFC v2 4/7] vduse: return internal vq group struct as map token
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cu4W_doLP4Xwq6DxTw0oFSfdr0HInNyuyrxpvBosQVk_1754910253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:11=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Aug 7, 2025 at 7:58=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Return the internal struct that represents the vq group as virtqueue ma=
p
> > token, instead of the device.
>
> Note that Michael prefers to use the iova domain. This indeed seems to
> be better.
>

Well iova domain would delete an indirection in the pointer chase, but
it would be problematic to store the token in the caller.

And we need to add some way to protect that the ASID of a vq group is
not changed in the middle of the operation by an ioctl. IOW, the
vq_group_internal struct pointer is constant for all the lifetime of
the device, while iova_domain is not.

> > This allows the DMA functions to access
>
> s/DMA/map/
>

Ouch, thanks for the catch!

> > the information per group.
> >
> > At this moment all the virtqueues share the same vq group, that only
> > can point to ASID 0.  This change prepares the infrastructure for actua=
l
> > per-group address space handling
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks
>

