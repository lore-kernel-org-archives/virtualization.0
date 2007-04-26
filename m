From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] Fix lguest documentation error
Date: Thu, 26 Apr 2007 20:46:42 +1000
Message-ID: <1177584403.30071.62.camel__44938.5630236522$1177584476$gmane$org@localhost.localdomain>
References: <1177584310.30071.60.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177584310.30071.60.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

[ How embarrassing, I got the iptables command wrong! --RR ]

From: James Morris <jmorris@namei.org>

Fix up nat example in documentation.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/lguest.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/Documentation/lguest/lguest.txt
+++ b/Documentation/lguest/lguest.txt
@@ -69,7 +69,7 @@ Running Lguest:
        kernel boot parameters.
 
 - Configuring networking.  I usually have the host masquerade, using
-  "iptables -t nat -o eth0 -j MASQUERADE" and "echo 1 >
+  "iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE" and "echo 1 >
   /proc/sys/net/ipv4/ip_forward".  In this example, I would configure
   eth0 inside the guest at 192.168.19.2.
