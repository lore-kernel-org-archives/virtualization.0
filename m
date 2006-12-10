From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Section mismatch in parainstructions
Date: Sun, 10 Dec 2006 15:58:21 -0800
Message-ID: <20061210155821.d2c5dfa5.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: akpm <akpm@osdl.org>, sam@ravnborg.org
List-Id: virtualization@lists.linuxfoundation.org


Is it OK for section .parainstructions to reference
exit.text?

I'm seeing:

WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exit.=
text: from .parainstructions after '' (at offset 0x0)
WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exit.=
text: from .parainstructions after '' (at offset 0x8)

If that's OK, we need a small patch to modpost, as below.

---
~Randy
From: Randy Dunlap <randy.dunlap@oracle.com>

Section .parainstructions should not warn about section mismatches.

WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exit.=
text: from .parainstructions after '' (at offset 0x0)
WARNING: drivers/net/hamradio/scc.o - Section mismatch: reference to .exit.=
text: from .parainstructions after '' (at offset 0x8)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 scripts/mod/modpost.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19-git17.orig/scripts/mod/modpost.c
+++ linux-2.6.19-git17/scripts/mod/modpost.c
@@ -997,6 +997,7 @@ static int exit_section_ref_ok(const cha
 		"__bug_table", /* used by powerpc for BUG() */
 		".exitcall.exit",
 		".eh_frame",
+		".parainstructions",
 		".stab",
 		"__ex_table",
 		".fixup",
