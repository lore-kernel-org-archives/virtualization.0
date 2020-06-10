From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio-mem: silence a static checker warning
Date: Wed, 10 Jun 2020 11:43:42 +0200
Message-ID: <56B2561B-33AC-40AB-9991-97EC72F9613F@redhat.com>
References: <20200610085911.GC5439@mwanda>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20200610085911.GC5439@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org



> Am 10.06.2020 um 10:59 schrieb Dan Carpenter <dan.carpenter@oracle.com>:
>=20
> =EF=BB=BFSmatch complains that "rc" can be uninitialized if we hit the "br=
eak;"
> statement on the first iteration through the loop.  I suspect that this
> can't happen in real life, but returning a zero literal is cleaner and
> silence the static checker warning.
>=20

Right, it=E2=80=98s impossible in real life. Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> drivers/virtio/virtio_mem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f658fe9149beb..893ef18060a02 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -1192,7 +1192,7 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_m=
em *vm, unsigned long mb_id,
>                        VIRTIO_MEM_MB_STATE_OFFLINE);
>    }
>=20
> -    return rc;
> +    return 0;
> }
>=20
> /*
> --=20
> 2.26.2
>=20
