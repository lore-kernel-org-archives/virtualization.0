From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH 0/3] deprecate usage of pci_scan_bus_parented()
Date: Fri, 21 Jun 2013 01:01:02 +0800
Message-ID: <1371747665-12768-1-git-send-email-liuj97@gmail.com>
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
To: Bjorn Helgaas <bhelgaas@google.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Jiang Liu <jiang.liu@huawei.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Yijing Wang <wangyijing@huawei.com>, liuj97@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jiang Liu <jiang.liu@huawei.com>

This patch tries to deprecate usage of pci_scan_bus_parented().
It applies to
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next

Jiang Liu (3):
  PCI: export three functions to support modular host bridge driver
  PCI, xen-pcifront: use new PCI interfaces to simplify implementation
  PCI: mark pci_scan_bus_parented() as __deprecated

 arch/tile/kernel/pci.c     |  3 --
 drivers/pci/host-bridge.c  |  1 +
 drivers/pci/probe.c        |  1 +
 drivers/pci/remove.c       |  7 +++++
 drivers/pci/xen-pcifront.c | 70 ++++++++++++++++++++--------------------------
 include/linux/pci.h        |  5 ++--
 6 files changed, 42 insertions(+), 45 deletions(-)

-- 
1.8.1.2
