From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [QEMU PATCH v4 2/3] virtio-net: introduce a new macaddr control
Date: Mon, 21 Jan 2013 17:08:26 +0100
Message-ID: <20130121160826.GD24473@stefanha-thinkpad.redhat.com>
References: <1358560468-10865-1-git-send-email-akong@redhat.com>
	<1358560468-10865-3-git-send-email-akong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1358560468-10865-3-git-send-email-akong@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 19, 2013 at 09:54:27AM +0800, akong@redhat.com wrote:
> @@ -350,6 +351,18 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
>      struct virtio_net_ctrl_mac mac_data;
>      size_t s;
>  
> +    if (cmd == VIRTIO_NET_CTRL_MAC_ADDR_SET) {
> +        if (iov_size(iov, iov_cnt) != ETH_ALEN) {
> +            return VIRTIO_NET_ERR;
> +        }
> +        s = iov_to_buf(iov, iov_cnt, 0, &n->mac, sizeof(n->mac));
> +        if (s != sizeof(n->mac)) {
> +            return VIRTIO_NET_ERR;
> +        }

Since iov_size() was checked before iov_to_buf(), we never hit this
error.  And if we did n->mac would be trashed (i.e. error handling is
not complete).

I think assert(s == sizeof(n->mac)) is more appropriate appropriate.
Also, please change ETH_ALEN to sizeof(n->mac) to make the relationship
between the check and the copy clear.

Stefan
