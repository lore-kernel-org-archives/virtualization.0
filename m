From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] Install udev rules in system-default directory
Date: Thu,  7 Aug 2014 18:39:00 +0530
Message-ID: <3df55388b1b3acd142f391494f102c3ddb2270ed.1407416628.git.amit.shah__45224.3810439997$1407417016$gmane$org@redhat.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1407416628.git.amit.shah@redhat.com>
In-Reply-To: <cover.1407416628.git.amit.shah@redhat.com>
References: <cover.1407416628.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jgarzik@bitpay.com
Cc: linux-kernel@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>, Amit Shah <amit.shah@redhat.com>, hpa@linux.intel.com
List-Id: virtualization@lists.linuxfoundation.org

not-quite-Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 Makefile.am  | 1 +
 configure.ac | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index f8490a3..a2b8173 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -8,6 +8,7 @@ sbin_PROGRAMS	 = rngd
 bin_PROGRAMS	 = rngtest
 man_MANS	 = rngd.8 rngtest.1
 noinst_LIBRARIES = librngd.a
+udevrules_DATA	 = 90-virtio-rng.rules
 
 rngd_SOURCES	= rngd.h rngd.c	rngd_entsource.h rngd_entsource.c	\
 		  rngd_linux.h rngd_linux.c util.c 			\
diff --git a/configure.ac b/configure.ac
index 27a2dba..4187aca 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,14 @@ AC_ARG_WITH([libgcrypt],
 	[with_libgcrypt=check]
 )
 
+PKG_PROG_PKG_CONFIG
+
+AC_ARG_WITH([udevrulesdir],
+	AS_HELP_STRING([--with-udevrulesdir=DIR], [Directory for udev rules]),
+	[],
+	[with_udevrulesdir=$($PKG_CONFIG --variable=udevdir udev)"/rules.d"])
+AC_SUBST([udevrulesdir], [$with_udevrulesdir])
+
 dnl Make sure anyone changing configure.ac/Makefile.am has a clue
 AM_MAINTAINER_MODE
 
-- 
1.9.3
