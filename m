From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv6 1/3] tun: export underlying socket
Date: Wed, 4 Nov 2009 21:05:23 +0200
Message-ID: <20091104190523.GA772__22050.5959507593$1257361890$gmane$org@redhat.com>
References: <cover.1257193660.git.mst@redhat.com>
	<20091102222612.GB15184@redhat.com>
	<200911031312.33580.arnd@arndb.de>
	<200911041909.06054.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200911041909.06054.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 07:09:05PM +0100, Arnd Bergmann wrote:
> On Tuesday 03 November 2009, Arnd Bergmann wrote:
> > > index 3f5fd52..404abe0 100644
> > > --- a/include/linux/if_tun.h
> > > +++ b/include/linux/if_tun.h
> > > @@ -86,4 +86,18 @@ struct tun_filter {
> > >         __u8   addr[0][ETH_ALEN];
> > >  };
> > >  
> > > +#ifdef __KERNEL__
> > > +#if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
> > > +struct socket *tun_get_socket(struct file *);
> > > +#else
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +struct file;
> > > +struct socket;
> > > +static inline struct socket *tun_get_socket(struct file *f)
> > > +{
> > > +       return ERR_PTR(-EINVAL);
> > > +}
> > > +#endif /* CONFIG_TUN */
> > > +#endif /* __KERNEL__ */
> > >  #endif /* __IF_TUN_H */
> > 
> > Is this a leftover from testing? Exporting the function for !__KERNEL__
> > seems pointless.
> > 
> 
> Michael, you didn't reply on this comment and the code is still there in v8.
> Do you actually need this? What for?
> 
> 	Arnd <><

Sorry, missed the question. If you look closely it is not exported for
!__KERNEL__ at all.  The stub is for when CONFIG_TUN is undefined.
Maybe I'll add a comment near #else, even though this is a bit strange
since the #if is just 2 lines above it.

-- 
MST
