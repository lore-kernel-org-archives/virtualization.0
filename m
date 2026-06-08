Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D834751E;
	Mon,  8 Jun 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935608; cv=none; b=Xgu9T91MLvUVHcBJaZcLH4GDVxlV9tQhaxE+NG4mP1MXZ8/vXAgPYXXW6V9E5lf39R3JV+cgKzsBiV35+ghkPhiwziNvt49ZoUioZ6YzRFpDiduh5BZgbAd2G+2N343PNw7Hu0VLC2W81AIgDvy3eUQ6h9fZvtx9u9pPnAhsJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935608; c=relaxed/simple;
	bh=KKo0yTt8QCRKgLx+2oHKr58zk2ZfkKqMPDGgMsnCt+Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XU5/fmmXf6HKTTj6kncN2CFVPhGEmIbOdJA2isObsGe7uLIStBK/OpDfhafy7ka/vV+XSbJMFLRJQThMl8MAw8dOAAhbgxy3yRuSjmQy32cv/2qO05/pnX5+bGzwKiJ6Tg3HW5ZDlWWMdFg2kOl7ONgfPFOujb65BaKhazcILqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=guePbd+7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="guePbd+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E541F00893;
	Mon,  8 Jun 2026 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780935605;
	bh=IA47/0wWSH5Jb2nhwGgbeCpI7lm8FtH32SntL7z1fRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=guePbd+7dxvB3aFnn5nzcbye95yA/1gvUCdASLX4UMyA8zMCwxM4J9HSpZ1AO5YwI
	 IHvtuALaBhDNDBLTMtfkTpzTURKFnV5LDJJwrdq1jg5G+qFmd9uCV5WC1X4nzCP46h
	 XBlAa6lB9sOaZwRmz/KeRjSjSmhLM1R5wcoPoqP8=
Date: Mon, 8 Jun 2026 09:20:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
 "David Hildenbrand (Arm)" <david@kernel.org>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lance Yang
 <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, Matthew Brost
 <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim
 <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, Gregory Price
 <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, Alistair
 Popple <apopple@nvidia.com>, Christoph Lameter <cl@gentwo.org>, David
 Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Harry Yoo <harry.yoo@oracle.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Chris Li <chrisl@kernel.org>, Kairui Song
 <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
 <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 virtualization@lists.linux.dev, linux-mm@kvack.org, Andrea Arcangeli
 <aarcange@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v10 02/37] mm: memory-failure: serialize
 TestSetPageHWPoison with zone->lock
Message-Id: <20260608092003.79da896c536a767ee6c2e495@linux-foundation.org>
In-Reply-To: <20260608094153-mutt-send-email-mst@kernel.org>
References: <cover.1780906288.git.mst@redhat.com>
	<df06b66fe4ff8e925ee0714955abc2183a727b90.1780906288.git.mst@redhat.com>
	<aiaOZoa2vSCz_0wY@lucifer>
	<20260608094153-mutt-send-email-mst@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 09:48:34 -0400 "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > These patches seem like unrelated fixups that you've discovered along the way,
> > and don't belong as part of the already rather large series, unless I'm missing
> > something here.
> > 
> > Thanks, Lorenzo
> 
> I think you are mising that they are a dependency, not unrelated.
> For example, this issue gets worse with the patchset as there are more
> places that manipulate flags without atomics. No?
> 
> 
> You are welcome to send this to stable, but I think stable rules
> preclude theoretical bugfixes.

I agree with Lorenzo, please - let's have fixes separated out.  After
all, the rest of the series might never be merged (sorry, it happens).

Whether each fix gets a cc:stable is TBD, case-by-case - it depends on
the expected userspace impact.

