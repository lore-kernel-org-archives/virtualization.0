From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V2] virtio_net: ethtool tx napi configuration
Date: Thu, 13 Sep 2018 15:52:53 -0700 (PDT)
Message-ID: <20180913.155253.713713547323242272.davem__46245.2813088477$1536879067$gmane$org@davemloft.net>
References: <20180913053545.18585-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180913053545.18585-1-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, willemb@google.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Sep 2018 13:35:45 +0800

> Toggle tx napi through a bit in tx-frames.

This is not what the code implements as the interface any more.

Please fix the commit message to match the code.

Thanks.
