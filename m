From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Wed, 27 Feb 2019 17:52:18 -0800
Message-ID: <20190227175218.736e13b6__45805.0692033552$1551319234$gmane$org@cakuba.netronome.com>
References: <20190222100753-mutt-send-email-mst@kernel.org>
	<e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
	<20190225210529-mutt-send-email-mst@kernel.org>
	<d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
	<20190227173710-mutt-send-email-mst@kernel.org>
	<c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
	<20190227184601-mutt-send-email-mst@kernel.org>
	<a617ce13-4114-469d-ef33-a1c91150eeca@oracle.com>
	<20190227193923-mutt-send-email-mst@kernel.org>
	<20190227165205.307ed83c@cakuba.netronome.com>
	<20190227201857-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190227201857-mutt-send-email-mst@kernel.org>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 27 Feb 2019 20:26:02 -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 27, 2019 at 04:52:05PM -0800, Jakub Kicinski wrote:
> > On Wed, 27 Feb 2019 19:41:32 -0500, Michael S. Tsirkin wrote:  
> > > > As this scheme adds much complexity to the kernel naming convention
> > > > (currently it's just ethX names) that no userspace can understand.    
> > > 
> > > Anything that pokes at slaves needs to be specially designed anyway.
> > > Naming seems like a minor issue.  
> > 
> > Can the users who care about the naming put net_failover into
> > "user space will do the bond enslavement" mode, and do the bond
> > creation/management themselves from user space (in systemd/ 
> > Network Manager) based on the failover flag?  
> 
> Putting issues of compatibility aside (userspace tends to be confused if
> you give it two devices with same MAC), how would you have it work in
> practice? Timer based hacks like netvsc where if userspace didn't
> respond within X seconds we assume it won't and do everything ourselves?

Well, what I'm saying is basically if user space knows how to deal with
the auto-bonding, we can put aside net_failover for the most part.  It
can either be blacklisted or it can have some knob which will
effectively disable the auto-enslavement.

Auto-bonding capable user space can do the renames, spawn the bond,
etc. all by itself.  I'm basically going back to my initial proposal
here :)  There is a RedHat bugzilla for the NetworkManager team to do
this, but we merged net_failover before those folks got around to
implementing it.

IOW if NM/systemd is capable of doing the auto-bonding itself it can
disable the kernel mechanism and take care of it all.  If kernel is
booted with an old user space which doesn't have capable NM/systemd -
net_failover will kick in and do its best.
