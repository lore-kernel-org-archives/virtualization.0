From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv6 1/3] tun: export underlying socket
Date: Wed, 4 Nov 2009 19:09:05 +0100
Message-ID: <200911041909.06054.arnd__46121.9601486393$1257358328$gmane$org@arndb.de>
References: <cover.1257193660.git.mst@redhat.com>
	<20091102222612.GB15184@redhat.com>
	<200911031312.33580.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200911031312.33580.arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, s.hetze@linux-ag.com, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 03 November 2009, Arnd Bergmann wrote:
> > index 3f5fd52..404abe0 100644
> > --- a/include/linux/if_tun.h
> > +++ b/include/linux/if_tun.h
> > @@ -86,4 +86,18 @@ struct tun_filter {
> >         __u8   addr[0][ETH_ALEN];
> >  };
> >  
> > +#ifdef __KERNEL__
> > +#if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
> > +struct socket *tun_get_socket(struct file *);
> > +#else
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +struct file;
> > +struct socket;
> > +static inline struct socket *tun_get_socket(struct file *f)
> > +{
> > +       return ERR_PTR(-EINVAL);
> > +}
> > +#endif /* CONFIG_TUN */
> > +#endif /* __KERNEL__ */
> >  #endif /* __IF_TUN_H */
> 
> Is this a leftover from testing? Exporting the function for !__KERNEL__
> seems pointless.
> 

Michael, you didn't reply on this comment and the code is still there in v8.
Do you actually need this? What for?

	Arnd <><
