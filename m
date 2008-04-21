From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [6/6] [VIRTIO] net: Allow receiving SG packets
Date: Tue, 22 Apr 2008 05:06:16 +1000
Message-ID: <200804220506.16887.rusty@rustcorp.com.au>
References: <20080418031257.GA17993@gondor.apana.org.au> <20080418032142.GD18071@gondor.apana.org.au> <20080418032427.GE18071@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20080418032427.GE18071@gondor.apana.org.au>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.osdl.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 18 April 2008 13:24:27 Herbert Xu wrote:
> Finally this patch lets virtio_net receive GSO packets in addition
> to sending them.
...
>  static void try_fill_recv(struct virtnet_info *vi)
>  {
>  	struct sk_buff *skb;
> -	struct scatterlist sg[1+MAX_SKB_FRAGS];
> +	struct scatterlist sg[2+MAX_SKB_FRAGS];
>  	int num, err;

I'm not sure what the right number is here.  Say worst case is header which 
goes over a page boundary then MAX_SKB_FRAGS in the skb, but for some reason 
that already has a +2:

/* To allow 64K frame to be packed as single skb without frag_list */
#define MAX_SKB_FRAGS (65536/PAGE_SIZE + 2)

Unless someone explains, I'll change the xmit sg to 2+MAX_SKB_FRAGS as well.

Thanks,
Rusty.
