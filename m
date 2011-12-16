From: zanghongyong@huawei.com
Subject: [PATCH 0/2] vhot-net: Use kvm_memslots instead of vhost_memory to
	translate GPA to HVA
Date: Fri, 16 Dec 2011 13:32:06 +0800
Message-ID: <1324013528-3663-1-git-send-email-zanghongyong__16908.9626208462$1324331284$gmane$org@huawei.com>
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
To: linux-kernel@vger.kernel.org
Cc: wusongwei@huawei.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, hanweidong@huawei.com, virtualization@lists.linux-foundation.org, xiaowei.yang@huawei.com, Hongyong Zang <zanghongyong@huawei.com>, levinsasha928@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: Hongyong Zang <zanghongyong@huawei.com>

Vhost-net uses its own vhost_memory, which results from user space (qemu) info,
to translate GPA to HVA. Since kernel's kvm structure already maintains the 
address relationship in its member *kvm_memslots*, these patches use kernel's 
kvm_memslots directly without the need of initialization and maintenance of 
vhost_memory.

Hongyong Zang (2):
  kvm: Introduce get_kvm_from_task
  vhost-net: Use kvm_memslots for address translation

 drivers/vhost/vhost.c    |   53 +++++++++++++++++----------------------------
 include/linux/kvm_host.h |    2 +-
 virt/kvm/kvm_main.c      |   13 +++++++++++
 3 files changed, 34 insertions(+), 34 deletions(-)
