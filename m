From: Juergen Gross <jgross@suse.com>
Subject: [PATCH] maintainers: drop Chris Wright from pvops
Date: Thu, 26 Oct 2017 12:31:54 +0200
Message-ID: <20171026103154.4590-1-jgross@suse.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: chrisw@sous-sol.org, Juergen Gross <jgross@suse.com>, akataria@vmware.com, rusty@rustcorp.com.au
List-Id: virtualization@lists.linuxfoundation.org

Mails to chrisw@sous-sol.org are not deliverable since several months.
Drop him as PARAVIRT_OPS maintainer.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d85c08956875..af0cb69f6a3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10179,7 +10179,6 @@ F:	Documentation/parport*.txt
 
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
-M:	Chris Wright <chrisw@sous-sol.org>
 M:	Alok Kataria <akataria@vmware.com>
 M:	Rusty Russell <rusty@rustcorp.com.au>
 L:	virtualization@lists.linux-foundation.org
-- 
2.12.3
