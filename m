From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Thu, 28 Feb 2019 17:05:20 -0800
Message-ID: <20190228170520.527ed6df__17318.5425273672$1551403067$gmane$org@cakuba.netronome.com>
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
	<CADGSJ239j-fG_vifkj-gTnAb_RXtBEbnQCFdZGimcgPXh35CMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADGSJ239j-fG_vifkj-gTnAb_RXtBEbnQCFdZGimcgPXh35CMA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, Jiri Pirko <jiri@resnulli.us>, "Michael S. Tsirkin" <mst@redhat.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 28 Feb 2019 16:20:28 -0800, Siwei Liu wrote:
> On Thu, Feb 28, 2019 at 11:56 AM Jakub Kicinski wrote:
> > On Thu, 28 Feb 2019 14:36:56 -0500, Michael S. Tsirkin wrote:  
> > > > It is a bit of a the chicken or the egg situation ;)  But users can
> > > > just blacklist, too.  Anyway, I think this is far better than module
> > > > parameters  
> > >
> > > Sorry I'm a bit confused. What is better than what?  
> >
> > I mean that blacklist net_failover or module param to disable
> > net_failover and handle in user space are better than trying to solve
> > the renaming at kernel level (either by adding module params that make
> > the kernel rename devices or letting user space change names of running
> > devices if they are slaves).  
> 
> Before I was aksed to revive this old mail thread, I knew the
> discussion could end up with something like this. Yes, theoretically
> there's a point - basically you don't believe kernel should take risk
> in fixing the issue, so you push back the hope to something in
> hypothesis that actually wasn't done and hard to get done in reality.
> It's not too different than saying "hey, what you're asking for is
> simply wrong, don't do it! Go back to modify userspace to create a
> bond or team instead!" FWIW I want to emphasize that the debate for
> what should be the right place to implement this failover facility:
> userspace versus kernel, had been around for almost a decade, and no
> real work ever happened in userspace to "standardize" this in the
> Linux world.

Let me offer you my very subjective opinion of why "no real work ever
happened in user space".  The actors who have primary interest to get
the auto-bonding working are HW vendors trying to either convince
customers to use SR-IOV, or being pressured by customers to make SR-IOV
easier to consume.  HW vendors hire driver developers, not user space
developers.  So the solution we arrive at is in the kernel for a non
technical reason (Conway's law, sort of).

$ cd NetworkManager/
$ git log --pretty=format:"%ae" | \
    grep '\(mellanox\|intel\|broadcom\|netronome\)' | sort | uniq -c
     81 andrew.zaborowski@intel.com
      2 David.Woodhouse@intel.com
      2 ismo.puustinen@intel.com
      1 michael.i.doherty@intel.com

Andrew works on WiFi.

I have asked the NetworkManager folks to implement this feature last
year when net_failover got dangerously close to getting merged, and
they said they were never approached with this request before, much less
offered code that solve it.  Unfortunately before they got around to it
net_failover was merged already, and they didn't proceed.  

So to my knowledge nobody ever tried to solve this in user space.
I don't think net_failover is particularly terrible, or that renaming
of primary in the kernel is the end of the world, but I'd appreciate if
you could point me to efforts to solve it upstream in user space
components, or acknowledge that nobody actually tried that.
