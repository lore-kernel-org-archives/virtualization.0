From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Fri, 16 Feb 2018 18:38:17 -0800
Message-ID: <20180216183817.42b07af6__8439.07496096126$1518835040$gmane$org@cakuba.netronome.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Feb 2018 10:11:19 -0800, Sridhar Samudrala wrote:
> Ppatch 2 is in response to the community request for a 3 netdev
> solution.  However, it creates some issues we'll get into in a moment.
> It extends virtio_net to use alternate datapath when available and
> registered. When BACKUP feature is enabled, virtio_net driver creates
> an additional 'bypass' netdev that acts as a master device and controls
> 2 slave devices.  The original virtio_net netdev is registered as
> 'backup' netdev and a passthru/vf device with the same MAC gets
> registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
> associated with the same 'pci' device.  The user accesses the network
> interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
> as default for transmits when it is available with link up and running.

Thank you do doing this.

> We noticed a couple of issues with this approach during testing.
> - As both 'bypass' and 'backup' netdevs are associated with the same
>   virtio pci device, udev tries to rename both of them with the same name
>   and the 2nd rename will fail. This would be OK as long as the first netdev
>   to be renamed is the 'bypass' netdev, but the order in which udev gets
>   to rename the 2 netdevs is not reliable. 

Out of curiosity - why do you link the master netdev to the virtio
struct device?

FWIW two solutions that immediately come to mind is to export "backup"
as phys_port_name of the backup virtio link and/or assign a name to the
master like you are doing already.  I think team uses team%d and bond
uses bond%d, soft naming of master devices seems quite natural in this
case.

IMHO phys_port_name == "backup" if BACKUP bit is set on slave virtio
link is quite neat.

> - When the 'active' netdev is unplugged OR not present on a destination
>   system after live migration, the user will see 2 virtio_net netdevs.

That's necessary and expected, all configuration applies to the master
so master must exist.
