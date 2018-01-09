From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v4 1/3] virtio_net: propagate linkspeed/duplex
	settings from the hypervisor
Date: Tue, 09 Jan 2018 11:38:12 -0500 (EST)
Message-ID: <20180109.113812.2257853296058477300.davem__49834.1419421651$1515515808$gmane$org@davemloft.net>
References: <cover.1515190238.git.jbaron@akamai.com>
	<cover.1515190238.git.jbaron@akamai.com>
	<718139aaea9a1ef032b29429af570fb171fdacac.1515190238.git.jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <718139aaea9a1ef032b29429af570fb171fdacac.1515190238.git.jbaron@akamai.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jbaron@akamai.com
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, netdev@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Baron <jbaron@akamai.com>
Date: Fri,  5 Jan 2018 17:44:54 -0500

> The ability to set speed and duplex for virtio_net is useful in various
> scenarios as described here:
> 
> 16032be virtio_net: add ethtool support for set and get of settings
> 
> However, it would be nice to be able to set this from the hypervisor,
> such that virtio_net doesn't require custom guest ethtool commands.
> 
> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> the hypervisor to export a linkspeed and duplex setting. The user can
> subsequently overwrite it later if desired via: 'ethtool -s'.
> 
> Note that VIRTIO_NET_F_SPEED_DUPLEX is defined as bit 63, the intention
> is that device feature bits are to grow down from bit 63, since the
> transports are starting from bit 24 and growing up.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Applied, thanks Jason.
