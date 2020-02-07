From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] tools/virtio: option to build an out of tree module
Date: Fri, 7 Feb 2020 11:38:20 +0800
Message-ID: <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
References: <20200206080125.1178242-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200206080125.1178242-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/6 =E4=B8=8B=E5=8D=884:01, Michael S. Tsirkin wrote:
> Handy for testing with distro kernels.
> Warn that the resulting module is completely unsupported,
> and isn't intended for production use.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tools/virtio/Makefile | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 8e2a908115c2..94106cde49e3 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -8,7 +8,18 @@ CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../include/ -I =
../../usr/include/ -Wno-poin
>   vpath %.c ../../drivers/virtio ../../drivers/vhost
>   mod:
>   	${MAKE} -C `pwd`/../.. M=3D`pwd`/vhost_test V=3D${V}
> -.PHONY: all test mod clean
> +
> +#oot: build vhost as an out of tree module for a distro kernel
> +#no effort is taken to make it actually build or work, but tends to mo=
stly work
> +#if the distro kernel is very close to upstream
> +#unsupported! this is a development tool only, don't use the
> +#resulting modules in production!
> +oot:
> +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> +	KCFLAGS=3D"-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/=
$$(uname -r) M=3D`pwd`/vhost_test V=3D${V}
> +	KCFLAGS=3D"-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/=
$$(uname -r) M=3D`pwd`/../../drivers/vhost V=3D${V} CONFIG_VHOST_VSOCK=3D=
n


Any reason for disabling vsock here?

Thanks


> +
> +.PHONY: all test mod clean vhost oot
>   clean:
>   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
>                 vhost_test/Module.symvers vhost_test/modules.order *.d
