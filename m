From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next v3 4/4] net: vhost: add rx busy polling in tx path
Date: Sat, 30 Jun 2018 09:03:03 +0200
Message-ID: <20180630090303.043a06c7@redhat.com>
References: <1530340438-3039-1-git-send-email-xiangxia.m.yue@gmail.com>
	<1530340438-3039-5-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1530340438-3039-5-git-send-email-xiangxia.m.yue@gmail.com>
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
Cc: mst@redhat.com, netdev@vger.kernel.org, brouer@redhat.com, virtualization@lists.linux-foundation.org, Tonghao Zhang <zhangtonghao@didichuxing.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 29 Jun 2018 23:33:58 -0700
xiangxia.m.yue@gmail.com wrote:

> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> This patch improves the guest receive and transmit performance.
> On the handle_tx side, we poll the sock receive queue at the
> same time. handle_rx do that in the same way.
> 
> We set the poll-us=100us and use the iperf3 to test

Where/how do you configure poll-us=100us ?

Are you talking about /proc/sys/net/core/busy_poll ?


p.s. Nice performance boost! :-)

> its bandwidth, use the netperf to test throughput and mean
> latency. When running the tests, the vhost-net kthread of
> that VM, is alway 100% CPU. The commands are shown as below.
> 
> iperf3  -s -D
> iperf3  -c IP -i 1 -P 1 -t 20 -M 1400
> 
> or
> netserver
> netperf -H IP -t TCP_RR -l 20 -- -O "THROUGHPUT,MEAN_LATENCY"
> 
> host -> guest:
> iperf3:
> * With the patch:     27.0 Gbits/sec
> * Without the patch:  14.4 Gbits/sec
> 
> netperf (TCP_RR):
> * With the patch:     48039.56 trans/s, 20.64us mean latency
> * Without the patch:  46027.07 trans/s, 21.58us mean latency
> 
> This patch also improves the guest transmit performance.
> 
> guest -> host:
> iperf3:
> * With the patch:     27.2 Gbits/sec
> * Without the patch:  24.4 Gbits/sec
> 
> netperf (TCP_RR):
> * With the patch:     47963.25 trans/s, 20.71us mean latency
> * Without the patch:  45796.70 trans/s, 21.68us mean latency
> 
> Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
