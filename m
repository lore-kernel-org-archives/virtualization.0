From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v9 0/6] net: vhost: improve performance when
	enable busyloop
Date: Sun, 09 Sep 2018 08:01:16 -0700 (PDT)
Message-ID: <20180909.080116.2052458616381152153.davem@davemloft.net>
References: <1536493887-2637-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1536493887-2637-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: xiangxia.m.yue@gmail.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: xiangxia.m.yue@gmail.com
Date: Sun,  9 Sep 2018 04:51:21 -0700

> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This patches improve the guest receive performance.
> On the handle_tx side, we poll the sock receive queue
> at the same time. handle_rx do that in the same way.
> 
> For more performance report, see patch 4, 5, 6

I only see patches 1-4.
