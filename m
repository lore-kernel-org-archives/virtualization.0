From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 1/2] tools/virtio/ringtest: fix run-on-all.sh for offline cpus
Date: Mon, 19 Sep 2016 17:06:55 +0200
Message-ID: <20160919150656.6194-2-cornelia.huck__22779.5333871201$1474297675$gmane$org@de.ibm.com>
References: <20160919150656.6194-1-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160919150656.6194-1-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: pasic@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Since ef1b144d ("tools/virtio/ringtest: fix run-on-all.sh to work
without /dev/cpu") run-on-all.sh uses seq 0 $HOST_AFFINITY as the list
of ids of the CPUs to run the command on (assuming ids of online CPUs
are consecutive and start from 0), where $HOST_AFFINITY is the highest
CPU id in the system previously determined using lscpu.  This can fail
on systems with offline CPUs.

Instead let's use lscpu to determine the list of online CPUs.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Fixes: ef1b144d ("tools/virtio/ringtest: fix run-on-all.sh to work without
/dev/cpu")
Reviewed-by: Sascha Silbe <silbe@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 tools/virtio/ringtest/run-on-all.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/ringtest/run-on-all.sh b/tools/virtio/ringtest/run-on-all.sh
index 2e69ca8..29b0d39 100755
--- a/tools/virtio/ringtest/run-on-all.sh
+++ b/tools/virtio/ringtest/run-on-all.sh
@@ -1,12 +1,13 @@
 #!/bin/sh
 
+CPUS_ONLINE=$(lscpu --online -p=cpu|grep -v -e '#')
 #use last CPU for host. Why not the first?
 #many devices tend to use cpu0 by default so
 #it tends to be busier
-HOST_AFFINITY=$(lscpu -p=cpu | tail -1)
+HOST_AFFINITY=$(echo "${CPUS_ONLINE}"|tail -n 1)
 
 #run command on all cpus
-for cpu in $(seq 0 $HOST_AFFINITY)
+for cpu in $CPUS_ONLINE
 do
 	#Don't run guest and host on same CPU
 	#It actually works ok if using signalling
-- 
2.8.4
