From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next 1/3] virtio_net: set multicast filter list to host
Date: Mon, 9 Dec 2013 16:16:32 -0800
Message-ID: <20131209161632.5ac96e5a__2695.59370722181$1386634754$gmane$org@nehalam.linuxnetplumber.net>
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
To: David Miller <davem@davemloft.net>, Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio_net driver never sends the multicast address list to
the host. This is because send command takes a pointer to scatter list
to send but only inserts that one entry into the outgoing scatter list.

This bug has been there since:
commit f565a7c259d71cc186753653d978c646d2354b36
Author: Alex Williamson <alex.williamson@hp.com>
Date:   Wed Feb 4 09:02:45 2009 +0000

    virtio_net: Add a MAC filter table

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

--- a/drivers/net/virtio_net.c	2013-12-09 16:12:03.897891975 -0800
+++ b/drivers/net/virtio_net.c	2013-12-09 16:12:36.353164803 -0800
@@ -893,7 +893,7 @@ static bool virtnet_send_command(struct
 	sg_init_one(&hdr, &ctrl, sizeof(ctrl));
 	sgs[out_num++] = &hdr;
 
-	if (out)
+	for (; out; out = sg_next(out))
 		sgs[out_num++] = out;
 	if (in)
 		sgs[out_num + in_num++] = in;
