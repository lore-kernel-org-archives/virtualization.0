From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Mon, 22 Jan 2018 16:16:23 -0800
Message-ID: <20180122161623.22b6e151@cakuba.netronome.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
	<20180123020332-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180123020332-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, achiad shochat <achiad.mellanox@gmail.com>, "Samudrala,
	Sridhar" <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, Achiad Shochat <achiad@mellanox.com>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 23 Jan 2018 02:05:48 +0200, Michael S. Tsirkin wrote:
> > As we are using virtio_net to control and manage the VF data path, it is not
> > clear to me
> > what is the advantage of creating a new device rather than extending
> > virtio_net to manage
> > the VF datapath via transparent bond mechanism.
> 
> So that XDP redirect actions can differentiate between virtio, PT
> device and the bond. Without it there's no way to redirect
> to virtio specifically.

Let's make a list :P

separate netdev:
1. virtio device being a bond master is confusing/unexpected.
2. virtio device being both a master and a slave is confusing.
3. configuration of a master may have different semantics than
   configuration of a slave.
4. two para-virt devices may create a loop (or rather will be bound 
   to each other indeterministically, depending on which spawns first).
5. there is no user configuration AFAIR in existing patch, VM admin
   won't be able to prevent the bond.  Separate netdev we can make 
   removable even if it's spawned automatically.
6. XDP redirect use-case (or any explicit use of the virtio slave)
   (from MST)

independent driver:
7. code reuse.

separate device:
8. bond any netdev with any netdev.
9. reuse well-known device driver model.
a. natural anchor for hypervisor configuration (switchdev etc.)
b. next-gen silicon may be able to disguise as virtio device, and the
   loop check in virtio driver will prevent the legitimate bond it such
   case.  AFAIU that's one of the goals of next-gen virtio spec as well.
