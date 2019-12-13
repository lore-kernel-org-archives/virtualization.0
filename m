From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v12 0/3] netdev: ndo_tx_timeout cleanup
Date: Thu, 12 Dec 2019 21:48:15 -0800 (PST)
Message-ID: <20191212.214815.1246328093645167656.davem__7419.56338040239$1576216114$gmane$org@davemloft.net>
References: <20191210142305.52171-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191210142305.52171-1-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com
Cc: dnmendes76@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, jcfaracco@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 10 Dec 2019 09:23:47 -0500

> Yet another forward declaration I missed. Hopfully the last one ...
> 
> A bunch of drivers want to know which tx queue triggered a timeout,
> and virtio wants to do the same.
> We actually have the info to hand, let's just pass it on to drivers.
> Note: tested with an experimental virtio patch by Julio.
> That patch itself isn't ready yet though, so not included.
> Other drivers compiled only.

Series applied, will push out after build testing completes.

Thanks.
