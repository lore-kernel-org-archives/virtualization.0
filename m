From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Sat, 17 Feb 2018 09:12:01 -0800
Message-ID: <CAKgT0UfU9gV2Y7hWFQi0vJoD9kYeoq+7cXmwAjXeV5zxXHa3dQ__12984.798095613$1518887437$gmane$org@mail.gmail.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<20180216183817.42b07af6@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180216183817.42b07af6@cakuba.netronome.com>
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
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Siwei Liu <loseweigh@gmail.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 16, 2018 at 6:38 PM, Jakub Kicinski <kubakici@wp.pl> wrote:
> On Fri, 16 Feb 2018 10:11:19 -0800, Sridhar Samudrala wrote:
>> Ppatch 2 is in response to the community request for a 3 netdev
>> solution.  However, it creates some issues we'll get into in a moment.
>> It extends virtio_net to use alternate datapath when available and
>> registered. When BACKUP feature is enabled, virtio_net driver creates
>> an additional 'bypass' netdev that acts as a master device and controls
>> 2 slave devices.  The original virtio_net netdev is registered as
>> 'backup' netdev and a passthru/vf device with the same MAC gets
>> registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>> associated with the same 'pci' device.  The user accesses the network
>> interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>> as default for transmits when it is available with link up and running.
>
> Thank you do doing this.
>
>> We noticed a couple of issues with this approach during testing.
>> - As both 'bypass' and 'backup' netdevs are associated with the same
>>   virtio pci device, udev tries to rename both of them with the same name
>>   and the 2nd rename will fail. This would be OK as long as the first netdev
>>   to be renamed is the 'bypass' netdev, but the order in which udev gets
>>   to rename the 2 netdevs is not reliable.
>
> Out of curiosity - why do you link the master netdev to the virtio
> struct device?

The basic idea of all this is that we wanted this to work with an
existing VM image that was using virtio. As such we were trying to
make it so that the bypass interface takes the place of the original
virtio and get udev to rename the bypass to what the original
virtio_net was.

> FWIW two solutions that immediately come to mind is to export "backup"
> as phys_port_name of the backup virtio link and/or assign a name to the
> master like you are doing already.  I think team uses team%d and bond
> uses bond%d, soft naming of master devices seems quite natural in this
> case.

I figured I had overlooked something like that.. Thanks for pointing
this out. Okay so I think the phys_port_name approach might resolve
the original issue. If I am reading things correctly what we end up
with is the master showing up as "ens1" for example and the backup
showing up as "ens1nbackup". Am I understanding that right?

The problem with the team/bond%d approach is that it creates a new
netdevice and so it would require guest configuration changes.

> IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
> link is quite neat.

I agree. For non-"backup" virio_net devices would it be okay for us to
just return -EOPNOTSUPP? I assume it would be and that way the legacy
behavior could be maintained although the function still exists.

>> - When the 'active' netdev is unplugged OR not present on a destination
>>   system after live migration, the user will see 2 virtio_net netdevs.
>
> That's necessary and expected, all configuration applies to the master
> so master must exist.

With the naming issue resolved this is the only item left outstanding.
This becomes a matter of form vs function.

The main complaint about the "3 netdev" solution is a bit confusing to
have the 2 netdevs present if the VF isn't there. The idea is that
having the extra "master" netdev there if there isn't really a bond is
a bit ugly.

The downside of the "2 netdev" solution is that you have to deal with
an extra layer of locking/queueing to get to the VF and you lose some
functionality since things like in-driver XDP have to be disabled in
order to maintain the same functionality when the VF is present or
not. However it looks more like classic virtio_net when the VF is not
present.
