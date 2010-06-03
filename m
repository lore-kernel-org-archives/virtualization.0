From: "Bruce Rogers" <brogers@novell.com>
Subject: [PATCH 2/3][STABLE] KVM: indicate oom if add_buf fails
Date: Thu, 03 Jun 2010 16:27:24 -0600
Message-ID: <4C07D7EC0200004800097507@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: rusty@rustcorp.com.au
Cc: virtualization@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch is a subset of an already upstream patch, but this portion is useful in earlier releases.
Please consider for the 2.6.32 and 2.6.33 stable trees.

    If the add_buf operation fails, indicate failure to the caller.
    Signed-off-by: Bruce Rogers <brogers@novell.com>

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c

@@ -318,6 +318,7 @@ static bool try_fill_recv_maxbufs(struct
                        skb_unlink(skb, &vi->recv);
                        trim_pages(vi, skb);
                        kfree_skb(skb);
+                       oom = true;
                        break;
                }
                vi->num++;
@@ -368,6 +369,7 @@ static bool try_fill_recv(struct virtnet
                if (err < 0) {
                        skb_unlink(skb, &vi->recv);
                        kfree_skb(skb);
+                       oom = true;
                        break;
                }
                vi->num++;
