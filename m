From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] netdevice: document NETDEV_TX_BUSY deprecation.
Date: Fri, 03 Apr 2015 12:37:53 -0400 (EDT)
Message-ID: <20150403.123753.1902372072873141931.davem__46542.0620669194$1428079091$gmane$org@davemloft.net>
References: <20150402125743-mutt-send-email-mst@redhat.com>
	<87pp7l5t8a.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pp7l5t8a.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>
Date: Fri, 03 Apr 2015 22:17:17 +1030

> This paraphrases DaveM (and steals some of his words) explaining why
> a device shouldn't return NETDEV_TX_BUSY, even though it looks so inviting
> to driver authors.
> 
> See http://www.spinics.net/lists/netdev/msg322350.html
> 
> Inspired-by: David Miller <davem@davemloft.net>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

Applied.
