From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 4/6] vsock: add vsock_loopback transport
Date: Fri, 22 Nov 2019 11:02:12 +0100
Message-ID: <20191122100212.u3mvt6qkay7zexz7@steredhat.homenet.telecomitalia.it>
References: <20191119110121.14480-1-sgarzare@redhat.com>
 <20191119110121.14480-5-sgarzare@redhat.com>
 <20191121093458.GB439743@stefanha-x1.localdomain>
 <20191121095948.bc7lc3ptsh6jxizw@steredhat>
 <20191121152517.zfedz6hg6ftcb2ks@steredhat>
 <20191122092546.GA464656@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191122092546.GA464656@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: kvm@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 22, 2019 at 09:25:46AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 21, 2019 at 04:25:17PM +0100, Stefano Garzarella wrote:
> > On Thu, Nov 21, 2019 at 10:59:48AM +0100, Stefano Garzarella wrote:
> > > On Thu, Nov 21, 2019 at 09:34:58AM +0000, Stefan Hajnoczi wrote:
> > > > On Tue, Nov 19, 2019 at 12:01:19PM +0100, Stefano Garzarella wrote:
> > > > > +static struct workqueue_struct *vsock_loopback_workqueue;
> > > > > +static struct vsock_loopback *the_vsock_loopback;
> > > > 
> > > > the_vsock_loopback could be a static global variable (not a pointer) and
> > > > vsock_loopback_workqueue could also be included in the struct.
> > > > 
> > > > The RCU pointer is really a way to synchronize vsock_loopback_send_pkt()
> > > > and vsock_loopback_cancel_pkt() with module exit.  There is no other
> > > > reason for using a pointer.
> > > > 
> > > > It's cleaner to implement the synchronization once in af_vsock.c (or
> > > > virtio_transport_common.c) instead of making each transport do it.
> > > > Maybe try_module_get() and related APIs provide the necessary semantics
> > > > so that core vsock code can hold the transport module while it's being
> > > > used to send/cancel a packet.
> > > 
> > > Right, the module cannot be unloaded until open sockets, so here the
> > > synchronization is not needed.
> > > 
> > > The synchronization come from virtio-vsock device that can be
> > > hot-unplugged while sockets are still open, but that can't happen here.
> > > 
> > > I will remove the pointers and RCU in the v2.
> > > 
> > > Can I keep your R-b or do you prefer to watch v2 first?
> 
> I'd like to review v2.
> 

Sure!

> > > > > +MODULE_ALIAS_NETPROTO(PF_VSOCK);
> > > > 
> > > > Why does this module define the alias for PF_VSOCK?  Doesn't another
> > > > module already define this alias?
> > > 
> > > It is a way to load this module when PF_VSOCK is starting to be used.
> > > MODULE_ALIAS_NETPROTO(PF_VSOCK) is already defined in vmci_transport
> > > and hyperv_transport. IIUC it is used for the same reason.
> > > 
> > > In virtio_transport we don't need it because it will be loaded when
> > > the PCI device is discovered.
> > > 
> > > Do you think there's a better way?
> > > Should I include the vsock_loopback transport directly in af_vsock
> > > without creating a new module?
> > > 
> > 
> > That last thing I said may not be possible:
> > I remembered that I tried, but DEPMOD found a cyclic dependency because
> > vsock_transport use virtio_transport_common that use vsock, so if I
> > include vsock_transport in the vsock module, DEPMOD is not happy.
> > 
> > Do you think it's okay in this case to keep MODULE_ALIAS_NETPROTO(PF_VSOCK)
> > or is there a better way?
> 
> The reason I asked is because the semantics of duplicate module aliases
> aren't clear to me.  Do all modules with the same alias get loaded?
> Or just the first?  Or ...?

It wasn't clear to me either, but when I tried, I saw that all modules
with the same alias got loaded.

Stefano
