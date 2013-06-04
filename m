From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 1/2] acpi/processor: remove bm_rld_set of acpi_processor_flags
Date: Tue, 4 Jun 2013 16:05:27 +0800
Message-ID: <1370333128-11412-1-git-send-email-lig.fnst__9232.17720487646$1370473220$gmane$org@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Liu Jinsong <jinsong.liu@intel.com>, Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org, Jan Beulich <JBeulich@suse.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, liguang <lig.fnst@cn.fujitsu.com>
List-Id: virtualization@lists.linuxfoundation.org

bm_rld_set seems obsolete now

Signed-off-by: liguang <lig.fnst@cn.fujitsu.com>
---
 include/acpi/processor.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index ea69367..cfec509 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -188,7 +188,6 @@ struct acpi_processor_flags {
 	u8 bm_check:1;
 	u8 has_cst:1;
 	u8 power_setup_done:1;
-	u8 bm_rld_set:1;
 	u8 need_hotplug_init:1;
 };
 
-- 
1.7.2.5
