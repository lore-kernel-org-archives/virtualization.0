From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2 0/4] Fix various issue of vhost
Date: Wed, 12 Dec 2018 15:31:34 -0800 (PST)
Message-ID: <20181212.153134.1249380470735153418.davem__32428.6967902028$1544657374$gmane$org@davemloft.net>
References: <20181212100819.21295-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212100819.21295-1-jasowang@redhat.com>
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
Date: Wed, 12 Dec 2018 18:08:15 +0800

> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> - Patch 4-7 fixes the diry page logging when device IOTLB is
>   enabled. We should done through GPA instead of GIOVA, this was done
>   through intorudce HVA->GPA reverse mapping and convert HVA to GPA
>   during logging dirty pages.
> 
> Please consider them for -stable.
> 
> Thanks
> 
> Changes from V1:
> - silent compiler warning for 32bit.
> - use mutex_trylock() on slowpath instead of mutex_lock() even on fast
>   path.

Hello Jason.

Look like Michael wants you to split out patch #4 and target
net-next with it.

So please do that and respin the first 3 patches here with Michael's
ACKs.

Thanks.
