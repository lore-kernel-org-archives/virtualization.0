From: liguang <lig.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] xen: remove bm_rld_set of xen_processor_flags
Date: Tue, 4 Jun 2013 16:05:28 +0800
Message-ID: <1370333128-11412-2-git-send-email-lig.fnst__25506.8144215786$1370473215$gmane$org@cn.fujitsu.com>
References: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370333128-11412-1-git-send-email-lig.fnst@cn.fujitsu.com>
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
 include/xen/interface/platform.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/xen/interface/platform.h b/include/xen/interface/platform.h
index c57d5f6..7ffff33 100644
--- a/include/xen/interface/platform.h
+++ b/include/xen/interface/platform.h
@@ -240,7 +240,6 @@ struct xen_processor_flags {
 	uint32_t bm_check:1;
 	uint32_t has_cst:1;
 	uint32_t power_setup_done:1;
-	uint32_t bm_rld_set:1;
 };
 
 struct xen_processor_power {
-- 
1.7.2.5
