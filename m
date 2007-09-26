From: rusty@rustcorp.com.au
Subject: [patch 06/43] lguest: turn err into errx in lguest call sites
Date: Wed, 26 Sep 2007 16:36:24 +1000
Message-ID: <20070926063645.985398864@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=launcher-errx.patch
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
Cc: Glauber de Oliveira Costa <gcosta@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

These two callsites should really be errx instead of err, since there is
no errno associated with them in the moment they are issued.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Glauber de Oliveira Costa <gcosta@redhat.com>
---
 Documentation/lguest/lguest.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -159,7 +159,7 @@ static unsigned long entry_point(void *s
 		if (memcmp(p, "GenuineLguest", strlen("GenuineLguest")) == 0)
 			return (long)p + strlen("GenuineLguest") + page_offset;
 
-	err(1, "Is this image a genuine lguest?");
+	errx(1, "Is this image a genuine lguest?");
 }
 
 /* This routine takes an open vmlinux image, which is in ELF, and maps it into
@@ -858,7 +858,7 @@ static u32 handle_block_output(int fd, c
 	/* We first check that the read or write is within the length of the
 	 * block file. */
 	if (off >= device_len)
-		err(1, "Bad offset %llu vs %llu", off, device_len);
+		errx(1, "Bad offset %llu vs %llu", off, device_len);
 	/* Move to the right location in the block file.  This shouldn't fail,
 	 * but best to check. */
 	if (lseek64(dev->fd, off, SEEK_SET) != off)

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
