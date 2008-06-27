From: Amit Shah <amit.shah@qumranet.com>
Subject: PCI device assignment to guests (userspace)
Date: Fri, 27 Jun 2008 15:58:38 +0300
Message-ID: <1214571520-20814-1-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: chrisw@redhat.com, allen.m.kay@intel.com, virtualization@lists.osdl.org, benami@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org


Userspace patches for the pci-passthrough functionality.

The major updates since the last post are:

- Loop to add passthrough devices in pc_init1
- Handle errors in read/write calls
- Allow invocation without irq number for in-kernel irqchip

Other than this, several small things were fixed according to review comments received last time.
