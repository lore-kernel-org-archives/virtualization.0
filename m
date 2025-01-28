Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0677F7FC
	for <virtualization@lists.linux.dev>; Tue, 28 Jan 2025 03:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738036279; cv=none; b=m8YYGIDnx2Q+GJJ6QNcVhb2w7R5LGxrf5nCWcu/D6I4gti3kdzocNdCYZxmufduxBg7CLyxMWcblqmzZIaQTDQD8nNnuplgflKft/ijfwLe7TuiDV8y0BY6iIsxX9p1DgWibjz6CF653jRf/oQcmTetMvtPITXNDDZEN8aYbcq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738036279; c=relaxed/simple;
	bh=7DHdH3QIB4/aIvYvMzTcfsXzKyQPErbl4wTLrcNA4u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txs6Lp2txgxtlf07C4XkOmRDzXKKw7RGMCduOTLYTMOhQOATokrrRm7nXFwshyswGIGs5uSyxXvpjXsBcardztsKdbbx99mRDiJ6nvtGjvlurhNFmGW5ZK5xnnABWyVSLxNRVu7CkPevZ4ymbb5Obswc81hiaeiHet8a7/oxbls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMJIEqoE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMJIEqoE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21680814d42so84518665ad.2
        for <virtualization@lists.linux.dev>; Mon, 27 Jan 2025 19:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738036277; x=1738641077; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eE4NK7zi6DRmjZbJJPFVGsr/4GCtOpXvykBa4nzZpdw=;
        b=gMJIEqoE8pqZ8JbP95DiU8T4dIzywrXK423yqtoJhDnGegx8RnIhIAoR0cXG1Yx76D
         zwcgqSuHzKaEVSHxXAOopAPbhNwx1++emnbPfgrxJYs4/qOrg5jbkiQjTDMSWkBM60mY
         EOTZP1G6eaNpTZjXujl2Hy4x2vpFxR7ms55U5lUzr2BeNRFLpcHAAENHcRQmD/L+6okZ
         EWxONqISgGz3R24rTFbdE0g+iCw3Nw8A04pJXhw5psgi7Bmhf5FgfCHNMk9z5uYtVl5e
         yezVuztaxb8RJk88ftLDvUp7F4PpLwxhfxV544YY/4LtzKdyfutRcukQItiYLBMjv1EY
         nQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738036277; x=1738641077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eE4NK7zi6DRmjZbJJPFVGsr/4GCtOpXvykBa4nzZpdw=;
        b=Sn5YVM6cv1vjhLqqsVTlrlrMSMTko4bEp0hi04+a+VMkqTprntSC3vg+hwaBoakMYt
         4h8MZtp1u57PCASzIeZptstiRm1q7ZYt2tG2U0NcASk/7ptgB9MCpW+i5OQgl+Mua4kl
         +/JlRq4oB13i4OPQxOWMFayphPQ/Y1sYQfX4nTsYZswgPiwNMk473D0y5ZOM3IfUGLcm
         EH85F2NVLhNsH6eFqbDFRly3+LXTr2jyNpHEd9Ej70idt/JARoAOvrMoct0xETEL6Iwd
         q+wj3zUzJgznxlNKty8rtEtk8I6sKi3g/6R1wrmFSFO+r4leJDs0ac6XqIk8EPsOG1HS
         ticA==
X-Forwarded-Encrypted: i=1; AJvYcCWiV9EmC9n9tYN0ygExoJSx4uv/BkH2thcT8SU8AdnyJ7bOhCInC/jonsoeWEm2N2qj4dSUPJ/sKlbh+gSN8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcLfmR2UbX1nJieIcScwy2rjam1b317evicDohr/K0SU+zVrV0
	k7vxP/0B93QXhoHJvjOZ/y+auAVwLi5Sxjg525fW5A/cUlkm7w9xCnnMO1w=
X-Gm-Gg: ASbGncubS41e0udgC1Ky4sKug7d2xFH9/NS4jGssTC0wzHGHCp56jT5fvbr7yUxWCrF
	IdmswVMf/EyjoYOrA2Dqh2j7xgFYeW6Kek+l08hOIzjPVHYAYlX79uBSSBcmqWzOZZzY9PdrR9P
	8/IVuRyKW3cEvdZbi8cq/KXk4MIUNGDXupJOdXx9En9bJ+eShFtcZaJaTPj6Vg1Wnz6Qeo9siPb
	6ouliUY26nvlVdJ6MGAm1sjE1hfGBP9ke7+oy09mn6muTU1EQzCWCRMDaDK6UNe8oYXsJTPfFPW
	dGbp3LxOjXk9WLs=
X-Google-Smtp-Source: AGHT+IFDB8vH86L3VCH6mxs2zWmuZXjDaEw3CuiPxfDxVtjVS5KKM1yt/iURsdzQSwN6nIik2SGVkQ==
X-Received: by 2002:a05:6a00:1c9b:b0:725:e015:9090 with SMTP id d2e1a72fcca58-72daf9508a0mr52200721b3a.9.1738036277037;
        Mon, 27 Jan 2025 19:51:17 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72f8a760e2asm8023776b3a.88.2025.01.27.19.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 19:51:16 -0800 (PST)
Date: Mon, 27 Jan 2025 19:51:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Ahern <dsahern@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joe Damato <jdamato@fastly.com>, dw@davidwei.uk
Subject: Re: [PATCH RFC net-next v1 1/5] net: add devmem TCP TX documentation
Message-ID: <Z5hUMyWY7PpCLK2c@mini-arch>
References: <20241221004236.2629280-1-almasrymina@google.com>
 <20241221004236.2629280-2-almasrymina@google.com>
 <Z2ZKl_t5e6rutAZ1@mini-arch>
 <CAHS8izOcQRjYYGwA_rx-zvX8dMV=40rzVJvEugY78jzCBHCq=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOcQRjYYGwA_rx-zvX8dMV=40rzVJvEugY78jzCBHCq=A@mail.gmail.com>

On 01/27, Mina Almasry wrote:
> On Fri, Dec 20, 2024 at 8:56 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 12/21, Mina Almasry wrote:
> > > Add documentation outlining the usage and details of the devmem TCP TX
> > > API.
> > >
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > ---
> > >  Documentation/networking/devmem.rst | 140 +++++++++++++++++++++++++++-
> > >  1 file changed, 136 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> > > index d95363645331..9be01cd96ee2 100644
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
> > > @@ -235,6 +235,138 @@ can be less than the tokens provided by the user in case of:
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
> >
> > [...]
> >
> > > +The user should create a msghdr with iov_base set to NULL and iov_len set to the
> > > +number of bytes to be sent from the dmabuf.
> >
> > Should we verify that iov_base is NULL in the kernel?
> >
> > But also, alternatively, why not go with iov_base == offset? This way we
> > can support several offsets in a single message, just like regular
> > sendmsg with host memory. Any reason to not do that?
> >
> 
> Sorry for the late reply. Some of these suggestions took a bit to
> investigate and other priorities pulled me a bit from this.
> 
> I've prototyped using iov_base as offset with some help from your
> published branch, and it works fine. It seems to me a big improvement
> to the UAPI. Will reupload RFC v2 while the tree is closed with this
> change.

Great, thanks for the update, looking forward!
