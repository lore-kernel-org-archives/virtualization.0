From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 2/4] io controller: biocgroup implementation
Date: Fri, 7 Nov 2008 09:44:17 -0500
Message-ID: <20081107144417.GE21884__22039.2545954839$1226069477$gmane$org@redhat.com>
References: <20081106153022.215696930@redhat.com>
	<20081106153135.790621895@redhat.com>
	<20081107115030.7ccf3f07.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Nov 07, 2008 at 11:50:30AM +0900, KAMEZAWA Hiroyuki wrote:
> On Thu, 06 Nov 2008 10:30:24 -0500
> vgoyal@redhat.com wrote:
> 
> > 
> > o biocgroup functionality.
> > o Implemented new controller "bio"
> > o Most of it picked from dm-ioband biocgroup implementation patches.
> > 
> page_cgroup implementation is changed and most of this patch needs rework.
> please see the latest one. (I think most of new characteristics are useful
> for you.)
> 

Sure I will have a look.

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

This is just another connecting element so that page_cgroup can be on another
list also. It is useful in making sure that IO on all the pages of a bio
group has completed beofer that bio cgroup is deleted.

> Maybe dm-ioband people will post his own new one. just making use of it is an idea.

Sure, I will have a look when dm-ioband people post new version of patch
and how they have optimized it further.

Thanks
Vivek
