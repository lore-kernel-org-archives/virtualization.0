From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: a room for blkio-cgroup in struct page_cgroup
Date: Wed, 02 Sep 2009 20:51:37 +0900 (JST)
Message-ID: <20090902.205137.71100180.ryov__3838.37634367428$1251892632$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Kamezawa-san,

As you wrote before (http://lkml.org/lkml/2009/7/22/65)
> To be honest, what I expected in these days for people of blockio
> cgroup is like following for getting room for themselves.
<<snip>>
> --- mmotm-2.6.31-Jul16.orig/include/linux/page_cgroup.h
> +++ mmotm-2.6.31-Jul16/include/linux/page_cgroup.h
> @@ -13,7 +13,7 @@
>  struct page_cgroup {
>       unsigned long flags;
>       struct mem_cgroup *mem_cgroup;
> -     struct page *page;
> +     /* block io tracking will use extra unsigned long bytes */
>       struct list_head lru;       /* per cgroup LRU list */
> };

Have you already added a room for blkio_cgroup in struct page_cgroup?
If not, I would like you to apply the above change to mmotm.

The latest blkio-cgroup has reflected the comments you pointed out.
I would also like you to give me any comments on it and consider
merging blkio-cgroup to mmotm.

Thank you for your help in advance.
Ryo Tsuruta
