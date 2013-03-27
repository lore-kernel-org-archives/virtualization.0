From: Dmitry Fleytman <dmitry@daynix.com>
Subject: [PATCH 0/2] virtio-spec: dynamic network offloads configuration
Date: Wed, 27 Mar 2013 15:43:16 +0200
Message-ID: <1364391798-8058-1-git-send-email-dmitry@daynix.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Yan Vugenfirer <yan@daynix.com>, Dmitry Fleytman <dfleytma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Dmitry Fleytman <dfleytma@redhat.com>

One of recently introduced Windows features (RSC)
requires network driver to be able to enable and disable
HW LRO offload on the fly without device reinitialization.

Current Virtio specification doesn't support this requirement.
The solution proposed by following spec patch is to add
a new control command for this purpose.

The same solution may be used in Linux driver for ethtool interface
implementation.

Patch for QEMU mainline that implements this specification change
attached as well for reference.

Dmitry Fleytman (1):
  virtio-net: dynamic network offloads configuration

 hw/virtio-net.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++---------
 hw/virtio-net.h |  19 ++++++++++
 2 files changed, 113 insertions(+), 16 deletions(-)

-- 
1.8.1.4
