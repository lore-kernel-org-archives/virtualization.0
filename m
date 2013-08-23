From: Andy King <acking@vmware.com>
Subject: [PATCH 0/2] VMCI: Add support for virtual IOMMU
Date: Fri, 23 Aug 2013 09:22:12 -0700
Message-ID: <1377274934-12223-1-git-send-email-acking@vmware.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Andy King <acking@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This patchset adds support for virtual IOMMU to the VMCI module.  We switch to
DMA consistent mappings for queuepair and doorbell pages that are passed to the
device, which allows the module to work in the presence of vIOMMU/VT-d.

Andy King (2):
  VMCI: Remove non-blocking/pinned queuepair support
  VMCI: Add support for virtual IOMMU

 drivers/misc/vmw_vmci/vmci_driver.c     |    2 +-
 drivers/misc/vmw_vmci/vmci_driver.h     |    7 +
 drivers/misc/vmw_vmci/vmci_guest.c      |   22 ++-
 drivers/misc/vmw_vmci/vmci_queue_pair.c |  313 ++++++++++++-------------------
 drivers/misc/vmw_vmci/vmci_queue_pair.h |   18 --
 5 files changed, 142 insertions(+), 220 deletions(-)

-- 
1.7.4.1
