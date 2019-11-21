From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Date: Thu, 21 Nov 2019 16:25:17 +0100
Message-ID: <20191121152517.zfedz6hg6ftcb2ks__42708.8152662449$1574349938$gmane$org@steredhat>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
 <20191121093458.GB439743@stefanha-x1.localdomain>
 <20191121095948.bc7lc3ptsh6jxizw@steredhat>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191121095948.bc7lc3ptsh6jxizw@steredhat>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 21, 2019 at 10:59:48AM +0100, Stefano Garzarella wrote:
> On Thu, Nov 21, 2019 at 09:34:58AM +0000, Stefan Hajnoczi wrote:
> > On Tue, Nov 19, 2019 at 12:01:19PM +0100, Stefano Garzarella wrote:
> > 
> > Ideas for long-term changes below.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> Thanks for reviewing!
> 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 760049454a23..c2a3dc3113ba 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17239,6 +17239,7 @@ F:	net/vmw_vsock/diag.c
> > >  F:	net/vmw_vsock/af_vsock_tap.c
> > >  F:	net/vmw_vsock/virtio_transport_common.c
> > >  F:	net/vmw_vsock/virtio_transport.c
> > > +F:	net/vmw_vsock/vsock_loopback.c
> > >  F:	drivers/net/vsockmon.c
> > >  F:	drivers/vhost/vsock.c
> > >  F:	tools/testing/vsock/
> > 
> > At this point you are most active in virtio-vsock and I am reviewing
> > patches on a best-effort basis.  Feel free to add yourself as
> > maintainer.
> > 
> 
> Sure, I'd be happy to maintain it.
> 
> > > diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
> > > new file mode 100644
> > > index 000000000000..3d1c1a88305f
> > > --- /dev/null
> > > +++ b/net/vmw_vsock/vsock_loopback.c
> > > @@ -0,0 +1,217 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * loopback transport for vsock using virtio_transport_common APIs
> > > + *
> > > + * Copyright (C) 2013-2019 Red Hat, Inc.
> > > + * Author: Asias He <asias@redhat.com>
> > > + *         Stefan Hajnoczi <stefanha@redhat.com>
> > > + *         Stefano Garzarella <sgarzare@redhat.com>
> > > + *
> > > + */
> > > +#include <linux/spinlock.h>
> > > +#include <linux/module.h>
> > > +#include <linux/list.h>
> > > +#include <linux/virtio_vsock.h>
> > 
> > Is it time to rename the generic functionality in
> > virtio_transport_common.c?  This doesn't have anything to do with virtio
> > :).
> > 
> 
> Completely agree, new transports could use it to handle the protocol without
> reimplementing things already done.
> 
> > > +
> > > +static struct workqueue_struct *vsock_loopback_workqueue;
> > > +static struct vsock_loopback *the_vsock_loopback;
> > 
> > the_vsock_loopback could be a static global variable (not a pointer) and
> > vsock_loopback_workqueue could also be included in the struct.
> > 
> > The RCU pointer is really a way to synchronize vsock_loopback_send_pkt()
> > and vsock_loopback_cancel_pkt() with module exit.  There is no other
> > reason for using a pointer.
> > 
> > It's cleaner to implement the synchronization once in af_vsock.c (or
> > virtio_transport_common.c) instead of making each transport do it.
> > Maybe try_module_get() and related APIs provide the necessary semantics
> > so that core vsock code can hold the transport module while it's being
> > used to send/cancel a packet.
> 
> Right, the module cannot be unloaded until open sockets, so here the
> synchronization is not needed.
> 
> The synchronization come from virtio-vsock device that can be
> hot-unplugged while sockets are still open, but that can't happen here.
> 
> I will remove the pointers and RCU in the v2.
> 
> Can I keep your R-b or do you prefer to watch v2 first?
> 
> > 
> > > +MODULE_ALIAS_NETPROTO(PF_VSOCK);
> > 
> > Why does this module define the alias for PF_VSOCK?  Doesn't another
> > module already define this alias?
> 
> It is a way to load this module when PF_VSOCK is starting to be used.
> MODULE_ALIAS_NETPROTO(PF_VSOCK) is already defined in vmci_transport
> and hyperv_transport. IIUC it is used for the same reason.
> 
> In virtio_transport we don't need it because it will be loaded when
> the PCI device is discovered.
> 
> Do you think there's a better way?
> Should I include the vsock_loopback transport directly in af_vsock
> without creating a new module?
> 

That last thing I said may not be possible:
I remembered that I tried, but DEPMOD found a cyclic dependency because
vsock_transport use virtio_transport_common that use vsock, so if I
include vsock_transport in the vsock module, DEPMOD is not happy.

Do you think it's okay in this case to keep MODULE_ALIAS_NETPROTO(PF_VSOCK)
or is there a better way?

Thanks,
Stefano
