From: jcfaracco@gmail.com
Subject: [PATCH RFC net-next 0/2] drivers: net: virtio_net: Implement
Date: Sun,  6 Oct 2019 15:45:13 -0300
Message-ID: <20191006184515.23048-1-jcfaracco@gmail.com>
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
Cc: dnmendes76@gmail.com, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

From: Julio Faracco <jcfaracco@gmail.com>

Driver virtio_net is not handling error events for TX provided by 
dev_watchdog. This event is reached when transmission queue is having 
problems to transmit packets. To enable it, driver should have 
.ndo_tx_timeout implemented. This serie has two commits:

In the past, we implemented a function to recover driver state when this
kind of event happens, but the structure was to complex for virtio_net
that moment. Alternativelly, this skeleton should be enough for now.

For further details, see thread:
https://lkml.org/lkml/2015/6/23/691

Patch 1/2:
  Add statistic field for TX timeout events.

Patch 2/2:
  Implement a skeleton function to debug TX timeout events.

Julio Faracco (2):
  drivers: net: virtio_net: Add tx_timeout stats field
  drivers: net: virtio_net: Add tx_timeout function

 drivers/net/virtio_net.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
2.21.0
