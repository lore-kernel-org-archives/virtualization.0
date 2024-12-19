Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FA225782
	for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734621180; cv=none; b=EF0Yn7bxf18WcrGAFYX6CgISom/rSZM60PzH/XgQHgSGYOJGhed/pIRP9SYnEL0m9TCc+84pFhwvyuPjmC25CYAUbFjVoF7qU2OgWG7xC+gEo2BHgrY3S8t5rooSO0MmrYWA0mnlyoj0zP045a+ZGWsjH71vwkT31p3fzy8DQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734621180; c=relaxed/simple;
	bh=BS1e2dHZHI3fvwxGNU/s5HGMxXY4wseBqH7EwQUXzlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duo3T4CmrGcJ3sw3+A4ToKXk6e/HdFf2E1pbtTJsIoU6Q6fB3IXhNGnsmN5da4/uz0HahoQ23dblv/0/hk5Si0BWXOEgwo3o6KVf8MFGl6j9alyGidpfBSYJayHzUeBEcP7Lkzq558fRpEb7CNAYe/P4SXFEQPrbuJuse+c+ypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEt5451k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEt5451k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734621178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BS1e2dHZHI3fvwxGNU/s5HGMxXY4wseBqH7EwQUXzlA=;
	b=AEt5451kIRhN0WaDPeYIDwUZjQJuMQHDCz2j0JAPd+Kkh80xv5BpN/puDwGt34u6XewBHG
	I+4Xs86BNTPUfpD9aIELqTjURqDERpYLINoeIpEDIS1h9MHU6/x3S3T+LnI5ZNFmzE1UK1
	KSBKbg2RekEsgTe5ri3vvji8NXa2CQE=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-SHI40J7JMhmefyI0_ZHNGw-1; Thu, 19 Dec 2024 10:12:57 -0500
X-MC-Unique: SHI40J7JMhmefyI0_ZHNGw-1
X-Mimecast-MFC-AGG-ID: SHI40J7JMhmefyI0_ZHNGw
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-6f2b3f1eb8cso9308177b3.2
        for <virtualization@lists.linux.dev>; Thu, 19 Dec 2024 07:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734621176; x=1735225976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BS1e2dHZHI3fvwxGNU/s5HGMxXY4wseBqH7EwQUXzlA=;
        b=aT8j1Q8qoL57vyc0E1zsl2EF1FFJrV5/kjvckRGczbEcQy4i6I8gtq/Ge4U17GvAQs
         X3DNW5qXhGArTTm+bx5XRKedzIcI4bBYpYi8BGvcjLuxnvVvhfE8VYl5svJytneEPXyI
         pgqmpcG4VuGUFqeVu83akL9Yqy59VIJSq0s2D3ZBxLqs41BLmHuwfE/3/UO4mBlfzEL5
         chGhqq2FIyhRcFtrvfNZAzHzD0jyRescpWKep1dkJPAAHetJiKZd0jfKnHGeAZcZQ28u
         kpdLgtzpHC2AX5ycEEaOZwx93gcVVUIvuSh6vohOJxhLDIMc1xgi/YjGhIK05edfUAXo
         xu+w==
X-Forwarded-Encrypted: i=1; AJvYcCXspXgsoznGzF2VLGp76ZekVWOynhMOgannCoa5HUZowHaib+F4kVasZ5GmET8rQSyWDDr0Tam7nDrLsmHnjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPi7iH8qZ9uG6QM1z/Sa4xzZhSKf3GaSau2FLgbNWBadaThvWe
	V/3PRlxzYSjW6fgdDPKvQl3kChu0ya/t+48mCZdsjefiMiJNuPYcINsipCWkzWUHWoKBPJVgqkO
	SGMNLmWIi6Roq6lFAYoUOV2NTVTVZk6DbVPZo86qLG500nOP12jz87KKI77bs6jfCM690Wv9qZ8
	RtBklsNjPOZW7Qhd6DwxVTm6NSyL/aun6cyoqnx4c=
X-Gm-Gg: ASbGncvMqCRy2n5MMtJk3o5dHOz4Qwy/EXh9RbjtS+aT/in/U0O6axbSU0L8Akf6vKD
	XP5jwzv7YnxaxR2knAhJ+Hj1jcbDNge/JXMj6
X-Received: by 2002:a05:690c:6d0c:b0:6ef:81c0:5b56 with SMTP id 00721157ae682-6f3e1b5ce05mr41292447b3.14.1734621176512;
        Thu, 19 Dec 2024 07:12:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1e1vKWNdpMhQtoYe0ECNznGPLcHrkVfOEIgjsb3Ce0adQykjZ0v+sCHN5/nm1oh7Kq8n+MtXssaBfGQPaLyA=
X-Received: by 2002:a05:690c:6d0c:b0:6ef:81c0:5b56 with SMTP id
 00721157ae682-6f3e1b5ce05mr41291937b3.14.1734621176096; Thu, 19 Dec 2024
 07:12:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX> <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX> <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX> <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX> <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co> <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
 <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
In-Reply-To: <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 19 Dec 2024 16:12:44 +0100
Message-ID: <CAGxU2F5K+0s9hnk=uuC_fE=otrH+iSe7OVi1gQbDjr7xt5wY9g@mail.gmail.com>
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Michal Luczaj <mhal@rbox.co>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	qwerty@theori.io
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V1228HzlAnOEwjFmvpDN8i3-Iz6-yhThX6oEA1a4ME8_1734621176
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Dec 2024 at 16:05, Michal Luczaj <mhal@rbox.co> wrote:
>
> On 12/19/24 15:48, Stefano Garzarella wrote:
> > On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
> >>
> >> On 12/19/24 09:19, Stefano Garzarella wrote:
> >>> ...
> >>> I think the best thing though is to better understand how to handle
> >>> deassign, rather than checking everywhere that it's not null, also
> >>> because in some cases (like the one in virtio-vsock), it's also
> >>> important that the transport is the same.
> >>
> >> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
> >> it impossible-by-design to switch ->transport from non-NULL to NULL in
> >> vsock_assign_transport().
> >
> > I don't know if that's enough, in this case the problem is that some
> > response packets are intended for a socket, where the transport has
> > changed. So whether it's null or assigned but different, it's still a
> > problem we have to handle.
> >
> > So making it impossible for the transport to be null, but allowing it
> > to be different (we can't prevent it from changing), doesn't solve the
> > problem for us, it only shifts it.
>
> Got it. I assumed this issue would be solved by `vsk->transport !=
> &t->transport` in the critical place(s).
>
> (Note that BPF doesn't care if transport has changed; BPF just expects to
> have _a_ transport.)
>
> >> If I'm not mistaken, that would require rewriting vsock_assign_transport()
> >> so that a new transport is assigned only once fully initialized, otherwise
> >> keep the old one (still unhurt and functional) and return error. Because
> >> failing connect() should not change anything under the hood, right?
> >>
> >
> > Nope, connect should be able to change the transport.
> >
> > Because a user can do an initial connect() that requires a specific
> > transport, this one fails maybe because there's no peer with that cid.
> > Then the user can redo the connect() to a different cid that requires
> > a different transport.
>
> But the initial connect() failing does not change anything under the hood
> (transport should/could stay NULL).

Nope, isn't null, it's assigned to a transport, because for example it
has to send a packet to connect to the remote CID and wait back for a
response that for example says the CID doesn't exist.

> Then a successful re-connect assigns
> the transport (NULL -> non-NULL). And it's all good because all I wanted to
> avoid (because of BPF) was non-NULL -> NULL. Anyway, that's my possibly
> shallow understanding :)
>

