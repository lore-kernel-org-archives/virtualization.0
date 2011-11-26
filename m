From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] vhost-net: Acquire device lock when releasing device
Date: Sat, 26 Nov 2011 15:45:03 -0500 (EST)
Message-ID: <20111126.154503.1317670837061338352.davem__28810.1438702599$1322361290$gmane$org@davemloft.net>
References: <1321607982-16283-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321607982-16283-1-git-send-email-levinsasha928@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: levinsasha928@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Sasha Levin <levinsasha928@gmail.com>
Date: Fri, 18 Nov 2011 11:19:42 +0200

> Device lock should be held when releasing a device, and specifically
> when calling vhost_dev_cleanup(). Otherwise, RCU complains about it:
 ...
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Sasha Levin <levinsasha928@gmail.com>

Michael et al., are you guys going to gather this fix or should I
apply it directly to thet net tree?

Thanks.
