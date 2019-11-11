From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 12/14] vsock/vmci: register vmci_transport only
	when VMCI guest/host are active
Date: Mon, 11 Nov 2019 18:30:53 +0100
Message-ID: <20191111173053.erwfzawioxje635o__6733.91612233303$1573493471$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-13-sgarzare@redhat.com>
	<MWHPR05MB3376266BC6AE9E6E0B75F1A1DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MWHPR05MB3376266BC6AE9E6E0B75F1A1DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jorgen Hansen <jhansen@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 11, 2019 at 04:27:28PM +0000, Jorgen Hansen wrote:
> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > Sent: Wednesday, October 23, 2019 11:56 AM
> > 
> > To allow other transports to be loaded with vmci_transport,
> > we register the vmci_transport as G2H or H2G only when a VMCI guest
> > or host is active.
> > 
> > To do that, this patch adds a callback registered in the vmci driver
> > that will be called when a new host or guest become active.
> > This callback will register the vmci_transport in the VSOCK core.
> > If the transport is already registered, we ignore the error coming
> > from vsock_core_register().
> 
> So today this is mainly an issue for the VMCI vsock transport, because
> VMCI autoloads with vsock (and with this solution it can continue to
> do that, so none of our old products break due to changed behavior,
> which is great).

I tried to not break anything :-)

>                  Shouldn't vhost behave similar, so that any module
> that registers a h2g transport only does so if it is in active use?
> 

The vhost-vsock module will load when the first hypervisor open
/dev/vhost-vsock, so in theory, when there's at least one active user.

> 
> > --- a/drivers/misc/vmw_vmci/vmci_host.c
> > +++ b/drivers/misc/vmw_vmci/vmci_host.c
> > @@ -108,6 +108,11 @@ bool vmci_host_code_active(void)
> >  	     atomic_read(&vmci_host_active_users) > 0);
> >  }
> > 
> > +int vmci_host_users(void)
> > +{
> > +	return atomic_read(&vmci_host_active_users);
> > +}
> > +
> >  /*
> >   * Called on open of /dev/vmci.
> >   */
> > @@ -338,6 +343,8 @@ static int vmci_host_do_init_context(struct
> > vmci_host_dev *vmci_host_dev,
> >  	vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
> >  	atomic_inc(&vmci_host_active_users);
> > 
> > +	vmci_call_vsock_callback(true);
> > +
> 
> Since we don't unregister the transport if user count drops back to 0, we could
> just call this the first time, a VM is powered on after the module is loaded.

Yes, make sense. can I use the 'vmci_host_active_users' or is better to
add a new 'vmci_host_vsock_loaded'?

My doubt is that vmci_host_active_users can return to 0, so when it returns
to 1, we call vmci_call_vsock_callback() again.

Thanks,
Stefano
