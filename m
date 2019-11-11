From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 12/14] vsock/vmci: register vmci_transport only
	when VMCI guest/host are active
Date: Mon, 11 Nov 2019 16:27:28 +0000
Message-ID: <MWHPR05MB3376266BC6AE9E6E0B75F1A1DA740__9050.7448812545$1573489662$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-13-sgarzare@redhat.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-13-sgarzare@redhat.com>
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
To: 'Stefano Garzarella' <sgarzare@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> Sent: Wednesday, October 23, 2019 11:56 AM
> 
> To allow other transports to be loaded with vmci_transport,
> we register the vmci_transport as G2H or H2G only when a VMCI guest
> or host is active.
> 
> To do that, this patch adds a callback registered in the vmci driver
> that will be called when a new host or guest become active.
> This callback will register the vmci_transport in the VSOCK core.
> If the transport is already registered, we ignore the error coming
> from vsock_core_register().

So today this is mainly an issue for the VMCI vsock transport, because
VMCI autoloads with vsock (and with this solution it can continue to
do that, so none of our old products break due to changed behavior,
which is great). Shouldn't vhost behave similar, so that any module
that registers a h2g transport only does so if it is in active use?


> --- a/drivers/misc/vmw_vmci/vmci_host.c
> +++ b/drivers/misc/vmw_vmci/vmci_host.c
> @@ -108,6 +108,11 @@ bool vmci_host_code_active(void)
>  	     atomic_read(&vmci_host_active_users) > 0);
>  }
> 
> +int vmci_host_users(void)
> +{
> +	return atomic_read(&vmci_host_active_users);
> +}
> +
>  /*
>   * Called on open of /dev/vmci.
>   */
> @@ -338,6 +343,8 @@ static int vmci_host_do_init_context(struct
> vmci_host_dev *vmci_host_dev,
>  	vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;
>  	atomic_inc(&vmci_host_active_users);
> 
> +	vmci_call_vsock_callback(true);
> +

Since we don't unregister the transport if user count drops back to 0, we could
just call this the first time, a VM is powered on after the module is loaded.

>  	retval = 0;
> 
>  out:
