From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 13/14] Tools: hv: Get rid of some unused variables
Date: Thu, 16 Aug 2012 17:45:24 -0700
Message-ID: <1345164325-5198-14-git-send-email-kys@microsoft.com>
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
 tools/hv/hv_kvp_daemon.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index e7db9ac..4a1428c 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -211,7 +211,7 @@ static void kvp_update_mem_state(int pool)
 }
 static int kvp_file_init(void)
 {
-	int ret, fd;
+	int  fd;
 	FILE *filep;
 	size_t records_read;
 	__u8 *fname;
@@ -327,7 +327,6 @@ static int kvp_key_add_or_modify(int pool, __u8 *key, int key_size, __u8 *value,
 			int value_size)
 {
 	int i;
-	int j, k;
 	int num_records;
 	struct kvp_record *record;
 	int num_blocks;
-- 
1.7.4.1
