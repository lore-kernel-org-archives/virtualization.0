Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D652F3E
	for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245093; cv=none; b=BDydS5lNykgADEYaCeiMmWrPYMUKRMOCL/JkGlmRi276mrvHn9MTHpnJEkZfhPK0pnkHllYtE6xAmBjIKrpvDQtmCp8vxAmYd32zZQgrOQYhw3lYwjRytNrRmWnkkHXUBlN05cY5Vg/q73KUrE2wwiEF3U+vAh9br1cLlynh7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245093; c=relaxed/simple;
	bh=D24S1QGo63Mvn+RPZq3ItemdRDY0yJs6VmQvMVfkjw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcmJIl0U53X0jsoQ2FTopE26OgjAmR9n7SmhZ+DyrwfiOqjSwfJlIANgpVv6C63QeKrrraNervbAcm2cBNIF9pJIFKwyqQXSbJCaRGtmTW2nWiTR7Yvi7NYnHpu5X9jV+8xEnT0UYbLc6gOIAamlBntCSxovV/ZsEQDNCj5/o5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bfsxtR1A; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bfsxtR1A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751245087; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=KE5Ke26crJ20g62CV0eTsdMDqmR58zlWRKiqOi/7eNA=;
	b=bfsxtR1AAfOKqYOrvQVGYxG0YVleoAzk7/lJiXzM5h8oSC+324K3CMCWgF2TWA+mYdU1K1/3pHe5C8S1Sa9F/e7Pw55LztCDyxQpobelHMr2wNuTFHPUuwM2ayS8M+6K+A6t1a63q8bLdUChU3RSYhDBUTX50+J1Y3W8OsL66XU=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wg25R9f_1751245082 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 08:58:04 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>,  Zi Yan <ziy@nvidia.com>,  Matthew
 Wilcox <willy@infradead.org>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-doc@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  virtualization@lists.linux.dev,
  linux-fsdevel@vger.kernel.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Corbet <corbet@lwn.net>,  Madhavan
 Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman <mpe@ellerman.id.au>,
  Nicholas Piggin <npiggin@gmail.com>,  Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>,  Arnd Bergmann <arnd@arndb.de>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matthew Brost
 <matthew.brost@intel.com>,  Joshua Hahn <joshua.hahnjy@gmail.com>,  Rakie
 Kim <rakie.kim@sk.com>,  Byungchul Park <byungchul@sk.com>,  Gregory Price
 <gourry@gourry.net>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  "Liam
 R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,
  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  Michal Hocko <mhocko@suse.com>,  Minchan Kim <minchan@kernel.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,  Brendan Jackman
 <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  John Hubbard <jhubbard@nvidia.com>,  Peter Xu
 <peterx@redhat.com>,  Xu Xin <xu.xin16@zte.com.cn>,  Chengming Zhou
 <chengming.zhou@linux.dev>,  Miaohe Lin <linmiaohe@huawei.com>,  Naoya
 Horiguchi <nao.horiguchi@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Rik van Riel <riel@surriel.com>,  Harry Yoo <harry.yoo@oracle.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 07/29] mm/migrate: rename isolate_movable_page() to
 isolate_movable_ops_page()
In-Reply-To: <nr4e7unt2dtfav5y5ckmsrehu37xejqonarlulzcn6mnhnnvxl@o3ppo34wqyyj>
	(Alistair Popple's message of "Mon, 30 Jun 2025 10:20:56 +1000")
References: <20250618174014.1168640-1-david@redhat.com>
	<20250618174014.1168640-8-david@redhat.com>
	<9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
	<aFMH0TmoPylhkSjZ@casper.infradead.org>
	<4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
	<bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
	<87h5zyrdl9.fsf@DESKTOP-5N7EMDA>
	<nr4e7unt2dtfav5y5ckmsrehu37xejqonarlulzcn6mnhnnvxl@o3ppo34wqyyj>
Date: Mon, 30 Jun 2025 08:58:03 +0800
Message-ID: <878qlaqc4k.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alistair Popple <apopple@nvidia.com> writes:

> On Sun, Jun 29, 2025 at 07:28:50PM +0800, Huang, Ying wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>> > On 18.06.25 20:48, Zi Yan wrote:
>> >> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
>> >> 
>> >>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>> >>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>> >>>>
>> >>>>> ... and start moving back to per-page things that will absolutely not be
>> >>>>> folio things in the future. Add documentation and a comment that the
>> >>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>> >>>>>
>> >>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>> >>>>> it gracefully (relevant with further changes), and convert a
>> >>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>> >>>>
>> >>>> The reason is that there is no upstream code, which use movable_ops for
>> >>>> folios? Is there any fundamental reason preventing movable_ops from
>> >>>> being used on folios?
>> >>>
>> >>> folios either belong to a filesystem or they are anonymous memory, and
>> >>> so either the filesystem knows how to migrate them (through its a_ops)
>> >>> or the migration code knows how to handle anon folios directly.
>> >
>> > Right, migration of folios will be handled by migration core.
>> >
>> >> for device private pages, to support migrating >0 order anon or fs
>> >> folios
>> >> to device, how should we represent them for devices? if you think folio is
>> >> only for anon and fs.
>> >
>> > I assume they are proper folios, so yes. Just like they are handled
>> > today (-> folios)
>
> Yes, they should be proper folios.

So, folios include file cache, anonymous, and some device private.

>> > I was asking a related question at LSF/MM in Alistair's session: are
>> > we sure these things will be folios even before they are assigned to a
>> > filesystem? I recall the answer was "yes".
>> >
>> > So we don't (and will not) support movable_ops for folios.
>> 
>> Is it possible to use some device specific callbacks (DMA?) to copy
>> from/to the device private folios (or pages) to/from the normal
>> file/anon folios in the future?
>
> I guess we could put such callbacks on the folio->pgmap, but I'm not sure why
> we would want to. Currently all migration to/from device private (or coherent)
> folios is managed by the device, which is one of the features of ZONE_DEVICE.

Yes.  The is the current behavior per my understanding too.

> Did you have some particular reason/idea for why we might want to do this?

No.  Just want to check whether there are some requirements for that.  I
think that it's just another way to organize code.

---
Best Regards,
Huang, Ying
