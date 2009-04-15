From: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/5] lguest: use KVM hypercalls
Date: Wed, 15 Apr 2009 11:55:33 -0300
Message-ID: <1239807333.18328.20.camel@zetabook>
References: <200903271022.38244.rusty@rustcorp.com.au>
	<1239273165.5687.10.camel@odie.local>
	<1239639939.31741.8.camel@zetabook>
	<200904151812.23318.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
In-Reply-To: <200904151812.23318.rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/lguest>,
	<mailto:lguest-request-mnsaURCQ41sdnm+yROfE0A@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Patrick McHardy <kaber-dcUjhNyLwpNeoWH0uzbU5w@public.gmane.org>, virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Hi, 

On Wed, 2009-04-15 at 18:12 +0930, Rusty Russell wrote:
> On Tue, 14 Apr 2009 01:55:39 am Matias Zabaljauregui wrote:
> > > > BTW, shouldn't this also affect my test boxes if this were the case?
> > > > 
> > > Could be the timing differences between our boxes I guess?
> > 
> > I haven't read COW code, but I cannot figure out how CPU timing
> > differences could affect a logic driven by faults. I will investigate
> > further and let you know if I can yield any conclusion.
> 
> I first thought it was guest image layout, until I reproduced it completely
> accidentally here.
> 
> Matias, can I have a Signed-off-by for your patch (enhanced with comment
> below):
> 

I think I just missed it, sorry for the delay (i was on the road).

Thanks for you fix

Matias
