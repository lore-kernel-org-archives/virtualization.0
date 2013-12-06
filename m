From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] virtio-net: free bufs correctly on invalid packet
	length
Date: Fri, 06 Dec 2013 16:32:35 -0500 (EST)
Message-ID: <20131206.163235.687717622324552173.davem__21580.9967754923$1386365569$gmane$org@davemloft.net>
References: <1386278045-23542-1-git-send-email-mwdalton@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1386278045-23542-1-git-send-email-mwdalton@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mwdalton@google.com
Cc: avagin@openvz.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com
List-Id: virtualization@lists.linuxfoundation.org

From: Michael Dalton <mwdalton@google.com>
Date: Thu,  5 Dec 2013 13:14:05 -0800

> When a packet with invalid length arrives, ensure that the packet
> is freed correctly if mergeable packet buffers and big packets
> (GUEST_TSO4) are both enabled.
> 
> Signed-off-by: Michael Dalton <mwdalton@google.com>

Applied, is this needed for -stable?
