From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 0/4] Fix various issue of vhost
Date: Mon, 10 Dec 2018 11:47:02 -0800 (PST)
Message-ID: <20181210.114702.127499839186553253.davem__1420.98351284421$1544471113$gmane$org@davemloft.net>
References: <20181210094454.21144-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181210094454.21144-1-jasowang@redhat.com>
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
Date: Mon, 10 Dec 2018 17:44:50 +0800

> This series tries to fix various issues of vhost:
> 
> - Patch 1 adds a missing write barrier between used idx updating and
>   logging.
> - Patch 2-3 brings back the protection of device IOTLB through vq
>   mutex, this fixes possible use after free in device IOTLB entries.
> - Patch 4 fixes the diry page logging when device IOTLB is
>   enabled. We should done through GPA instead of GIOVA, this was done
>   through logging through iovec and traversing GPA->HPA list for the
>   GPA.
> 
> Please consider them for -stable.

Looks like the kbuild robot found some problems.

->used is a pointer (which might be 32-bit) and you're casting it to
a u64 in the translate_desc() calls of patch #4.

Please make sure that you don't actually require the full domain of
a u64 in these values, as obviously if vq->used is a pointer you will
only get a 32-bit domain on 32-bit architectures.
