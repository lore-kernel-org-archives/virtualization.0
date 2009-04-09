From: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Thu, 09 Apr 2009 15:20:20 +0200
Message-ID: <49DDF614.1060909@trash.net>
References: <200903271022.38244.rusty@rustcorp.com.au>	
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>	
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook> <49DDE91A.8060603@trash.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090803020509030402000206"
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <49DDE91A.8060603-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------090803020509030402000206
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Patrick McHardy wrote:
> which goes away by turning of CONFIG_STACKPROTECTOR. Now it seems
> to work, but the host crashes before the guests are fully up somewhere
> in the tun-device. I couldn't capture the oops yet, but I'll try
> to fix it myself.

This was caused by a local change of mine to attach to existing
tun-devices, combined with a bug in the tun driver, which looks
like it was introduced by this patch:

commit c70f182940f988448f3c12a209d18b1edc276e33
Author: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Date:   Tue Jan 20 11:07:17 2009 +0000

     tun: Fix races between tun_net_close and free_netdev.

When creating the device using tunctl the sk->sk_sleep poiner is
set to the read_wait completion of the file opened by tunctl, but
it is not refreshed when attaching to lguest or released when
closing the file, causing a stale pointer dereference in
tun_sock_write_space().

Eric, please review. Thanks.

Signed-off-by: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>


--------------090803020509030402000206
Content-Type: text/x-patch;
 name="tun.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tun.diff"

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index a1b0697..0af7ceb 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -173,6 +173,8 @@ static void __tun_detach(struct tun_struct *tun)
 	tun->tfile = NULL;
 	netif_tx_unlock_bh(tun->dev);
 
+	tun->sk->sk_sleep = NULL;
+
 	/* Drop read queue */
 	skb_queue_purge(&tun->readq);
 
@@ -873,6 +875,9 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		else
 			return -EINVAL;
 
+		sk = tun->sk;
+		sk->sk_sleep = &tfile->read_wait;
+
 		err = tun_attach(tun, file);
 		if (err < 0)
 			return err;

--------------090803020509030402000206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Lguest mailing list
Lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
https://ozlabs.org/mailman/listinfo/lguest

--------------090803020509030402000206--
