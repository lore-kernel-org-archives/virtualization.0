From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] tools/virtio/ringtest: fix run-on-all.sh to work without
	/dev/cpu
Date: Wed,  4 May 2016 09:12:56 +0300
Message-ID: <1462342376-16065-2-git-send-email-rppt__7884.03238771043$1462349072$gmane$org@linux.vnet.ibm.com>
References: <1462342376-16065-1-git-send-email-rppt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1462342376-16065-1-git-send-email-rppt@linux.vnet.ibm.com>
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
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

/dev/cpu is only available on x86 with certain modules (e.g. msr) enabled.
Using /proc/cpuinfo to get processors count is more portable.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 tools/virtio/ringtest/run-on-all.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/virtio/ringtest/run-on-all.sh b/tools/virtio/ringtest/run-on-all.sh
index 52b0f71..38ccfa3 100755
--- a/tools/virtio/ringtest/run-on-all.sh
+++ b/tools/virtio/ringtest/run-on-all.sh
@@ -3,10 +3,10 @@
 #use last CPU for host. Why not the first?
 #many devices tend to use cpu0 by default so
 #it tends to be busier
-HOST_AFFINITY=$(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n|tail -1)
+HOST_AFFINITY=$(($(grep -c processor /proc/cpuinfo) - 1))
 
 #run command on all cpus
-for cpu in $(cd /dev/cpu; ls|grep -v '[a-z]'|sort -n);
+for cpu in $(seq 0 $HOST_AFFINITY)
 do
 	#Don't run guest and host on same CPU
 	#It actually works ok if using signalling
-- 
1.9.1
