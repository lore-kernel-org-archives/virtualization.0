From: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net 0/2] vsock: don't allow half-closed socket in the host
	transports
Date: Fri, 11 Oct 2019 15:07:56 +0200
Message-ID: <20191011130758.22134-1-sgarzare__33475.099939254$1570799978$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Adit Ranadive <aditr@vmware.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

We are implementing a test suite for the VSOCK sockets and we discovered
that vmci_transport never allowed half-closed socket on the host side.

As Jorgen explained [1] this is due to the implementation of VMCI.

Since we want to have the same behaviour across all transports, this
series adds a section in the "Implementation notes" to exaplain this
behaviour, and changes the vhost_transport to behave the same way.

[1] https://patchwork.ozlabs.org/cover/847998/#1831400

Stefano Garzarella (2):
  vsock: add half-closed socket details in the implementation notes
  vhost/vsock: don't allow half-closed socket in the host

 drivers/vhost/vsock.c    | 17 ++++++++++++++++-
 net/vmw_vsock/af_vsock.c |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.21.0
