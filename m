From: Ian Campbell <Ian.Campbell@xensource.com>
Subject: [PATCH 2/5] XEN: Add elfnote.h interface header
Date: Wed, 23 Aug 2006 16:09:33 +0100
Message-ID: <1156345773.12949.123.camel@localhost.localdomain>
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
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Pretty self explanatory. Should be merged into 023-xen-interface.patch

Signed-off-by: Ian Campbell <ian.campbell@xensource.com>

diff -r 6d25b8f9ce5b include/xen/interface/elfnote.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/xen/interface/elfnote.h	Wed Aug 23 15:45:20 2006 +0100
@@ -0,0 +1,124 @@
+/*************************************************************************=
*****
+ * elfnote.h
+ *
+ * Definitions used for the Xen ELF notes.
+ *
+ * Copyright (c) 2006, Ian Campbell, XenSource Ltd.
+ */
+
+#ifndef __XEN_PUBLIC_ELFNOTE_H__
+#define __XEN_PUBLIC_ELFNOTE_H__
+
+/*
+ * The notes should live in a SHT_NOTE segment and have "Xen" in the
+ * name field.
+ *
+ * Numeric types are either 4 or 8 bytes depending on the content of
+ * the desc field.
+ *
+ * LEGACY indicated the fields in the legacy __xen_guest string which
+ * this a note type replaces.
+ */
+
+/*
+ * NAME=3DVALUE pair (string).
+ *
+ * LEGACY: FEATURES and PAE
+ */
+#define XEN_ELFNOTE_INFO           0
+
+/*
+ * The virtual address of the entry point (numeric).
+ *
+ * LEGACY: VIRT_ENTRY
+ */
+#define XEN_ELFNOTE_ENTRY          1
+
+/* The virtual address of the hypercall transfer page (numeric).
+ *
+ * LEGACY: HYPERCALL_PAGE. (n.b. legacy value is a physical page
+ * number not a virtual address)
+ */
+#define XEN_ELFNOTE_HYPERCALL_PAGE 2
+
+/* The virtual address where the kernel image should be mapped (numeric).
+ *
+ * Defaults to 0.
+ *
+ * LEGACY: VIRT_BASE
+ */
+#define XEN_ELFNOTE_VIRT_BASE      3
+
+/*
+ * The offset of the ELF paddr field from the acutal required
+ * psuedo-physical address (numeric).
+ *
+ * This is used to maintain backwards compatibility with older kernels
+ * which wrote __PAGE_OFFSET into that field. This field defaults to 0
+ * if not present.
+ *
+ * LEGACY: ELF_PADDR_OFFSET. (n.b. legacy default is VIRT_BASE)
+ */
+#define XEN_ELFNOTE_PADDR_OFFSET   4
+
+/*
+ * The version of Xen that we work with (string).
+ *
+ * LEGACY: XEN_VER
+ */
+#define XEN_ELFNOTE_XEN_VERSION    5
+
+/*
+ * The name of the guest operating system (string).
+ *
+ * LEGACY: GUEST_OS
+ */
+#define XEN_ELFNOTE_GUEST_OS       6
+
+/*
+ * The version of the guest operating system (string).
+ *
+ * LEGACY: GUEST_VER
+ */
+#define XEN_ELFNOTE_GUEST_VERSION  7
+
+/*
+ * The loader type (string).
+ *
+ * LEGACY: LOADER
+ */
+#define XEN_ELFNOTE_LOADER         8
+
+/*
+ * The kernel supports PAE (x86/32 only, string =3D "yes" or "no").
+ *
+ * LEGACY: PAE (n.b. The legacy interface included a provision to
+ * indicate 'extended-cr3' support allowing L3 page tables to be
+ * placed above 4G. It is assumed that any kernel new enough to use
+ * these ELF notes will include this and therefore "yes" here is
+ * equivalent to "yes[entended-cr3]" in the __xen_guest interface.
+ */
+#define XEN_ELFNOTE_PAE_MODE       9
+
+/*
+ * The features supported/required by this kernel (string).
+ *
+ * The string must consist of a list of feature names (as given in
+ * features.h, without the "XENFEAT_" prefix) separated by '|'
+ * characters. If a feature is required for the kernel to function
+ * then the feature name must be preceded by a '!' character.
+ *
+ * LEGACY: FEATURES
+ */
+#define XEN_ELFNOTE_FEATURES      10
+
+/*
+ * The kernel requires the symbol table to be loaded (string =3D "yes" or =
"no")
+ * LEGACY: BSD_SYMTAB (n.b. The legacy treated the presence or absence
+ * of this string as a boolean flag rather than requiring "yes" or
+ * "no".
+ */
+#define XEN_ELFNOTE_BSD_SYMTAB    11
+
+#endif /* __XEN_PUBLIC_ELFNOTE_H__ */
+
