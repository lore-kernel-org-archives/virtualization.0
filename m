From: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: a room for blkio-cgroup in struct page_cgroup
Date: Thu, 3 Sep 2009 01:32:24 +0530
Message-ID: <661de9470909021302ge86d01s5d107dc2b5cffbc5__44391.7658682496$1251922021$gmane$org@mail.gmail.com>
References: <20090902.205137.71100180.ryov@valinux.co.jp>
	<ff13736137802f78cf492d13c43c1af1.squirrel@webmail-b.css.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <ff13736137802f78cf492d13c43c1af1.squirrel@webmail-b.css.fujitsu.com>
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
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

2009/9/2 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>:
> Ryo Tsuruta wrote:
>> Hi Kamezawa-san,
>>
>> As you wrote before (http://lkml.org/lkml/2009/7/22/65)
>>> To be honest, what I expected in these days for people of blockio
>>> cgroup is like following for getting room for themselves.
>> <<snip>>
>>> --- mmotm-2.6.31-Jul16.orig/include/linux/page_cgroup.h
>>> +++ mmotm-2.6.31-Jul16/include/linux/page_cgroup.h
>>> @@ -13,7 +13,7 @@
>>> =A0struct page_cgroup {
>>> =A0 =A0 =A0 unsigned long flags;
>>> =A0 =A0 =A0 struct mem_cgroup *mem_cgroup;
>>> - =A0 =A0 struct page *page;
>>> + =A0 =A0 /* block io tracking will use extra unsigned long bytes */
>>> =A0 =A0 =A0 struct list_head lru; =A0 =A0 =A0 /* per cgroup LRU list */
>>> };
>>
>> Have you already added a room for blkio_cgroup in struct page_cgroup?
> No.
>

The diff above is unclear, are you removing struct page from page_cgroup?

Balbir Singh
