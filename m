From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 0/2] export 'available' memory to virtio balloon statistics
Date: Tue, 16 Feb 2016 18:50:50 +0300
Message-ID: <1455637852-7323-1-git-send-email-den__38023.3747455806$1455639118$gmane$org@openvz.org>
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
Cc: Igor Redko <redkoi@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Denis V. Lunev" <den@openvz.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Add a new field, VIRTIO_BALLOON_S_AVAIL, to virtio_balloon memory
statistics protocol, corresponding to 'Available' in /proc/meminfo.

It indicates to the hypervisor how big the balloon can be inflated
without pushing the guest system to swap. This metric would be very
useful in VM orchestration software to improve memory management
of different VMs under overcommit.

Signed-off-by: Igor Redko <redkoi@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>

Igor Redko (2):
  calculate 'available' memory in the separate function
  virtio_balloon: export 'available' memory to balloon statistics

 drivers/virtio/virtio_balloon.c     |  6 ++++++
 fs/proc/meminfo.c                   | 31 +-------------------------
 include/linux/mm.h                  |  1 +
 include/uapi/linux/virtio_balloon.h |  3 ++-
 mm/page_alloc.c                     | 43 +++++++++++++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.5.0
