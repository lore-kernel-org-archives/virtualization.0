From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v11 3/5] net: Introduce net_failover driver
Date: Tue, 22 May 2018 10:59:40 +0200
Message-ID: <20180522085940.GD2149__446.29928092963$1526979494$gmane$org@nanopsycho>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
	<1526954781-35359-4-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1526954781-35359-4-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, anjali.singhai@intel.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Tue, May 22, 2018 at 04:06:19AM CEST, sridhar.samudrala@intel.com wrote:
>The net_failover driver provides an automated failover mechanism via APIs
>to create and destroy a failover master netdev and mananges a primary and
>standby slave netdevs that get registered via the generic failover
>infrastructure.
>
>The failover netdev acts a master device and controls 2 slave devices. The
>original paravirtual interface gets registered as 'standby' slave netdev and
>a passthru/vf device with the same MAC gets registered as 'primary' slave
>netdev. Both 'standby' and 'failover' netdevs are associated with the same
>'pci' device. The user accesses the network interface via 'failover' netdev.
>The 'failover' netdev chooses 'primary' netdev as default for transmits when
>it is available with link up and running.
>
>This can be used by paravirtual drivers to enable an alternate low latency
>datapath. It also enables hypervisor controlled live migration of a VM with
>direct attached VF by failing over to the paravirtual datapath when the VF
>is unplugged.
>
>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

[...]

>+
>+The net_failover driver provides an automated failover mechanism via APIs
>+to create and destroy a failover master netdev and mananges a primary and

s/mananges/manages/
