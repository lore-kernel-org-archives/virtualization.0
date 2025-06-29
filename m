Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BA1FAC34
	for <virtualization@lists.linux.dev>; Sun, 29 Jun 2025 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751196876; cv=none; b=SPxYxOec2DoMpCx8VPup5hdx2QGAMoZBj92pVBypOrctL3WhYWb/Z+SY7hLIHUZOA4HLFYGomou3wW0kqOEct7JuBZyWM6HfSp+suROwSAGGJScYo4d0197jgszRBM6ybBLkphX8+iGfpsgAr40XBMDRAc/APlYmBdjrNYK/UOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751196876; c=relaxed/simple;
	bh=Mp0ZQrvSfkXHIaP5jgz7YayUIfi2aH+uu2FQFAw4D1I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNkMTLSdNLEK/HNsaUeWpnh9LWd9QENq9BKTdXh5eqsaCIIQ9k+5ffvps4TQ0ybqu3qum4whV5Cz7tc1nOtAtDcz1GRQsQRdEoe5Wm0puimPxxA/Pis0pjIy5ODYAyCyqOxXvOCspYa7fqgZnYaYcseBpZaUVIuo9KILgPuQbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OK0NttVT; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OK0NttVT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751196865; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=Td91IaRHPLMg0S4S34rjLSxSTe+KTe00bq2/ozJgwkc=;
	b=OK0NttVT26Gn1b0j7afvKJEnOza3KImKsGkrCY96xlqOcEhcf1IjrojhWJ3Wdo12Hgaq/xOWVtbOIpNUicWY40SLrKUg3A6mbraylacXxwhMGnJVZ8QLtVBgJ/bUqGGcT9SqxC8MmL78JLnvowUM8pElk5IDk90o/BFDOWGwXz8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WfwyPTY_1751196530 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 29 Jun 2025 19:29:05 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>
Cc: Matthew Wilcox <willy@infradead.org>,  linux-kernel@vger.kernel.org,
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
 <gourry@gourry.net>,  Alistair Popple <apopple@nvidia.com>,  Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,  "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  Vlastimil Babka <vbabka@suse.cz>,  Mike
 Rapoport <rppt@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
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
In-Reply-To: <bef13481-5218-4732-831d-fe22d95184c1@redhat.com> (David
	Hildenbrand's message of "Mon, 23 Jun 2025 17:33:15 +0200")
References: <20250618174014.1168640-1-david@redhat.com>
	<20250618174014.1168640-8-david@redhat.com>
	<9F76592E-BB0E-4136-BDBA-195CC6FF3B03@nvidia.com>
	<aFMH0TmoPylhkSjZ@casper.infradead.org>
	<4D6D7321-CAEC-4D82-9354-4B9786C4D05E@nvidia.com>
	<bef13481-5218-4732-831d-fe22d95184c1@redhat.com>
Date: Sun, 29 Jun 2025 19:28:50 +0800
Message-ID: <87h5zyrdl9.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 18.06.25 20:48, Zi Yan wrote:
>> On 18 Jun 2025, at 14:39, Matthew Wilcox wrote:
>> 
>>> On Wed, Jun 18, 2025 at 02:14:15PM -0400, Zi Yan wrote:
>>>> On 18 Jun 2025, at 13:39, David Hildenbrand wrote:
>>>>
>>>>> ... and start moving back to per-page things that will absolutely not be
>>>>> folio things in the future. Add documentation and a comment that the
>>>>> remaining folio stuff (lock, refcount) will have to be reworked as well.
>>>>>
>>>>> While at it, convert the VM_BUG_ON() into a WARN_ON_ONCE() and handle
>>>>> it gracefully (relevant with further changes), and convert a
>>>>> WARN_ON_ONCE() into a VM_WARN_ON_ONCE_PAGE().
>>>>
>>>> The reason is that there is no upstream code, which use movable_ops for
>>>> folios? Is there any fundamental reason preventing movable_ops from
>>>> being used on folios?
>>>
>>> folios either belong to a filesystem or they are anonymous memory, and
>>> so either the filesystem knows how to migrate them (through its a_ops)
>>> or the migration code knows how to handle anon folios directly.
>
> Right, migration of folios will be handled by migration core.
>
>> for device private pages, to support migrating >0 order anon or fs
>> folios
>> to device, how should we represent them for devices? if you think folio is
>> only for anon and fs.
>
> I assume they are proper folios, so yes. Just like they are handled
> today (-> folios)
>
> I was asking a related question at LSF/MM in Alistair's session: are
> we sure these things will be folios even before they are assigned to a
> filesystem? I recall the answer was "yes".
>
> So we don't (and will not) support movable_ops for folios.

Is it possible to use some device specific callbacks (DMA?) to copy
from/to the device private folios (or pages) to/from the normal
file/anon folios in the future?

---
Best Regards,
Huang, Ying
