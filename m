From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] CodingStyle: add some more error handling guidelines
Date: Mon, 22 Aug 2016 16:57:46 +0300
Message-ID: <1471874251-7721-1-git-send-email-mst@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

commit commit ea04036032edda6f771c1381d03832d2ed0f6c31 ("CodingStyle:
add some more error handling guidelines") suggests never naming goto
labels after the goto location - that is the error that is handled.

But it's actually pretty common and IMHO it's a reasonable style
provided each error gets its own label, and each label comes after the
matching cleanup:

                foo = kmalloc(SIZE, GFP_KERNEL);
                if (!foo)
                        goto err_foo;

                foo->bar = kmalloc(SIZE, GFP_KERNEL);
                if (!foo->bar)
                        goto err_bar;
                ...

                kfree(foo->bar);
        err_bar:

                kfree(foo);
        err_foo:

                return ret;

Provides some symmetry and makes it easy to add more cases as code
calling goto does not need to worry about how is the error handled.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 tools/virtio/ringtest/main.h |  4 +++-
 Documentation/CodingStyle    | 44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index 16917ac..e4d76c3 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -80,7 +80,9 @@ extern unsigned ring_size;
 
 /* Is there a portable way to do this? */
 #if defined(__x86_64__) || defined(__i386__)
-#define cpu_relax() asm ("rep; nop" ::: "memory")
+#define cpu_relax() do { \
+	asm ("rep; nop" ::: "memory"); \
+} while (0)
 #else
 #define cpu_relax() assert(0)
 #endif
diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
index a096836..af2b5e9 100644
--- a/Documentation/CodingStyle
+++ b/Documentation/CodingStyle
@@ -397,8 +397,7 @@ cleanup needed then just return directly.
 
 Choose label names which say what the goto does or why the goto exists.  An
 example of a good name could be "out_buffer:" if the goto frees "buffer".  Avoid
-using GW-BASIC names like "err1:" and "err2:".  Also don't name them after the
-goto location like "err_kmalloc_failed:"
+using GW-BASIC names like "err1:" and "err2:".
 
 The rationale for using gotos is:
 
@@ -440,6 +439,47 @@ A common type of bug to be aware of is "one err bugs" which look like this:
 The bug in this code is that on some exit paths "foo" is NULL.  Normally the
 fix for this is to split it up into two error labels "err_bar:" and "err_foo:".
 
+Note that labels normally come before the appropriate cleanups:
+
+		foo = kmalloc(SIZE, GFP_KERNEL); 
+		if (!foo)
+			goto out;
+
+		foo->bar = kmalloc(SIZE, GFP_KERNEL); 
+		if (!foo->bar)
+			goto out_foo;
+		...
+		if (err)
+			goto out_bar;
+
+	out_bar:
+		kfree(foo->bar);
+
+	out_foo:
+		kfree(foo);
+
+	out:
+		return ret;
+
+If labels are named after the goto location (or error that was detected), they
+come after the matching cleanup code:
+
+		foo = kmalloc(SIZE, GFP_KERNEL); 
+		if (!foo)
+			goto err_foo;
+
+		foo->bar = kmalloc(SIZE, GFP_KERNEL); 
+		if (!foo->bar)
+			goto err_bar;
+		...
+
+		kfree(foo->bar);
+	err_bar:
+
+		kfree(foo);
+	err_foo:
+
+		return ret;
 
 		Chapter 8: Commenting
 
-- 
MST
