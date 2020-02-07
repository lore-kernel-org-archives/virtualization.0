From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tools/virtio: option to build an out of tree module
Date: Fri, 7 Feb 2020 02:10:26 -0500
Message-ID: <20200207015917-mutt-send-email-mst@kernel.org>
References: <20200206080125.1178242-1-mst@redhat.com>
 <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d4581772-8314-e746-dbea-2603e0447cdd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 07, 2020 at 11:38:20AM +0800, Jason Wang wrote:
> 
> On 2020/2/6 下午4:01, Michael S. Tsirkin wrote:
> > Handy for testing with distro kernels.
> > Warn that the resulting module is completely unsupported,
> > and isn't intended for production use.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   tools/virtio/Makefile | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
> > index 8e2a908115c2..94106cde49e3 100644
> > --- a/tools/virtio/Makefile
> > +++ b/tools/virtio/Makefile
> > @@ -8,7 +8,18 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
> >   vpath %.c ../../drivers/virtio ../../drivers/vhost
> >   mod:
> >   	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
> > -.PHONY: all test mod clean
> > +
> > +#oot: build vhost as an out of tree module for a distro kernel
> > +#no effort is taken to make it actually build or work, but tends to mostly work
> > +#if the distro kernel is very close to upstream
> > +#unsupported! this is a development tool only, don't use the
> > +#resulting modules in production!
> > +oot:
> > +	echo "UNSUPPORTED! Don't use the resulting modules in production!"
> > +	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/vhost_test V=${V}
> > +	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/../../drivers/vhost V=${V} CONFIG_VHOST_VSOCK=n
> 
> 
> Any reason for disabling vsock here?
> 
> Thanks

It's just moving too fast with its internal API changes for a simplistic
oot build like this to work. But I guess it need to make it a bit
more generic. I'll try.

> 
> > +
> > +.PHONY: all test mod clean vhost oot
> >   clean:
> >   	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
> >                 vhost_test/Module.symvers vhost_test/modules.order *.d
