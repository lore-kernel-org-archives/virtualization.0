From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
	PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to
	use the bypass framework)
Date: Wed, 27 Feb 2019 19:38:34 -0500
Message-ID: <20190227193330-mutt-send-email-mst__7921.8053071358$1551315049$gmane$org@kernel.org>
References: <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
	<d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
	<20190222100753-mutt-send-email-mst@kernel.org>
	<e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
	<20190225210529-mutt-send-email-mst@kernel.org>
	<d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
	<20190227173710-mutt-send-email-mst@kernel.org>
	<c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
	<20190227184601-mutt-send-email-mst@kernel.org>
	<20190227160342.788dc2b4@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190227160342.788dc2b4@shemminger-XPS-13-9360>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 27, 2019 at 04:03:42PM -0800, Stephen Hemminger wrote:
> > With this approach kernel will deny attempts by userspace to rename
> > slaves.  Slaves will always be named XXXnsby and XXnpry. Master renames
> > will rename both slaves.
> > 
> > It seems pretty solid to me, the only issue is that in theory userspace
> > can use a name like XXXnsby for something else. But this seems unlikely.
> 
> Similar schemes (with kernel providing naming) were also previously rejected
> upstream.

Links?
I'm inclined to try and see what happens.

> It has been a consistent theme that the kernel should not be in
> the renaming business.

In this case it's not in renaming business per se. The only reason
we even have the original name is due to the ways internal APIs
work. You can look at it as simply having slaves names being
part of master.

> It will certainly break userspace.

That's a strong claim. What is it based on?  It so happens that
userspace renaming slaves is already broken on virtio. So we can fix it
any way we like :)

And yes it won't help netvsc because netvsc wants compatibility with old
scripts but then netvsc uses a 2 device model anyway.

-- 
MST
