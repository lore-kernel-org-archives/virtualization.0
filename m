From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 21 Nov 2008 09:58:23 -0500
Message-ID: <20081121145823.GD3111__24230.6360895329$1227279698$gmane$org@redhat.com>
References: <20081114160525.GE24624@redhat.com>
	<e98e18940811141444u5947b806v27fac453ed1e8a5@mail.gmail.com>
	<20081117142309.GA15564@redhat.com>
	<4922224A.5030502@cn.fujitsu.com>
	<e98e18940811172101na345b6bh5c73f9e657aac5a7@mail.gmail.com>
	<20081118120508.GD15268@gandalf.sssup.it>
	<20081118140751.GA4283@redhat.com>
	<20081118144139.GE15268@gandalf.sssup.it>
	<20081120213155.GI29306@redhat.com>
	<20081121030533.GA30883@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081121030533.GA30883@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Fabio Checconi <fchecconi@gmail.com>
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, peterz@infradead.org, paolo.valente@unimore.it, containers@lists.linux-foundation.org, jens.axboe@oracle.com, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, taka@valinux.co.jp, jmoyer@redhat.com, Divyesh Shah <dpshah@google.com>, Nauman Rafique <nauman@google.com>, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 21, 2008 at 04:05:33AM +0100, Fabio Checconi wrote:
> > From: Vivek Goyal <vgoyal@redhat.com>
> > Date: Thu, Nov 20, 2008 04:31:55PM -0500
> >
> ...
> > Hi Fabio,
> > 
> > I though will give bfq a try.  I get following when I put my current shell
> > into a newly created cgroup and then try to do "ls".
> > 
> 
> The posted patch cannot work as it is, I'm sorry for that ugly bug.
> Do you still have problems with this one applied?
> 
> ---
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index efb03fc..ed8c597 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -168,7 +168,7 @@ static void bfq_group_chain_link(struct bfq_data *bfqd, struct cgroup *cgroup,
>  
>  		spin_lock_irqsave(&bgrp->lock, flags);
>  
> -		rcu_assign_pointer(bfqg->bfqd, bfqd);
> +		rcu_assign_pointer(leaf->bfqd, bfqd);
>  		hlist_add_head_rcu(&leaf->group_node, &bgrp->group_data);
>  		hlist_add_head(&leaf->bfqd_node, &bfqd->group_list);

Thanks Fabio. This fix solves the issue for me.

I did a quick testing and I can see the differential service if I create
two cgroups of different priority. How do I map ioprio to shares? I
mean lets say one cgroup has ioprio 4 and other has got ioprio 7, then
what's the respective share(%) of each cgroup?

Thanks
Vivek
