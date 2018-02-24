From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Fri, 23 Feb 2018 16:03:05 -0800
Message-ID: <20180223160305.71fb2db2@xeon-e3>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180216183817.42b07af6@cakuba.netronome.com>
	<CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
	<CADGSJ217HahFJsGmNXMD6SwWiK374+u_YET8QqdsmofCRFZr=Q@mail.gmail.com>
	<CAKgT0Uda7Bmzf06RMmD7hCVLr8hHQxaY8Fk7w9Qy=7Vi6NODwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKgT0Uda7Bmzf06RMmD7hCVLr8hHQxaY8Fk7w9Qy=7Vi6NODwQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

(pruned to reduce thread)

On Wed, 21 Feb 2018 16:17:19 -0800
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> >>> FWIW two solutions that immediately come to mind is to export "backup"
> >>> as phys_port_name of the backup virtio link and/or assign a name to the
> >>> master like you are doing already.  I think team uses team%d and bond
> >>> uses bond%d, soft naming of master devices seems quite natural in this
> >>> case.  
> >>
> >> I figured I had overlooked something like that.. Thanks for pointing
> >> this out. Okay so I think the phys_port_name approach might resolve
> >> the original issue. If I am reading things correctly what we end up
> >> with is the master showing up as "ens1" for example and the backup
> >> showing up as "ens1nbackup". Am I understanding that right?
> >>
> >> The problem with the team/bond%d approach is that it creates a new
> >> netdevice and so it would require guest configuration changes.
> >>  
> >>> IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
> >>> link is quite neat.  
> >>
> >> I agree. For non-"backup" virio_net devices would it be okay for us to
> >> just return -EOPNOTSUPP? I assume it would be and that way the legacy
> >> behavior could be maintained although the function still exists.
> >>  
> >>>> - When the 'active' netdev is unplugged OR not present on a destination
> >>>>   system after live migration, the user will see 2 virtio_net netdevs.  
> >>>
> >>> That's necessary and expected, all configuration applies to the master
> >>> so master must exist.  
> >>
> >> With the naming issue resolved this is the only item left outstanding.
> >> This becomes a matter of form vs function.
> >>
> >> The main complaint about the "3 netdev" solution is a bit confusing to
> >> have the 2 netdevs present if the VF isn't there. The idea is that
> >> having the extra "master" netdev there if there isn't really a bond is
> >> a bit ugly.  
> >
> > Is it this uglier in terms of user experience rather than
> > functionality? I don't want it dynamically changed between 2-netdev
> > and 3-netdev depending on the presence of VF. That gets back to my
> > original question and suggestion earlier: why not just hide the lower
> > netdevs from udev renaming and such? Which important observability
> > benefits users may get if exposing the lower netdevs?
> >
> > Thanks,
> > -Siwei  
> 
> The only real advantage to a 2 netdev solution is that it looks like
> the netvsc solution, however it doesn't behave like it since there are
> some features like XDP that may not function correctly if they are
> left enabled in the virtio_net interface.
> 
> As far as functionality the advantage of not hiding the lower devices
> is that they are free to be managed. The problem with pushing all of
> the configuration into the upper device is that you are limited to the
> intersection of the features of the lower devices. This can be
> limiting for some setups as some VFs support things like more queues,
> or better interrupt moderation options than others so trying to make
> everything work with one config would be ugly.
> 


Let's not make XDP the blocker for doing the best solution
from the end user point of view. XDP is just yet another offload
thing which needs to be handled.  The current backup device solution
used in netvsc doesn't handle the full range of offload options
(things like flow direction, DCB, etc); no one but the HW vendors
seems to care.
