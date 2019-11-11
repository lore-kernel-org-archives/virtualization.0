From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 14/14] vsock: fix bind() behaviour taking care of
	CID
Date: Mon, 11 Nov 2019 16:53:56 +0000
Message-ID: <MWHPR05MB3376C7CE32B8FD98DE4EF45FDA740__26802.6127292373$1573491251$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-15-sgarzare@redhat.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191023095554.11340-15-sgarzare@redhat.com>
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
> When we are looking for a socket bound to a specific address,
> we also have to take into account the CID.
> 
> This patch is useful with multi-transports support because it
> allows the binding of the same port with different CID, and
> it prevents a connection to a wrong socket bound to the same
> port, but with different CID.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
