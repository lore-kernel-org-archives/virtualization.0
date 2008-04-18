From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [2/6] [TUN]: Add GSO detection
Date: Fri, 18 Apr 2008 11:15:54 +0800
Message-ID: <20080418031554.GA18071@gondor.apana.org.au>
References: <20080418031257.GA17993@gondor.apana.org.au>
	<20080418031444.GA18041@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080418031444.GA18041@gondor.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This is Rusty's second patch to tun to allow user-space access
to the GSO feature in a backwards compatible way.

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 34a03ec..4c15dc4 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -800,6 +800,15 @@ static int tun_chr_ioctl(struct inode *inode, struct file *file,
 		return 0;
 	}
 
+	if (cmd == TUNGETFEATURES) {
+		/* Currently this just means: "what IFF flags are valid?".
+		 * This is needed because we never checked for invalid flags on
+		 * TUNSETIFF.  This was introduced with IFF_GSO_HDR, so if a
+		 * kernel doesn't have this ioctl, it doesn't have GSO header
+		 * support. */
+		return put_user(IFF_ALL_FLAGS, (unsigned int __user*)argp);
+	}
+
 	if (!tun)
 		return -EBADFD;
 
diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
index 3dbef10..fe6855d 100644
--- a/include/linux/if_tun.h
+++ b/include/linux/if_tun.h
@@ -84,6 +84,7 @@ struct tun_struct {
 #define TUNSETOWNER   _IOW('T', 204, int)
 #define TUNSETLINK    _IOW('T', 205, int)
 #define TUNSETGROUP   _IOW('T', 206, int)
+#define TUNGETFEATURES _IOR('T', 207, unsigned int)
 
 /* TUNSETIFF ifr flags */
 #define IFF_TUN		0x0001
@@ -93,6 +94,8 @@ struct tun_struct {
 #define IFF_VIRTIO_HDR	0x4000
 #define IFF_RECV_CSUM	0x8000
 #define IFF_RECV_GSO	0x0800
+#define IFF_ALL_FLAGS (IFF_TUN | IFF_TAP | IFF_NO_PI | IFF_ONE_QUEUE | \
+		       IFF_VIRTIO_HDR | IFF_RECV_CSUM | IFF_RECV_GSO)
 
 struct tun_pi {
 	unsigned short flags;
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
