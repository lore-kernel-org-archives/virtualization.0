From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Thu, 28 Feb 2019 16:20:28 -0800
Message-ID: <CADGSJ239j-fG_vifkj-gTnAb_RXtBEbnQCFdZGimcgPXh35CMA__45147.8941527725$1551400504$gmane$org@mail.gmail.com>
References: <20190227173710-mutt-send-email-mst@kernel.org>
	<c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
	<20190227184601-mutt-send-email-mst@kernel.org>
	<a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
	<20190227193923-mutt-send-email-mst@kernel.org>
	<20190227165205.307ed83c@cakuba.netronome.com>
	<20190227201857-mutt-send-email-mst@kernel.org>
	<20190227175218.736e13b6@cakuba.netronome.com>
	<20190227233812-mutt-send-email-mst@kernel.org>
	<20190228101356.39ac70aa@cakuba.netronome.com>
	<20190228143511-mutt-send-email-mst@kernel.org>
	<20190228115641.7afe6f09@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190228115641.7afe6f09@cakuba.netronome.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jakub Kicinski <kubakici@wp.pl>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2019 at 11:56 AM Jakub Kicinski <kubakici@wp.pl> wrote:
>
> On Thu, 28 Feb 2019 14:36:56 -0500, Michael S. Tsirkin wrote:
> > > It is a bit of a the chicken or the egg situation ;)  But users can
> > > just blacklist, too.  Anyway, I think this is far better than module
> > > parameters
> >
> > Sorry I'm a bit confused. What is better than what?
>
> I mean that blacklist net_failover or module param to disable
> net_failover and handle in user space are better than trying to solve
> the renaming at kernel level (either by adding module params that make
> the kernel rename devices or letting user space change names of running
> devices if they are slaves).

Before I was aksed to revive this old mail thread, I knew the
discussion could end up with something like this. Yes, theoretically
there's a point - basically you don't believe kernel should take risk
in fixing the issue, so you push back the hope to something in
hypothesis that actually wasn't done and hard to get done in reality.
It's not too different than saying "hey, what you're asking for is
simply wrong, don't do it! Go back to modify userspace to create a
bond or team instead!" FWIW I want to emphasize that the debate for
what should be the right place to implement this failover facility:
userspace versus kernel, had been around for almost a decade, and no
real work ever happened in userspace to "standardize" this in the
Linux world.  The truth is that it's quite amount of complex work to
get it implemented right at userspace in reality: what Michael
mentions about making dracut auto-bonding aware is just tip of the
iceberg. Basically one would need to modify all the existing network
config tools to treat them well with this new auto-bonding concept:
handle duplicate MACs, differentiate it with regular bond/team, fix
boot time dependency of network boot and etc. Moreover, it's not a
single distro's effort from cloud provider's perspective, at least not
as simple as to say just move it to a daemon systemd/NM then work is
done. We (Oracle) had done extensive work in the past year to help
align various userspace components and work with distro vendors to
patch shipped packages to make them work with the failover 3-netdev
model. The work that needs to be done with userspace auto-bonding
would be more involved than just that, with quite trivial value (just
naming?) in turn that I suspect any developer in userspace could be
motivated.

So, simply put, no, we have zero interest in this direction. If
upstream believes this is the final conclusion, I think we can stop
discussing.

Thanks,
-Siwei
>
> > > for twiddling kernel-based interface naming policy.. :S
> >
> > I see your point. But my point is slave names don't really matter, only
> > master name matters.  So I am not sure there's any policy worth talking
> > about here.
>
> Oh yes, I don't disagree with you, but others seems to want to rename
> the auto-bonded lower devices.  Which can be done trivially if it was
> a daemon in user space instantiating the auto-bond.  We are just
> providing a basic version of auto-bonding in the kernel.  If there are
> extra requirements on policy, or naming - the whole thing is better
> solved in user space.
