From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/1] [virt] virtio-blk: Use ida to allocate disk index
Date: Wed, 15 Jun 2011 14:21:51 +0930
Message-ID: <87mxhjzogo.fsf__27123.3492567719$1308116455$gmane$org@rustcorp.com.au>
References: <1306913069-23637-1-git-send-email-dwu@redhat.com>
	<87mxi1xfz0.fsf@rustcorp.com.au> <4DEF744D.9040702@redhat.com>
	<87mxhrgba6.fsf@rustcorp.com.au>
	<20110609091433.GB11773@htj.dyndns.org>
	<4DF0A374.6090504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DF0A374.6090504@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Mark Wu <dwu@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Tejun Heo <tj@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

> Since virtio blk driver doesn't use async probe, it needn't use spinlock to protect ida.
> So remove the lock from patch.

OK, that's fine, but:
> -	if (index_to_minor(index) >= 1 << MINORBITS)
> -		return -ENOSPC;
> +	do {
> +		if (!ida_pre_get(&vd_index_ida, GFP_KERNEL))
> +			return -ENOMEM;
> +		err = ida_get_new(&vd_index_ida, &index);
> +	} while (err == -EAGAIN);
> +
> +	if (err)
> +		return err;
> +
> +	if (index_to_minor(index) >= 1 << MINORBITS) {
> +		err =  -ENOSPC;
> +		goto out_free_index;
> +	}

Is this *really* how this is supposed to be used?

Tejun, this is your code.  What do you think of something like this?
(untested)

Subject: ida: Simplified functions for id allocation.

The current hyper-optimized functions are overkill if you simply want
to allocate an id for a device.  Create versions which use an internal
lock.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/include/linux/idr.h b/include/linux/idr.h
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -146,6 +146,9 @@ void ida_remove(struct ida *ida, int id)
 void ida_destroy(struct ida *ida);
 void ida_init(struct ida *ida);
 
+int ida_simple_get(struct ida *ida, int min_id, int max_id);
+void ida_simple_remove(struct ida *ida, int id);
+
 void __init idr_init_cache(void);
 
 #endif /* __IDR_H__ */
diff --git a/lib/idr.c b/lib/idr.c
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -34,8 +34,10 @@
 #include <linux/err.h>
 #include <linux/string.h>
 #include <linux/idr.h>
+#include <linux/mutex.h>
 
 static struct kmem_cache *idr_layer_cache;
+static DEFINE_MUTEX(simple_ida);
 
 static struct idr_layer *get_from_free_list(struct idr *idp)
 {
@@ -926,6 +928,52 @@ void ida_destroy(struct ida *ida)
 EXPORT_SYMBOL(ida_destroy);
 
 /**
+ * ida_simple_get - get a new id.
+ * @ida: the (initialized) ida.
+ * @min_id: the minimum id (inclusive)
+ * @max_id: the maximum id (inclusive)
+ *
+ * Allocates an id in the range min_id <= id <= max_id, or returns -ENOSPC.
+ * On allocation failure, returns -ENOMEM.  This function can sleep.
+ *
+ * Use ida_simple_remove() to get rid of an id.
+ */
+int ida_simple_get(struct ida *ida, int min_id, int max_id)
+{
+	int ret;
+
+	mutex_lock(&simple_ida);
+	if (ida_pre_get(ida, GFP_KERNEL)) {
+		int id;
+		ret = ida_get_new_above(ida, min_id, &id);
+		if (!ret) {
+			if (id > max_id) {
+				ida_remove(ida, id);
+				ret = -ENOSPC;
+			} else
+				ret = id;
+		}
+	} else
+		ret = -ENOMEM;
+	mutex_unlock(&simple_ida);
+	return ret;
+}
+EXPORT_SYMBOL(ida_simple_get);
+
+/**
+ * ida_simple_remove - remove an allocated id.
+ * @ida: the (initialized) ida.
+ * @id: the id returned by ida_simple_get.
+ */
+void ida_simple_remove(struct ida *ida, int id)
+{
+	mutex_lock(&simple_ida);
+	ida_remove(ida, id);
+	mutex_unlock(&simple_ida);
+}
+EXPORT_SYMBOL(ida_simple_remove);
+
+/**
  * ida_init - initialize ida handle
  * @ida:	ida handle
  *
