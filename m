From: Amos Kong <akong@redhat.com>
Subject: Re: [Qemu-devel] [QEMU PATCH v4 1/3] virtio-net: remove layout
	assumptions for ctrl vq
Date: Sat, 19 Jan 2013 10:08:54 +0800
Message-ID: <20130119020854.GA11286@t430s.redhat.com>
References: <1358560468-10865-1-git-send-email-akong@redhat.com>
	<1358560468-10865-2-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358560468-10865-2-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 19, 2013 at 09:54:26AM +0800, akong@redhat.com wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> Virtio-net code makes assumption about virtqueue descriptor layout
> (e.g. sg[0] is the header, sg[1] is the data buffer).
> 
> This patch makes code not rely on the layout of descriptors.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Amos Kong <akong@redhat.com>
> ---
>  hw/virtio-net.c | 128 ++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 74 insertions(+), 54 deletions(-)

Had tested this patch with following scenarios:

VIRTIO_NET_CTRL_RX_MODE
1) ip link eth0 promisc on/off
2) ip link set eth0 allmulticast on/off
3) ip link set eth0 multicast on/off

VIRTIO_NET_CTRL_MAC
4) ifconfig eth0 hw ether 52:54:00:12:34:57
5) ping guest after joined guest into multicast
   group (225.0.0.1 ~ 225.0.0.10)

VIRTIO_NET_CTRL_VLAN
6) vconfig add eth0 2; vconfig rem eth0.2
