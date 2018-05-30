From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost_net: flush batched heads before trying to
	busy polling
Date: Wed, 30 May 2018 13:31:04 -0400 (EDT)
Message-ID: <20180530.133104.1841137099094945800.davem__9356.15091952986$1527701367$gmane$org@davemloft.net>
References: <1527574699-13047-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1527574699-13047-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 May 2018 14:18:19 +0800

> After commit e2b3b35eb989 ("vhost_net: batch used ring update in rx"),
> we tend to batch updating used heads. But it doesn't flush batched
> heads before trying to do busy polling, this will cause vhost to wait
> for guest TX which waits for the used RX. Fixing by flush batched
> heads before busy loop.
> 
> 1 byte TCP_RR performance recovers from 13107.83 to 50402.65.
> 
> Fixes: e2b3b35eb989 ("vhost_net: batch used ring update in rx")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
