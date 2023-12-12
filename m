Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC74D2E1
	for <virtualization@lists.linux.dev>; Tue, 12 Dec 2023 04:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fY21y5tr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702355720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
	b=fY21y5trR46im1+Qy8QOObhsQMJZbsfgzNB7fhDoPU7RrAhQEZHRxrbTkOJr/QnXUS/ctd
	YmcPfJZ3e7gld/jOwfpll2xV2ROhej+hMuL8+as9EOhNMZQxKNLIuWR9kj+eyZbcx2QLFu
	vCWvYPcmaEUYKd2Kx1HxfiC3GspD9Fg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-l2DdY2mPPyCf7-eDRn9pog-1; Mon, 11 Dec 2023 23:35:16 -0500
X-MC-Unique: l2DdY2mPPyCf7-eDRn9pog-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77f54de7f10so531876485a.1
        for <virtualization@lists.linux.dev>; Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702355716; x=1702960516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VntsOLPXuWJtx6zQj2tvFN5GConn9kSc0M72tw246g=;
        b=I0FTedyBm8YIX95Rpt3Ql4sJh9Xxazq5bMTp33r0CWAT47pzbaCjx438/hwdUuNKmi
         Uoc5EFNw2FwyiFNWyBbPGk5tLb75sSmLvCt9lNqiGdzOhrVhCU2xmETNO3WgyOtEZM1Q
         GFeOdUwZ1Mo69AJMUlnVuCTAFKqZgIiVwzyk2b12wltjJdu4KUPfwrBDOvE+UA1jOIM7
         fpAfzWL/X7Z6xb1WqjvB4J9BSrYTjRf+Rc6m+F1vRJOyVXE1CV4RcUeUAMRPLmUpMPdi
         CVXHpkSxKQKm8o5tHkJ625cblZ/J/9aQ11lRhM2bHi2zveA7XFq0jTLBRt/EFRMmJDlv
         g0bg==
X-Gm-Message-State: AOJu0Ywp4PmeB/8ZLxjO9Ecu4OTorpZZzhLSSEfliQXIBsk3lrHpckUt
	aFfbEzIpv2ccO7eiqNj9WupC/xulYS9kTsrTxAcU7zhzuN/KqTfo5xw1q5vr5ikYzWYaJKZwZOs
	TbIMCqoevI63G2gRJeM5dE8i9vC9bdXOYiynIhHm4ywk=
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id br20-20020a05620a461400b0077f06dd4dbamr8523584qkb.96.1702355716196;
        Mon, 11 Dec 2023 20:35:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrOyuf1Odoaak2ZYdtgyzyZFIpFfyG35pal8NbvcJN0xXVIGcCgktqW+IfyPOYVkS+zor94oNUfe4BlGyRZ3A=
X-Received: by 2002:a05:620a:4614:b0:77f:6dd:4dba with SMTP id
 br20-20020a05620a461400b0077f06dd4dbamr8523573qkb.96.1702355715908; Mon, 11
 Dec 2023 20:35:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com>
 <20231205113444.63015-7-linyunsheng@huawei.com> <CACGkMEvVezZnHK-gRWY+MUd_6awnprb024scqPNmMQ05P8rWTQ@mail.gmail.com>
 <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
In-Reply-To: <424670ab-23d8-663b-10cb-d88906767956@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Dec 2023 12:35:04 +0800
Message-ID: <CACGkMEsMdP1B-9RaqibJYfFsd_qJpB+Kta5BnyD_WXH=W2w_OQ@mail.gmail.com>
Subject: Re: [PATCH net-next 6/6] tools: virtio: introduce vhost_net_test
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 7:28=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2023/12/7 14:00, Jason Wang wrote:
> > On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> ...
>
> >> +
> >> +static int tun_alloc(void)
> >> +{
> >> +       struct ifreq ifr;
> >> +       int fd, e;
> >> +
> >> +       fd =3D open("/dev/net/tun", O_RDWR);
> >> +       if (fd < 0) {
> >> +               perror("Cannot open /dev/net/tun");
> >> +               return fd;
> >> +       }
> >> +
> >> +       memset(&ifr, 0, sizeof(ifr));
> >> +
> >> +       ifr.ifr_flags =3D IFF_TUN | IFF_NO_PI;
> >
> > Why did you use IFF_TUN but not IFF_TAP here?
>
> To be honest, no particular reason, I just picked IFF_TUN and it happened
> to work for me to test changing in vhost_net_build_xdp().
>
> Is there a particular reason you perfer the IFF_TAP over IFF_TUN?

No preference here. It only matters if you want to test L2 or L3.


>
> >
> >> +       strncpy(ifr.ifr_name, "tun0", IFNAMSIZ);
> >
> > tun0 is pretty common if there's a VPN. Do we need some randomized name=
 here?
>
> How about something like below?
>
> snprintf(ifr.ifr_name, IFNAMSIZ, "tun_%d", getpid());
>
> >
> >
> >> +
> >> +       e =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
> >> +       if (e < 0) {
> >> +               perror("ioctl[TUNSETIFF]");
> >> +               close(fd);
> >> +               return e;
> >> +       }
> >> +
> >> +       return fd;
> >> +}
> >> +
> >> +/* Unused */
> >> +void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> >
> > Why do we need trick like these here?
>
> That is because of the below error:
> tools/virtio/./linux/kernel.h:58: undefined reference to `__kmalloc_fake'
>
> when virtio_ring.c is compiled in the userspace, the kmalloc raleted func=
tion
> is implemented in tools/virtio/./linux/kernel.h, which requires those var=
ibles
> to be defined.
>
> >
> >> +
> >> +struct vq_info {
> >> +       int kick;
> >> +       int call;
> >> +       int num;
> >> +       int idx;
> >> +       void *ring;
> >> +       /* copy used for control */
> >> +       struct vring vring;
> >> +       struct virtqueue *vq;
> >> +};
> >> +
> >> +struct vdev_info {
> >> +       struct virtio_device vdev;
> >> +       int control;
> >> +       struct pollfd fds[1];
> >> +       struct vq_info vqs[1];
> >> +       int nvqs;
> >> +       void *buf;
> >> +       size_t buf_size;
> >> +       struct vhost_memory *mem;
> >> +};
> >> +
> >> +static struct vhost_vring_file no_backend =3D { .index =3D 1, .fd =3D=
 -1 },
> >> +                                    backend =3D { .index =3D 1, .fd =
=3D 1 };
> >
> > A magic number like fd =3D 1 is pretty confusing.
> >
> > And I don't see why we need global variables here.
>
> I was using the virtio_test.c as reference, will try to remove it
> if it is possible.
>
> >
> >> +static const struct vhost_vring_state null_state =3D {};
> >> +
>
> ..
>
> >> +
> >> +done:
> >> +       backend.fd =3D tun_alloc();
> >> +       assert(backend.fd >=3D 0);
> >> +       vdev_info_init(&dev, features);
> >> +       vq_info_add(&dev, 256);
> >> +       run_test(&dev, &dev.vqs[0], delayed, batch, reset, nbufs);
> >
> > I'd expect we are testing some basic traffic here. E.g can we use a
> > packet socket then we can test both tx and rx?
>
> Yes, only rx for tun is tested.
> Do you have an idea how to test the tx too? As I am not familar enough
> with vhost_net and tun yet.

Maybe you can have a packet socket to bind to the tun/tap. Then you can tes=
t:

1) TAP RX: by write a packet via virtqueue through vhost_net and read
it from packet socket
2) TAP TX:  by write via packet socket and read it from the virtqueue
through vhost_net

Thanks

>
> >
> > Thanks
>

