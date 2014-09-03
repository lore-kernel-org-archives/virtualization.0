From: Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 1/3] virtio_net: pass well-formed sgs to virtqueue_add_*()
Date: Wed, 3 Sep 2014 12:23:50 +0200
Message-ID: <20140903122350.1c365bee__21044.1485899084$1409932539$gmane$org@redhat.com>
References: <1409718556-3041-1-git-send-email-rusty@rustcorp.com.au>
	<1409718556-3041-2-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1409718556-3041-2-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev <netdev@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, brouer@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed,  3 Sep 2014 13:59:14 +0930
Rusty Russell <rusty@rustcorp.com.au> wrote:

> pktgen results:
> 	modprobe pktgen
> 	echo 'add_device eth0' > /proc/net/pktgen/kpktgend_0
> 	echo nowait 1 > /proc/net/pktgen/eth0

Maybe your pktgen "nowait" (patch) should be a flag instead?

 echo "flag EXIT_NO_WAIT" > /proc/net/pktgen/eth0

> 	echo count 1000000 > /proc/net/pktgen/eth0
> 	echo clone_skb 100000 > /proc/net/pktgen/eth0
> 	echo dst_mac 4e:14:25:a9:30:ac > /proc/net/pktgen/eth0
> 	echo dst 192.168.1.2 > /proc/net/pktgen/eth0
> 	for i in `seq 20`; do echo start > /proc/net/pktgen/pgctrl; tail -n1 /proc/net/pktgen/eth0; done
> 


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Sr. Network Kernel Developer at Red Hat
  Author of http://www.iptv-analyzer.org
  LinkedIn: http://www.linkedin.com/in/brouer
