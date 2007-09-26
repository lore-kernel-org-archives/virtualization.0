From: rusty@rustcorp.com.au
Subject: [patch 01/43] lguest: lguest example launcher truncates block
	device file to 0 length on problems
Date: Wed, 26 Sep 2007 16:36:19 +1000
Message-ID: <20070926063645.068771169@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=ftruncate64-fix.patch
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
Cc: Chris Malley <mail@chrismalley.co.uk>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The function should also use ftruncate64() rather than ftruncate() to prevent
files over 4GB (not uncommon for a root filesystem) being zeroed.

Signed-off-by: Chris Malley <mail@chrismalley.co.uk>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
CC: Chris Malley <mail@chrismalley.co.uk>

diff -r bcbb99849fd9 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Wed Sep 26 12:21:40 2007 +1000
+++ b/Documentation/lguest/lguest.c	Wed Sep 26 14:15:38 2007 +1000
@@ -882,7 +882,7 @@ static u32 handle_block_output(int fd, c
 		 * of the block file (possibly extending it). */
 		if (off + len > device_len) {
 			/* Trim it back to the correct length */
-			ftruncate(dev->fd, device_len);
+			ftruncate64(dev->fd, device_len);
 			/* Die, bad Guest, die. */
 			errx(1, "Write past end %llu+%u", off, len);
 		}

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
