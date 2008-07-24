From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/4] tun: Allow GSO using virtio_net_hdr
Date: Fri, 25 Jul 2008 09:54:18 +1000
Message-ID: <200807250954.19120.rusty__16499.2052400068$1216943954$gmane$org@rustcorp.com.au>
References: <200806260028.07883.rusty@rustcorp.com.au>
	<200806260030.38293.rusty@rustcorp.com.au>
	<20080724142044.GA8266@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080724142044.GA8266@gondor.apana.org.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: markmc@redhat.com, netdev@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 25 July 2008 00:20:44 Herbert Xu wrote:
> On Thu, Jun 26, 2008 at 12:30:37AM +1000, Rusty Russell wrote:
> > Add a IFF_VNET_HDR flag.  This uses the same ABI as virtio_net (ie.
> > prepending struct virtio_net_hdr to packets) to indicate GSO and checksum
> > information.
> >
> > Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> I just noticed that we still allocate a linear skb even when GSO
> is enabled.  Please fix this by allocating page frags where
> necessary.  Otherwise GSO is only going to work before memory
> fragmentation sets in.
>
> IIRC I'd sent out a patch to the virt mailing list with code
> that did this.
>
> Thanks,

Hi Herbert,

   Thanks for the reminder.  I have this code in the virtio_net patches which 
Linus failed to pull.  Will just need to share it with the tun code (maybe a 
skb_alloc_large() helper).

Cheers,
Rusty.
