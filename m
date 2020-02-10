From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_balloon: Fix unused label warning
Date: Mon, 10 Feb 2020 10:38:12 +0100
Message-ID: <c6ee9611-745b-0292-9fde-c037d2e407a9@redhat.com>
References: <20200210093328.15349-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200210093328.15349-1-bp@alien8.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>, virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 10.02.20 10:33, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
>=20
> Fix
>=20
>   drivers/virtio/virtio_balloon.c: In function =E2=80=98virtballoon_pro=
be=E2=80=99:
>   drivers/virtio/virtio_balloon.c:963:1: warning: label =E2=80=98out_de=
l_vqs=E2=80=99 defined but not used [-Wunused-label]
>     963 | out_del_vqs:
>         | ^~
>=20
> The CONFIG_BALLOON_COMPACTION ifdeffery should enclose it too.
>=20
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
> index 7bfe365d9372..b6ed5f8bccb1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -959,9 +959,9 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
>  	iput(vb->vb_dev_info.inode);
>  out_kern_unmount:
>  	kern_unmount(balloon_mnt);
> -#endif
>  out_del_vqs:
>  	vdev->config->del_vqs(vdev);
> +#endif
>  out_free_vb:
>  	kfree(vb);
>  out:
>=20

Oh, right, thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb
