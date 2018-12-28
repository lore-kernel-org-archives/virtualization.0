From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V2 0/3] vhost: accelerate metadata access through vmap()
Date: Fri, 28 Dec 2018 15:55:34 +0800
Message-ID: <20181228075537.21402-1-jasowang@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

This series tries to access virtqueue metadata through kernel virtual
address instead of copy_user() friends since they had too much
overheads like checks, spec barriers or even hardware feature
toggling.

Test shows about 24% improvement on TX PPS. It should benefit other
cases as well.

Changes from V1:
- instead of pinning pages, use MMU notifier to invalidate vmaps and
  remap duing metadata prefetch
- fix build warning on MIPS

Please review

Jason Wang (3):
  vhost: generalize adding used elem
  vhost: fine grain userspace memory accessors
  vhost: access vq metadata through kernel virtual address

 drivers/vhost/net.c   |   4 +-
 drivers/vhost/vhost.c | 362 ++++++++++++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h |  15 +-
 3 files changed, 348 insertions(+), 33 deletions(-)

-- 
2.17.1
