From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2] virtio_mmio: fix devm cleanup
Date: Tue, 12 Dec 2017 14:45:07 +0000
Message-ID: <20171212144506.c4z6aqieo5uo3pcn__22750.1312074766$1513091753$gmane$org@lakrids.cambridge.arm.com>
References: <20171212134550.18378-1-mark.rutland@arm.com>
	<CAA70yB7qN_50xFFmx5Vxs61teSjBjm2jCzZY=XqwNiLU_dWMgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAA70yB7qN_50xFFmx5Vxs61teSjBjm2jCzZY=XqwNiLU_dWMgw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: weiping zhang <zwp10758@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, weiping zhang <zhangweiping@didichuxing.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 12, 2017 at 10:26:24PM +0800, weiping zhang wrote:
> 2017-12-12 21:45 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
> Hi Mark,

Hi,

> thanks your patch, I dig into these three devm_xxx funciton,
> all of them represented by a struct devres as following,
> 
> struct devres_node {
>         struct list_head                entry;
>         dr_release_t                    release;
> #ifdef CONFIG_DEBUG_DEVRES
>         const char                      *name;
>         size_t                          size;
> #endif
> 
> };
> 
> struct devres {
>         struct devres_node              node;
>         /* -- 3 pointers */
>         unsigned long long              data[]; /* guarantee ull alignment */
> };

> 2) devm_kzalloc -> devm_kmalloc
> 
> dr = alloc_dr(devm_kmalloc_release, size, gfp, dev_to_node(dev));
> "devm_kmalloc_release" is noop, do nothing.

Please note that the release function is there to perform cleanup prior
to the devm infrastructure releasing the memory.

The devm_kmalloc_release function is a no-op since nothing has to be
done prior to memory being freed, but the memory itself is still freed.

In alloc_dr(), the struct devres is allocated together with the memory,
since alloc_dr() does:

	size_t tot_size = sizeof(struct devres) + size; 
	struct devres *dr;

	dr = kmalloc_node_track_caller(tot_size, gfp, nid);

	return dr->data;

... where dr->data points at the memory after the struct devres.

Later, in release_nodes() we do:

	list_for_each_entry_safe_reverse(dr, tmp, &todo, node.entry) {
		devres_log(dev, &dr->node, "REL");
		dr->node.release(dev, dr->data);
		kfree(dr);
	}    

... which will invoke the no-op devm_kmalloc_release, then free the
devres allocation, including the dr->data memory the user requested.

> so for case 2) above, we need a devm_kfree() before call
> register_virtio_device

As above, I do not believe that is the case.

Thanks,
Mark.
