From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio-net: correctly set xdp_xmit for
	mergeable buffer
Date: Fri, 22 Sep 2017 18:16:21 -0700 (PDT)
Message-ID: <20170922.181621.639395877867842082.davem__18078.6430057653$1506129408$gmane$org@davemloft.net>
References: <1506062338-3617-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1506062338-3617-1-git-send-email-jasowang@redhat.com>
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
Date: Fri, 22 Sep 2017 14:38:58 +0800

> We should set xdp_xmit only when xdp_do_redirect() succeed.
> 
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied, thanks Jason.
