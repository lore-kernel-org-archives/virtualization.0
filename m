From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 0/8] vhost: support for cross endian guests
Date: Fri, 24 Apr 2015 15:31:54 +0200
Message-ID: <20150424153137-mutt-send-email-mst__27979.4609909461$1429882349$gmane$org@redhat.com>
References: <20150424122211.19156.97626.stgit@bahia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150424122211.19156.97626.stgit@bahia.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 24, 2015 at 02:24:15PM +0200, Greg Kurz wrote:
> Only cosmetic and documentation changes since v5.
> 
> ---

Looks sane to me. I plan to review and apply next week.

> Greg Kurz (8):
>       virtio: introduce virtio_is_little_endian() helper
>       tun: add tun_is_little_endian() helper
>       macvtap: introduce macvtap_is_little_endian() helper
>       vringh: introduce vringh_is_little_endian() helper
>       vhost: introduce vhost_is_little_endian() helper
>       virtio: add explicit big-endian support to memory accessors
>       vhost: cross-endian support for legacy devices
>       macvtap/tun: cross-endian support for little-endian hosts
> 
> 
>  drivers/net/Kconfig              |   14 ++++++
>  drivers/net/macvtap.c            |   66 +++++++++++++++++++++++++++++-
>  drivers/net/tun.c                |   68 ++++++++++++++++++++++++++++++
>  drivers/vhost/Kconfig            |   15 +++++++
>  drivers/vhost/vhost.c            |   85 ++++++++++++++++++++++++++++++++++++++
>  drivers/vhost/vhost.h            |   25 ++++++++---
>  include/linux/virtio_byteorder.h |   24 ++++++-----
>  include/linux/virtio_config.h    |   18 +++++---
>  include/linux/vringh.h           |   18 +++++---
>  include/uapi/linux/if_tun.h      |    6 +++
>  include/uapi/linux/vhost.h       |   14 ++++++
>  11 files changed, 320 insertions(+), 33 deletions(-)
> 
> --
> Greg
