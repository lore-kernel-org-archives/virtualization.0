Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0861C54BE
	for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738345191; cv=none; b=lrQ+/mmxd4dPS+DkLa/9tR33aiq3cdsdApghDrCOo5l6+h8jHpmETZAGSMS4lZSMK+wyFTi6qrdQfiYlqQ+1YI0s9nP9GjM2/Wev2V4T0wGfLWtGbqEGMjExB0pMc389BDF8+nCzZItbuTXsJCFOu4/cJh3PE++PshrZEZvKHJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738345191; c=relaxed/simple;
	bh=jI6xBAqkENymhzCkLRyN0q3fCK0KMKrm0ferMkUc3MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcmE3mQ1dHUWyRfuy5aqri2+3AcOuPc8llPGRh1T8Ik91YUriP7tXaDikrzgRyry3oIstvgJFRYhAqX5fIDgTEBjmFQwY4rfYF8m9SrRIoEtzMhNBZWjhenvisz2xYF7z48ROOQPnxCf8FWhMDRzqkak2E3Bs8CLJ8+6g33x76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9UyNTl8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9UyNTl8"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so3154833a91.2
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 09:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738345189; x=1738949989; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EP6vtvl2ztwAQQMiEI1+F32Ml1gmY2uzSrH4+0NeMuI=;
        b=b9UyNTl8mgmShCLME+vmZyIy8YWGDY56B510FzEGJIHgDiDNYHkIq3+kFkeqsdSX5f
         WykWnaFC4smqoZp2IIndwIODN4ajq71ViDD4pa3PbpLr3yZxRotC+Su5vu97gKVcsRWK
         lb8LLM3IAxX7jwv7JZl4azu4nyLGqla23bM7qvoVKn+7zYWQ48NtRJ1ii8z8bAo0jLKD
         TeEHgEptd+HTy2py0ad/nbSUSwHSONxcbUG5jzUP49rUazmObUFT2hyb4Cg8KM5ysEAN
         +MUCCBDGX/BtE8WM+pXjdw7XUJoYID0CwZwQ3v3Ip55TkA1cwdVf8kG7RJgVhonmxgBF
         ZHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738345189; x=1738949989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EP6vtvl2ztwAQQMiEI1+F32Ml1gmY2uzSrH4+0NeMuI=;
        b=AqOiCoRr8j2VyLx6WbSoZTKiL3RHy87Y66KNN2+FlOBlvETeCws1AmhEuS+/1JwMCo
         7B33NOldDloyuUjq4tPWodCL+BsbLKnHBhI5OgBgTSFM7A0PnjhxKZKUjVB4aWzzLKFu
         cQqePk9yEOI7rIJh/Inu7agtl4KUMi3uWCS5L11GbbL5TbCvasXwJzVwZtKpaBmlbCoA
         JU/SymXExQyx/RJCSZXYUP7Ib2GYwGa5XwOKfptiB0P706FuhQyBLs77DVdmjGNrglvT
         3RiVriOLSJ1dMImG3cKAr/EYYd3unQY8fNhVk4HUYhgjB8pFXvsNJya9Zi33FBZvK1i9
         sZbg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTJZLPqC8Af+R47RDIPUEAAu7vynpNRf7nSM2YdCHufKEgFwGXYpAJoudYRoQvaJQ60YzWi1vGlGFwD7clg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO9PKc5TEj+FHHfq1wOOOLA1+chH5MZvdBuMOCgde5/t2GG64D
	KG6pXfOc8o9QWTa17Qp7Ja+FHGiONXWs9OZoxtltdC9Po1SwoXs=
X-Gm-Gg: ASbGncvE5c8gI8bY97z3DSya5nqiaNqNLbmE496LrnGVl06GgvH8+6IAnKH2oFwnpb9
	OFKLU2/bFaK90CW2QI82ZDjR3Tb3bCqFT10UjX77kv3TB8FVxI7WqjQilJ630dd0NjJlSbfh5C3
	LcrCE5Yw0gqW4LR/bh9olcCJrWMdoy/mLcKbxDv0TGFJ4ihuDA2bRs8ZTYgDamSYGm0tc7kfWGt
	buwOcmv7VnZqDKJY+/V3p1CspcdExA5Y+I12P1igSRwE4Q1CPn4t1FAUokCPdp0GLm9rZK92pCX
	VwuHGK2xr40k1hk=
X-Google-Smtp-Source: AGHT+IGFMwPhVUoi5cNUZr0zxvv0GNocT1cBhbIvI4h7KkyyN/IeC1YQVRfg0MelZFRzBHzDDj8ewg==
X-Received: by 2002:a17:90b:518b:b0:2ee:db8a:29f0 with SMTP id 98e67ed59e1d1-2f83ac73bddmr16816455a91.27.1738345189244;
        Fri, 31 Jan 2025 09:39:49 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f8489d3707sm3967611a91.23.2025.01.31.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 09:39:48 -0800 (PST)
Date: Fri, 31 Jan 2025 09:39:47 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
	asml.silence@gmail.com, dw@davidwei.uk,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next v2 1/6] net: add devmem TCP TX documentation
Message-ID: <Z50K4_2lkAJHz8s5@mini-arch>
References: <20250130211539.428952-1-almasrymina@google.com>
 <20250130211539.428952-2-almasrymina@google.com>
 <Z5wEPlsRoU6Kx9S-@mini-arch>
 <CAHS8izMKdcpQkWjmP9OmQFox2CFvZyJVnKG9k9YAdmLYPn6bPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMKdcpQkWjmP9OmQFox2CFvZyJVnKG9k9YAdmLYPn6bPw@mail.gmail.com>

On 01/30, Mina Almasry wrote:
> On Thu, Jan 30, 2025 at 2:59 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 01/30, Mina Almasry wrote:
> > > Add documentation outlining the usage and details of the devmem TCP TX
> > > API.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > v2:
> > > - Update documentation for iov_base is the dmabuf offset (Stan)
> > > ---
> > >  Documentation/networking/devmem.rst | 144 +++++++++++++++++++++++++++-
> > >  1 file changed, 140 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> > > index d95363645331..8166fe09da13 100644
> > > --- a/Documentation/networking/devmem.rst
> > > +++ b/Documentation/networking/devmem.rst
> > > @@ -62,15 +62,15 @@ More Info
> > >      https://lore.kernel.org/netdev/20240831004313.3713467-1-almasrymina@google.com/
> > >
> > >
> > > -Interface
> > > -=========
> > > +RX Interface
> > > +============
> > >
> > >
> > >  Example
> > >  -------
> > >
> > > -tools/testing/selftests/net/ncdevmem.c:do_server shows an example of setting up
> > > -the RX path of this API.
> > > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_server shows an example of
> > > +setting up the RX path of this API.
> > >
> > >
> > >  NIC Setup
> > > @@ -235,6 +235,142 @@ can be less than the tokens provided by the user in case of:
> > >  (a) an internal kernel leak bug.
> > >  (b) the user passed more than 1024 frags.
> > >
> > > +TX Interface
> > > +============
> > > +
> > > +
> > > +Example
> > > +-------
> > > +
> > > +./tools/testing/selftests/drivers/net/hw/ncdevmem:do_client shows an example of
> > > +setting up the TX path of this API.
> > > +
> > > +
> > > +NIC Setup
> > > +---------
> > > +
> > > +The user must bind a TX dmabuf to a given NIC using the netlink API::
> > > +
> > > +        struct netdev_bind_tx_req *req = NULL;
> > > +        struct netdev_bind_tx_rsp *rsp = NULL;
> > > +        struct ynl_error yerr;
> > > +
> > > +        *ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> > > +
> > > +        req = netdev_bind_tx_req_alloc();
> > > +        netdev_bind_tx_req_set_ifindex(req, ifindex);
> > > +        netdev_bind_tx_req_set_fd(req, dmabuf_fd);
> > > +
> > > +        rsp = netdev_bind_tx(*ys, req);
> > > +
> > > +        tx_dmabuf_id = rsp->id;
> > > +
> > > +
> > > +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> > > +that has been bound.
> > > +
> > > +The user can unbind the dmabuf from the netdevice by closing the netlink socket
> > > +that established the binding. We do this so that the binding is automatically
> > > +unbound even if the userspace process crashes.
> > > +
> > > +Note that any reasonably well-behaved dmabuf from any exporter should work with
> > > +devmem TCP, even if the dmabuf is not actually backed by devmem. An example of
> > > +this is udmabuf, which wraps user memory (non-devmem) in a dmabuf.
> > > +
> > > +Socket Setup
> > > +------------
> > > +
> > > +The user application must use MSG_ZEROCOPY flag when sending devmem TCP. Devmem
> > > +cannot be copied by the kernel, so the semantics of the devmem TX are similar
> > > +to the semantics of MSG_ZEROCOPY.
> > > +
> > > +     ret = setsockopt(socket_fd, SOL_SOCKET, SO_ZEROCOPY, &opt, sizeof(opt));
> > > +
> > > +Sending data
> > > +--------------
> > > +
> > > +Devmem data is sent using the SCM_DEVMEM_DMABUF cmsg.
> > > +
> > > +The user should create a msghdr where,
> > > +
> > > +iov_base is set to the offset into the dmabuf to start sending from.
> > > +iov_len is set to the number of bytes to be sent from the dmabuf.
> > > +
> > > +The user passes the dma-buf id to send from via the dmabuf_tx_cmsg.dmabuf_id.
> > > +
> > > +The example below sends 1024 bytes from offset 100 into the dmabuf, and 2048
> > > +from offset 2000 into the dmabuf. The dmabuf to send from is tx_dmabuf_id::
> > > +
> > > +       char ctrl_data[CMSG_SPACE(sizeof(struct dmabuf_tx_cmsg))];
> > > +       struct dmabuf_tx_cmsg ddmabuf;
> > > +       struct msghdr msg = {};
> > > +       struct cmsghdr *cmsg;
> > > +       struct iovec iov[2];
> > > +
> > > +       iov[0].iov_base = (void*)100;
> > > +       iov[0].iov_len = 1024;
> > > +       iov[1].iov_base = (void*)2000;
> > > +       iov[1].iov_len = 2048;
> > > +
> > > +       msg.msg_iov = iov;
> > > +       msg.msg_iovlen = 2;
> > > +
> > > +       msg.msg_control = ctrl_data;
> > > +       msg.msg_controllen = sizeof(ctrl_data);
> > > +
> > > +       cmsg = CMSG_FIRSTHDR(&msg);
> > > +       cmsg->cmsg_level = SOL_SOCKET;
> > > +       cmsg->cmsg_type = SCM_DEVMEM_DMABUF;
> > > +       cmsg->cmsg_len = CMSG_LEN(sizeof(struct dmabuf_tx_cmsg));
> > > +
> > > +       ddmabuf.dmabuf_id = tx_dmabuf_id;
> > > +
> > > +       *((struct dmabuf_tx_cmsg *)CMSG_DATA(cmsg)) = ddmabuf;
> >
> > [..]
> >
> > > +       sendmsg(socket_fd, &msg, MSG_ZEROCOPY);
> >
> > Not super important, but any reason not to use MSG_SOCK_DEVMEM as a
> > flag? We already use it for recvmsg, seems logical to mirror the same
> > flag on the transmit side?
> 
> Only to remove redundancy, and the possible confusion that could
> arise, and the extra checks needed to catch invalid input.
> 
> With this, the user tells the kernel to send from the dmabuf by
> supplying the SCM_DEVMEM_DMABUF cmsg. If we add another signal like
> MSG_SOCK_DEVMEM, there is room for the user to supply the cmg but not
> the flag (confusion), and the kernel needs to have the code and
> overhead to check that both the flag and the cmsg are provided.

SG! Having another 'if' doesn't seem like a big overhead to me (given that
we already spend a ton of time copying all the cmsg stuff), but no
strong preference on my side..
