From: rusty@rustcorp.com.au
Subject: [patch 07/43] lguest: Use copy_to_user() not put_user for struct
	timespec
Date: Wed, 26 Sep 2007 16:36:25 +1000
Message-ID: <20070926063646.186187456@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lg-timespec-copy.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Jes Sorensen <jes@sgi.com>, Al Viro <viro@ftp.linux.org.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Use copy_to_user() when copying a struct timespec to the guest -
put_user() cannot handle two long's in one go on a 64bit arch.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jes Sorensen <jes@sgi.com>
Cc: Al Viro <viro@ftp.linux.org.uk>
---
 drivers/lguest/hypercalls.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- linux-2.6.23-rc4.orig/drivers/lguest/hypercalls.c
+++ linux-2.6.23-rc4/drivers/lguest/hypercalls.c
@@ -243,6 +243,6 @@ void write_timestamp(struct lguest *lg)
 {
 	struct timespec now;
 	ktime_get_real_ts(&now);
-	if (put_user(now, &lg->lguest_data->time))
+	if (copy_to_user(&lg->lguest_data->time, &now, sizeof(struct timespec)))
 		kill_guest(lg, "Writing timestamp");
 }

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
