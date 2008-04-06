From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC 2/5] vringfd base/offset
Date: Sun, 6 Apr 2008 13:23:53 +1000
Message-ID: <200804061323.53566.rusty__23480.6425789886$1207452371$gmane$org@rustcorp.com.au>
References: <200804052202.09157.rusty@rustcorp.com.au>
	<200804052204.28518.rusty__10896.9346424148$1207397431$gmane$org@rustcorp.com.au>
	<47F7B483.8090101@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47F7B483.8090101@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 06 April 2008 03:18:59 Anthony Liguori wrote:
> Rusty Russell wrote:
> > -	if (unlikely(get_user(head, &vr->ring.avail->ring[head]) != 0))
> > +
> > +	if (unlikely(get_user(head, &vr->ring.avail->ring[vr->last_avail
> > +							  % vr->ring.num])))
>
> Why not & with vr->mask for the sake of consistency with the rest of the
> code.

Thanks, fixed.

Rusty.
