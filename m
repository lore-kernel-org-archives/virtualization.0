From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 3/3] virtio-net: support XDP_REDIRECT
Date: Wed, 20 Sep 2017 14:28:21 -0700 (PDT)
Message-ID: <20170920.142821.2032300208230027682.davem__7014.32985156334$1505942909$gmane$org@davemloft.net>
References: <1505814163-7315-1-git-send-email-jasowang@redhat.com>
	<1505814163-7315-3-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1505814163-7315-3-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 19 Sep 2017 17:42:43 +0800

> This patch tries to add XDP_REDIRECT for virtio-net. The changes are
> not complex as we could use exist XDP_TX helpers for most of the
> work. The rest is passing the XDP_TX to NAPI handler for implementing
> batching.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied.
