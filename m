From: Radu Rendec via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: virtio_net: ethtool supported link modes
Date: Thu, 31 Aug 2017 18:04:04 +0100
Message-ID: <1504199044.22080.11.camel__28597.712404053$1509079303$gmane$org@arista.com>
Reply-To: Radu Rendec <rrendec@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello,

Looking at the code in virtnet_set_link_ksettings, it seems the speed
and duplex can be set to any valid value. The driver will "remember"
them and report them back in virtnet_get_link_ksettings.

However, the supported link modes (link_modes.supported in struct
ethtool_link_ksettings) is always 0, indicating that no speed/duplex
setting is supported.

Does it make more sense to set (at least a few of) the supported link
modes, such as 10baseT_Half ... 10000baseT_Full?

I would expect to see consistency between what is reported in
link_modes.supported and what can actually be set. Could you please
share your opinion on this?

Thank you,
Radu Rendec
