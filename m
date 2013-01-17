From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [QEMU PATCH v2] virtio-net: introduce a new macaddr control
Date: Thu, 17 Jan 2013 11:49:20 +1030
Message-ID: <87mww8y5bb.fsf@rustcorp.com.au>
References: <1358315821-29519-1-git-send-email-akong@redhat.com>
	<1358317007-29972-1-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1358317007-29972-1-git-send-email-akong@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: akong@redhat.com, mst@redhat.com
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, stefanha@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

akong@redhat.com writes:
> @@ -349,6 +351,14 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>  {
>      struct virtio_net_ctrl_mac mac_data;
>  
> +    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET && elem->out_num == 2 &&
> +        elem->out_sg[1].iov_len == ETH_ALEN) {
> +        /* Set MAC address */
> +        memcpy(n->mac, elem->out_sg[1].iov_base, elem->out_sg[1].iov_len);
> +        qemu_format_nic_info_str(&n->nic->nc, n->mac);
> +        return VIRTIO_NET_OK;
> +    }

Does the rest of the net device still rely on the layout of descriptors?
If so, OK, we'll fix them all together.  If not, this introduces a new
one.

Cheers,
Rusty.
