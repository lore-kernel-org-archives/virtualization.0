From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] export cpu_tlbstate to modules
Date: Mon, 10 Aug 2009 21:53:02 +0300
Message-ID: <20090810185302.GB13924__6753.79970712147$1249930615$gmane$org@redhat.com>
References: <cover.1249930169.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1249930169.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

vhost net module wants to do copy to/from user from a kernel thread,
which needs switch_mm (like what fs/aio has).
export cpu_tlbstate to make this possible

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/x86/mm/tlb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 821e970..e33a5f0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -13,6 +13,7 @@
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct tlb_state, cpu_tlbstate)
 			= { &init_mm, 0, };
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_tlbstate);
 
 /*
  *	Smarter SMP flushing macros.
-- 
1.6.2.5
