From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 0/2] vsock/virtio: fix issues on device hot-unplug
Date: Sun, 03 Feb 2019 11:06:41 -0800 (PST)
Message-ID: <20190203.110641.1343135792694929353.davem__15160.22042358$1549341501$gmane$org@davemloft.net>
References: <20190201114207.97217-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190201114207.97217-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri,  1 Feb 2019 12:42:05 +0100

> These patches try to handle the hot-unplug of vsock virtio transport device in
> a proper way.
> 
> Maybe move the vsock_core_init()/vsock_core_exit() functions in the module_init
> and module_exit of vsock_virtio_transport module can't be the best way, but the
> architecture of vsock_core forces us to this approach for now.
> 
> The vsock_core proto_ops expect a valid pointer to the transport device, so we
> can't call vsock_core_exit() until there are open sockets.
> 
> v2 -> v3:
>  - Rebased on master
> 
> v1 -> v2:
>  - Fixed commit message of patch 1.
>  - Added Reviewed-by, Acked-by tags by Stefan

Series applied.
