From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] virtio-net: keep vnet header zeroed after
	processing XDP
Date: Fri, 30 Nov 2018 17:25:46 -0800 (PST)
Message-ID: <20181130.172546.127269245503154590.davem__16804.6079147191$1543627426$gmane$org@davemloft.net>
References: <20181129055316.24090-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181129055316.24090-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Nov 2018 13:53:16 +0800

> We copy vnet header unconditionally in page_to_skb() this is wrong
> since XDP may modify the packet data. So let's keep a zeroed vnet
> header for not confusing the conversion between vnet header and skb
> metadata.
> 
> In the future, we should able to detect whether or not the packet was
> modified and keep using the vnet header when packet was not touched.
> 
> Fixes: f600b6905015 ("virtio_net: Add XDP support")
> Reported-by: Pavel Popa <pashinho1990@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks.
