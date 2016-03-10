From: Aaron Conole <aconole@redhat.com>
Subject: [RFC -next 0/2] virtio-net: Advised MTU feature
Date: Thu, 10 Mar 2016 09:28:10 -0500
Message-ID: <1457620092-24170-1-git-send-email-aconole__44941.9543067508$1457620128$gmane$org@redhat.com>
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
To: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The following series adds the ability for a hypervisor to set an MTU on the
guest during feature negotiation phase. This is useful for VM orchestration
when, for instance, tunneling is involved and the MTU of the various systems
should be homogenous.

The first patch adds the feature bit as described in the proposed VFIO spec
addition found at
https://lists.oasis-open.org/archives/virtio-dev/201603/msg00001.html

The second patch adds a user of the bit, and a warning when the guest changes
the MTU from the hypervisor advised MTU. Future patches may add more thorough
error handling.

Aaron Conole (2):
  virtio: Start the advised MTU feature support
  virtio_net: Read and use the advised MTU

 drivers/net/virtio_net.c        | 15 ++++++++++++++-
 include/uapi/linux/virtio_net.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.5.0
