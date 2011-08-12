From: Jason Wang <jasowang@redhat.com>
Subject: [net-next RFC PATCH 2/7] tuntap: categorize ioctl
Date: Fri, 12 Aug 2011 09:55:00 +0800
Message-ID: <20110812015500.31613.29559.stgit__34508.2904714674$1313114325$gmane$org@intel-e5620-16-2.englab.nay.redhat.com>
References: <20110812015221.31613.95001.stgit@intel-e5620-16-2.englab.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110812015221.31613.95001.stgit@intel-e5620-16-2.englab.nay.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, netdev@vger.kernel.org, jasowang@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
Cc: krkumar2@in.ibm.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, mirq-linux@rere.qmqm.pl
List-Id: virtualization@lists.linuxfoundation.org

As we've moved socket related structure to
file->private_data, we can separate system calls that only
touch tfile from others as they don't need hold rtnl lock.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c |   52 ++++++++++++++++++++++++++++++++++------------------
 1 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 2739887..4cd292a 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1240,10 +1240,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 	struct tun_file *tfile = file->private_data;
 	struct tun_struct *tun;
 	void __user* argp = (void __user*)arg;
-	struct sock_fprog fprog;
 	struct ifreq ifr;
-	int sndbuf;
-	int vnet_hdr_sz;
 	int ret;
 
 	if (cmd == TUNSETIFF || _IOC_TYPE(cmd) == 0x89)
@@ -1348,14 +1345,6 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = set_offload(tun, arg);
 		break;
 
-	case TUNSETTXFILTER:
-		/* Can be set only for TAPs */
-		ret = -EINVAL;
-		if ((tfile->flags & TUN_TYPE_MASK) != TUN_TAP_DEV)
-			break;
-		ret = update_filter(&tfile->txflt, (void __user *)arg);
-		break;
-
 	case SIOCGIFHWADDR:
 		/* Get hw address */
 		memcpy(ifr.ifr_hwaddr.sa_data, tun->dev->dev_addr, ETH_ALEN);
@@ -1372,6 +1361,37 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		ret = dev_set_mac_address(tun->dev, &ifr.ifr_hwaddr);
 		break;
 
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+unlock:
+	rtnl_unlock();
+	if (tun)
+		tun_put(tun);
+	return ret;
+}
+
+static long __tun_socket_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long arg, int ifreq_len)
+{
+	struct tun_file *tfile = file->private_data;
+	void __user* argp = (void __user*)arg;
+	struct sock_fprog fprog;
+	int sndbuf;
+	int vnet_hdr_sz;
+	int ret = 0;
+
+	switch (cmd) {
+	case TUNSETTXFILTER:
+		/* Can be set only for TAPs */
+		ret = -EINVAL;
+		if ((tfile->flags & TUN_TYPE_MASK) != TUN_TAP_DEV)
+			break;
+		ret = update_filter(&tfile->txflt, (void __user *)arg);
+		break;
+
 	case TUNGETSNDBUF:
 		sndbuf = tfile->socket.sk->sk_sndbuf;
 		if (copy_to_user(argp, &sndbuf, sizeof(sndbuf)))
@@ -1427,21 +1447,17 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 		break;
 
 	default:
-		ret = -EINVAL;
+		ret = __tun_chr_ioctl(file, cmd, arg, ifreq_len);
 		break;
 	}
 
-unlock:
-	rtnl_unlock();
-	if (tun)
-		tun_put(tun);
 	return ret;
 }
 
 static long tun_chr_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long arg)
 {
-	return __tun_chr_ioctl(file, cmd, arg, sizeof (struct ifreq));
+	return __tun_socket_ioctl(file, cmd, arg, sizeof (struct ifreq));
 }
 
 #ifdef CONFIG_COMPAT
@@ -1469,7 +1485,7 @@ static long tun_chr_compat_ioctl(struct file *file,
 	 * driver are compatible though, we don't need to convert the
 	 * contents.
 	 */
-	return __tun_chr_ioctl(file, cmd, arg, sizeof(struct compat_ifreq));
+	return __tun_socket_ioctl(file, cmd, arg, sizeof(struct compat_ifreq));
 }
 #endif /* CONFIG_COMPAT */
