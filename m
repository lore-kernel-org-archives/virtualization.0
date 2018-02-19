From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Sun, 18 Feb 2018 22:11:40 -0800
Message-ID: <20180218221140.6c7fb32e@cakuba.netronome.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180216183817.42b07af6@cakuba.netronome.com>
	<CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ@mail.gmail.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 17 Feb 2018 09:12:01 -0800, Alexander Duyck wrote:
> >> We noticed a couple of issues with this approach during testing.
> >> - As both 'bypass' and 'backup' netdevs are associated with the same
> >>   virtio pci device, udev tries to rename both of them with the same name
> >>   and the 2nd rename will fail. This would be OK as long as the first netdev
> >>   to be renamed is the 'bypass' netdev, but the order in which udev gets
> >>   to rename the 2 netdevs is not reliable.  
> >
> > Out of curiosity - why do you link the master netdev to the virtio
> > struct device?  
> 
> The basic idea of all this is that we wanted this to work with an
> existing VM image that was using virtio. As such we were trying to
> make it so that the bypass interface takes the place of the original
> virtio and get udev to rename the bypass to what the original
> virtio_net was.

That makes sense.  Is it udev/naming that you're most concerned about
here?  I.e. what's the user space app that expects the netdev to be
linked?  This is just out of curiosity, the linking of netdevs to
devices is a bit of a PITA in the switchdev eswitch mode world, with
libvirt expecting only certain devices to be there..  Right now we're
not linking VF reprs, which breaks naming.  I wanted to revisit that.

> > FWIW two solutions that immediately come to mind is to export "backup"
> > as phys_port_name of the backup virtio link and/or assign a name to the
> > master like you are doing already.  I think team uses team%d and bond
> > uses bond%d, soft naming of master devices seems quite natural in this
> > case.  
> 
> I figured I had overlooked something like that.. Thanks for pointing
> this out. Okay so I think the phys_port_name approach might resolve
> the original issue. If I am reading things correctly what we end up
> with is the master showing up as "ens1" for example and the backup
> showing up as "ens1nbackup". Am I understanding that right?

Yes, provided systemd is new enough.

> The problem with the team/bond%d approach is that it creates a new
> netdevice and so it would require guest configuration changes.
>
> > IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
> > link is quite neat.  
> 
> I agree. For non-"backup" virio_net devices would it be okay for us to
> just return -EOPNOTSUPP? I assume it would be and that way the legacy
> behavior could be maintained although the function still exists.

That's my understanding too.
