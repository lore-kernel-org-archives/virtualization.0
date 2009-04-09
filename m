From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Lguest] [PATCH 4/5] lguest: use KVM hypercalls
Date: Thu, 09 Apr 2009 06:59:25 -0700
Message-ID: <m1bpr6hqrm.fsf@fess.ebiederm.org>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook> <49DDE91A.8060603@trash.net>
	<49DDF614.1060909@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <49DDF614.1060909@trash.net> (Patrick McHardy's message of "Thu\,
	09 Apr 2009 15\:20\:20 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrick McHardy <kaber@trash.net>
Cc: lguest@ozlabs.org, Herbert Xu <herbert@gondor.apana.org.au>, odie@cs.aau.dk, virtualization@lists.osdl.org, Matias Zabaljauregui <zabaljauregui@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Patrick McHardy <kaber@trash.net> writes:

> Patrick McHardy wrote:
>> which goes away by turning of CONFIG_STACKPROTECTOR. Now it seems
>> to work, but the host crashes before the guests are fully up somewhere
>> in the tun-device. I couldn't capture the oops yet, but I'll try
>> to fix it myself.
>
> This was caused by a local change of mine to attach to existing
> tun-devices, combined with a bug in the tun driver, which looks
> like it was introduced by this patch:
>
> commit c70f182940f988448f3c12a209d18b1edc276e33
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Jan 20 11:07:17 2009 +0000
>
>     tun: Fix races between tun_net_close and free_netdev.

A combination of my patch and the patches that added a socket
into the tun driver.

> When creating the device using tunctl the sk->sk_sleep poiner is
> set to the read_wait completion of the file opened by tunctl, but
> it is not refreshed when attaching to lguest or released when
> closing the file, causing a stale pointer dereference in
> tun_sock_write_space().
>
> Eric, please review. Thanks.

That looks a little better.  Certainly as the socket currently
lives with the tun_struct instead of the tun_file it make sense.
I'm not at all certain it makes sense for the socket to live in
tun_struct instead of tun_file.

I happened to glance at the code about a week ago, and realized that
the introduction of the socket had done horribly things to the
guarantees I had introduced, and I haven't had a chance to think
through and figure out what the code should be doing.

I am certain that:
opening a tap device and then "ip link del tap0" while holding
the tap open leads into a territory of madness right now.

And apparently so does reattaching to an existing tun device.

Patrick I'm not seeing anything in the particular patch you pointed
out that would cause crashes.

Other lurking bugs aside your patch appears slightly off.

tun->sk->sk_sleep in __tun_detach is correct.

Setting sk_sleep on both paths to tun_attach instead
of in tun_attach is wrong.  You are performing the assignment
before we complete the permission checks into tun_attach, which
means there is no guarantee that the tun_attach will succeed.

Eric

> Signed-off-by: Patrick McHardy <kaber@trash.net>
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a1b0697..0af7ceb 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -173,6 +173,8 @@ static void __tun_detach(struct tun_struct *tun)
>  	tun->tfile = NULL;
>  	netif_tx_unlock_bh(tun->dev);
>  
> +	tun->sk->sk_sleep = NULL;
> +
>  	/* Drop read queue */
>  	skb_queue_purge(&tun->readq);
>  
> @@ -873,6 +875,9 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		else
>  			return -EINVAL;
>  
> +		sk = tun->sk;
> +		sk->sk_sleep = &tfile->read_wait;
> +
>  		err = tun_attach(tun, file);
>  		if (err < 0)
>  			return err;
