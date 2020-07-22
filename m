From: =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RFC PATCH v1 07/34] KVM: x86: mmu: increase mmu_memory_cache size
Date: Wed, 22 Jul 2020 19:00:54 +0300
Message-ID: <20200722160121.9601-8-alazar@bitdefender.com>
References: <20200722160121.9601-1-alazar@bitdefender.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200722160121.9601-1-alazar@bitdefender.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?=C8=98tefan=20=C8=98icleru?= <ssicleru@bitdefender.com>, =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Ștefan Șicleru <ssicleru@bitdefender.com>

We use/allocate more root_hpa's every time mmu_alloc_roots()
is called.

Signed-off-by: Ștefan Șicleru <ssicleru@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 553425ab3518..70461c7ef58c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1119,11 +1119,13 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 				   pte_list_desc_cache, 8 + PTE_PREFETCH_NUM);
 	if (r)
 		goto out;
-	r = mmu_topup_memory_cache_page(&vcpu->arch.mmu_page_cache, 8);
+	r = mmu_topup_memory_cache_page(&vcpu->arch.mmu_page_cache,
+					8 * KVM_MAX_EPT_VIEWS);
 	if (r)
 		goto out;
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
-				   mmu_page_header_cache, 4);
+				   mmu_page_header_cache,
+				   4 * KVM_MAX_EPT_VIEWS);
 out:
 	return r;
 }
