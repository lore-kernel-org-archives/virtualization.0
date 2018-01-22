From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
	datapath when available
Date: Mon, 22 Jan 2018 23:41:51 +0200
Message-ID: <20180122233205-mutt-send-email-mst__1046.97982683337$1516657228$gmane$org@kernel.org>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
	<1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
	<CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CADGSJ22BsdB-hDb0xebSyWrwDuBJaFACjb26PDoqAd2Ah+tsQg@mail.gmail.com>
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
Cc: Alexander Duyck <alexander.h.duyck@intel.com>, virtio-dev@lists.oasis-open.org, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jan 22, 2018 at 12:27:14PM -0800, Siwei Liu wrote:
> First off, as mentioned in another thread, the model of stacking up
> virt-bond functionality over virtio seems a wrong direction to me.
> Essentially the migration process would need to carry over all guest
> side configurations previously done on the VF/PT and get them moved to
> the new device being it virtio or VF/PT.

I might be wrong but I don't see why we should worry about this usecase.
Whoever has a bond configured already has working config for migration.
We are trying to help people who don't, not convert existig users.

> Without the help of a new
> upper layer bond driver that enslaves virtio and VF/PT devices
> underneath, virtio will be overloaded with too much specifics being a
> VF/PT backup in the future.

So this paragraph already includes at least two conflicting
proposals. On the one hand you want a separate device for
the virtual bond, on the other you are saying a separate
driver.

Further, the reason to have a separate *driver* was that
some people wanted to share code with netvsc - and that
one does not create a separate device, which you can't
change without breaking existing configs.

So some people want a fully userspace-configurable switchdev, and that
already exists at some level, and maybe it makes sense to add more
features for performance.

But the point was that some host configurations are very simple,
and it probably makes sense to pass this information to the guest
and have guest act on it directly. Let's not conflate the two.

-- 
MST
