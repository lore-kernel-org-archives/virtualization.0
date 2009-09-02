From: "KAMEZAWA Hiroyuki" <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: a room for blkio-cgroup in struct page_cgroup
Date: Wed, 2 Sep 2009 22:12:51 +0900 (JST)
Message-ID: <ff13736137802f78cf492d13c43c1af1.squirrel__12797.3307077356$1251897327$gmane$org@webmail-b.css.fujitsu.com>
References: <20090902.205137.71100180.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090902.205137.71100180.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, kamezawa.hiroyu@jp.fujitsu.com, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Ryo Tsuruta wrote:
> Hi Kamezawa-san,
>
> As you wrote before (http://lkml.org/lkml/2009/7/22/65)
>> To be honest, what I expected in these days for people of blockio
>> cgroup is like following for getting room for themselves.
> <<snip>>
>> --- mmotm-2.6.31-Jul16.orig/include/linux/page_cgroup.h
>> +++ mmotm-2.6.31-Jul16/include/linux/page_cgroup.h
>> @@ -13,7 +13,7 @@
>>  struct page_cgroup {
>>       unsigned long flags;
>>       struct mem_cgroup *mem_cgroup;
>> -     struct page *page;
>> +     /* block io tracking will use extra unsigned long bytes */
>>       struct list_head lru;       /* per cgroup LRU list */
>> };
>
> Have you already added a room for blkio_cgroup in struct page_cgroup?
No.

> If not, I would like you to apply the above change to mmotm.
>
Plz wait until October. We're deadly busy and some amount of more important
patches are piled up in front of us. I have no objections if you add
a pointer or id  because I know I can reduce 8(4)bytes later.
Just add (a small) member for a while and ignore page_cgroup's size.
I'll fix later.

> The latest blkio-cgroup has reflected the comments you pointed out.
> I would also like you to give me any comments on it and consider
> merging blkio-cgroup to mmotm.
>
BTW, do you all have cosensus about implementation ?

Bye,
-Kame
