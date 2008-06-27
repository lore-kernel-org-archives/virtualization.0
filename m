From: Amit Shah <amit.shah@qumranet.com>
Subject: PCI device assignment to guests
Date: Fri, 27 Jun 2008 15:55:01 +0300
Message-ID: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, avi@qumranet.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


The main change from the patches I sent out earlier this week is support for guests that use the PIC. A callback for PIC irq ack handling is also introduced.

Currently, there's no mechanism to register/unregister callers to the irq ack callbacks, but they can be added when there's more than one user for the functionality.

Please review.
