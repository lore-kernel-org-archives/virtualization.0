From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 16/62] x86/boot/compressed/64: Check return value of
 kernel_ident_mapping_init()
Date: Tue, 11 Feb 2020 14:52:10 +0100
Message-ID: <20200211135256.24617-17-joro@8bytes.org>
References: <20200211135256.24617-1-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200211135256.24617-1-joro@8bytes.org>
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

The function can fail to create an identity mapping, check for that
and bail out if it happens.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/boot/compressed/ident_map_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 5b720736a789..feb180cced28 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -93,6 +93,8 @@ static struct x86_mapping_info mapping_info;
  */
 static void add_identity_map(unsigned long start, unsigned long end)
 {
+	int ret;
+
 	/* Align boundary to 2M. */
 	start = round_down(start, PMD_SIZE);
 	end = round_up(end, PMD_SIZE);
@@ -100,8 +102,9 @@ static void add_identity_map(unsigned long start, unsigned long end)
 		return;
 
 	/* Build the mapping. */
-	kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt,
-				  start, end);
+	ret = kernel_ident_mapping_init(&mapping_info, (pgd_t *)top_level_pgt, start, end);
+	if (ret)
+		error("Error: kernel_ident_mapping_init() failed\n");
 }
 
 /* Locates and clears a region for a new top level page table. */
-- 
2.17.1
