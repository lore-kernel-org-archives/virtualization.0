From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 0/3] vsock: support network namespace
Date: Tue, 3 Dec 2019 12:17:39 +0100
Message-ID: <20191203111739.jbxptcpmvtwg7j2g__16687.1794311859$1575371882$gmane$org@steredhat>
References: <20191128171519.203979-1-sgarzare@redhat.com>
 <20191203092649.GB153510@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191203092649.GB153510@stefanha-x1.localdomain>
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
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 03, 2019 at 09:26:49AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 28, 2019 at 06:15:16PM +0100, Stefano Garzarella wrote:
> > Hi,
> > now that we have multi-transport upstream, I started to take a look to
> > support network namespace (netns) in vsock.
> > 
> > As we partially discussed in the multi-transport proposal [1], it could
> > be nice to support network namespace in vsock to reach the following
> > goals:
> > - isolate host applications from guest applications using the same ports
> >   with CID_ANY
> > - assign the same CID of VMs running in different network namespaces
> > - partition VMs between VMMs or at finer granularity
> > 
> > This preliminary implementation provides the following behavior:
> > - packets received from the host (received by G2H transports) are
> >   assigned to the default netns (init_net)
> > - packets received from the guest (received by H2G - vhost-vsock) are
> >   assigned to the netns of the process that opens /dev/vhost-vsock
> >   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
> >     - for vmci I need some suggestions, because I don't know how to do
> >       and test the same in the vmci driver, for now vmci uses the
> >       init_net
> > - loopback packets are exchanged only in the same netns
> > 
> > Questions:
> > 1. Should we make configurable the netns (now it is init_net) where
> >    packets from the host should be delivered?
> 
> Yes, it should be possible to have multiple G2H (e.g. virtio-vsock)
> devices and to assign them to different net namespaces.  Something like
> net/core/dev.c:dev_change_net_namespace() will eventually be needed.
> 

Make sense, but for now we support only one G2H.
How we can provide this feature to the userspace?
Should we interface vsock with ip-link(8)?

I don't know if initially we can provide through sysfs a way to set the
netns of the only G2H loaded.

> > 2. Should we provide an ioctl in vhost-vsock to configure the netns
> >    to use? (instead of using the netns of the process that opens
> >    /dev/vhost-vsock)
> 
> Creating the vhost-vsock instance in the process' net namespace makes
> sense.  Maybe wait for a use case before adding an ioctl.
> 

Agree.

> > 3. Should we provide a way to disable the netns support in vsock?
> 
> The code should follow CONFIG_NET_NS semantics.  I'm not sure what they
> are exactly since struct net is always defined, regardless of whether
> network namespaces are enabled.

I think that if CONFIG_NET_NS is not defined, all sockets and processes
are assigned to init_net and this RFC should work in this case, but I'll
try this case before v1.

I was thinking about the Kata's use case, I don't know if they launch the
VM in a netns and even the runtime in the host runs inside the same netns.

I'll send an e-mail to kata mailing list.

Thanks,
Stefano
