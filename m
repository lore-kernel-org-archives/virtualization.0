From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Wed, 13 Nov 2019 14:30:24 +0000
Message-ID: <MWHPR05MB3376560CFD2A710723843828DA760__32296.6915716947$1573655466$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
	<MWHPR05MB33761FE4DA27130C72FC5048DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
	<20191111171740.xwo7isdmtt7ywibo@steredhat>
	<MWHPR05MB33764F82AFA882B921A11E56DA770@MWHPR05MB3376.namprd05.prod.outlook.com>
	<20191112103630.vd3kbk7xnplv6rey@steredhat>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191112103630.vd3kbk7xnplv6rey@steredhat>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Stefano Garzarella' <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> Sent: Tuesday, November 12, 2019 11:37 AM

> > > > You already mentioned that you are working on a fix for loopback
> > > > here for the guest, but presumably a host could also do loopback.
> > >
> > > IIUC we don't support loopback in the host, because in this case the
> > > application will use the CID_HOST as address, but if we are in a nested
> > > VM environment we are in trouble.
> >
> > If both src and dst CID are CID_HOST, we should be fairly sure that this
> > Is host loopback, no? If src is anything else, we would do G2H.
> >
> 
> The problem is that we don't know the src until we assign a transport
> looking at the dst. (or if the user bound the socket to CID_HOST before
> the connect(), but it is not very common)
> 
> So if we are in a L1 and the user uses the local guest CID, it works, but if
> it uses the HOST_CID, the packet will go to the L0.
> 
> If we are in L0, it could be simple, because we can simply check if G2H
> is not loaded, so any packet to CID_HOST, is host loopback.
> 
> I think that if the user uses the IOCTL_VM_SOCKETS_GET_LOCAL_CID, to set
> the dest CID for the loopback, it works in both cases because we return the
> HOST_CID in L0, and always the guest CID in L1, also if a H2G is loaded to
> handle the L2.
> 
> Maybe we should document this in the man page.

Yeah, it seems like a good idea to flesh out the routing behavior for nested
VMs in the man page.

> 
> But I have a question: Does vmci support the host loopback?
> I've tried, and it seems not.

Only for datagrams - not for stream sockets.
 
> Also vhost-vsock doesn't support it, but virtio-vsock does.
> 
> > >
> > > Since several people asked about this feature at the KVM Forum, I would
> like
> > > to add a new VMADDR_CID_LOCAL (i.e. using the reserved 1) and
> implement
> > > loopback in the core.
> > >
> > > What do you think?
> >
> > What kind of use cases are mentioned in the KVM forum for loopback?
> One concern
> > is that we have to maintain yet another interprocess communication
> mechanism,
> > even though other choices exist already  (and those are likely to be more
> efficient
> > given the development time and specific focus that went into those). To
> me, the
> > local connections are mainly useful as a way to sanity test the protocol and
> transports.
> > However, if loopback is compelling, it would make sense have it in the core,
> since it
> > shouldn't need a specific transport.
> 
> The common use cases is for developer point of view, and to test the
> protocol and transports as you said.
> 
> People that are introducing VSOCK support in their projects, would like to
> test them on their own PC without starting a VM.
> 
> The idea is to move the code to handle loopback from the virtio-vsock,
> in the core, but in another series :-)

OK, that makes sense.

Thanks,
Jorgen
