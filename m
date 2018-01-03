From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next v2 1/3] virtio_net: propagate linkspeed/duplex
	settings from the hypervisor
Date: Wed, 3 Jan 2018 15:49:21 +0200
Message-ID: <20180103154824-mutt-send-email-mst@kernel.org>
References: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
	<cover.1513974243.git.jbaron@akamai.com>
	<44da522ecee60792ec918234ee4d61a84e4574f0.1513974243.git.jbaron@akamai.com>
	<20171227.164334.2079471466039224265.davem@davemloft.net>
	<93b66082-f37c-0463-e977-d4b430a44008@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <93b66082-f37c-0463-e977-d4b430a44008@akamai.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Baron <jbaron@akamai.com>
Cc: qemu-devel@nongnu.org, netdev@vger.kernel.org, David Miller <davem@davemloft.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 28, 2017 at 10:53:54AM -0500, Jason Baron wrote:
> 
> 
> On 12/27/2017 04:43 PM, David Miller wrote:
> > From: Jason Baron <jbaron@akamai.com>
> > Date: Fri, 22 Dec 2017 16:54:01 -0500
> > 
> >> The ability to set speed and duplex for virtio_net in useful in various
> >> scenarios as described here:
> >>
> >> 16032be virtio_net: add ethtool support for set and get of settings
> >>
> >> However, it would be nice to be able to set this from the hypervisor,
> >> such that virtio_net doesn't require custom guest ethtool commands.
> >>
> >> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> >> the hypervisor to export a linkspeed and duplex setting. The user can
> >> subsequently overwrite it later if desired via: 'ethtool -s'.
> >>
> >> Signed-off-by: Jason Baron <jbaron@akamai.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Jason Wang <jasowang@redhat.com>
> > 
> > Looks mostly fine to me but need some virtio_net reviewers on this one.
> > 
> >> @@ -57,6 +57,8 @@
> >>  					 * Steering */
> >>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> >>  
> >> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Host set linkspeed and duplex */
> >> +
> > 
> > Why use a value so far away from the largest existing one?
> > 
> > Just curious.
> > 
> 
> So that came from a discussion with Michael about which bit to use for
> this, and he suggested using 63:
> 
> "
> Transports started from bit 24 and are growing up.
> So I would say devices should start from bit 63 and grow down.
> "
> 
> https://patchwork.ozlabs.org/patch/848814/#1826669
> 
> I will add a comment to explain it.

Maybe in the commit log. I don't think we need it in the header.

> Thanks,
> 
> -Jason
