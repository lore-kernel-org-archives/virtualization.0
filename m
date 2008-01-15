From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] skb_partial_csum_set
Date: Tue, 15 Jan 2008 03:14:22 -0800 (PST)
Message-ID: <20080115.031422.06112893.davem__48407.1546736688$1200412009$gmane$org@davemloft.net>
References: <200801152141.56172.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801152141.56172.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 15 Jan 2008 21:41:55 +1100

> Implement skb_partial_csum_set, for setting partial csums on untrusted packets.
> 
> Use it in virtio_net (replacing buggy version there), it's also going
> to be used by TAP for partial csum support.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Looks fine to me.

Acked-by: David S. Miller <davem@davemloft.net>

If you like I can merge this into my net-2.6.25 tree, or alternatively
if it makes your life easier you then you can handle it yourself.
