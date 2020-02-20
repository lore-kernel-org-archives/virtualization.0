From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_balloon: Fix build error seen with CONFIG_BALLOON_COMPACTION=n
Date: Thu, 20 Feb 2020 10:09:20 +0100
Message-ID: <48277641-3748-4EFD-BB19-ED5C9E06FDF2@redhat.com>
References: <20200220023156.20636-1-linux@roeck-us.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200220023156.20636-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> Am 20.02.2020 um 03:32 schrieb Guenter Roeck <linux@roeck-us.net>:
>=20
> =EF=BB=BF0day reports:
>=20
> drivers//virtio/virtio_balloon.c: In function 'virtballoon_probe':
> drivers//virtio/virtio_balloon.c:960:1: error:
>    label 'out_del_vqs' defined but not used [-Werror=3Dunused-label]
>=20
> This is seen with CONFIG_BALLOON_COMPACTION=3Dn.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtba=
lloon_probe()")
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

There is already a patch on the list to fix that (and it looks exactly like t=
his one :) ). Unfortunately, not picked up yet.

Thanks!=
