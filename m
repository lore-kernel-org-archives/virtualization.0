From: Patrick Ohly <patrick.ohly@intel.com>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Mon, 01 Jun 2009 21:47:22 +0200
Message-ID: <1243885642.22917.35.camel__13681.6014921807$1243955848$gmane$org@pohly-MOBL>
References: <200905292344.56814.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905292344.56814.rusty@rustcorp.com.au>
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
Cc: libertas-dev@lists.infradead.org, Dan Williams <dcbw@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Roland Dreier <rolandd@cisco.com>, Divy Le Ray <divy@chelsio.com>, Pavel Emelianov <xemul@openvz.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2009-05-29 at 23:44 +0930, Rusty Russell wrote:
> This patch adds skb_orphan to the start of dev_hard_start_xmit(): it
> can be premature in the NETDEV_TX_BUSY case, but that's uncommon.

Would it be possible to make the new skb_orphan() at the start of
dev_hard_start_xmit() conditionally so that it is not executed for
packets that are to be time stamped?

As discussed before
(http://article.gmane.org/gmane.linux.network/121378/), the skb->sk
socket pointer is required for sending back the send time stamp from
inside the device driver. Calling skb_orphan() unconditionally as in
this patch would break the hardware time stamping of outgoing packets.

This should work without much overhead (skb_tx() expands to a lookup of
the skb_shared_info):
if (!skb_tx(skb)->flags)
    skb_orphan(skb);

Instead of looking at the individual skb_shared_tx "hardware" and
"software" bits I'm just checking the whole byte here because it is
shorter and perhaps faster. Semantically the result is the same.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
