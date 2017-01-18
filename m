From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V5 0/3] vhost_net tx batching
Date: Wed, 18 Jan 2017 16:35:51 -0500 (EST)
Message-ID: <20170118.163551.1438116039860355723.davem__36715.3875450187$1496083262$gmane$org@davemloft.net>
References: <1484722923-7698-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1484722923-7698-1-git-send-email-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, wexu@redhat.com, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 18 Jan 2017 15:02:00 +0800

> This series tries to implement tx batching support for vhost. This was
> done by using MSG_MORE as a hint for under layer socket. The backend
> (e.g tap) can then batch the packets temporarily in a list and
> submit it all once the number of bacthed exceeds a limitation.
> 
> Tests shows obvious improvement on guest pktgen over over
> mlx4(noqueue) on host:
 ...

Series applied, thanks Jason.
