From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 09/11] xen/xenbus: use printk_ratelimited() instead of
	printk_ratelimit()
Date: Thu, 16 Jun 2011 16:44:05 -0700
Message-ID: <1308267845.12072.15.camel__304.738191380416$1308267882$gmane$org@Joe-Laptop>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
	<d2bc569719b3b1d8271d1f4b2c4080bbc7527e04.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
	<4DFA6EF7.9060702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4DFA6EF7.9060702@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, christian.dietrich@informatik.uni-erlangen.de, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2011-06-16 at 14:00 -0700, Jeremy Fitzhardinge wrote:
> On 06/16/2011 05:14 AM, Manuel Zerpies wrote:
> > Since printk_ratelimit() shouldn't be used anymore (see comment in
> > include/linux/printk.h), replace it with printk_ratelimited()
> Looks OK to me, but please fix the indentation of the rest of the
> statement to match.
[]
> > diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
[]
> > @@ -270,8 +271,7 @@ static void *xs_talkv(struct xenbus_transaction t,
> >  	}
> >  
> >  	if (msg.type != type) {
> > -		if (printk_ratelimit())
> > -			printk(KERN_WARNING
> > +		`printk_ratelimited(KERN_WARNING

Appears that it's not compile tested?
A stray "`" got put before printk_ratelimited()
