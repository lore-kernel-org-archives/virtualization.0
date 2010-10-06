From: devi thapa <devi.thapa@gmail.com>
Subject: vhost_net_ioctl
Date: Wed, 6 Oct 2010 15:46:18 +0530
Message-ID: <AANLkTimzGqmS=YOsJjdM_-d1sJDd4w1t2Cyjk57xrQZo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi All,


           What's the role or value of the third argument in the
vhost_net_ioctl function in /drivers/vhost/net.c .

       The function declaration is

         static long vhost_net_ioctl(struct file *f, unsigned int
ioctl, unsigned long arg)

As per my knowledge,

*f represents the fd of vhost-net device,
ioctl  any device request like VHOST_NET_SET_BACKEND,

But what's the third arg represent ?

With hope,
Devi.
