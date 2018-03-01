From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v3 0/6] jailhouse: Enhance secondary Jailhouse guest support
	/wrt PCI
Date: Thu,  1 Mar 2018 06:40:43 +0100
Message-ID: <cover.1519882849.git.jan.kiszka__40599.3316825063$1519882809$gmane$org@siemens.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: jailhouse-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, Benedikt Spranger <b.spranger@linutronix.de>, linux-pci@vger.kernel.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Otavio Pontes <otavio.pontes@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Basic x86 support [1] for running Linux as secondary Jailhouse [2] guest
is currently pending in the tip tree. This builds on top and enhances
the PCI support for x86 and also ARM guests (ARM[64] does not require
platform patches and works already).

Key elements of this series are:
 - detection of Jailhouse via device tree hypervisor node
 - function-level PCI scan if Jailhouse is detected
 - MMCONFIG support for x86 guests

As most changes affect x86, I would suggest to route the series also via
tip after the necessary acks are collected.

Changes in v3:
 - avoided duplicate scans of PCI functions under Jailhouse
 - reformated PCI_MMCONFIG condition and rephrase related commit log

Changes in v2:
 - adjusted commit log and include ordering in patch 2
 - rebased over Linus master

Jan

[1] https://lkml.org/lkml/2017/11/27/125
[2] http://jailhouse-project.org

CC: Benedikt Spranger <b.spranger@linutronix.de>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Otavio Pontes <otavio.pontes@intel.com>
CC: Rob Herring <robh+dt@kernel.org>

Jan Kiszka (5):
  jailhouse: Provide detection for non-x86 systems
  PCI: Scan all functions when running over Jailhouse
  x86: Consolidate PCI_MMCONFIG configs
  x86/jailhouse: Allow to use PCI_MMCONFIG without ACPI
  MAINTAINERS: Add entry for Jailhouse

Otavio Pontes (1):
  x86/jailhouse: Enable PCI mmconfig access in inmates

 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 MAINTAINERS                                     |  7 +++++++
 arch/x86/Kconfig                                | 11 ++++++-----
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 arch/x86/include/asm/pci_x86.h                  |  2 ++
 arch/x86/kernel/Makefile                        |  2 +-
 arch/x86/kernel/cpu/amd.c                       |  2 +-
 arch/x86/kernel/jailhouse.c                     |  7 +++++++
 arch/x86/pci/legacy.c                           |  4 +++-
 arch/x86/pci/mmconfig-shared.c                  |  4 ++--
 drivers/pci/probe.c                             | 22 +++++++++++++++++++---
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 12 files changed, 72 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/jailhouse.txt

-- 
2.13.6
