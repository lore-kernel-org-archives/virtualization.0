From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH] vhost, mm: make sure that oom_reaper doesn't reap
	memory read by vhost
Date: Sun, 19 Jun 2016 23:52:58 +0200
Message-ID: <20160619215258.GA2110__2400.89042713425$1466373206$gmane$org@dhcp22.suse.cz>
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

Found it
http://lkml.kernel.org/r/1440776707-22016-1-git-send-email-mst@redhat.com
-- 
Michal Hocko
SUSE Labs
