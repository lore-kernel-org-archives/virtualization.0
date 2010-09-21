From: matt mooney <mfm@muteddisk.com>
Subject: Re: [PATCH 1/4] x86: remove cast from void*
Date: Tue, 21 Sep 2010 12:15:13 -0700
Message-ID: <20100921191513.GA15107@haskell.muteddisk.com>
References: <1284441511-11511-1-git-send-email-mfm@muteddisk.com>
	<4C98FBDB.6030601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4C98FBDB.6030601@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, x86@kernel.org, kernel-janitors@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ian Campbell <ian.campbell@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11:39 Tue 21 Sep     , Jeremy Fitzhardinge wrote:
>  On 09/13/2010 10:18 PM, matt mooney wrote:
> > Unnecessary cast from void* in assignment.
> >
> > Signed-off-by: matt mooney <mfm@muteddisk.com>
> > ---
> >  arch/x86/xen/mmu.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/x86/xen/mmu.c b/arch/x86/xen/mmu.c
> > index 42086ac..7436283 100644
> > --- a/arch/x86/xen/mmu.c
> > +++ b/arch/x86/xen/mmu.c
> > @@ -737,7 +737,7 @@ pgd_t *xen_get_user_pgd(pgd_t *pgd)
> >  
> >  	if (offset < pgd_index(USER_LIMIT)) {
> >  		struct page *page = virt_to_page(pgd_page);
> > -		user_ptr = (pgd_t *)page->private;
> > +		user_ptr = page->private;
> 
> Um, page->private is unsigned long anyway, so this is needed either way.
> 

You're right. I missed that one, sorry; I really thought I had verified it.

-mfm
