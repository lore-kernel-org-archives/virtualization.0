From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] tools/virtio: option to build an out of tree module
Date: Tue, 11 Feb 2020 11:19:37 +0800
Message-ID: <e361e68d-e7c8-1fe0-45c1-21e6be8333d1@redhat.com>
References: <20200207073327.1205669-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200207073327.1205669-1-mst@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/2/7 =E4=B8=8B=E5=8D=883:35, Michael S. Tsirkin wrote:
> Handy for testing with distro kernels.
> Warn that the resulting module is completely unsupported,
> and isn't intended for production use.
>
> Usage:
>          make oot # builds vhost_test.ko, vhost.ko
>          make oot-clean # cleans out files created
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> changes from v1:
> 	lots of refactoring
> 	disable all modules except vhost by default (more of a chance
> 						     it'll build)
> 	oot-clean target
>
>   tools/virtio/Makefile | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> index 8e2a908115c2..f33f32f1d208 100644
> --- a/tools/virtio/Makefile
> +++ b/tools/virtio/Makefile
> @@ -8,7 +8,32 @@ CFLAGS +=3D -g -O2 -Werror -Wall -I. -I../include/ -I =
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
> +OOT_KSRC=3D/lib/modules/$$(uname -r)/build
> +OOT_VHOST=3D`pwd`/../../drivers/vhost
> +#Everyone depends on vhost
> +#Tweak the below to enable more modules
> +OOT_CONFIGS=3D\
> +	CONFIG_VHOST=3Dm \
> +	CONFIG_VHOST_NET=3Dn \
> +	CONFIG_VHOST_SCSI=3Dn \
> +	CONFIG_VHOST_VSOCK=3Dn
> +OOT_BUILD=3DKCFLAGS=3D"-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=3D${V=
}
> +oot-build:
> +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> +	${OOT_BUILD} M=3D`pwd`/vhost_test
> +	${OOT_BUILD} M=3D${OOT_VHOST} ${OOT_CONFIGS}
> +
> +oot-clean: oot-build
> +oot: oot-build
> +oot-clean: OOT_BUILD+=3Dclean
> +
> +.PHONY: all test mod clean vhost oot oot-clean oot-build
>   clean:
>   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
>                 vhost_test/Module.symvers vhost_test/modules.order *.d


Acked-by: Jason Wang <jasowang@redhat.com>
