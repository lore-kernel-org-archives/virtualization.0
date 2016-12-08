From: Peng Tao <bergwolf@gmail.com>
Subject: [PATCH v3 0/4] vsock: cancel connect packets when failing to connect
Date: Fri,  9 Dec 2016 01:12:32 +0800
Message-ID: <1481217156-7160-1-git-send-email-bergwolf__33413.2093623795$1481217203$gmane$org@gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>, David Miller <davem@davemloft.net>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently, if a connect call fails on a signal or timeout (e.g., guest is still
in the process of starting up), we'll just return to caller and leave the connect
packet queued and they are sent even though the connection is considered a failure,
which can confuse applications with unwanted false connect attempt.

The patchset enables vsock (both host and guest) to cancel queued packets when
a connect attempt is considered to fail.

v3 changelog:
  - define cancel_pkt callback in struct vsock_transport rather than struct virtio_transport
  - rename virtio_vsock_pkt->vsk to virtio_vsock_pkt->cancel_token
v2 changelog:
  - fix queued_replies counting and resume tx/rx when necessary


Peng Tao (4):
  vsock: track pkt owner vsock
  vhost-vsock: add pkt cancel capability
  vsock: add pkt cancel capability
  vsock: cancel packets when failing to connect

 drivers/vhost/vsock.c                   | 41 ++++++++++++++++++++++++++++++++
 include/linux/virtio_vsock.h            |  2 ++
 include/net/af_vsock.h                  |  3 +++
 net/vmw_vsock/af_vsock.c                | 14 +++++++++++
 net/vmw_vsock/virtio_transport.c        | 42 +++++++++++++++++++++++++++++++++
 net/vmw_vsock/virtio_transport_common.c |  7 ++++++
 6 files changed, 109 insertions(+)

-- 
2.7.4
