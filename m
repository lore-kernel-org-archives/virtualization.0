From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RFC 3/5] tun: vringfd receive support.
Date: Sat, 05 Apr 2008 12:26:57 -0500
Message-ID: <47F7B661.6090606__9429.64990758828$1207416547$gmane$org@codemonkey.ws>
References: <200804052202.09157.rusty@rustcorp.com.au>	<200804052204.28518.rusty@rustcorp.com.au>
	<200804052205.43824.rusty__2650.41595926068$1207397436$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052205.43824.rusty__2650.41595926068$1207397436$gmane$org@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> This patch modifies tun to allow a vringfd to specify the receive
> buffer.  Because we can't copy to userspace in bh context, we queue
> like normal then use the "pull" hook to actually do the copy.
> 
> More thought needs to be put into the possible races with ring
> registration and a simultaneous close, for example (see FIXME).
> 
> We use struct virtio_net_hdr prepended to packets in the ring to allow
> userspace to receive GSO packets in future (at the moment, the tun
> driver doesn't tell the stack it can handle them, so these cases are
> never taken).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

<snip>

> +
> +#ifdef CONFIG_VRINGFD

I think the rest of the code needs these for it to actually work without 
VRINGFD.

> +static void unset_recv(void *_tun)
> +{
> +	struct tun_struct *tun = _tun;
> +
> +	tun->inring = NULL;
> +}
> +
> +/* Returns number of used buffers, or negative errno. */
> +static int pull_recv_skbs(void *_tun)
> +{
> +	struct tun_struct *tun = _tun;
> +	int err = 0, num_copied = 0;
> +	struct sk_buff *skb;
> +
> +	while ((skb = skb_dequeue(&tun->readq)) != NULL) {
> +		struct iovec iov[1+MAX_SKB_FRAGS];
> +		struct virtio_net_hdr gso = { 0 }; /* no info leak */
> +		unsigned int iovnum = ARRAY_SIZE(iov);
> +		unsigned long len;
> +		int id;
> +
> +		id = vring_get_buffer(tun->inring, iov, &iovnum, &len,
> +				      NULL, NULL, NULL);
> +		if (id <= 0) {
> +			err = id;
> +			break;
> +		}

Ah, I see now why you're passing something from the stack.

Regards,

Anthony Liguori
