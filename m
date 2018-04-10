From: Siwei Liu <loseweigh@gmail.com>
Subject: Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Tue, 10 Apr 2018 08:55:37 -0700
Message-ID: <CADGSJ21Ak_4w0etwamDe-y4oy0W=ZcvikQOqHu5sETfZpQhysw__32363.4094129831$1523375638$gmane$org@mail.gmail.com>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
	<1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
	<20180406124814.GA24525@nanopsycho>
	<bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
	<20180409080751.GE19345@nanopsycho>
	<16b2e531-7bfa-7f25-2702-f3f8069663ee@intel.com>
	<20180410105504.GA2028@nanopsycho>
	<2ccfad76-589d-9dca-7e4b-9bafee41f844@intel.com>
	<20180410152205.GF2028@nanopsycho>
	<d08ed1e6-678a-7b34-cd2e-52788ceec919@intel.com>
	<20180410154304.GG2028@nanopsycho>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180410154304.GG2028@nanopsycho>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 10, 2018 at 8:43 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Tue, Apr 10, 2018 at 05:27:48PM CEST, sridhar.samudrala@intel.com wrote:
>>On 4/10/2018 8:22 AM, Jiri Pirko wrote:
>>> Tue, Apr 10, 2018 at 05:13:40PM CEST, sridhar.samudrala@intel.com wrote:
>>> > On 4/10/2018 3:55 AM, Jiri Pirko wrote:
>>> > > Mon, Apr 09, 2018 at 08:47:06PM CEST, sridhar.samudrala@intel.com wrote:
>>> > > > On 4/9/2018 1:07 AM, Jiri Pirko wrote:
>>> > > > > Sat, Apr 07, 2018 at 12:59:14AM CEST, sridhar.samudrala@intel.com wrote:
>>> > > > > > On 4/6/2018 5:48 AM, Jiri Pirko wrote:
>>> > > > > > > Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudrala@intel.com wrote:
>>> > > > > [...]
>>> > > > >
>>> > > > > > > > +static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
>>> > > > > > > > +                                   struct net_device *child_netdev)
>>> > > > > > > > +{
>>> > > > > > > > +      struct virtnet_bypass_info *vbi;
>>> > > > > > > > +      bool backup;
>>> > > > > > > > +
>>> > > > > > > > +      vbi = netdev_priv(bypass_netdev);
>>> > > > > > > > +      backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>>> > > > > > > > +      if (backup ? rtnl_dereference(vbi->backup_netdev) :
>>> > > > > > > > +                      rtnl_dereference(vbi->active_netdev)) {
>>> > > > > > > > +              netdev_info(bypass_netdev,
>>> > > > > > > > +                          "%s attempting to join bypass dev when %s already present\n",
>>> > > > > > > > +                          child_netdev->name, backup ? "backup" : "active");
>>> > > > > > > Bypass module should check if there is already some other netdev
>>> > > > > > > enslaved and refuse right there.
>>> > > > > > This will work for virtio-net with 3 netdev model, but this check has to be done by netvsc
>>> > > > > > as its bypass_netdev is same as the backup_netdev.
>>> > > > > > Will add a flag while registering with the bypass module to indicate if the driver is doing
>>> > > > > > a 2 netdev or 3 netdev model and based on that flag this check can be done in bypass module
>>> > > > > > for 3 netdev scenario.
>>> > > > > Just let me undestand it clearly. What I expect the difference would be
>>> > > > > between 2netdev and3 netdev model is this:
>>> > > > > 2netdev:
>>> > > > >      bypass_master
>>> > > > >         /
>>> > > > >        /
>>> > > > > VF_slave
>>> > > > >
>>> > > > > 3netdev:
>>> > > > >      bypass_master
>>> > > > >         /     \
>>> > > > >        /       \
>>> > > > > VF_slave   backup_slave
>>> > > > >
>>> > > > > Is that correct? If not, how does it look like?
>>> > > > >
>>> > > > >
>>> > > > Looks correct.
>>> > > > VF_slave and backup_slave are the original netdevs and are present in both the models.
>>> > > > In the 3 netdev model, bypass_master netdev is created and VF_slave and backup_slave are
>>> > > > marked as the 2 slaves of this new netdev.
>>> > > You say it looks correct and in another sentence you provide completely
>>> > > different description. Could you please look again?
>>> > >
>>> > To be exact, 2 netdev model with netvsc looks like this.
>>> >
>>> >     netvsc_netdev
>>> >       /
>>> >      /
>>> > VF_slave
>>> >
>>> > With virtio_net, 3 netdev model
>>> >
>>> >   bypass_netdev
>>> >       /     \
>>> >      /       \
>>> > VF_slave   virtio_net netdev
>>> Could you also mark the original netdev which is there now? is it
>>> bypass_netdev or virtio_net_netdev ?
>>
>> bypass_netdev
>>     /     \
>>    /       \
>>VF_slave   virtio_net netdev (original)
>
> That does not make sense.
> 1) You diverge from the behaviour of the netvsc, where the original
>    netdev is a master of the VF
> 2) If the original netdev is a slave, you cannot have any IP address
>    configured on it (well you could, but the rx_handler would eat every
>    incoming packet). So you will break the user bacause he would have to
>    move the configuration to the new master device.

That's exactly the point why I need to hide the lower netdev slaves
and trying the align the naming of the bypass with where IP was
configured on the original netdev. The current 3-netdev model is not
"transparent" by any means.

-Siwei

> This only makes sense that the original netdev becomes the master for both
> netvsc and virtio_net.
