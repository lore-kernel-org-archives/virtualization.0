From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 12/14] vsock/vmci: register vmci_transport only
	when VMCI guest/host are active
Date: Tue, 29 Oct 2019 17:35:16 +0100
Message-ID: <20191029163516.td6wk7lf5pmytwtk__6586.28526596061$1572366938$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-13-sgarzare@redhat.com>
	<20191027081752.GD4472@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191027081752.GD4472@stefanha-x1.localdomain>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Oct 27, 2019 at 09:17:52AM +0100, Stefan Hajnoczi wrote:
> On Wed, Oct 23, 2019 at 11:55:52AM +0200, Stefano Garzarella wrote:
> > +static int __init vmci_transport_init(void)
> > +{
> > +	int features = VSOCK_TRANSPORT_F_DGRAM;
> 
> Where is this variable used?

It is introduced in the previous patch "vsock: add multi-transports support",
and it is used in the vsock_core_register(), but since now the
vmci_transport_init() registers the vmci_transport only with DGRAM
feature, I can remove this variable and I can use directly the
VSOCK_TRANSPORT_F_DGRAM.

I'll fix in the v3.

Thanks,
Stefano
