From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 27/70] x86/idt: Split idt_data setup out of set_intr_gate()
Date: Thu, 19 Mar 2020 10:13:24 +0100
Message-ID: <20200319091407.1481-28-joro@8bytes.org>
References: <20200319091407.1481-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200319091407.1481-1-joro@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, Joerg Roedel <jroedel@suse.de>, Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>, hpa@zytor.com, Dan Williams <dan.j.williams@intel.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: virtualization@lists.linuxfoundation.org

From: Joerg Roedel <jroedel@suse.de>

The code to setup idt_data is needed for early exception handling, but
set_intr_gate() can't be used that early because it has pv-ops in its
code path, which don't work that early.

Split out the idt_data initialization part from set_intr_gate() so
that it can be used separatly.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/idt.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index a8fc01ea602a..c752027abc9e 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -231,18 +231,24 @@ idt_setup_from_table(gate_desc *idt, const struct idt_data *t, int size, bool sy
 	}
 }
 
+static void init_idt_data(struct idt_data *data, unsigned int n,
+			  const void *addr)
+{
+	BUG_ON(n > 0xFF);
+
+	memset(data, 0, sizeof(*data));
+	data->vector	= n;
+	data->addr	= addr;
+	data->segment	= __KERNEL_CS;
+	data->bits.type	= GATE_INTERRUPT;
+	data->bits.p	= 1;
+}
+
 static void set_intr_gate(unsigned int n, const void *addr)
 {
 	struct idt_data data;
 
-	BUG_ON(n > 0xFF);
-
-	memset(&data, 0, sizeof(data));
-	data.vector	= n;
-	data.addr	= addr;
-	data.segment	= __KERNEL_CS;
-	data.bits.type	= GATE_INTERRUPT;
-	data.bits.p	= 1;
+	init_idt_data(&data, n, addr);
 
 	idt_setup_from_table(idt_table, &data, 1, false);
 }
-- 
2.17.1
