From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH RFC 2/5] vringfd base/offset
Date: Sat, 05 Apr 2008 12:18:59 -0500
Message-ID: <47F7B483.8090101__33661.6238266744$1207416047$gmane$org@codemonkey.ws>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<200804052204.28518.rusty__10896.9346424148$1207397431$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804052204.28518.rusty__10896.9346424148$1207397431$gmane$org@rustcorp.com.au>
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
> It turns out the lguest (and possibly kvm) want the addresses in the
> ring buffer to only cover a certain part of memory, and be offset.
> 
> It makes sense that this be an ioctl.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>

<snip>

> @@ -208,12 +232,15 @@ int vring_get_buffer(struct vring_info *
>  		out_len = &dummy;
>  
>  	*in_len = *out_len = 0;
> -	
> -	if (unlikely(get_user(head, &vr->ring.avail->ring[head]) != 0))
> +
> +	if (unlikely(get_user(head, &vr->ring.avail->ring[vr->last_avail
> +							  % vr->ring.num])))

Why not & with vr->mask for the sake of consistency with the rest of the 
code.

Regards,

Anthony Liguori
