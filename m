From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio_net: add gro capability
Date: Fri, 31 Jul 2015 16:57:32 -0700 (PDT)
Message-ID: <20150731.165732.2136164140565390142.davem__3394.87697133354$1438387072$gmane$org@davemloft.net>
References: <1438359917.2748.18.camel@edumazet-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1438359917.2748.18.camel@edumazet-glaptop2.roam.corp.google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: eric.dumazet@gmail.com
Cc: netdev@vger.kernel.org, rick.jones2@hp.com, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Fri, 31 Jul 2015 18:25:17 +0200

> From: Eric Dumazet <edumazet@google.com>
> 
> Straightforward patch to add GRO processing to virtio_net.
> 
 ...
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Rick Jones <rick.jones2@hp.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Michael, please review :-)
