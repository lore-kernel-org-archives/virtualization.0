From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V3 0/3] Fix various issue of vhost
Date: Wed, 12 Dec 2018 21:57:17 -0800 (PST)
Message-ID: <20181212.215717.702103892928039727.davem__7366.8307428763$1544680519$gmane$org@davemloft.net>
References: <20181213025339.14023-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
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
Date: Thu, 13 Dec 2018 10:53:36 +0800

> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> 
> Please consider them for -stable.
> 
> Thanks
> 
> Changes from V2:
> - drop dirty page fix and make it for net-next
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.

Series applied and queued up for -stable, thanks Jason.
