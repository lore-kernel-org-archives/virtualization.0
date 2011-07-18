From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv9] vhost: experimental tx zero-copy support
Date: Mon, 18 Jul 2011 10:16:06 +0300
Message-ID: <20110718071606.GA29538__31381.1183129021$1310973405$gmane$org@redhat.com>
References: <20110717193540.GA29392@redhat.com>
	<alpine.LNX.2.00.1107172153030.32359@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1107172153030.32359@swampdragon.chaosbits.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Jul 17, 2011 at 10:01:41PM +0200, Jesper Juhl wrote:
> > @@ -28,10 +29,18 @@
> >  
> >  #include "vhost.h"
> >  
> > +static int zcopytx;
> > +module_param(zcopytx, int, 0444);
> 
> Should everyone be able to read this? How about "0440" just to be 
> paranoid? or?

I find it very helpful to have the parameter visible in sysfs.
Given that:

[mst@tuck linux-2.6]$ grep module_param drivers/net/*c|grep [64]44|wc -l
14
[mst@tuck linux-2.6]$ grep module_param drivers/net/*c|grep [64]40|wc -l
0
[mst@tuck linux-2.6]$ grep module_param drivers/net/*c|grep [64]00|wc -l
7

So at least the precedent is against 0440.  What do you think?


-- 
MST
