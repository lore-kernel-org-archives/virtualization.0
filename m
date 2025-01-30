Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A541C07DB
	for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279390; cv=none; b=BvfJOFO1vTfIUAmB9xjy9tA+v4XZYPtSzkEMt3+kSOgpBqw4xvPUvHqvZ3R7yzt8EjjjAge7czSLcKOS2+V8x69TCyrxrvpoLuPtaaUQLwRpqfgYAger0nWQg4ho1xPjpNE8vGgnF2pM5oboEM5fBDtcswFMf6t4o4R7iXcb+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279390; c=relaxed/simple;
	bh=l3pLSAMR5hyZwynYjVj0f5+5gQyw1x0yVwTtSl3x4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JA0H1D0aRt4Z4e4M1qoG9pZTn7nSKRrHpH9mOKLbA35yirDRYh61B70XQ/MYgqZY6U5OdAY8G79A3S/I3AP+zWryZp0bpgoQ4t0Y3qh3HDQYS7HkwbJTYOFJwbDJfYIdgFVe6fkmayM277ZkkxV5DLkJEY1bN/yY/703WuEiST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CMz8Ba48; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CMz8Ba48"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21625b4f978so47365ad.0
        for <virtualization@lists.linux.dev>; Thu, 30 Jan 2025 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738279387; x=1738884187; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4RB+Jf+i5RqaVVfCNjehyqZK5R36kdLSdheWh6HH74=;
        b=CMz8Ba48UYZyR8f95LxBQcA4ApPIXSmzHvdWLINMKghpkXaX2JrV6tZHiPggBmgGob
         i0taiDH4d6It0iJ6+lFfr1xHvgtL34MV+67WAbT9KUk8TZP8aYC3PIta1PiUOK7Fw4lX
         Sn+94OlF9gnNglx7k+gwx4Comd6wDbhu8kBVzBaEMwohDPh39dv1Wf3Q9uglSe3qv4lq
         RohLaNZmgCxLK1eb083MVwXjIH5HAUcbIZtoaJkaHExxyZmCjEoLEzUa+3o+eYf31625
         rXxArLydB5odVu9rSdsdr/+tIm7FbmaF6V6MJ40iYDbafiFYB7gbUzdlZCxnFwsD4tNE
         +4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738279387; x=1738884187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4RB+Jf+i5RqaVVfCNjehyqZK5R36kdLSdheWh6HH74=;
        b=OuZDxIbF0GG2MjK4cHAXYRV3pVUPSgO5WqFZ1PExrw8plvANicG3qBqmPnOYQOTUxt
         rOAZTwR35RhF0/S3GEn+a3AuxxM7Be1E2mh+14bWmDm02K80ZcBmteNptWw1hatDRSqx
         jXrWE6tJG35FtqUCh/xpuegUbaHiQbcA3qo7tToxHFDvWXUBQx8qlaXvNrcZgiiTTf28
         Pd3f5kFLrYI4TAdF3qH55WHjMEtiBDxTF6VhKK6bdiTMM2mViYuJXRRoT+aUaXrJtEGI
         AazWK2JrSWJ9DNtL1kQEgaws37Fio7yoQW/9/Do10MttRgwv/48R1EUcETaHy4AshA4G
         RtQw==
X-Forwarded-Encrypted: i=1; AJvYcCW9EQOEbC8m1Zf2OSLHCrRTAAdWqa7AbZeR3PvP7XyX/rtmJLa8/bVv0ilWQZKjS7Hiv6UaIrAkrInlahhVeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVzFgoMn0PVvQipi8rfDqgYAa22efMJAe0C70R4v6ddPeLuvp8
	i3aKKJq0QGrATj8dkhkPvAb9MR0u21DEBHlAhILhMA2Vxl3oXcscZVutTesbiNAKfT/zLbKOqQn
	QUcyz7yzu41BdwrGTGs9Fe/mJl/FlaMeg7JNt
X-Gm-Gg: ASbGncv5dzM6oz6wM43IuIKQP6eXSNxqeZdDjx/kKqcqDYoXZG3g6Ava7x+Fsmjihlz
	7AtoVmJyncRgbrJXqHBW4Yl2qv8SdJdFzMqL6AGzEKfYk0TkK6p9DXjmNCOSgQ+XE06GItz5Mxd
	M/GGWVCgNchoJ+qJXVSbzyQcJS2SA=
X-Google-Smtp-Source: AGHT+IE/QPS22mFf0S15DpgJBmM4XVfL576eNpFPYru7l4fiKqYBqjQMzyyVnrRxZd0Rnz4Q8ehW/Qpmn9SwV7Q1bns=
X-Received: by 2002:a17:902:8343:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-21edf0435c0mr348145ad.13.1738279386767; Thu, 30 Jan 2025
 15:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-2-almasrymina@google.com> <Z5wEPlsRoU6Kx9S-@mini-arch>
In-Reply-To: <Z5wEPlsRoU6Kx9S-@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 30 Jan 2025 15:22:53 -0800
X-Gm-Features: AWEUYZkqj5XooHiN2tyUua1n1f68bkkfjeEH2K8q451D_O0CCPBOyX4tiBp941s
Message-ID: <CAHS8izMKdcpQkWjmP9OmQFox2CFvZyJVnKG9k9YAdmLYPn6bPw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v2 1/6] net: add devmem TCP TX documentation
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 2:59=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 01/30, Mina Almasry wrote:
> > Add documentation outlining the usage and details of the devmem TCP TX
> > API.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > v2:
> > - Update documentation for iov_base is the dmabuf offset (Stan)
> > ---
> >  Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
> >  1 file changed, 140 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/networking/devmem.rst b/Documentation/networ=
king/devmem.rst
> > index d95363645331..8166fe09da13 100644
> > --- a/Documentation/networking/devmem.rst
> > +++ b/Documentation/networking/devmem.rst
> > @@ -62,15 +62,15 @@ More Info
> >      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymin=
a@google.com/
> >
> >
> > -Interface
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +RX Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> >  Example
> >  -------
> >
> > -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of s=
etting up
> > -the RX path of this API.
> > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an e=
xample of
> > +setting up the RX path of this API.
> >
> >
> >  NIC Setup
> > @@ -235,6 +235,142 @@ can be less than the tokens provided by the user =
in case of:
> >  (a) an internal kernel leak bug.
> >  (b) the user passed more than 1024 frags.
> >
> > +TX Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +
> > +Example
> > +-------
> > +
> > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an e=
xample of
> > +setting up the TX path of this API.
> > +
> > +
> > +NIC Setup
> > +---------
> > +
> > +The user must bind a TX dmabuf to a given NIC using the netlink API::
> > +
> > +        struct netdev_bind_tx_req *req =3D NULL;
> > +        struct netdev_bind_tx_rsp *rsp =3D NULL;
> > +        struct ynl_error yerr;
> > +
> > +        *ys =3D ynl_sock_create(&ynl_netdev_family, &yerr);
> > +
> > +        req =3D netdev_bind_tx_req_alloc();
> > +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> > +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> > +
> > +        rsp =3D netdev_bind_tx(*ys, req);
> > +
> > +        tx_dmabuf_id =3D rsp->id;
> > +
> > +
> > +The netlink API returns a dmabuf_id: a unique ID that refers to this d=
mabuf
> > +that has been bound.
> > +
> > +The user can unbind the dmabuf from the netdevice by closing the netli=
nk socket
> > +that established the binding. We do this so that the binding is automa=
tically
> > +unbound even if the userspace process crashes.
> > +
> > +Note that any reasonably well-behaved dmabuf from any exporter should =
work with
> > +devmem TCP, even if the dmabuf is not actually backed by devmem. An ex=
ample of
> > +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> > +
> > +Socket Setup
> > +------------
> > +
> > +The user application must use MSG_ZEROCOPY flag when sending devmem TC=
P. Devmem
> > +cannot be copied by the kernel, so the semantics of the devmem TX are =
similar
> > +to the semantics of MSG_ZEROCOPY.
> > +
> > +     ret =3D setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, size=
of(opt));
> > +
> > +Sending data
> > +--------------
> > +
> > +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> > +
> > +The user should create a msghdr where,
> > +
> > +iov_base is set to the offset into the dmabuf to start sending from.
> > +iov_len is set to the number of bytes to be sent from the dmabuf.
> > +
> > +The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dma=
buf_id.
> > +
> > +The example below sends 1024 bytes from offset 100 into the dmabuf, an=
d 2048
> > +from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf=
_id::
> > +
> > +       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> > +       struct dmabuf_tx_cmsg ddmabuf;
> > +       struct msghdr msg =3D {};
> > +       struct cmsghdr *cmsg;
> > +       struct iovec iov[2];
> > +
> > +       iov[0].iov_base =3D (void*)100;
> > +       iov[0].iov_len =3D 1024;
> > +       iov[1].iov_base =3D (void*)2000;
> > +       iov[1].iov_len =3D 2048;
> > +
> > +       msg.msg_iov =3D iov;
> > +       msg.msg_iovlen =3D 2;
> > +
> > +       msg.msg_control =3D ctrl_data;
> > +       msg.msg_controllen =3D sizeof(ctrl_data);
> > +
> > +       cmsg =3D CMSG_FIRSTHDR(&msg);
> > +       cmsg->cmsg_level =3D SOL_SOCKET;
> > +       cmsg->cmsg_type =3D SCM_DEVMEM_DMABUF;
> > +       cmsg->cmsg_len =3D CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
> > +
> > +       ddmabuf.dmabuf_id =3D tx_dmabuf_id;
> > +
> > +       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) =3D ddmabuf;
>
> [..]
>
> > +       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
>
> Not super important, but any reason not to use MSG_SOCK_DEVMEM as a
> flag? We already use it for recvmsg, seems logical to mirror the same
> flag on the transmit side?

Only to remove redundancy, and the possible confusion that could
arise, and the extra checks needed to catch invalid input.

With this, the user tells the kernel to send from the dmabuf by
supplying the SCM_DEVMEM_DMABUF cmsg. If we add another signal like
MSG_SOCK_DEVMEM, there is room for the user to supply the cmg but not
the flag (confusion), and the kernel needs to have the code and
overhead to check that both the flag and the cmsg are provided.

--=20
Thanks,
Mina
