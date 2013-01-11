From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH] virtio-net: introduce a new macaddr control
Date: Fri, 11 Jan 2013 10:50:17 +0100
Message-ID: <20130111095017.GD14394@stefanha-thinkpad.muc.redhat.com>
References: <1357829141-25455-1-git-send-email-akong@redhat.com>
	<1357829517-25656-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1357829517-25656-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 10, 2013 at 10:51:57PM +0800, akong@redhat.com wrote:
> @@ -349,6 +351,13 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>  {
>      struct virtio_net_ctrl_mac mac_data;
>  
> +    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2) {
> +        /* Set MAC address */
> +        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);

We cannot trust the guest's iov_len, it could overflow n->mac.
