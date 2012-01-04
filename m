From: Ian Campbell <ian.campbell@citrix.com>
Subject: [PATCH 1/2] xenbus: maximum buffer size is XENSTORE_PAYLOAD_MAX
Date: Wed, 4 Jan 2012 11:39:51 +0000
Message-ID: <1325677192-10459-1-git-send-email-ian.campbell@citrix.com>
References: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1325677158.25206.244.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Ian Campbell <ian.campbell@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Haogang Chen <haogangchen@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Use this now that it is defined even though it happens to be == PAGE_SIZE.

The code which takes requests from userspace already validates against the size
of this buffer so no further checks are required to ensure that userspace
requests comply with the protocol in this respect.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Haogang Chen <haogangchen@gmail.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/xen/xenbus/xenbus_dev_frontend.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_dev_frontend.c b/drivers/xen/xenbus/xenbus_dev_frontend.c
index fb30cff..1fe4324 100644
--- a/drivers/xen/xenbus/xenbus_dev_frontend.c
+++ b/drivers/xen/xenbus/xenbus_dev_frontend.c
@@ -104,7 +104,7 @@ struct xenbus_file_priv {
 	unsigned int len;
 	union {
 		struct xsd_sockmsg msg;
-		char buffer[PAGE_SIZE];
+		char buffer[XENSTORE_PAYLOAD_MAX];
 	} u;
 
 	/* Response queue. */
-- 
1.7.2.5
