From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 00/11] Vhost_net TX batching
Date: Thu,  6 Sep 2018 12:05:15 +0800
Message-ID: <20180906040526.22518-1-jasowang__28685.5626073249$1536206617$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi all:

This series tries to batch submitting packets to underlayer socket
through msg_control during sendmsg(). This is done by:

1) Doing userspace copy inside vhost_net
2) Build XDP buff
3) Batch at most 64 (VHOST_NET_BATCH) XDP buffs and submit them once
   through msg_control during sendmsg().
4) Underlayer sockets can use XDP buffs directly when XDP is enalbed,
   or build skb based on XDP buff.

For the packet that can not be built easily with XDP or for the case
that batch submission is hard (e.g sndbuf is limited). We will go for
the previous slow path, passing iov iterator to underlayer socket
through sendmsg() once per packet.

This can help to improve cache utilization and avoid lots of indirect
calls with sendmsg(). It can also co-operate with the batching support
of the underlayer sockets (e.g the case of XDP redirection through
maps).

Testpmd(txonly) in guest shows obvious improvements:

Test                /+pps%
XDP_DROP on TAP     /+44.8%
XDP_REDIRECT on TAP /+29%
macvtap (skb)       /+26%

Netperf TCP_STREAM TX from guest shows obvious improvements on small
packet:

    size/session/+thu%/+normalize%
       64/     1/   +2%/    0%
       64/     2/   +3%/   +1%
       64/     4/   +7%/   +5%
       64/     8/   +8%/   +6%
      256/     1/   +3%/    0%
      256/     2/  +10%/   +7%
      256/     4/  +26%/  +22%
      256/     8/  +27%/  +23%
      512/     1/   +3%/   +2%
      512/     2/  +19%/  +14%
      512/     4/  +43%/  +40%
      512/     8/  +45%/  +41%
     1024/     1/   +4%/    0%
     1024/     2/  +27%/  +21%
     1024/     4/  +38%/  +73%
     1024/     8/  +15%/  +24%
     2048/     1/  +10%/   +7%
     2048/     2/  +16%/  +12%
     2048/     4/    0%/   +2%
     2048/     8/    0%/   +2%
     4096/     1/  +36%/  +60%
     4096/     2/  -11%/  -26%
     4096/     4/    0%/  +14%
     4096/     8/    0%/   +4%
    16384/     1/   -1%/   +5%
    16384/     2/    0%/   +2%
    16384/     4/    0%/   -3%
    16384/     8/    0%/   +4%
    65535/     1/    0%/  +10%
    65535/     2/    0%/   +8%
    65535/     4/    0%/   +1%
    65535/     8/    0%/   +3%

Please review.

Thanks

Jason Wang (11):
  net: sock: introduce SOCK_XDP
  tuntap: switch to use XDP_PACKET_HEADROOM
  tuntap: enable bh early during processing XDP
  tuntap: simplify error handling in tun_build_skb()
  tuntap: tweak on the path of non-xdp case in tun_build_skb()
  tuntap: split out XDP logic
  tuntap: move XDP flushing out of tun_do_xdp()
  tun: switch to new type of msg_control
  tuntap: accept an array of XDP buffs through sendmsg()
  tap: accept an array of XDP buffs through sendmsg()
  vhost_net: batch submitting XDP buffers to underlayer sockets

 drivers/net/tap.c      |  87 +++++++++++++-
 drivers/net/tun.c      | 251 +++++++++++++++++++++++++++++++----------
 drivers/vhost/net.c    | 171 +++++++++++++++++++++++++---
 include/linux/if_tun.h |   7 ++
 include/net/sock.h     |   1 +
 5 files changed, 437 insertions(+), 80 deletions(-)

-- 
2.17.1
