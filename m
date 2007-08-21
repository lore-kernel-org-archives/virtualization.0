From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: bug in virtio network driver?
Date: Tue, 21 Aug 2007 10:48:33 +0200
Message-ID: <200708211048.33534.borntraeger__641.831305301999$1187686228$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

I think I have found a problem in the virtio network driver. virtio_net 
reclaims sent skbs on xmit. That means that there is always one skb 
outstanding and the netdev packet statistic is always one packet to low.

Documentation/networking/drivers.txt says

3) Do not forget that once you return 0 from your hard_start_xmit
   method, it is your driver's responsibility to free up the SKB
   and in some finite amount of time.

   For example, this means that it is not allowed for your TX
   mitigation scheme to let TX packets "hang out" in the TX
   ring unreclaimed forever if no new TX packets are sent.
   This error can deadlock sockets waiting for send buffer room
   to be freed up.

One solution would be to use the xmit_done interrupt. Unfortunately this would 
require additional locking as multiple interrupts can happen at two or more 
cpus. Do you have any better ideas?

Christian
