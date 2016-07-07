From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/2] virtio/s390 patches for 4.8
Date: Thu,  7 Jul 2016 17:07:55 +0200
Message-ID: <1467904077-1887-1-git-send-email-cornelia.huck__4549.98226273364$1467922113$gmane$org@de.ibm.com>
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
To: mst@redhat.com
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Michael,

here are two virtio/s390 patches for 4.8.

First, Jing Liu noticed that she could trigger panics while playing
around with hvc0 as preferred console but no virtio console: This
can be fixed by not discarding our early_put_chars after init (as
the minimal fix).

This made us wonder why we still have that code around when no current
host code supports the old transport: We have no idea whether this
still works, and it's probably a good idea to put a deprecation
message in there to check whether anyone screams.

Patches are against your vhost branch.

Christian Borntraeger (1):
  virtio/s390: keep early_put_chars

Cornelia Huck (1):
  virtio/s390: deprecate old transport

 arch/s390/Kconfig                | 13 +++++++++++++
 drivers/s390/virtio/Makefile     |  6 +++++-
 drivers/s390/virtio/kvm_virtio.c |  4 +++-
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.6.6
