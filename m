From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] drivers: virtio: Make out_del_vqs dependent on BALLOON_COMPACTION
Date: Sun, 8 Mar 2020 20:38:19 +0100
Message-ID: <4AB99BBC-0EC7-40F0-96ED-04796A73CBA2@redhat.com>
References: <20200306105528.5272-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306105528.5272-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org



> Am 06.03.2020 um 11:56 schrieb Vincenzo Frascino <vincenzo.frascino@arm.co=
m>:
>=20
> =EF=BB=BFout_del_vqs label is currently used only when BALLOON_COMPACTION
> configuration option is enabled. Having it disabled triggers the
> following warning at compile time:
>=20
> drivers/virtio/virtio_balloon.c: In function =E2=80=98virtballoon_probe=E2=
=80=99:
> drivers/virtio/virtio_balloon.c:963:1: warning: label =E2=80=98out_del_vqs=
=E2=80=99
> defined but not used [-Wunused-label]
>  963 | out_del_vqs:
>      | ^~~~~~~~~~~
>=20
> Make out_del_vqs dependent on BALLOON_COMPACTION to address the
> issue.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

I think this is now the third patch on the list that tries to fix this warni=
ng.

Michael, can we finally queue one of these (or is there one in -next already=
 - did not check)?

Thanks=
