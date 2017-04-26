From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] virtio-net: on tx, only call napi_disable if
	tx napi is on
Date: Wed, 26 Apr 2017 14:50:23 -0400 (EDT)
Message-ID: <20170426.145023.520426501343191968.davem__4552.95843207768$1493232631$gmane$org@davemloft.net>
References: <20170425195917.54209-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170425195917.54209-1-willemdebruijn.kernel@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, willemb@google.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 25 Apr 2017 15:59:17 -0400

> From: Willem de Bruijn <willemb@google.com>
> 
> As of tx napi, device down (`ip link set dev $dev down`) hangs unless
> tx napi is enabled. Else napi_enable is not called, so napi_disable
> will spin on test_and_set_bit NAPI_STATE_SCHED.
> 
> Only call napi_disable if tx napi is enabled.
> 
> Fixes: 5a719c2552ca ("virtio-net: transmit napi")
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Applied, thanks.
