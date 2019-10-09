From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 11/13] vsock: add 'transport_hg' to handle g2h\h2g
	transports
Date: Wed, 9 Oct 2019 11:44:32 +0200
Message-ID: <20191009094432.by5zs4c3binrznpp__34042.7753095113$1570614289$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-12-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190927112703.17745-12-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 27, 2019 at 01:27:01PM +0200, Stefano Garzarella wrote:
> VMCI transport provides both g2h and h2g behaviors in a single
> transport.
> We are able to set (or not) the g2h behavior, detecting if we
> are in a VMware guest (or not), but the h2g feature is always set.
> This prevents to load other h2g transports while we are in a
> VMware guest.
> 
> This patch adds a new 'transport_hg' to handle this case, reducing
> the priority of transports that provide both g2h and h2g
> behaviors. A transport that has g2h and h2g features, can be
> bypassed by a transport that has only the h2g feature.
> 

Since I'm enabling the VSOCK_TRANSPORT_F_G2H in the vmci_transport only
when we run in a VMware guest, this patch doesn't work well if a KVM (or
HyperV) guest application create an AF_VSOCK socket and no transports are
loaded, because in this case the vmci_transport is loaded
(MODULE_ALIAS_NETPROTO(PF_VSOCK)) and it is registered as transport_h2g.

At this point, if we want to run a nested VM using vhost_transport, we
can't load it.

So, I can leave VSOCK_TRANSPORT_F_G2H always set in the vmci_transport
and this should fix this issue.
Or maybe I need to change how the registering works, e.g. handling a list
of transport registered, setting priority or using the last registered
transport.

Any suggestion?

Thanks,
Stefano
