From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 2/2] virtio-net: simplify XDP handling in small
	buffer
Date: Thu, 1 Mar 2018 09:02:06 +0100
Message-ID: <20180301090206.04e13a71__2782.36588133058$1519891217$gmane$org@redhat.com>
References: <1519874345-10235-1-git-send-email-jasowang@redhat.com>
	<1519874345-10235-3-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1519874345-10235-3-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


On Thu,  1 Mar 2018 11:19:05 +0800 Jason Wang <jasowang@redhat.com> wrote:

> We used to do data copy through xdp_linearize_page() for the buffer
> without sufficient headroom, it brings extra complexity without
> helping for the performance. So this patch remove it and switch to use
> generic XDP routine to handle this case.

I don't like where this is going.  I don't like intermixing the native
XDP and generic XDP in this way, for several reasons:

1. XDP generic is not feature complete, e.g. cpumap will drop these
   packets. It might not be possible to implement some features, think
   of (AF_XDP) zero-copy.

2. This can easily cause out-of-order packets.

3. It makes it harder to troubleshoot, when diagnosing issues
   around #1, we have a hard time determining what path an XDP packet
   took (the xdp tracepoints doesn't know).


[...]
> @@ -590,25 +526,14 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  		if (unlikely(hdr->hdr.gso_type))
>  			goto err_xdp;
>  
> +		/* This happnes when headroom is not enough because
> +		 * the buffer was refilled before XDP is set. This
> +		 * only happen for several packets, for simplicity,
> +		 * offload them to generic XDP routine.

In my practical tests, I also saw that sometime my ping packets were
traveling this code-path, even after a long time when XDP were attached.

This worries me a bit, for troubleshooting purposes... as this can give
a strange user experience given point #1.


> +		 */
>  		if (unlikely(xdp_headroom < virtnet_get_headroom(vi))) {
> -			int offset = buf - page_address(page) + header_offset;
> -			unsigned int tlen = len + vi->hdr_len;
> -			u16 num_buf = 1;


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
