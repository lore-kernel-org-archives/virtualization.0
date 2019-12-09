From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v9 0/3] netdev: ndo_tx_timeout cleanup
Date: Mon, 09 Dec 2019 14:43:41 -0800 (PST)
Message-ID: <20191209.144341.154593651924539444.davem__10291.1345473089$1575931439$gmane$org@davemloft.net>
References: <20191209162727.10113-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191209162727.10113-1-mst@redhat.com>
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
Date: Mon, 9 Dec 2019 11:28:57 -0500

> A bunch of drivers want to know which tx queue triggered a timeout,
> and virtio wants to do the same.
> We actually have the info to hand, let's just pass it on to drivers.
> Note: tested with an experimental virtio patch by Julio.
> That patch itself isn't ready yet though, so not included.
> Other drivers compiled only.

Besides the "int" --> "unsigned int" typing issue, I never saw patch #2
neither on the mailing list nor directly sent to me.
