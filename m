From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [patch 2/4] io controller: biocgroup implementation
Date: Fri, 07 Nov 2008 13:19:49 +0900 (JST)
Message-ID: <20081107.131949.106618398.taka__17408.7167055861$1226031740$gmane$org@valinux.co.jp>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.790621895@redhat.com>
	<20081107115030.7ccf3f07.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107115030.7ccf3f07.kamezawa.hiroyu@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: menage@google.com, riel@redhat.com, akpm@linux-foundation.org, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jmoyer@redhat.com, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, vgoyal@redhat.com, righi.andrea@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm going to release a new version of bio_cgroup soon, which doesn't
have "struct list_head blist" anymore and whose overhead is minimized.

> > o biocgroup functionality.
> > o Implemented new controller "bio"
> > o Most of it picked from dm-ioband biocgroup implementation patches.
> > 
> page_cgroup implementation is changed and most of this patch needs rework.
> please see the latest one. (I think most of new characteristics are useful
> for you.)
> 
> One comment from me is
> ==
> > +struct page_cgroup {
> > +	struct list_head lru;		/* per cgroup LRU list */
> > +	struct page *page;
> > +	struct mem_cgroup *mem_cgroup;
> > +	int flags;
> > +#ifdef CONFIG_CGROUP_BIO
> > +	struct list_head blist;		/* for bio_cgroup page list */
> > +	struct bio_cgroup *bio_cgroup;
> > +#endif
> > +};
> ==
> 
> this blist is too bad. please keep this object small...
> 
> Maybe dm-ioband people will post his own new one. just making use of it is an idea.
> 
> Thanks,
> -Kame
> 
> 
