From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 13/14] vsock: prevent transport modules unloading
Date: Mon, 11 Nov 2019 16:36:23 +0000
Message-ID: <MWHPR05MB337664DF4523C75B44982048DA740__17222.1252390713$1573490204$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-14-sgarzare@redhat.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-14-sgarzare@redhat.com>
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

> This patch adds 'module' member in the 'struct vsock_transport'
> in order to get/put the transport module. This prevents the
> module unloading while sockets are assigned to it.
> 
> We increase the module refcnt when a socket is assigned to a
> transport, and we decrease the module refcnt when the socket
> is destructed.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> RFC -> v1:
> - fixed typo 's/tranport/transport/' in a comment (Stefan)
> ---
>  drivers/vhost/vsock.c            |  2 ++
>  include/net/af_vsock.h           |  2 ++
>  net/vmw_vsock/af_vsock.c         | 20 ++++++++++++++++----
>  net/vmw_vsock/hyperv_transport.c |  2 ++
>  net/vmw_vsock/virtio_transport.c |  2 ++
>  net/vmw_vsock/vmci_transport.c   |  1 +
>  6 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
