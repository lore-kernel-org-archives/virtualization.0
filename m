From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 01/10] x86: remove stale prototype from
	arch/x86/include/asm/pgalloc.h
Date: Fri, 19 May 2017 17:47:37 +0200
Message-ID: <20170519154746.29389-2-jgross__16024.6498453946$1495208888$gmane$org@suse.com>
References: <20170519154746.29389-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170519154746.29389-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

paravirt_alloc_pmd_clone() doesn't exist anywhere. Remove its
prototype.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/pgalloc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index b2d0cd8288aa..71de65bb1791 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -14,8 +14,6 @@ static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 static inline void paravirt_pgd_free(struct mm_struct *mm, pgd_t *pgd) {}
 static inline void paravirt_alloc_pte(struct mm_struct *mm, unsigned long pfn)	{}
 static inline void paravirt_alloc_pmd(struct mm_struct *mm, unsigned long pfn)	{}
-static inline void paravirt_alloc_pmd_clone(unsigned long pfn, unsigned long clonepfn,
-					    unsigned long start, unsigned long count) {}
 static inline void paravirt_alloc_pud(struct mm_struct *mm, unsigned long pfn)	{}
 static inline void paravirt_alloc_p4d(struct mm_struct *mm, unsigned long pfn)	{}
 static inline void paravirt_release_pte(unsigned long pfn) {}
-- 
2.12.0
