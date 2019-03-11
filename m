From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH V2 5/5] vhost: access vq metadata through kernel
	virtual address
Date: Mon, 11 Mar 2019 09:43:05 -0400
Message-ID: <20190311134305.GC23321__24444.9190724239$1552311809$gmane$org@redhat.com>
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com>
	<1551856692-3384-6-git-send-email-jasowang@redhat.com>
	<20190307103503-mutt-send-email-mst@kernel.org>
	<20190307124700-mutt-send-email-mst@kernel.org>
	<20190307191622.GP23850@redhat.com>
	<e2fad6ed-9257-b53c-394b-bc913fc444c0@redhat.com>
	<20190308194845.GC26923@redhat.com>
	<8b68a2a0-907a-15f5-a07f-fc5b53d7ea19@redhat.com>
	<20190311084525-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190311084525-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2019 at 08:48:37AM -0400, Michael S. Tsirkin wrote:
> Using copyXuser is better I guess.

It certainly would be faster there, but I don't think it's needed if
that would be the only use case left that justifies supporting two
different models. On small 32bit systems with little RAM kmap won't
perform measurably different on 32bit or 64bit systems. If the 32bit
host has a lot of ram it all gets slow anyway at accessing RAM above
the direct mapping, if compared to 64bit host kernels, it's not just
an issue for vhost + mmu notifier + kmap and the best way to optimize
things is to run 64bit host kernels.

Like Christoph pointed out, the main use case for retaining the
copy-user model would be CPUs with virtually indexed not physically
tagged data caches (they'll still suffer from the spectre-v1 fix,
although I exclude they have to suffer the SMAP
slowdown/feature). Those may require some additional flushing than the
current copy-user model requires.

As a rule of thumb any arch where copy_user_page doesn't define as
copy_page will require some additional cache flushing after the
kmap. Supposedly with vmap, the vmap layer should have taken care of
that (I didn't verify that yet).

There are some accessories like copy_to_user_page()
copy_from_user_page() that could work and obviously defines to raw
memcpy on x86 (the main cons is they don't provide word granular
access) and at least on sparc they're tailored to ptrace assumptions
so then we'd need to evaluate what happens if this is used outside of
ptrace context. kmap has been used generally either to access whole
pages (i.e. copy_user_page), so ptrace may actually be the only use
case with subpage granularity access.

#define copy_to_user_page(vma, page, vaddr, dst, src, len)		\
	do {								\
		flush_cache_page(vma, vaddr, page_to_pfn(page));	\
		memcpy(dst, src, len);					\
		flush_ptrace_access(vma, page, vaddr, src, len, 0);	\
	} while (0)

So I wouldn't rule out the need for a dual model, until we solve how
to run this stable on non-x86 arches with not physically tagged
caches.

Thanks,
Andrea
