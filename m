From: Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Thu, 09 Apr 2009 14:24:58 +0200
Message-ID: <49DDE91A.8060603@trash.net>
References: <200903271022.38244.rusty@rustcorp.com.au>	
	<1238709324.5823.8.camel@odie.local>
	<1239043798.27826.93.camel@zetabook>	
	<200904081021.39877.rusty@rustcorp.com.au>
	<1239224319.17844.16.camel@zetabook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <1239224319.17844.16.camel@zetabook>
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Matias Zabaljauregui wrote:
> Simon, Patrick,
> 
> Rusty suggested that perhaps we need to flush all shadow after rewriting. 
> Could you please try this patch?

I get a new error with this patch:

lguest: unhandled trap 13 at 0xc0513417 (0x0)
c0513410 <lguest_init>:
c0513410:       55                      push   %ebp
c0513411:       89 e5                   mov    %esp,%ebp
c0513413:       53                      push   %ebx
c0513414:       83 ec 14                sub    $0x14,%esp
c0513417:       65 a1 14 00 00 00       mov    %gs:0x14,%eax
c051341d:       89 45 f8                mov    %eax,-0x8(%ebp)
c0513420:       31 c0                   xor    %eax,%eax
c0513422:       c7 05 ac 06 4e c0 ab    movl   $0xc04754ab,0xc04e06ac

which goes away by turning of CONFIG_STACKPROTECTOR. Now it seems
to work, but the host crashes before the guests are fully up somewhere
in the tun-device. I couldn't capture the oops yet, but I'll try
to fix it myself.
