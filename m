From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/14] Tools: hv: Gather DNS information
Date: Thu, 16 Aug 2012 17:45:19 -0700
Message-ID: <1345164325-5198-9-git-send-email-kys@microsoft.com>
References: <1345164300-5146-1-git-send-email-kys@microsoft.com>
 <1345164325-5198-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1345164325-5198-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

---
 tools/hv/hv_kvp_daemon.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 65d54c8..2f8e0b9 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -550,6 +550,29 @@ static void kvp_get_ipconfig_info(char *if_name,
 	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
 				(MAX_GATEWAY_SIZE * 2), INET6_ADDRSTRLEN, 1);
 
+
+	/*
+	 * Gather the DNS  state.
+	 * Since there is no standard way to get this information
+	 * across various distributions of interest; we just invoke
+	 * an external script that needs to be ported across distros
+	 * of interest.
+	 *
+	 * Following is the expected format of the information from the script:
+	 *
+	 * ipaddr1 (nameserver1)
+	 * ipaddr2 (nameserver2)
+	 * .
+	 * .
+	 */
+
+	sprintf(cmd, "%s",  "hv_get_dns_info");
+
+	/*
+	 * Execute the command to gather DNS info.
+	 */
+	kvp_process_ipconfig_file(cmd, (char *)buffer->dns_addr,
+				(MAX_IP_ADDR_SIZE * 2), INET_ADDRSTRLEN, 0);
 }
 
 
-- 
1.7.4.1
