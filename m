From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/9] TX used ring batched updating for vhost
Date: Sat, 21 Jul 2018 21:44:05 -0700 (PDT)
Message-ID: <20180721.214405.519016522016153008.davem@davemloft.net>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
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
Date: Fri, 20 Jul 2018 08:15:12 +0800

> This series implement batch updating of used ring for TX. This help to
> reduce the cache contention on used ring. The idea is first split
> datacopy path from zerocopy, and do only batching for datacopy. This
> is because zercopy had already supported its own batching.
> 
> TX PPS was increased 25.8% and Netperf TCP does not show obvious
> differences.
> 
> The split of datapath will also be helpful for future implementation
> like in order completion.
> 
> Please review.

Jason, I really like the way you composed this patch series, it was
very easy to read and understand. :-)

Michael, please review.
