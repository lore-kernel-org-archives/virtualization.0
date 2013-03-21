From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC qemu PATCH] only writing out the last byte of MAC makes it
	have effect
Date: Thu, 21 Mar 2013 12:51:52 +0200
Message-ID: <20130321105152.GB30874@redhat.com>
References: <1363834956-9409-1-git-send-email-akong@redhat.com>
	<1363848290-30344-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1363848290-30344-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 21, 2013 at 02:44:50PM +0800, Amos Kong wrote:
> The lengcy guests don't have mac programming command, we don't know when
> it's safe to use MAC. This patch changed qemu to makes MAC change effect
> when the last byte of MAC is written to config space.
> 
> MAC address takes first 6 bytes of config space of virtio-net, the addr
> is 5 when the last byte is written in virtio_config_writeb().
> 
> MAC change will effect when n->mac is updated in virtio_net_set_config().
> 
> Signed-off-by: Amos Kong <akong@redhat.com>

Let's see what Rusty says about the spec change.

> ---
>  hw/virtio.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/hw/virtio.c b/hw/virtio.c
> index 26fbc79..2e08302 100644
> --- a/hw/virtio.c
> +++ b/hw/virtio.c
> @@ -605,8 +605,9 @@ void virtio_config_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data)
>  
>      stb_p(vdev->config + addr, val);
>  
> -    if (vdev->set_config)
> +    if (vdev->set_config && (addr == 5 || strcmp(vdev->name, "virtio-net"))) {
>          vdev->set_config(vdev, vdev->config);
> +    }
>  }
>  
>  void virtio_config_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data)
> -- 
> 1.7.1
