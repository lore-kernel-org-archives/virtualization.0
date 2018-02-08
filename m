From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v27 3/4] mm/page_poison: expose page_poisoning_enabled to
	kernel modules
Date: Thu, 8 Feb 2018 05:04:43 +0200
Message-ID: <20180208050337-mutt-send-email-mst__18643.1898539469$1518059004$gmane$org@kernel.org>
References: <1517986471-15185-1-git-send-email-wei.w.wang@intel.com>
	<1517986471-15185-4-git-send-email-wei.w.wang@intel.com>
	<20180207203004-mutt-send-email-mst@kernel.org>
	<5A7BAB7D.7070805@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5A7BAB7D.7070805@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: yang.zhang.wz@gmail.com, virtio-dev@lists.oasis-open.org, riel@redhat.com, quan.xu0@gmail.com, kvm@vger.kernel.org, nilal@redhat.com, liliang.opensource@gmail.com, linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org, huangzhichao@huawei.com, pbonzini@redhat.com, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 08, 2018 at 09:44:29AM +0800, Wei Wang wrote:
> On 02/08/2018 02:34 AM, Michael S. Tsirkin wrote:
> > On Wed, Feb 07, 2018 at 02:54:30PM +0800, Wei Wang wrote:
> > > In some usages, e.g. virtio-balloon, a kernel module needs to know if
> > > page poisoning is in use. This patch exposes the page_poisoning_enabled
> > > function to kernel modules.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Michal Hocko <mhocko@kernel.org>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   mm/page_poison.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/mm/page_poison.c b/mm/page_poison.c
> > > index e83fd44..c08d02a 100644
> > > --- a/mm/page_poison.c
> > > +++ b/mm/page_poison.c
> > > @@ -30,6 +30,11 @@ bool page_poisoning_enabled(void)
> > >   		debug_pagealloc_enabled()));
> > >   }
> > > +/**
> > > + * page_poisoning_enabled - check if page poisoning is enabled
> > > + *
> > > + * Return true if page poisoning is enabled, or false if not.
> > > + */
> > >   static void poison_page(struct page *page)
> > >   {
> > >   	void *addr = kmap_atomic(page);
> > > @@ -37,6 +42,7 @@ static void poison_page(struct page *page)
> > >   	memset(addr, PAGE_POISON, PAGE_SIZE);
> > >   	kunmap_atomic(addr);
> > >   }
> > > +EXPORT_SYMBOL_GPL(page_poisoning_enabled);
> > >   static void poison_pages(struct page *page, int n)
> > >   {
> > Looks like both the comment and the export are in the wrong place.
> 
> Thanks. Will be more careful.
> 
> > I'm a bit concerned that callers also in fact poke at the
> > PAGE_POISON - exporting that seems to be more of an accident
> > as it's only used without page_poisoning.c - it might be
> > better to have page_poisoning_enabled get u8 * and set it.
> > 
> 
> PAGE_POISON is a macro defined in the header, why would callers using it be
> a concern?


It might be a good idea to move it out of there though.

> Do you suggest to have:
> 
> bool page_poisoning_get(u8 *val)
> {
>     if (page_poisoning_enabled()) {
>         *val = PAGE_POISON;
>         return true;
>     }
> 
>     return false;
> }
> EXPORT_SYMBOL_GPL(page_poisoning_get);
> 
> 
> Best,
> Wei

Something like this, yes.

-- 
MST
