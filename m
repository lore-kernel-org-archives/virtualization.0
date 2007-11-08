From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 0/3] virtio PCI driver
Date: Wed,  7 Nov 2007 20:46:29 -0600
Message-ID: <11944899922822-git-send-email-aliguori@us.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760250AbXKHCqt@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

This patch series implements a PCI driver for virtio.  This allows virtio
devices (like block and network) to be used in QEMU/KVM.  I'll post a very
early KVM userspace backend in kvm-devel for those that are interested.

This series depends on the two virtio fixes I've posted and Rusty's config_ops
refactoring.  I've tested with these patches on Rusty's experimental virtio
tree.
