From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Mon, 7 May 2018 16:46:32 -0700
Message-ID: <20180507164632.4f6c2eef__35709.8295972266$1525736696$gmane$org@xeon-e3>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon,  7 May 2018 15:10:44 -0700
Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> This provides a generic interface for paravirtual drivers to listen
> for netdev register/unregister/link change events from pci ethernet
> devices with the same MAC and takeover their datapath. The notifier and
> event handling code is based on the existing netvsc implementation.
> 
> It exposes 2 sets of interfaces to the paravirtual drivers.
> 1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>    the failover module provides interfaces to create/destroy additional
>    master netdev and all the slave events are managed internally.
>           net_failover_create()
>           net_failover_destroy()
>    A failover netdev is created that acts a master device and controls 2
>    slave devices. The original virtio_net netdev is registered as 'standby'
>    netdev and a passthru/vf device with the same MAC gets registered as
>    'primary' netdev. Both 'standby' and 'failover' netdevs are associated
>    with the same 'pci' device.  The user accesses the network interface via
>    'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>    default for transmits when it is available with link up and running.
> 2. For existing netvsc driver that uses 2 netdev model, no master netdev
>    is created. The paravirtual driver registers each instance of netvsc
>    as a 'failover' netdev  along with a set of ops to manage the slave
>    events. There is no 'standby' netdev in this model. A passthru/vf device
>    with the same MAC gets registered as 'primary' netdev.
>           net_failover_register()
>           net_failover_unregister()
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

You are conflating the net_failover device (3 device model) with
the generic network failover infrastructure into one file. There should be two
seperate files net/core/failover.c and drivers/net/failover.c which splits
the work into two parts (and acts a check for the api).
