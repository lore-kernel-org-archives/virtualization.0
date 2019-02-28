From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Thu, 28 Feb 2019 14:36:56 -0500
Message-ID: <20190228143511-mutt-send-email-mst__44970.4391461395$1551383329$gmane$org@kernel.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190228101356.39ac70aa@cakuba.netronome.com>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 28, 2019 at 10:13:56AM -0800, Jakub Kicinski wrote:
> On Wed, 27 Feb 2019 23:47:33 -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 27, 2019 at 05:52:18PM -0800, Jakub Kicinski wrote:
> > > > > Can the users who care about the naming put net_failover into
> > > > > "user space will do the bond enslavement" mode, and do the bond
> > > > > creation/management themselves from user space (in systemd/ 
> > > > > Network Manager) based on the failover flag?    
> > > > 
> > > > Putting issues of compatibility aside (userspace tends to be confused if
> > > > you give it two devices with same MAC), how would you have it work in
> > > > practice? Timer based hacks like netvsc where if userspace didn't
> > > > respond within X seconds we assume it won't and do everything ourselves?  
> > > 
> > > Well, what I'm saying is basically if user space knows how to deal with
> > > the auto-bonding, we can put aside net_failover for the most part.  It
> > > can either be blacklisted or it can have some knob which will
> > > effectively disable the auto-enslavement.  
> > 
> > OK I guess we could add a module parameter to skip this.
> > Is this what you mean?
> 
> Yup.
> 
> > > Auto-bonding capable user space can do the renames, spawn the bond,
> > > etc. all by itself.  I'm basically going back to my initial proposal
> > > here :)  There is a RedHat bugzilla for the NetworkManager team to do
> > > this, but we merged net_failover before those folks got around to
> > > implementing it.  
> > 
> > In particular because there's no policy involved whatsoever
> > here so it's just mechanism being pushed up to userspace.
> > 
> > > IOW if NM/systemd is capable of doing the auto-bonding itself it can
> > > disable the kernel mechanism and take care of it all.  If kernel is
> > > booted with an old user space which doesn't have capable NM/systemd -
> > > net_failover will kick in and do its best.  
> > 
> > Sure - it's just 2 lines of code, see below.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > But I don't intend to bother until there's actual interest from
> > userspace developers to bother. In particular it is not just NM/systemd
> > even on Fedora - e.g. you will need to teach dracut to somehow detect
> > and handle this - right now it gets confused if there are two devices
> > with same MAC addresses.
> 
> It is a bit of a the chicken or the egg situation ;)  But users can
> just blacklist, too.  Anyway, I think this is far better than module
> parameters

Sorry I'm a bit confused. What is better than what?

> for twiddling kernel-based interface naming policy.. :S

I see your point. But my point is slave names don't really matter, only
master name matters.  So I am not sure there's any policy worth talking
about here.

> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 955b3e76eb8d..dd2b2c370003 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -43,6 +43,7 @@ static bool csum = true, gso = true, napi_tx;
> >  module_param(csum, bool, 0444);
> >  module_param(gso, bool, 0444);
> >  module_param(napi_tx, bool, 0644);
> > +module_param(disable_failover, bool, 0644);
> >  
> >  /* FIXME: MTU in config. */
> >  #define GOOD_PACKET_LEN (ETH_HLEN + VLAN_HLEN + ETH_DATA_LEN)
> > @@ -3163,6 +3164,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >  	virtnet_init_settings(dev);
> >  
> > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY)) {
> > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY) &&
> > +		!disable_failover) {
> >  		vi->failover = net_failover_create(vi->dev);
> >  		if (IS_ERR(vi->failover)) {
> >  			err = PTR_ERR(vi->failover);
> > 
