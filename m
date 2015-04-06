From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio: document queue state logic
Date: Mon, 06 Apr 2015 16:44:49 -0400 (EDT)
Message-ID: <20150406.164449.1091214597663452067.davem__44648.4784399674$1428353106$gmane$org@davemloft.net>
References: <20150402125743-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150402125743-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Thu, 2 Apr 2015 13:05:47 +0200

> commit d631b94e7a15277858ec5f88d674d93080506999
>     virtio: change comment in transmit
> 
> started clarifying the logic behind queue state management,
> but introduced an inaccuracy: TX_BUSY does not cause
> a BUG message.
> 
> Clean this up some more, explaining the tradeoffs in detail.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks Michael.
