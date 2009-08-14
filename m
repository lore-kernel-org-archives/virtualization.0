From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv3 2/2] vhost_net: a kernel-level virtio server
Date: Fri, 14 Aug 2009 13:40:36 +0200
Message-ID: <200908141340.36176.arnd__27714.7465771579$1250250491$gmane$org@arndb.de>
References: <cover.1250187913.git.mst@redhat.com>
	<20090813182931.GC6585@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813182931.GC6585@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 13 August 2009, Michael S. Tsirkin wrote:
> What it is: vhost net is a character device that can be used to reduce
> the number of system calls involved in virtio networking.
> Existing virtio net code is used in the guest without modification.

AFAICT, you have addressed all my comments, mostly by convincing me
that you got it right anyway ;-).

I hope this gets into 2.6.32, good work!

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

One idea though:

> +	/* Parameter checking */
> +	if (sock->sk->sk_type != SOCK_RAW) {
> +		r = -ESOCKTNOSUPPORT;
> +		goto done;
> +	}
> +
> +	r = sock->ops->getname(sock, (struct sockaddr *)&uaddr.sa,
> +			       &uaddr_len, 0);
> +	if (r)
> +		goto done;
> +
> +	if (uaddr.sa.sll_family != AF_PACKET) {
> +		r = -EPFNOSUPPORT;
> +		goto done;
> +	}

You currently limit the scope of the driver by only allowing raw packet
sockets to be passed into the network driver. In qemu, we currently support
some very similar transports:

* raw packet (not in a release yet)
* tcp connection
* UDP multicast
* tap character device
* VDE with Unix local sockets

My primary interest right now is the tap support, but I think it would
be interesting in general to allow different file descriptor types
in vhost_net_set_socket. AFAICT, there are two major differences
that we need to handle for this:

* most of the transports are sockets, tap uses a character device.
  This could be dealt with by having both a struct socket * in
  struct vhost_net *and* a struct file *, or by always keeping the
  struct file and calling vfs_readv/vfs_writev for the data transport
  in both cases.

* Each transport has a slightly different header, we have
  - raw ethernet frames (raw, udp multicast, tap)
  - 32-bit length + raw frames, possibly fragmented (tcp)
  - 80-bit header + raw frames, possibly fragmented (tap with vnet_hdr)
  To handle these three cases, we need either different ioctl numbers
  so that vhost_net can choose the right one, or a flags field in
  VHOST_NET_SET_SOCKET, like

  #define VHOST_NET_RAW		1
  #define VHOST_NET_LEN_HDR	2
  #define VHOST_NET_VNET_HDR	4

  struct vhost_net_socket {
	unsigned int flags;
	int fd;
  };
  #define VHOST_NET_SET_SOCKET _IOW(VHOST_VIRTIO, 0x30, struct vhost_net_socket)

If both of those are addressed, we can treat vhost_net as a generic
way to do network handling in the kernel independent of the qemu
model (raw, tap, ...) for it. 

Your qemu patch would have to work differently, so instead of 

qemu -net nic,vhost=eth0

you would do the same as today with the raw packet socket extension

qemu -net nic -net raw,ifname=eth0 

Qemu could then automatically try to use vhost_net, if it's available
in the kernel, or just fall back on software vlan otherwise.
Does that make sense?

	Arnd <>
