From: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Mon, 13 Apr 2009 13:29:40 -0300
Message-ID: <1239640180.31741.12.camel@zetabook>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook> <49DDE91A.8060603@trash.net>
	<49DDF614.1060909@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <49DDF614.1060909-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
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
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Patrick,

On Thu, 2009-04-09 at 15:20 +0200, Patrick McHardy wrote:
> Patrick McHardy wrote:
> > which goes away by turning of CONFIG_STACKPROTECTOR. Now it seems
> > to work, but the host crashes before the guests are fully up somewhere
> > in the tun-device. I couldn't capture the oops yet, but I'll try
> > to fix it myself.
> 
> This was caused by a local change of mine to attach to existing
> tun-devices, combined with a bug in the tun driver, which looks
> like it was introduced by this patch:
> 
> commit c70f182940f988448f3c12a209d18b1edc276e33
> Author: Eric W. Biederman <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
> Date:   Tue Jan 20 11:07:17 2009 +0000
> 
>      tun: Fix races between tun_net_close and free_netdev.
> 

So, can we assume that everything is ok if we turn off STACK_PROTECTOR ?

thanks 

Matias





> When creating the device using tunctl the sk->sk_sleep poiner is
> set to the read_wait completion of the file opened by tunctl, but
> it is not refreshed when attaching to lguest or released when
> closing the file, causing a stale pointer dereference in
> tun_sock_write_space().
> 
> Eric, please review. Thanks.
> 
> Signed-off-by: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
> 
