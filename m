From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Fri,  6 Sep 2013 16:20:05 +0800
Message-ID: <1378455607-32459-1-git-send-email-aaron.lu__17917.6499521875$1378506965$gmane$org@intel.com>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
drivers and virtio pci driver.

With patch 1/2, two compile warnings are eliminated for virtio pci
driver, and patch 2/2 is a clean up for all virtio drivers as suggested
by Amit Shah.

Aaron Lu (2):
  virtio_pci: pm: Use CONFIG_PM_SLEEP instead of CONFIG_PM
  virtio: pm: use CONFIG_PM_SLEEP instead of CONFIG_PM

 drivers/block/virtio_blk.c          | 4 ++--
 drivers/char/hw_random/virtio-rng.c | 4 ++--
 drivers/char/virtio_console.c       | 4 ++--
 drivers/net/virtio_net.c            | 4 ++--
 drivers/scsi/virtio_scsi.c          | 4 ++--
 drivers/virtio/virtio_balloon.c     | 4 ++--
 drivers/virtio/virtio_pci.c         | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

-- 
1.8.4.12.g2ea3df6
