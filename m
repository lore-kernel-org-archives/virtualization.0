From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 2/2] virtio: free transmit skbs when notified,
	not on next xmit.
Date: Mon, 19 Nov 2007 11:31:08 +0100
Message-ID: <200711191131.08630.borntraeger__23510.9737994664$1195468700$gmane$org@de.ibm.com>
References: <200711191120.15596.rusty@rustcorp.com.au>
	<200711191125.45065.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200711191125.45065.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, lguest <lguest@ozlabs.org>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, 19. November 2007 schrieb Rusty Russell:
> This fixes a potential dangling xmit problem.
> 
> We also suppress refill interrupts until we need them.
> (Anthony and I have been working on performance recently, so this
> is a WIP).
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Thanks Rusty,
that was the 2nd next item on my todo list :-)

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
