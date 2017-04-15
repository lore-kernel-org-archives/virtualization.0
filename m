From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ringtest: fix an assert statement
Date: Sat, 15 Apr 2017 22:22:14 +0300
Message-ID: <20170415192214.GB6416@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There is an || vs && typo so the assert can never be triggered.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/tools/virtio/ringtest/main.c b/tools/virtio/ringtest/main.c
index 022ae95a06bd..453ca3c21193 100644
--- a/tools/virtio/ringtest/main.c
+++ b/tools/virtio/ringtest/main.c
@@ -87,7 +87,7 @@ void set_affinity(const char *arg)
 	cpu = strtol(arg, &endptr, 0);
 	assert(!*endptr);
 
-	assert(cpu >= 0 || cpu < CPU_SETSIZE);
+	assert(cpu >= 0 && cpu < CPU_SETSIZE);
 
 	self = pthread_self();
 	CPU_ZERO(&cpuset);
