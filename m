From: James Morris <jmorris@redhat.com>
Subject: [PATCH] paravirt build fix
Date: Wed, 1 Nov 2006 17:28:31 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0611011724300.31378-100000@redline.boston.redhat.com>
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
List-Id: virtualization@lists.linuxfoundation.org

Currently, 020-paravirt-xen.patch contains inconsistent declarations for a =

bunch of native_read/write functions.  This patch updates the declarations =

to use unsigned long for register values.

Signed-off-by: James Morris <jmorris@redhat.com>

---

 include/asm-i386/paravirt.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -purN -X dontdiff linux-pv-2.6.o/include/asm-i386/paravirt.h linux-pv-=
2.6.x/include/asm-i386/paravirt.h
--- linux-pv-2.6.o/include/asm-i386/paravirt.h	2006-11-01 16:46:50.00000000=
0 -0500
+++ linux-pv-2.6.x/include/asm-i386/paravirt.h	2006-11-01 16:57:47.00000000=
0 -0500
@@ -176,18 +176,18 @@ extern struct paravirt_ops paravirt_ops;
    back-ends which don't need their own version. */
 fastcall void native_clts(void);
 =

-fastcall unsigned int native_read_cr0(void);
-fastcall void native_write_cr0(unsigned int val);
+fastcall unsigned long native_read_cr0(void);
+fastcall void native_write_cr0(unsigned long val);
 =

-fastcall unsigned int native_read_cr2(void);
-fastcall void native_write_cr2(unsigned int val);
+fastcall unsigned long native_read_cr2(void);
+fastcall void native_write_cr2(unsigned long val);
 =

-fastcall unsigned int native_read_cr3(void);
-fastcall void native_write_cr3(unsigned int val);
+fastcall unsigned long native_read_cr3(void);
+fastcall void native_write_cr3(unsigned long val);
 =

-fastcall unsigned int native_read_cr4(void);
-fastcall unsigned int native_read_cr4_safe(void);
-fastcall void native_write_cr4(unsigned int val);
+fastcall unsigned long native_read_cr4(void);
+fastcall unsigned long native_read_cr4_safe(void);
+fastcall void native_write_cr4(unsigned long val);
 =

 fastcall void native_wbinvd(void);
 =
