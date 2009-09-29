From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 14:03:08 +0200
Message-ID: <200909291403.08547.borntraeger__13739.0891010456$1254225848$gmane$org@de.ibm.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<20090922154549.GA11379@amit-x200.redhat.com>
	<20090929092431.GA3368@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090929092431.GA3368@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 29 September 2009 11:24:31 schrieb Amit Shah:
> -static void hvc_handle_input(struct virtqueue *vq)
> +/* The operations for our console. */
> +static struct hv_ops virtio_cons = {
> +	.get_chars = cons_get_chars,
> +	.put_chars = cons_put_chars,
> +	.notifier_add = cons_notifier_add_vio,
> +	.notifier_del = cons_notifier_del_vio,
> +	.notifier_hangup = cons_notifier_del_vio,
> +};
[...]
> +int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int)) 
> +{
> +	virtio_cons.put_chars = put_chars;
> +	return hvc_instantiate(0, 0, &virtio_cons);
> +}
[...]
> +static int __devinit virtcons_probe(struct virtio_device *vdev)
[...]
> -	/* Start using the new console output. */
> -	virtio_cons.get_chars = get_chars;
> -	virtio_cons.put_chars = put_chars;

Ok, that wont work for systems that use virtio_cons_early_init. The early
put_chars method was replaced by the final one, but these hunks changed that
behaviour. Something like the following restores the old behaviour: (only 
tested on s390)

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
If you agree, you can merge this snipped into your big patch.

---
 drivers/char/virtio_console.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/char/virtio_console.c
===================================================================
--- linux-2.6.orig/drivers/char/virtio_console.c
+++ linux-2.6/drivers/char/virtio_console.c
@@ -590,6 +590,9 @@ int init_port_console(struct virtio_cons
 		pr_err("%s: Could not alloc hvc for virtio console port, ret = %d\n",
 		       __func__, ret);
 		port->hvc = NULL;
+	} else {
+		/* get rid of early put char variants */
+		virtio_cons.put_chars = cons_put_chars;
 	}
 	return ret;
 }
