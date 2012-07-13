From: Asias He <asias@redhat.com>
Subject: [PATCH RESEND 2/5] eventfd: Export symbol eventfd_file_create()
Date: Fri, 13 Jul 2012 16:55:08 +0800
Message-ID: <1342169711-12386-3-git-send-email-asias@redhat.com>
References: <1342169711-12386-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1342169711-12386-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Jeff Moyer <jmoyer@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

This is useful for people who want to create an eventfd in kernel,
e.g. vhost-blk.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Asias He <asias@redhat.com>
---
 fs/eventfd.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index d81b9f6..b288963 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -402,6 +402,7 @@ struct file *eventfd_file_create(unsigned int count, int flags)
 
 	return file;
 }
+EXPORT_SYMBOL_GPL(eventfd_file_create);
 
 SYSCALL_DEFINE2(eventfd2, unsigned int, count, int, flags)
 {
-- 
1.7.10.4
