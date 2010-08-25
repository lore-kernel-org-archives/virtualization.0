From: Jens Osterkamp <jens@linux.vnet.ibm.com>
Subject: [PATCH 07/10] add libnl dependency to configure.ac
Date: Wed, 25 Aug 2010 14:27:39 +0200
Message-ID: <1282739262-14968-8-git-send-email-jens@linux.vnet.ibm.com>
References: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1282739262-14968-1-git-send-email-jens@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: e1000-eedc@lists.sourceforge.net, virtualization@lists.linux-foundation.org, evb@yahoogroups.com
Cc: chrisw@redhat.com, Jens Osterkamp <jens@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jens Osterkamp <jens@linux.vnet.ibm.com>
---
 configure.ac |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 619c6c4..8b9d08a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,6 +12,11 @@ PKG_CHECK_MODULES(LIBCONFIG, libconfig,
 AC_SUBST(LIBCONFIG_CFLAGS)
 AC_SUBST(LIBCONFIG_LIBS)
 
+PKG_CHECK_MODULES(LIBNL, libnl-1 >= 1.1)
+AC_SUBST(LIBNL_CFLAGS)
+AC_SUBST(LIBNL_LIBS)
+
+AC_CHECK_LIB(nl, rtnl_link_get_by_name)
 AC_CONFIG_SUBDIRS([libconfig-1.3.2])
 AC_CONFIG_FILES([Makefile include/version.h lldpad.spec lldpad.pc dcbd.pc])
 AC_OUTPUT
-- 
1.7.1
