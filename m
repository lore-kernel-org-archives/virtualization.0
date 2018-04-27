From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
Date: Fri, 27 Apr 2018 19:53:45 +0200
Message-ID: <20180427175345.GF5632__16941.0795592286$1524851527$gmane$org@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Fri, Apr 27, 2018 at 07:06:58PM CEST, sridhar.samudrala@intel.com wrote:
>This provides a generic interface for paravirtual drivers to listen
>for netdev register/unregister/link change events from pci ethernet
>devices with the same MAC and takeover their datapath. The notifier and
>event handling code is based on the existing netvsc implementation.
>
>It exposes 2 sets of interfaces to the paravirtual drivers.
>1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>   the failover module provides interfaces to create/destroy additional
>   master netdev and all the slave events are managed internally.
>        net_failover_create()
>        net_failover_destroy()
>   A failover netdev is created that acts a master device and controls 2
>   slave devices. The original virtio_net netdev is registered as 'standby'
>   netdev and a passthru/vf device with the same MAC gets registered as
>   'primary' netdev. Both 'standby' and 'primary' netdevs are associated
>   with the same 'pci' device.  The user accesses the network interface via
>   'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>   default for transmits when it is available with link up and running.
>2. For existing netvsc driver that uses 2 netdev model, no master netdev
>   is created. The paravirtual driver registers each instance of netvsc
>   as a 'failover' netdev  along with a set of ops to manage the slave
>   events. There is no 'standby' netdev in this model. A passthru/vf device
>   with the same MAC gets registered as 'primary' netdev.
>        net_failover_register()
>        net_failover_unregister()
>
>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>---
> include/linux/netdevice.h  |  16 +
> include/net/net_failover.h |  62 ++++
> net/Kconfig                |  10 +
> net/core/Makefile          |   1 +
> net/core/net_failover.c    | 892 +++++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 981 insertions(+)
> create mode 100644 include/net/net_failover.h
> create mode 100644 net/core/net_failover.c

checkpatch says:

_exportax/0002-net-Introduce-generic-failover-module.patch
----------------------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#92: 
new file mode 100644

Please add an entry to the MAINTAINERS file.
