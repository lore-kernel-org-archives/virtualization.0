From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 13/15] kvm-s390: update maintainers
Date: Thu, 20 Mar 2008 17:25:23 +0100
Message-ID: <1206030323.6690.64.camel__48374.6182326742$1206031272$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206028710.6690.21.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch adds an entry for kvm on s390 to the MAINTAINERS file :-). We intend
to push all patches regarding this via Avi's kvm.git.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 MAINTAINERS |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: kvm/MAINTAINERS
===================================================================
--- kvm.orig/MAINTAINERS
+++ kvm/MAINTAINERS
@@ -2296,6 +2296,16 @@ L:	kvm-ia64-devel@lists.sourceforge.net
 W:	kvm.sourceforge.net
 S:	Supported
 
+KERNEL VIRTUAL MACHINE for s390 (KVM/s390)
+P:	Carsten Otte
+M:	cotte@de.ibm.com
+P:	Christian Borntraeger
+M:	borntraeger@de.ibm.com
+M:	linux390@de.ibm.com
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+
 KEXEC
 P:	Eric Biederman
 M:	ebiederm@xmission.com
