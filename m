From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V4] vhost: log dirty page correctly
Date: Thu, 17 Jan 2019 11:58:55 -0800 (PST)
Message-ID: <20190117.115855.725358558291814993.davem__21229.1419077248$1547755256$gmane$org@davemloft.net>
References: <20190116085442.3836-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190116085442.3836-1-jasowang@redhat.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jintack@cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Jan 2019 16:54:42 +0800

> Vhost dirty page logging API is designed to sync through GPA. But we
> try to log GIOVA when device IOTLB is enabled. This is wrong and may
> lead to missing data after migration.
> 
> To solve this issue, when logging with device IOTLB enabled, we will:
> 
> 1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
>    get HVA, for writable descriptor, get HVA through iovec. For used
>    ring update, translate its GIOVA to HVA
> 2) traverse the GPA->HVA mapping to get the possible GPA and log
>    through GPA. Pay attention this reverse mapping is not guaranteed
>    to be unique, so we should log each possible GPA in this case.
> 
> This fix the failure of scp to guest during migration. In -next, we
> will probably support passing GIOVA->GPA instead of GIOVA->HVA.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Jintack Lim <jintack@cs.columbia.edu>
> Cc: Jintack Lim <jintack@cs.columbia.edu>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Michaell, can I get a review for this please?

Thank you.
