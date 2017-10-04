From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 12/13] objtool: Add support for new .pv_altinstructions section
Date: Wed,  4 Oct 2017 10:58:33 -0500
Message-ID: <7bb04938efcac2c1eaba2cae849337a9a542e1b0.1507128293.git.jpoimboe__33508.6672370837$1509079691$gmane$org@redhat.com>
References: <cover.1507128293.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1507128293.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xenproject.org, Peter Zijlstra <peterz@infradead.org>, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Sasha Levin <alexander.levin@verizon.com>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, live-patching@vger.kernel.org, Alok Kataria <akataria@vmware.com>, virtualization@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/special.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..dc15a3564fc9 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -63,6 +63,16 @@ struct special_entry entries[] = {
 		.feature = ALT_FEATURE_OFFSET,
 	},
 	{
+		.sec = ".pv_altinstructions",
+		.group = true,
+		.size = ALT_ENTRY_SIZE,
+		.orig = ALT_ORIG_OFFSET,
+		.orig_len = ALT_ORIG_LEN_OFFSET,
+		.new = ALT_NEW_OFFSET,
+		.new_len = ALT_NEW_LEN_OFFSET,
+		.feature = ALT_FEATURE_OFFSET,
+	},
+	{
 		.sec = "__jump_table",
 		.jump_or_nop = true,
 		.size = JUMP_ENTRY_SIZE,
-- 
2.13.6
