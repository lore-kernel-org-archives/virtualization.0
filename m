Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC241E4A9
	for <virtualization@lists.linux.dev>; Tue, 28 May 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890661; cv=none; b=VBe0Yi4zQZ77+MVmRC+IMLtxVHI69PUVVpZH1KHDXlEWxEixJ1rrjHV/B2Xy2+Q93pup4+6t7tjCyen7AbaQGCN5gL1qVH3kgh4HavEjzxMe98pIDkU6Qp35Y7BKUoyiWzlslbQUULq5CBex77Eqx4mSJfPi3EYuFoji1A5e5Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890661; c=relaxed/simple;
	bh=JLZBjuV9FjWwrqElkHL7/0Dzy6r5XduYESmPLs/5DrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QK3vMZN6bIXzIcqsJY8msC/ob4a3a8gbPxqZAYFvxwGfFZxuZ0gigRcJexgxNRjvi8wwNGVj3OTHevLD3z4TLSCAbUNA+wz5+gVKD3B5ouXCudR5x5wMuRIT0Ub/vii8RWmbbof6fE2WaPepXD7MQ0n6af5GqiHq8oVVhKlTtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bm+BmPxz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bm+BmPxz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716890658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9V4jimh/6risGAe2O06TN5OwVU/L4TnWF8iwGoBLZjo=;
	b=Bm+BmPxzoWeCwewKFbkiaMn/YwaHRv4HzTZ10SbrUxSkzP1b4oQ09IShCNO4ftJG5GWYul
	gygbdlIya1Bf+uS3honoc2idWWmF/TxHdWP9NI1mkYu6wy0RWJfwHVq2iGy0ycDNdJmH1O
	YqMb4dQupgzJQ1aNlfOev/UYY65YNbY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-LEKwgTxHOniobb41pT9Azw-1; Tue, 28 May 2024 06:04:17 -0400
X-MC-Unique: LEKwgTxHOniobb41pT9Azw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52848dcebabso128179e87.0
        for <virtualization@lists.linux.dev>; Tue, 28 May 2024 03:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890655; x=1717495455;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcvsDbrOq0GkpjSztve05vpNT+2/RrsUPlhndH7vsLs=;
        b=oJW3uTezS116WkDQZz6TvI5+bWpPvg74FzGjbKrXnGBvSYxwd924zn4xRej/D693Vk
         u4okMnUuNrAi1WvrVrmWBPIq+6att4DZ4dzTzcnPDwPFHbCQeepjNAFUZQYsdXO8HNQB
         4t3ALvZu5BWz55zm2sJ/LiaDGKRchNhEGOIAqrZ4/9H4GXRgFubwPg7xSapHWa+Rl+nu
         vtG42s3dPWGmlrlXNg2mUo4UMnuHuRQNWZSS5ENaVGUDInMUKygMluKDBZc9f08xqwRM
         c/EG6JBK4lddJnS9b8lysQVrfsOs3chTXGoCxqlx1oyVuxjxCzZeBZEVuiF6MlTrv1lZ
         PpnA==
X-Forwarded-Encrypted: i=1; AJvYcCUcsxQYA2cg2Ojq1eAToyshBD0DhN/AaaD4a3KhtS1NH41q3ejLFpsaKV4fSxDZh6pRd6gIYTfO6zDYnQHS7wqFPjD8ON9Rrf9dTnUNcQ8=
X-Gm-Message-State: AOJu0YxaUFCFbgHo+zXl93ZOq+bSxn5MOXsFeBcMN1jbcHx5CZntq3wu
	200oPClaPJPiWYSsfiFVBKa7XI5uoWwSgfBwkxR4lhxRpycuA//E/hxYcrXrd/dVlD71lMOBsLR
	e33VHkEDG8OjJ6r73uHc0RRbhSE/QkPPhmrdg0KoatJLps4/OZYT3LR3HNtnYFlMQ
X-Received: by 2002:a2e:700d:0:b0:2e9:8417:bd83 with SMTP id 38308e7fff4ca-2e98417c2f6mr14578481fa.2.1716890655556;
        Tue, 28 May 2024 03:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDX6q4BHIIUrvRpHdC4viyVbBbRa7x2mqeybNkxr9smMj9o8Xg3R3KLzlmvTOAu7aaRV/Hqw==
X-Received: by 2002:a2e:700d:0:b0:2e9:8417:bd83 with SMTP id 38308e7fff4ca-2e98417c2f6mr14578221fa.2.1716890655039;
        Tue, 28 May 2024 03:04:15 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35b1d7a496asm1458750f8f.87.2024.05.28.03.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:04:14 -0700 (PDT)
Message-ID: <c443d5d84fc32beb6e11c6dd5fa506abcd6b4fc4.camel@redhat.com>
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
From: Paolo Abeni <pabeni@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 28 May 2024 12:04:13 +0200
In-Reply-To: <1716865564.880848-2-hengqi@linux.alibaba.com>
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
	 <20240523074651.3717-3-hengqi@linux.alibaba.com>
	 <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
	 <1716865564.880848-2-hengqi@linux.alibaba.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=mQINBGISiDUBEAC5uMdJicjm3ZlWQJG4u2EU1EhWUSx8IZLUTmEE8zmjPJFSYDcjtfGcbzLPb63BvX7FADmTOkO7gwtDgm501XnQaZgBUnCOUT8qv5MkKsFH20h1XJyqjPeGM55YFAXc+a4WD0YyO5M0+KhDeRLoildeRna1ey944VlZ6Inf67zMYw9vfE5XozBtytFIrRyGEWkQwkjaYhr1cGM8ia24QQVQid3P7SPkR78kJmrT32sGk+TdR4YnZzBvVaojX4AroZrrAQVdOLQWR+w4w1mONfJvahNdjq73tKv51nIpu4SAC1Zmnm3x4u9r22mbMDr0uWqDqwhsvkanYmn4umDKc1ZkBnDIbbumd40x9CKgG6ogVlLYeJa9WyfVMOHDF6f0wRjFjxVoPO6p/ZDkuEa67KCpJnXNYipLJ3MYhdKWBZw0xc3LKiKc+nMfQlo76T/qHMDfRMaMhk+L8gWc3ZlRQFG0/Pd1pdQEiRuvfM5DUXDo/YOZLV0NfRFU9SmtIPhbdm9cV8Hf8mUwubihiJB/9zPvVq8xfiVbdT0sPzBtxW0fXwrbFxYAOFvT0UC2MjlIsukjmXOUJtdZqBE3v3Jf7VnjNVj9P58+MOx9iYo8jl3fNd7biyQWdPDfYk9ncK8km4skfZQIoUVqrWqGDJjHO1W9CQLAxkfOeHrmG29PK9tHIwARAQABtB9QYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+iQJSBBMBCAA8FiEEg1AjqC77wbdLX2LbKSR5jcyPE6QFAmISiDUCGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheAAAoJECkkeY3MjxOkJSYQAJcc6MTsuFxYdYZkeWjW//zbD3ApRHzpNlHLVSuJqHr9/aDS+tyszgS8jj9MiqALzgq4iZbg
 7ZxN9ZsDL38qVIuFkSpgMZCiUHdxBC11J8nbBSLlpnc924UAyr5XrGA99 6Wl5I4Km3128GY6iAkH54pZpOmpoUyBjcxbJWHstzmvyiXrjA2sMzYjt3Xkqp0cJfIEekOi75wnNPofEEJg28XPcFrpkMUFFvB4Aqrdc2yyR8Y36rbw18sIX3dJdomIP3dL7LoJi9mfUKOnr86Z0xltgcLPGYoCiUZMlXyWgB2IPmmcMP2jLJrusICjZxLYJJLofEjznAJSUEwB/3rlvFrSYvkKkVmfnfro5XEr5nStVTECxfy7RTtltwih85LlZEHP8eJWMUDj3P4Q9CWNgz2pWr1t68QuPHWaA+PrXyasDlcRpRXHZCOcvsKhAaCOG8TzCrutOZ5NxdfXTe3f1jVIEab7lNgr+7HiNVS+UPRzmvBc73DAyToKQBn9kC4jh9HoWyYTepjdcxnio0crmara+/HEyRZDQeOzSexf85I4dwxcdPKXv0fmLtxrN57Ae82bHuRlfeTuDG3x3vl/Bjx4O7Lb+oN2BLTmgpYq7V1WJPUwikZg8M+nvDNcsOoWGbU417PbHHn3N7yS0lLGoCCWyrK1OY0QM4EVsL3TjOfUtCNQYW9sbyBBYmVuaSA8cGFvbG8uYWJlbmlAZ21haWwuY29tPokCUgQTAQgAPBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEoitAhsDBQsJCAcCAyICAQYVCgkICwIEFgIDAQIeBwIXgAAKCRApJHmNzI8TpBzHD/45pUctaCnhee1vkQnmStAYvHmwrWwIEH1lzDMDCpJQHTUQOOJWDAZOFnE/67bxSS81Wie0OKW2jvg1ylmpBA0gPpnzIExQmfP72cQ1TBoeVColVT6Io35BINn+ymM7c0Bn8RvngSEpr3jBtqvvWXjvtnJ5/HbOVQCg62NC6ewosoKJPWpGXMJ9SKsVIOUHsmoWK60spzeiJoSmAwm3zTJQnM5kRh2q
 iWjoCy8L35zPqR5TV+f5WR5hTVCqmLHSgm1jxwKhPg9L+GfuE4d0SWd84y GeOB3sSxlhWsuTj1K6K3MO9srD9hr0puqjO9sAizd0BJP8ucf/AACfrgmzIqZXCfVS7jJ/M+0ic+j1Si3yY8wYPEi3dvbVC0zsoGj9n1R7B7L9c3g1pZ4L9ui428vnPiMnDN3jh9OsdaXeWLvSvTylYvw9q0DEXVQTv4/OkcoMrfEkfbXbtZ3PRlAiddSZA5BDEkkm6P9KA2YAuooi1OD9d4MW8LFAeEicvHG+TPO6jtKTacdXDRe611EfRwTjBs19HmabSUfFcumL6BlVyceIoSqXFe5jOfGpbBevTZtg4kTSHqymGb6ra6sKs+/9aJiONs5NXY7iacZ55qG3Ib1cpQTps9bQILnqpwL2VTaH9TPGWwMY3Nc2VEc08zsLrXnA/yZKqZ1YzSY9MGXWYLkCDQRiEog1ARAAyXMKL+x1lDvLZVQjSUIVlaWswc0nV5y2EzBdbdZZCP3ysGC+s+n7xtq0o1wOvSvaG9h5q7sYZs+AKbuUbeZPu0bPWKoO02i00yVoSgWnEqDbyNeiSW+vI+VdiXITV83lG6pS+pAoTZlRROkpb5xo0gQ5ZeYok8MrkEmJbsPjdoKUJDBFTwrRnaDOfb+Qx1D22PlAZpdKiNtwbNZWiwEQFm6mHkIVSTUe2zSemoqYX4QQRvbmuMyPIbwbdNWlItukjHsffuPivLF/XsI1gDV67S1cVnQbBgrpFDxN62USwewXkNl+ndwa+15wgJFyq4Sd+RSMTPDzDQPFovyDfA/jxN2SK1Lizam6o+LBmvhIxwZOfdYH8bdYCoSpqcKLJVG3qVcTwbhGJr3kpRcBRz39Ml6iZhJyI3pEoX3bJTlR5Pr1Kjpx13qGydSMos94CIYWAKhegI06aTdvvuiigBwjngo/Rk5S+iEGR5KmTqGyp27o6YxZy6D4NIc6PKUzhIUxfvuHNvfu
 sD2W1U7eyLdm/jCgticGDsRtweytsgCSYfbz0gdgUuL3EBYN3JLbAU+UZpy v/fyD4cHDWaizNy/KmOI6FFjvVh4LRCpGTGDVPHsQXaqvzUybaMb7HSfmBBzZqqfVbq9n5FqPjAgD2lJ0rkzb9XnVXHgr6bmMRlaTlBMAEQEAAYkCNgQYAQgAIBYhBINQI6gu+8G3S19i2ykkeY3MjxOkBQJiEog1AhsMAAoJECkkeY3MjxOkY1YQAKdGjHyIdOWSjM8DPLdGJaPgJdugHZowaoyCxffilMGXqc8axBtmYjUIoXurpl+f+a7S0tQhXjGUt09zKlNXxGcebL5TEPFqgJTHN/77ayLslMTtZVYHE2FiIxkvW48yDjZUlefmphGpfpoXe4nRBNto1mMB9Pb9vR47EjNBZCtWWbwJTIEUwHP2Z5fV9nMx9Zw2BhwrfnODnzI8xRWVqk7/5R+FJvl7s3nY4F+svKGD9QHYmxfd8Gx42PZc/qkeCjUORaOf1fsYyChTtJI4iNm6iWbD9HK5LTMzwl0n0lL7CEsBsCJ97i2swm1DQiY1ZJ95G2Nz5PjNRSiymIw9/neTvUT8VJJhzRl3Nb/EmO/qeahfiG7zTpqSn2dEl+AwbcwQrbAhTPzuHIcoLZYV0xDWzAibUnn7pSrQKja+b8kHD9WF+m7dPlRVY7soqEYXylyCOXr5516upH8vVBmqweCIxXSWqPAhQq8d3hB/Ww2A0H0PBTN1REVw8pRLNApEA7C2nX6RW0XmA53PIQvAP0EAakWsqHoKZ5WdpeOcH9iVlUQhRgemQSkhfNaP9LqR1XKujlTuUTpoyT3xwAzkmSxN1nABoutHEO/N87fpIbpbZaIdinF7b9srwUvDOKsywfs5HMiUZhLKoZzCcU/AEFjQsPTATACGsWf3JYPnWxL9
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2024-05-28 at 11:06 +0800, Heng Qi wrote:
> On Mon, 27 May 2024 12:42:43 +0200, Paolo Abeni <pabeni@redhat.com> wrote=
:
> > On Thu, 2024-05-23 at 15:46 +0800, Heng Qi wrote:
> > > This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
> > >=20
> > > When the following snippet is run, lockdep will report a deadlock[1].
> > >=20
> > >   /* Acquire all queues dim_locks */
> > >   for (i =3D 0; i < vi->max_queue_pairs; i++)
> > >           mutex_lock(&vi->rq[i].dim_lock);
> > >=20
> > > There's no deadlock here because the vq locks are always taken
> > > in the same order, but lockdep can not figure it out, and we
> > > can not make each lock a separate class because there can be more
> > > than MAX_LOCKDEP_SUBCLASSES of vqs.
> > >=20
> > > However, dropping the lock is harmless:
> > >   1. If dim is enabled, modifications made by dim worker to coalescin=
g
> > >      params may cause the user's query results to be dirty data.
> >=20
> > It looks like the above can confuse the user-space/admin?
>=20
> Maybe, but we don't seem to guarantee this --
> the global query interface (.get_coalesce) cannot=20
> guarantee correct results when the DIM and .get_per_queue_coalesce are pr=
esent:
>=20
> 1. DIM has been around for a long time (it will modify the per-queue para=
meters),
>    but many nics only have interfaces for querying global parameters.
> 2. Some nics provide the .get_per_queue_coalesce interface, it is not
>    synchronized with DIM.
>=20
> So I think this is acceptable.

Yes, the above sounds acceptable to me.

> > Have you considered instead re-factoring
> > virtnet_send_rx_notf_coal_cmds() to avoid acquiring all the mutex in
> > sequence?
>=20
> Perhaps it is a way to not traverse and update the parameters of each que=
ue
> in the global settings interface.

I'm wondering if something as dumb as the following would suffice? Not
even compile-tested.
---
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4a802c0ea2cb..d844f4c89152 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4267,27 +4267,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct vi=
rtnet_info *vi,
 =09=09=09       ec->rx_max_coalesced_frames !=3D vi->intr_coal_rx.max_pack=
ets))
 =09=09return -EINVAL;
=20
-=09/* Acquire all queues dim_locks */
-=09for (i =3D 0; i < vi->max_queue_pairs; i++)
-=09=09mutex_lock(&vi->rq[i].dim_lock);
-
 =09if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
 =09=09vi->rx_dim_enabled =3D true;
-=09=09for (i =3D 0; i < vi->max_queue_pairs; i++)
+=09=09for (i =3D 0; i < vi->max_queue_pairs; i++) {
+=09=09=09mutex_lock(&vi->rq[i].dim_lock);
 =09=09=09vi->rq[i].dim_enabled =3D true;
-=09=09goto unlock;
+=09=09=09mutex_unlock(&vi->rq[i].dim_lock);
+=09=09}
+=09=09return 0;
 =09}
=20
 =09coal_rx =3D kzalloc(sizeof(*coal_rx), GFP_KERNEL);
-=09if (!coal_rx) {
-=09=09ret =3D -ENOMEM;
-=09=09goto unlock;
-=09}
+=09if (!coal_rx)
+=09=09return -ENOMEM;
=20
 =09if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
 =09=09vi->rx_dim_enabled =3D false;
-=09=09for (i =3D 0; i < vi->max_queue_pairs; i++)
+=09=09for (i =3D 0; i < vi->max_queue_pairs; i++) {
+=09=09=09mutex_lock(&vi->rq[i].dim_lock);
 =09=09=09vi->rq[i].dim_enabled =3D false;
+=09=09=09mutex_unlock(&vi->rq[i].dim_lock);
+=09=09}
 =09}
=20
 =09/* Since the per-queue coalescing params can be set,
@@ -4300,21 +4300,17 @@ static int virtnet_send_rx_notf_coal_cmds(struct vi=
rtnet_info *vi,
=20
 =09if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
 =09=09=09=09  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
-=09=09=09=09  &sgs_rx)) {
-=09=09ret =3D -EINVAL;
-=09=09goto unlock;
-=09}
+=09=09=09=09  &sgs_rx))
+=09=09return -EINVAL;
=20
 =09vi->intr_coal_rx.max_usecs =3D ec->rx_coalesce_usecs;
 =09vi->intr_coal_rx.max_packets =3D ec->rx_max_coalesced_frames;
 =09for (i =3D 0; i < vi->max_queue_pairs; i++) {
+=09=09mutex_lock(&vi->rq[i].dim_lock);
 =09=09vi->rq[i].intr_coal.max_usecs =3D ec->rx_coalesce_usecs;
 =09=09vi->rq[i].intr_coal.max_packets =3D ec->rx_max_coalesced_frames;
-=09}
-unlock:
-=09for (i =3D vi->max_queue_pairs - 1; i >=3D 0; i--)
 =09=09mutex_unlock(&vi->rq[i].dim_lock);
-
+=09}
 =09return ret;
 }
---

Otherwise I think you need to add {READ,WRITE}_ONCE annotations while
touching the dim fields to avoid data races.

Thanks,

Paolo





