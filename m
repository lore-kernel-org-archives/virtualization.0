From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 2/2] virtio_balloon: free some memory from baloon on OOM
Date: Mon, 13 Oct 2014 16:02:52 +1030
Message-ID: <87iojoedq3.fsf@rustcorp.com.au>
References: <1412763669-2980-1-git-send-email-den@parallels.com>
	<1412763669-2980-3-git-send-email-den@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412763669-2980-3-git-send-email-den@parallels.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Denis V. Lunev" <den@parallels.com>
Cc: den@openvz.org, virtualization@lists.linux-foundation.org, Raushaniya Maksudova <rmaksudova@parallels.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

"Denis V. Lunev" <den@parallels.com> writes:
> From: Raushaniya Maksudova <rmaksudova@parallels.com>
>
> Excessive virtio_balloon inflation can cause invocation of OOM-killer,
> when Linux is under severe memory pressure. Various mechanisms are
> responsible for correct virtio_balloon memory management. Nevertheless
> it is often the case that these control tools does not have enough time
> to react on fast changing memory load. As a result OS runs out of memory
> and invokes OOM-killer. The balancing of memory by use of the virtio
> balloon should not cause the termination of processes while there are
> pages in the balloon. Now there is no way for virtio balloon driver to
> free some memory at the last moment before some process will be get
> killed by OOM-killer.

This makes some amount of sense.

But I suggest a few minor changes:

> +static int oom_vballoon_pages = OOM_VBALLOON_DEFAULT_PAGES;
> +module_param(oom_vballoon_pages, int, S_IRUSR | S_IWUSR);
> +MODULE_PARM_DESC(oom_vballoon_pages, "pages to free on OOM");

Since this is already prefixed with "virtio_balloon." I suggest just
calling it "oom_pages".

> +static int virtballoon_oom_notify(struct notifier_block *self,
> +				  unsigned long dummy, void *parm)
> +{
> +	unsigned int num_freed_pages;
> +	unsigned long *freed = (unsigned long *)parm;
> +	struct virtio_balloon *vb = container_of((struct notifier_block *)self,
> +						 struct virtio_balloon, nb);

Why cast self here?

> +	num_freed_pages = leak_balloon(vb, oom_vballoon_pages);
> +	update_balloon_size(vb);
> +	*freed += num_freed_pages;
> +
> +	return NOTIFY_OK;
> +}

Cheers,
Rusty.
