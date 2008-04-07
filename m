From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [PATCH] virtio: remove overzealous BUG_ON.
Date: Mon, 07 Apr 2008 08:50:24 -0500
Message-ID: <47FA26A0.3020701__36607.1307719269$1207576429$gmane$org@codemonkey.ws>
References: <200804071430.28399.rusty__35361.6672721275$1207542780$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804071430.28399.rusty__35361.6672721275$1207542780$gmane$org@rustcorp.com.au>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> The 'disable_cb' callback is designed as an optimization to tell the host
> we don't need callbacks now.  As it is not reliable, the debug check is
> overzealous: it can happen on two CPUs at the same time.  Document this.
> 
> Even if it were reliable, the virtio_net driver doesn't disable
> callbacks on transmit so the START_USE/END_USE debugging reentrance
> protection can be easily tripped even on UP.
> 
> Thanks to Balaji Rao for the bug report and testing.

I think the printk() in start_xmit should be removed too (or at least 
rate limited).

Regards,

Anthony Liguori
