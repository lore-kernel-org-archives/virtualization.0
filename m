From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 11/13] vsock: add 'transport_hg' to handle g2h\h2g
	transports
Date: Thu, 10 Oct 2019 15:04:38 +0200
Message-ID: <20191010130438.3hbv33fgslmlprtf__4777.50355364464$1570712697$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-12-sgarzare@redhat.com>
	<20191009131643.GL5747@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009131643.GL5747@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 09, 2019 at 02:16:43PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:27:01PM +0200, Stefano Garzarella wrote:
> > VMCI transport provides both g2h and h2g behaviors in a single
> > transport.
> > We are able to set (or not) the g2h behavior, detecting if we
> > are in a VMware guest (or not), but the h2g feature is always set.
> > This prevents to load other h2g transports while we are in a
> > VMware guest.
> 
> In the vhost_vsock.ko case we only register the h2g transport when
> userspace has loaded the module (by opening /dev/vhost-vsock).
> 
> VMCI has something kind of similar: /dev/vmci and the
> vmci_host_active_users counter.  Maybe we can use this instead of
> introducing the transport_hg concept?

Yes, maybe we can register the host in the vmci_host_do_init_context().

I also don't like a lot the transport_hg concept, so I'll try to found
an alternative.

Thanks,
Stefano
