From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: fix use after free
Date: Wed, 15 Oct 2014 16:47:27 -0400 (EDT)
Message-ID: <20141015.164727.298073723527552510.davem__43837.0198513896$1413406070$gmane$org@davemloft.net>
References: <1413378878-28118-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1413378878-28118-1-git-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 15 Oct 2014 16:23:28 +0300

> You used __netif_subqueue_stopped but that seems to use
> a slightly more expensive test_bit internally.

More expensive in what sense?  It should be roughly the same
as "x & y" sans the volatile.

Anyways I'm ambivalent and I want to see this bug fixes, so I'll
apply your patch.

Thanks!
