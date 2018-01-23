From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [RFC PATCH net-next v2 1/2] virtio_net: Introduce
	VIRTIO_NET_F_BACKUP feature bit
Date: Tue, 23 Jan 2018 02:05:48 +0200
Message-ID: <20180123020332-mutt-send-email-mst@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-2-git-send-email-sridhar.samudrala@intel.com>
	<CAKgT0Uc8bRoAsXYSr7k27gf5+vh7rF2Dd_kWNB1d38tpZAeRGg@mail.gmail.com>
	<20180117203757-mutt-send-email-mst@kernel.org>
	<058068e5-febd-92c8-e5a9-faf262b82335@intel.com>
	<20180117213527-mutt-send-email-mst@kernel.org>
	<CAKgT0UeyNvVQc11KXc3updJfa9p7a9NcfRC=gP6=ktkjrSkOag@mail.gmail.com>
	<20180122231713-mutt-send-email-mst@kernel.org>
	<7edf772b-627c-6121-3332-479caed524da@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <7edf772b-627c-6121-3332-479caed524da@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: "Duyck, Alexander H" <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Netdev <netdev@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, achiad shochat <achiad.mellanox@gmail.com>, Achiad Shochat <achiad@mellanox.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 22, 2018 at 03:27:40PM -0800, Samudrala, Sridhar wrote:
> > > You could probably
> > > even handle the Tx queue selection via a simple eBPF program and map
> > > since the input for whatever is used to select Tx should be pretty
> > > simple, destination MAC, source NUMA node, etc, and the data-set
> > > shouldn't be too large.
> > That sounds interesting. A separate device might make this kind of setup
> > a bit easier.  Sridhar, did you look into creating a separate device for
> > the virtual bond device at all?  It does not have to be in a separate
> > module, that kind of refactoring can come later, but once we commit to
> > using the same single device as virtio, we can't change that.
> 
> No. I haven't looked into creating a separate device. If we are going to
> create a new
> device, i guess it has to be of a new device type with its own driver.

Well not necessarily - just a separate netdev ops.
Kind of like e.g. vlans share a driver with the main driver.

> As we are using virtio_net to control and manage the VF data path, it is not
> clear to me
> what is the advantage of creating a new device rather than extending
> virtio_net to manage
> the VF datapath via transparent bond mechanism.
> 
> Thanks
> Sridhar

So that XDP redirect actions can differentiate between virtio, PT
device and the bond. Without it there's no way to redirect
to virtio specifically.

-- 
MST
