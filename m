From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH v3 0/3] Enable virtio_net to act as a backup for a
	passthru device
Date: Tue, 20 Feb 2018 11:42:24 +0100
Message-ID: <20180220104224.GA2031@nanopsycho>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Fri, Feb 16, 2018 at 07:11:19PM CET, sridhar.samudrala@intel.com wrote:
>Patch 1 introduces a new feature bit VIRTIO_NET_F_BACKUP that can be
>used by hypervisor to indicate that virtio_net interface should act as
>a backup for another device with the same MAC address.
>
>Ppatch 2 is in response to the community request for a 3 netdev
>solution.  However, it creates some issues we'll get into in a moment.
>It extends virtio_net to use alternate datapath when available and
>registered. When BACKUP feature is enabled, virtio_net driver creates
>an additional 'bypass' netdev that acts as a master device and controls
>2 slave devices.  The original virtio_net netdev is registered as
>'backup' netdev and a passthru/vf device with the same MAC gets
>registered as 'active' netdev. Both 'bypass' and 'backup' netdevs are
>associated with the same 'pci' device.  The user accesses the network
>interface via 'bypass' netdev. The 'bypass' netdev chooses 'active' netdev
>as default for transmits when it is available with link up and running.

Sorry, but this is ridiculous. You are apparently re-implemeting part
of bonding driver as a part of NIC driver. Bond and team drivers
are mature solutions, well tested, broadly used, with lots of issues
resolved in the past. What you try to introduce is a weird shortcut
that already has couple of issues as you mentioned and will certanly
have many more. Also, I'm pretty sure that in future, someone comes up
with ideas like multiple VFs, LACP and similar bonding things.

What is the reason for this abomination? According to:
https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
The reason is quite weak.
User in the vm sees 2 (or more) netdevices, he puts them in bond/team
and that's it. This works now! If the vm lacks some userspace features,
let's fix it there! For example the MAC changes is something that could
be easily handled in teamd userspace deamon.
