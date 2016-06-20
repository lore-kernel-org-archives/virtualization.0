From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH] vhost, mm: make sure that oom_reaper doesn't reap
	memory read by vhost
Date: Mon, 20 Jun 2016 11:35:05 +0200
Message-ID: <20160620093505.GA4601@dhcp22.suse.cz>
References: <1466154017-2222-1-git-send-email-mhocko@kernel.org>
	<20160618025904-mutt-send-email-mst@redhat.com>
	<20160619213543.GA32752@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160619213543.GA32752@dhcp22.suse.cz>
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
Cc: Vladimir Davydov <vdavydov@parallels.com>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtualization@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun 19-06-16 23:35:43, Michal Hocko wrote:
> On Sat 18-06-16 03:09:02, Michael S. Tsirkin wrote:
> > On Fri, Jun 17, 2016 at 11:00:17AM +0200, Michal Hocko wrote:
[...]
> > > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > > index 349557825428..b1f314fca3c8 100644
> > > --- a/include/linux/uaccess.h
> > > +++ b/include/linux/uaccess.h
> > > @@ -76,6 +76,28 @@ static inline unsigned long __copy_from_user_nocache(void *to,
> > >  #endif		/* ARCH_HAS_NOCACHE_UACCESS */
> > >  
> > >  /*
> > > + * A safe variant of __get_user for for use_mm() users to have a
> > > + * gurantee that the address space wasn't reaped in the background
> > > + */
> > > +#define __get_user_mm(mm, x, ptr)				\
> > > +({								\
> > > +	int ___gu_err = __get_user(x, ptr);			\
> > > +	if (!___gu_err && test_bit(MMF_UNSTABLE, &mm->flags))	\
> > 
> > test_bit is somewhat expensive. See my old mail
> > 	x86/bitops: implement __test_bit
> 
> Do you have a msg_id?
> 
> > I dropped it as virtio just switched to simple &/| for features,
> > but we might need something like this now.
> 
> Is this such a hot path that something like this would make a visible
> difference? 

OK, so I've tried to apply your patch [1] and updated both __get_user_mm
and __copy_from_user_mm and the result is a code size reduction:
   text    data     bss     dec     hex filename
  12835       2      32   12869    3245 drivers/vhost/vhost.o
  12882       2      32   12916    3274 drivers/vhost/vhost.o.before

This is really tiny and I cannot tell anything about the performance. Should
I resurrect your patch and push it together with this change or this can happen
later?

[1] http://lkml.kernel.org/r/1440776707-22016-1-git-send-email-mst@redhat.com
-- 
Michal Hocko
SUSE Labs
