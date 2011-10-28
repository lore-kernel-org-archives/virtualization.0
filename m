From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] VirtioConsole support.
Date: Fri, 28 Oct 2011 05:55:58 +0300
Message-ID: <1319770558.2529.20.camel@Joe-Laptop>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1319751802-27013-1-git-send-email-miche@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miche Baker-Harvey <miche@google.com>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2011-10-27 at 14:43 -0700, Miche Baker-Harvey wrote:
> Multiple HVC console terminals enabled.

Just a note on allocation.

> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
[]
> @@ -845,6 +857,19 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
>  	kref_init(&hp->kref);
>  
>  	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
> +	/*
> +	 * make each console its own struct console.
> +	 * No need to do allocation and copy under lock.
> +	 */
> +	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
> +	if (!cp) {
> +		kfree(hp);
> +		mutex_unlock(&hvc_ports_mutex);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	memcpy(cp, &hvc_console, sizeof(*cp));

The kzalloc should be kmalloc as the allocated
memory is immediately overwritten.
