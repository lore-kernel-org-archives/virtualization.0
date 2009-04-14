From: ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org (Eric W. Biederman)
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Tue, 14 Apr 2009 10:10:11 -0700
Message-ID: <m1r5zv5fgs.fsf@fess.ebiederm.org>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook> <49DDE91A.8060603@trash.net>
	<49DDF614.1060909@trash.net> <m1bpr6hqrm.fsf@fess.ebiederm.org>
	<49E47976.8020005@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <49E47976.8020005-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org> (Patrick McHardy's message of "Tue\,
	14 Apr 2009 13\:54\:30 +0200")
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Herbert Xu <herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org> writes:

> Eric W. Biederman wrote:
>> Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org> writes:
>>
>>> When creating the device using tunctl the sk->sk_sleep poiner is
>>> set to the read_wait completion of the file opened by tunctl, but
>>> it is not refreshed when attaching to lguest or released when
>>> closing the file, causing a stale pointer dereference in
>>> tun_sock_write_space().
>>>
>>> Eric, please review. Thanks.
>>
>> That looks a little better.  Certainly as the socket currently
>> lives with the tun_struct instead of the tun_file it make sense.
>> I'm not at all certain it makes sense for the socket to live in
>> tun_struct instead of tun_file.
>>
>> I happened to glance at the code about a week ago, and realized that
>> the introduction of the socket had done horribly things to the
>> guarantees I had introduced, and I haven't had a chance to think
>> through and figure out what the code should be doing.
>>
>> I am certain that:
>> opening a tap device and then "ip link del tap0" while holding
>> the tap open leads into a territory of madness right now.
>>
>> And apparently so does reattaching to an existing tun device.
>>
>> Patrick I'm not seeing anything in the particular patch you pointed
>> out that would cause crashes.
>
> It might have been a different patch or a combination, I assumed it
> was your patch since git annotate pointed to it and it was a very
> recent change.

No problem.  tun was remarkably active this last while.
Sounds like a testament to virtual environments.

>> Other lurking bugs aside your patch appears slightly off.
>>
>> tun->sk->sk_sleep in __tun_detach is correct.
>>
>> Setting sk_sleep on both paths to tun_attach instead
>> of in tun_attach is wrong.  You are performing the assignment
>> before we complete the permission checks into tun_attach, which
>> means there is no guarantee that the tun_attach will succeed.
>
> I see. How about this patch instead? It moves the sk_sleep assignment
> to tun_attach, after the permission checks took place.

Acked-by: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>

Looks good.

> Thanks.
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a1b0697..4c5ae95 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -155,6 +155,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file)
>  	err = 0;
>  	tfile->tun = tun;
>  	tun->tfile = tfile;
> +	tun->sk->sk_sleep = &tfile->read_wait;
>  	dev_hold(tun->dev);
>  	atomic_inc(&tfile->count);
>  
> @@ -173,6 +174,8 @@ static void __tun_detach(struct tun_struct *tun)
>  	tun->tfile = NULL;
>  	netif_tx_unlock_bh(tun->dev);
>  
> +	tun->sk->sk_sleep = NULL;
> +
>  	/* Drop read queue */
>  	skb_queue_purge(&tun->readq);
>  
> @@ -861,7 +864,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  	struct sock *sk;
>  	struct tun_struct *tun;
>  	struct net_device *dev;
> -	struct tun_file *tfile = file->private_data;
>  	int err;
>  
>  	dev = __dev_get_by_name(net, ifr->ifr_name);
> @@ -925,7 +927,6 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  		sk->sk_write_space = tun_sock_write_space;
>  		sk->sk_destruct = tun_sock_destruct;
>  		sk->sk_sndbuf = INT_MAX;
> -		sk->sk_sleep = &tfile->read_wait;
>  
>  		tun->sk = sk;
>  		container_of(sk, struct tun_sock, sk)->tun = tun;
