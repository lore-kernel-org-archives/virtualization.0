From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH net-next 0/2] Enable virtio to act as a master for a
	passthru device
Date: Tue, 2 Jan 2018 18:16:03 -0800
Message-ID: <20180102181603.7fe4fd1e__16842.0581067496$1514945685$gmane$org@cakuba.netronome.com>
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jesse.brandeburg@intel.com
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, mst@redhat.com, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue,  2 Jan 2018 16:35:36 -0800, Sridhar Samudrala wrote:
> This patch series enables virtio to switch over to a VF datapath when a VF
> netdev is present with the same MAC address. It allows live migration of a VM
> with a direct attached VF without the need to setup a bond/team between a
> VF and virtio net device in the guest.
> 
> The hypervisor needs to unplug the VF device from the guest on the source
> host and reset the MAC filter of the VF to initiate failover of datapath to
> virtio before starting the migration. After the migration is completed, the
> destination hypervisor sets the MAC filter on the VF and plugs it back to
> the guest to switch over to VF datapath.
> 
> It is based on netvsc implementation and it may be possible to make this code 
> generic and move it to a common location that can be shared by netvsc and virtio.
> 
> This patch series is based on the discussion initiated by Jesse on this thread.
> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2

How does the notion of a device which is both a bond and a leg of a
bond fit with Alex's recent discussions about feature propagation?
Which propagation rules will apply to VirtIO master?  Meaning of the
flags on a software upper device may be different.  Why muddy the
architecture like this and not introduce a synthetic bond device?
