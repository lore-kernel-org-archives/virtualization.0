From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] virtio_net: remove hcpu from virtnet_clean_affinity
Date: Mon, 18 Mar 2019 22:26:54 -0700 (PDT)
Message-ID: <20190318.222654.406823620667582106.davem__20321.2526555703$1552973362$gmane$org@davemloft.net>
References: <20190318065606.17100-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190318065606.17100-1-peterx@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: peterx@redhat.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Peter Xu <peterx@redhat.com>
Date: Mon, 18 Mar 2019 14:56:06 +0800

> The variable is never used.
> 
> CC: Michael S. Tsirkin <mst@redhat.com>
> CC: Jason Wang <jasowang@redhat.com>
> CC: virtualization@lists.linux-foundation.org
> CC: netdev@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>

This looks rather uncontroversial and straightforward so I've applied
this to net-next.

Thanks.
