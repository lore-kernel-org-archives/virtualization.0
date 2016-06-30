From: John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next V4 5/6] net: introduce NETDEV_CHANGE_TX_QUEUE_LEN
Date: Thu, 30 Jun 2016 09:33:06 -0700
Message-ID: <577549C2.7010406__35814.244967378$1467395540$gmane$org@gmail.com>
References: <1467269136-8082-1-git-send-email-jasowang@redhat.com>
	<1467269136-8082-6-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1467269136-8082-6-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net
Cc: John Fastabend <john.r.fastabend@intel.com>, brouer@redhat.com, eric.dumazet@gmail.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 16-06-29 11:45 PM, Jason Wang wrote:
> This patch introduces a new event - NETDEV_CHANGE_TX_QUEUE_LEN, this
> will be triggered when tx_queue_len. It could be used by net device
> who want to do some processing at that time. An example is tun who may
> want to resize tx array when tx_queue_len is changed.
> 
> Cc: John Fastabend <john.r.fastabend@intel.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---


Thanks for adding the setlink case.

Acked-by: John Fastabend <john.r.fastabend@intel.com>
