From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Date: Tue, 28 Apr 2020 18:00:52 +0200
Message-ID: <20200428160052.o3ihui4262xogyg4@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> 
> On 2020/4/27 下午10:25, Stefano Garzarella wrote:
> > Hi David, Michael, Stefan,
> > I'm restarting to work on this topic since Kata guys are interested to
> > have that, especially on the guest side.
> > 
> > While working on the v2 I had few doubts, and I'd like to have your
> > suggestions:
> > 
> >   1. netns assigned to the device inside the guest
> > 
> >     Currently I assigned this device to 'init_net'. Maybe it is better
> >     if we allow the user to decide which netns assign to the device
> >     or to disable this new feature to have the same behavior as before
> >     (host reachable from any netns).
> >     I think we can handle this in the vsock core and not in the single
> >     transports.
> > 
> >     The simplest way that I found, is to add a new
> >     IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS to /dev/vsock to enable the feature
> >     and assign the device to the same netns of the process that do the
> >     ioctl(), but I'm not sure it is clean enough.
> > 
> >     Maybe it is better to add new rtnetlink messages, but I'm not sure if
> >     it is feasible since we don't have a netdev device.
> > 
> >     What do you suggest?
> 
> 
> As we've discussed, it should be a netdev probably in either guest or host
> side. And it would be much simpler if we want do implement namespace then.
> No new API is needed.
> 

Thanks Jason!

It would be cool, but I don't have much experience on netdev.
Do you see any particular obstacles?

I'll take a look to understand how to do it, surely in the guest would
be very useful to have the vsock device as a netdev and maybe also in the host.

Stefano
