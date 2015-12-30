From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 08/34] asm-generic: smp_store_mb should use smp_mb
Date: Wed, 30 Dec 2015 22:30:38 +0200
Message-ID: <20151230222703-mutt-send-email-mst__25992.1598517851$1451507458$gmane$org@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
	<1451473761-30019-9-git-send-email-mst@redhat.com>
	<5946017.BCmPrpGMuh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5946017.BCmPrpGMuh@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Dec 30, 2015 at 02:44:21PM +0100, Arnd Bergmann wrote:
> On Wednesday 30 December 2015 15:24:47 Michael S. Tsirkin wrote:
> > asm-generic variant of smp_store_mb() calls mb() which is stronger
> > than implied by both the name and the documentation.
> > 
> > smp_store_mb is only used by core kernel code at the moment, so
> > we know no one mis-uses it for an MMIO barrier.
> > Make it call smp_mb consistently before some arch-specific
> > code uses it as such by mistake.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/asm-generic/barrier.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index 538f8d1..987b2e0 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -93,7 +93,7 @@
> >  #endif	/* CONFIG_SMP */
> >  
> >  #ifndef smp_store_mb
> > -#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); mb(); } while (0)
> > +#define smp_store_mb(var, value)  do { WRITE_ONCE(var, value); smp_mb(); } while (0)
> >  #endif
> >  
> >  #ifndef smp_mb__before_atomic
> > 
> 
> The same patch is already in the tip tree scheduled for 4.5 as d5a73cadf3fd
> ("lcoking/barriers, arch: Use smp barriers in smp_store_release()").

Sorry which tree do you mean exactly?

> I think you can drop your version.
> 
> 	arnd

Will drop mine, thanks.
I kind of dislike that if I just drop it, some arches will temporarily
regress to a slower implementation.
I think I can just cherry-pick d5a73cadf3fd into my tree: git
normally figures such duplicates out nicely.
Does this sound good?

-- 
MST
