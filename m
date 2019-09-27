From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net v2] vsock: Fix a lockdep warning in __vsock_release()
Date: Fri, 27 Sep 2019 10:32:59 +0200
Message-ID: <20190927083259.zpzseatncogfdrv4__10503.6868060537$1569573198$gmane$org@steredhat.homenet.telecomitalia.it>
References: <1569460241-57800-1-git-send-email-decui@microsoft.com>
	<20190926074749.sltehhkcgfduu7n2@steredhat.homenet.telecomitalia.it>
	<PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <PU1P153MB01698C46C9348B9762D5E122BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "sashal@kernel.org" <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ytht.net@gmail.com" <ytht.net@gmail.com>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "jhansen@vmware.com" <jhansen@vmware.com>, Michael Kelley <mikelley@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Sep 27, 2019 at 05:37:20AM +0000, Dexuan Cui wrote:
> > From: linux-hyperv-owner@vger.kernel.org
> > <linux-hyperv-owner@vger.kernel.org> On Behalf Of Stefano Garzarella
> > Sent: Thursday, September 26, 2019 12:48 AM
> > 
> > Hi Dexuan,
> > 
> > On Thu, Sep 26, 2019 at 01:11:27AM +0000, Dexuan Cui wrote:
> > > ...
> > > NOTE: I only tested the code on Hyper-V. I can not test the code for
> > > virtio socket, as I don't have a KVM host. :-( Sorry.
> > >
> > > @Stefan, @Stefano: please review & test the patch for virtio socket,
> > > and let me know if the patch breaks anything. Thanks!
> > 
> > Comment below, I'll test it ASAP!
> 
> Stefano, Thank you!
> 
> BTW, this is how I tested the patch:
> 1. write a socket server program in the guest. The program calls listen()
> and then calls sleep(10000 seconds). Note: accept() is not called.
> 
> 2. create some connections to the server program in the guest.
> 
> 3. kill the server program by Ctrl+C, and "dmesg" will show the scary
> call-trace, if the kernel is built with 
> 	CONFIG_LOCKDEP=y
> 	CONFIG_LOCKDEP_SUPPORT=y
> 
> 4. Apply the patch, do the same test and we should no longer see the call-trace.

Thanks very useful! I'll follow these steps!

> 
> > > -		lock_sock(sk);
> > > +		/* When "level" is 2, use the nested version to avoid the
> > > +		 * warning "possible recursive locking detected".
> > > +		 */
> > > +		if (level == 1)
> > > +			lock_sock(sk);
> > 
> > Since lock_sock() calls lock_sock_nested(sk, 0), could we use directly
> > lock_sock_nested(sk, level) with level = 0 in vsock_release() and
> > level = SINGLE_DEPTH_NESTING here in the while loop?
> > 
> > Thanks,
> > Stefano
> 
> IMHO it's better to make the lock usage more explicit, as the patch does.
> 
> lock_sock_nested(sk, level) or lock_sock_nested(sk, 0) seems a little
> odd to me. But I'm open to your suggestion: if any of the network
> maintainers, e.g. davem, also agrees with you, I'll change the code 
> as you suggested. :-)

Sure!

Just to be clear, I'm proposing this (plus the changes in the transports
and yours useful comments):

--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -638,7 +638,7 @@ struct sock *__vsock_create(struct net *net,
 }
 EXPORT_SYMBOL_GPL(__vsock_create);

-static void __vsock_release(struct sock *sk)
+static void __vsock_release(struct sock *sk, int level)
 {
        if (sk) {
                struct sk_buff *skb;
@@ -650,7 +650,7 @@ static void __vsock_release(struct sock *sk)

                transport->release(vsk);

-               lock_sock(sk);
+               lock_sock_nested(sk, level);
                sock_orphan(sk);
                sk->sk_shutdown = SHUTDOWN_MASK;

@@ -659,7 +659,7 @@ static void __vsock_release(struct sock *sk)

                /* Clean up any sockets that never were accepted. */
                while ((pending = vsock_dequeue_accept(sk)) != NULL) {
-                       __vsock_release(pending);
+                       __vsock_release(pending, SINGLE_DEPTH_NESTING);
                        sock_put(pending);
                }

@@ -708,7 +708,7 @@ EXPORT_SYMBOL_GPL(vsock_stream_has_space);

 static int vsock_release(struct socket *sock)
 {
-       __vsock_release(sock->sk);
+       __vsock_release(sock->sk, 0);
        sock->sk = NULL;
        sock->state = SS_FREE;

Thanks,
Stefano
