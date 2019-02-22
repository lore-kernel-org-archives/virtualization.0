From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: net_failover slave udev renaming (was Re: [RFC PATCH net-next v6
	4/4] netvsc: refactor notifier/event handling code to use the bypass
	framework)
Date: Thu, 21 Feb 2019 20:39:15 -0500
Message-ID: <20190221203808-mutt-send-email-mst__24876.9294865028$1550799776$gmane$org@kernel.org>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-5-git-send-email-sridhar.samudrala@intel.com>
	<20180410142608.50f15b45@xeon-e3>
	<20180411075334.GK2028@nanopsycho>
	<CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ214RJV_zWVBGv0Ydo=CJj6WESTYAH=PpaYLFHdtWVrm3g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Siwei Liu <loseweigh@gmail.com>
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev <virtio-dev@lists.oasis-open.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, si-wei liu <si-wei.liu@oracle.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
> Sorry for replying to this ancient thread. There was some remaining
> issue that I don't think the initial net_failover patch got addressed
> cleanly, see:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
> 
> The renaming of 'eth0' to 'ens4' fails because the udev userspace was
> not specifically writtten for such kernel automatic enslavement.
> Specifically, if it is a bond or team, the slave would typically get
> renamed *before* virtual device gets created, that's what udev can
> control (without getting netdev opened early by the other part of
> kernel) and other userspace components for e.g. initramfs,
> init-scripts can coordinate well in between. The in-kernel
> auto-enslavement of net_failover breaks this userspace convention,
> which don't provides a solution if user care about consistent naming
> on the slave netdevs specifically.
> 
> Previously this issue had been specifically called out when IFF_HIDDEN
> and the 1-netdev was proposed, but no one gives out a solution to this
> problem ever since. Please share your mind how to proceed and solve
> this userspace issue if netdev does not welcome a 1-netdev model.

Above says:

	there's no motivation in the systemd/udevd community at
	this point to refactor the rename logic and make it work well with
	3-netdev.

What would the fix be? Skip slave devices?

-- 
MST
