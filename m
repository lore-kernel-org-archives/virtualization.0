From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/3] virtio-net: introduce features defined in the spec
Date: Sun, 1 Mar 2020 06:32:25 -0500
Message-ID: <20200301063121-mutt-send-email-mst@kernel.org>
References: <20200301110733.20197-1-yuri.benditovich@daynix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200301110733.20197-1-yuri.benditovich@daynix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, yan@daynix.com
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 01, 2020 at 01:07:30PM +0200, Yuri Benditovich wrote:
> This series introduce virtio-net features VIRTIO_NET_F_RSC_EXT,
> VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT.
> 
> Changes from v1:
> __virtio -> __le
> maximal -> maximum
> minor style fixes


Looks good to me - sent a bit of consmetics.

But as any virtio UAPI change, please CC virtio-dev as virtio TC maintains the
interface. Thanks!

> Yuri Benditovich (3):
>   virtio-net: Introduce extended RSC feature
>   virtio-net: Introduce RSS receive steering feature
>   virtio-net: Introduce hash report feature
> 
>  include/uapi/linux/virtio_net.h | 90 +++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 4 deletions(-)
> 
> -- 
> 2.17.1
