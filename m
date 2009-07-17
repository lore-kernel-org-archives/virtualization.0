From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 09/54] Staging: hv: use the correct #ifdef for x86-64
Date: Fri, 17 Jul 2009 11:08:59 -0700
Message-ID: <20090717180917.291210440@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-use-the-correct-ifdef-for-x86-64.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

x86-64 needs a different config check.  Thanks to Hank for the debugging
to determine the fix for this.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/Hv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/hv/Hv.c
+++ b/drivers/staging/hv/Hv.c
@@ -165,7 +165,7 @@ HvDoHypercall (
     void*   Output
     )
 {
-#ifdef x86_64
+#ifdef CONFIG_X86_64
     UINT64 hvStatus=0;
     UINT64 inputAddress = (Input)? GetPhysicalAddress(Input) : 0;
 	UINT64 outputAddress = (Output)? GetPhysicalAddress(Output) : 0;
