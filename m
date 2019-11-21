From: Jorgen Hansen via Virtualization
 <virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 3/6] vsock: add local transport support in the
 vsock core
Date: Thu, 21 Nov 2019 15:53:47 +0000
Message-ID: <MWHPR05MB3376D95B5E50DF7CAF675EEDDA4E0__37967.7650331118$1574351647$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-4-sgarzare@redhat.com>
 <MWHPR05MB3376F4452F0CF38C1AFABA2EDA4E0@MWHPR05MB3376.namprd05.prod.outlook.com>
 <20191121152148.slv26oesn25dpjb6@steredhat>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191121152148.slv26oesn25dpjb6@steredhat>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: 'Stefano Garzarella' <sgarzare@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> Sent: Thursday, November 21, 2019 4:22 PM
> 
> On Thu, Nov 21, 2019 at 03:04:18PM +0000, Jorgen Hansen wrote:
> > > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > > Sent: Tuesday, November 19, 2019 12:01 PM
> > > To: netdev@vger.kernel.org
> > >
> > > This patch allows to register a transport able to handle
> > > local communication (loopback).
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  include/net/af_vsock.h   |  2 ++
> > >  net/vmw_vsock/af_vsock.c | 17 ++++++++++++++++-
> > >  2 files changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > > index 4206dc6d813f..b1c717286993 100644
> > > --- a/include/net/af_vsock.h
> > > +++ b/include/net/af_vsock.h
> > > @@ -98,6 +98,8 @@ struct vsock_transport_send_notify_data {
> > >  #define VSOCK_TRANSPORT_F_G2H		0x00000002
> > >  /* Transport provides DGRAM communication */
> > >  #define VSOCK_TRANSPORT_F_DGRAM		0x00000004
> > > +/* Transport provides local (loopback) communication */
> > > +#define VSOCK_TRANSPORT_F_LOCAL		0x00000008
> > >
> > >  struct vsock_transport {
> > >  	struct module *module;
> > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > > index cc8659838bf2..c9e5bad59dc1 100644
> > > --- a/net/vmw_vsock/af_vsock.c
> > > +++ b/net/vmw_vsock/af_vsock.c
> > > @@ -136,6 +136,8 @@ static const struct vsock_transport
> *transport_h2g;
> > >  static const struct vsock_transport *transport_g2h;
> > >  /* Transport used for DGRAM communication */
> > >  static const struct vsock_transport *transport_dgram;
> > > +/* Transport used for local communication */
> > > +static const struct vsock_transport *transport_local;
> > >  static DEFINE_MUTEX(vsock_register_mutex);
> > >
> > >  /**** UTILS ****/
> > > @@ -2130,7 +2132,7 @@
> EXPORT_SYMBOL_GPL(vsock_core_get_transport);
> > >
> > >  int vsock_core_register(const struct vsock_transport *t, int features)
> > >  {
> > > -	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram;
> > > +	const struct vsock_transport *t_h2g, *t_g2h, *t_dgram, *t_local;
> > >  	int err = mutex_lock_interruptible(&vsock_register_mutex);
> > >
> > >  	if (err)
> > > @@ -2139,6 +2141,7 @@ int vsock_core_register(const struct
> > > vsock_transport *t, int features)
> > >  	t_h2g = transport_h2g;
> > >  	t_g2h = transport_g2h;
> > >  	t_dgram = transport_dgram;
> > > +	t_local = transport_local;
> > >
> > >  	if (features & VSOCK_TRANSPORT_F_H2G) {
> > >  		if (t_h2g) {
> > > @@ -2164,9 +2167,18 @@ int vsock_core_register(const struct
> > > vsock_transport *t, int features)
> > >  		t_dgram = t;
> > >  	}
> > >
> > > +	if (features & VSOCK_TRANSPORT_F_LOCAL) {
> > > +		if (t_local) {
> > > +			err = -EBUSY;
> > > +			goto err_busy;
> > > +		}
> > > +		t_local = t;
> > > +	}
> > > +
> > >  	transport_h2g = t_h2g;
> > >  	transport_g2h = t_g2h;
> > >  	transport_dgram = t_dgram;
> > > +	transport_local = t_local;
> > >
> > >  err_busy:
> > >  	mutex_unlock(&vsock_register_mutex);
> > > @@ -2187,6 +2199,9 @@ void vsock_core_unregister(const struct
> > > vsock_transport *t)
> > >  	if (transport_dgram == t)
> > >  		transport_dgram = NULL;
> > >
> > > +	if (transport_local == t)
> > > +		transport_local = NULL;
> > > +
> > >  	mutex_unlock(&vsock_register_mutex);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vsock_core_unregister);
> > > --
> > > 2.21.0
> >
> > Having loopback support as a separate transport fits nicely, but do we need
> to support
> > different variants of loopback? It could just be built in.
> 
> I agree with you, indeed initially I developed it as built in, but
> DEPMOD found a cyclic dependency because vsock_transport use
> virtio_transport_common that use vsock, so if I include vsock_transport
> in the vsock module, DEPMOD is not happy.
> 
> I don't know how to break this cyclic dependency, do you have any ideas?

One way to view this would be that the loopback transport and the support
it uses from virtio_transport_common are independent of virtio as such,
and could be part of  the af_vsock module if loopback is configured. So
in a way, the virtio g2h and h2g transports would be extensions of the
built in loopback transport. But that brings in quite a bit of code so
it could be better to just keep it as is.

Thanks,
Jorgen
