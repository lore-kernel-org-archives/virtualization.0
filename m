From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 1/3] hvc_console: rework setup to replace irq functions with callbacks (not word wrapped)
Date: Tue, 3 Jun 2008 19:30:09 +0200
Message-ID: <200806031930.09556.arnd@arndb.de>
References: <200806031444.21945.borntraeger@de.ibm.com> <200806031449.14385.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757549AbYFCRa2@vger.kernel.org>
In-Reply-To: <200806031449.14385.borntraeger@de.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 June 2008, Christian Borntraeger wrote:

> @@ -42,22 +42,48 @@
>   */
>  #define HVC_ALLOC_TTY_ADAPTERS	8
>  
> +struct hvc_struct {
> +	spinlock_t lock;
> +	int index;
> +	struct tty_struct *tty;
> +	unsigned int count;
> +	int do_wakeup;
> +	char *outbuf;
> +	int outbuf_size;
> +	int n_outbuf;
> +	uint32_t vtermno;
> +	struct hv_ops *ops;
> +	int data;
> +	struct list_head next;
> +	struct kref kref; /* ref count & hvc_struct lifetime */
> +};
>  

I don't see a reason to make this data structure known to other files,
so why not leave it in hvc_console.c?


> +
> +#ifdef CONFIG_HVC_IRQ
> +/* default notifier for irq based notification */
> +extern int notifier_add_irq(struct hvc_struct *hp, int irq);
> +extern void notifier_del_irq(struct hvc_struct *hp, int irq);
> +#endif
>  #endif // HVC_CONSOLE_H

Please remove the #ifdef around the declarations.

h	Arnd <><
