From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Tue, 29 Sep 2009 17:50:06 +0530
Message-ID: <20090929122006.GB3766__13198.6474422321$1254226903$gmane$org@amit-x200.redhat.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<20090922154549.GA11379@amit-x200.redhat.com>
	<20090929092431.GA3368@amit-x200.redhat.com>
	<200909291403.08547.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200909291403.08547.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Sep 29 2009 [14:03:08], Christian Borntraeger wrote:
> Am Dienstag 29 September 2009 11:24:31 schrieb Amit Shah:
> > -static void hvc_handle_input(struct virtqueue *vq)
> > +/* The operations for our console. */
> > +static struct hv_ops virtio_cons = {
> > +	.get_chars = cons_get_chars,
> > +	.put_chars = cons_put_chars,
> > +	.notifier_add = cons_notifier_add_vio,
> > +	.notifier_del = cons_notifier_del_vio,
> > +	.notifier_hangup = cons_notifier_del_vio,
> > +};
> [...]
> > +int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int)) 
> > +{
> > +	virtio_cons.put_chars = put_chars;
> > +	return hvc_instantiate(0, 0, &virtio_cons);
> > +}
> [...]
> > +static int __devinit virtcons_probe(struct virtio_device *vdev)
> [...]
> > -	/* Start using the new console output. */
> > -	virtio_cons.get_chars = get_chars;
> > -	virtio_cons.put_chars = put_chars;
> 
> Ok, that wont work for systems that use virtio_cons_early_init. The early
> put_chars method was replaced by the final one, but these hunks changed that
> behaviour. Something like the following restores the old behaviour: (only 
> tested on s390)

Thanks for the testing as well as the patch! Sadly I can only test this
on qemu and x86, so this is very welcome.

However:

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> If you agree, you can merge this snipped into your big patch.
> 
> ---
>  drivers/char/virtio_console.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-2.6/drivers/char/virtio_console.c
> ===================================================================
> --- linux-2.6.orig/drivers/char/virtio_console.c
> +++ linux-2.6/drivers/char/virtio_console.c
> @@ -590,6 +590,9 @@ int init_port_console(struct virtio_cons
>  		pr_err("%s: Could not alloc hvc for virtio console port, ret = %d\n",
>  		       __func__, ret);
>  		port->hvc = NULL;
> +	} else {
> +		/* get rid of early put char variants */
> +		virtio_cons.put_chars = cons_put_chars;
>  	}
>  	return ret;
>  }

I changed it to look like this, which initializes the final value even
when hvc_alloc fails. It should work for you I guess.

I'll merge this in my patch when I send it next.

Can you please ack the patch?

Thanks,

		Amit


From 462aa408c2a1140137d0890ca8043f37b447410d Mon Sep 17 00:00:00 2001
From: Amit Shah <amit.shah@redhat.com>
Date: Tue, 29 Sep 2009 17:46:41 +0530
Subject: [PATCH] virtio_console: fix put_chars after early-init

Christian tested the patch on s390 and found that the output was
very slow. He tracked it down to put_chars never getting init'ed
to the final value.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 37513e8..598bc0d 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -571,6 +571,14 @@ int init_port_console(struct virtio_console_port *port)
 	 * The Host's telling us this port is a console port. Hook it
 	 * up with an hvc console.
 	 *
+	 * We had set the virtio_cons put_chars implementation to
+	 * put_chars for early_init. Now that we're done with the
+	 * early init phase, replace it with our cons_put_chars
+	 * implementation.
+	 */
+	virtio_cons.put_chars = cons_put_chars;
+
+	/*
 	 * To set up and manage our virtual console, we call
 	 * hvc_alloc().
 	 *
-- 
1.6.2.5
