From: akong@redhat.com
Subject: [RFC PATCH 0/2] make mac programming for virtio net more robust
Date: Thu, 10 Jan 2013 22:45:39 +0800
Message-ID: <1357829141-25455-1-git-send-email-akong@redhat.com>
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
To: kvm@vger.kernel.org, rusty@rustcorp.com.au
Cc: mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Amos Kong <akong@redhat.com>

Currenly mac is programmed byte by byte. This means that we
have an intermediate step where mac is wrong. 

Second patch introduced a new vq control command to set mac
address in one time.

Amos Kong (2):
  move virtnet_send_command() above virtnet_set_mac_address()
  virtio-net: introduce a new control to set macaddr

 drivers/net/virtio_net.c        | 105 ++++++++++++++++++++++------------------
 include/uapi/linux/virtio_net.h |   8 ++-
 2 files changed, 66 insertions(+), 47 deletions(-)

-- 
1.7.11.7
