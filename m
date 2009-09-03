From: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: a room for blkio-cgroup in struct page_cgroup
Date: Thu, 3 Sep 2009 09:30:05 +0900 (JST)
Message-ID: <fa721014d75b6e193623349bfde28124.squirrel__33847.6739627824$1251937873$gmane$org@webmail-b.css.fujitsu.com>
References: <20090902.205137.71100180.ryov@valinux.co.jp>
	<ff13736137802f78cf492d13c43c1af1.squirrel@webmail-b.css.fujitsu.com>
	<661de9470909021302ge86d01s5d107dc2b5cffbc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <661de9470909021302ge86d01s5d107dc2b5cffbc5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: virtualization@lists.linuxfoundation.org

Balbir Singh wrote:
> 2009/9/2 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>:
>> Ryo Tsuruta wrote:
>>> Hi Kamezawa-san,
>>>
>>> As you wrote before (http://lkml.org/lkml/2009/7/22/65)
>>>> To be honest, what I expected in these days for people of blockio
>>>> cgroup is like following for getting room for themselves.
>>> <<snip>>
>>>> --- mmotm-2.6.31-Jul16.orig/include/linux/page_cgroup.h
>>>> +++ mmotm-2.6.31-Jul16/include/linux/page_cgroup.h
>>>> @@ -13,7 +13,7 @@
>>>> &#160;struct page_cgroup {
>>>> &#160; &#160; &#160; unsigned long flags;
>>>> &#160; &#160; &#160; struct mem_cgroup *mem_cgroup;
>>>> - &#160; &#160; struct page *page;
>>>> + &#160; &#160; /* block io tracking will use extra unsigned long
bytes */
>>>> &#160; &#160; &#160; struct list_head lru; &#160; &#160; &#160; /*
per cgroup LRU list */
>>>> };
>>>
>>> Have you already added a room for blkio_cgroup in struct page_cgroup?
>> No.
>>
>
> The diff above is unclear, are you removing struct page from page_cgroup?
>
I said him "if you want a room, plz get by youself, consider more"
And offered this change.
 http://lkml.org/lkml/2009/7/22/65
you were CC'd.
Because page_cgroup's layout is same to memmap, we can use similar function
as
  page_cgroup_to_pfn(), pfn_to_page_cgroup().
And, we don't access page_cgroup->page in fast path. (maybe)
But as I wrote, we're busy. I'll not do this until all performance fixes
go ahead.

Thanks,
-Kame
