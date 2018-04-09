From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
	datapath when available
Date: Mon, 9 Apr 2018 10:07:51 +0200
Message-ID: <20180409080751.GE19345__10137.5687322163$1523261166$gmane$org@nanopsycho>
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
	<1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
	<20180406124814.GA24525@nanopsycho>
	<bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Sat, Apr 07, 2018 at 12:59:14AM CEST, sridhar.samudrala@intel.com wrote:
>On 4/6/2018 5:48 AM, Jiri Pirko wrote:
>> Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudrala@intel.com wrote:

[...]

>> > +static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
>> > +				     struct net_device *child_netdev)
>> > +{
>> > +	struct virtnet_bypass_info *vbi;
>> > +	bool backup;
>> > +
>> > +	vbi = netdev_priv(bypass_netdev);
>> > +	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>> > +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>> > +			rtnl_dereference(vbi->active_netdev)) {
>> > +		netdev_info(bypass_netdev,
>> > +			    "%s attempting to join bypass dev when %s already present\n",
>> > +			    child_netdev->name, backup ? "backup" : "active");
>> Bypass module should check if there is already some other netdev
>> enslaved and refuse right there.
>
>This will work for virtio-net with 3 netdev model, but this check has to be done by netvsc
>as its bypass_netdev is same as the backup_netdev.
>Will add a flag while registering with the bypass module to indicate if the driver is doing
>a 2 netdev or 3 netdev model and based on that flag this check can be done in bypass module
>for 3 netdev scenario.

Just let me undestand it clearly. What I expect the difference would be
between 2netdev and3 netdev model is this:
2netdev:
  bypass_master
     /
    /
VF_slave

3netdev:
  bypass_master
     /     \
    /       \
VF_slave   backup_slave

Is that correct? If not, how does it look like?

Thanks!
