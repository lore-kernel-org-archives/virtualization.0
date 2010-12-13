From: Jesper Juhl <jj@chaosbits.net>
Subject: RE: [PATCH 1/1] hv: Use only one receive buffer per channel and
	kmalloc on initialize
Date: Mon, 13 Dec 2010 22:06:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012132204240.26491@swampdragon.chaosbits.net>
References: <1292272498-29483-1-git-send-email-hjanssen@microsoft.com>
	<alpine.LNX.2.00.1012132143590.26491@swampdragon.chaosbits.net>
	<8AFC7968D54FB448A30D8F38F259C5622C0BCB78@TK5EX14MBXC116.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <8AFC7968D54FB448A30D8F38F259C5622C0BCB78@TK5EX14MBXC116.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Evgeniy Polyakov <zbr@ioremap.net>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Ky Srinivasan <ksrinivasan@novell.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Dec 2010, Hank Janssen wrote:

> 
> 
> > -----Original Message-----
> > From: Jesper Juhl [mailto:jj@chaosbits.net]
> > Sent: Monday, December 13, 2010 12:48 PM
> > You are leaking memory in the failure path. If for example one or two
> > allocations succeed but one or two fail, then you'll leak the two successful
> > allocations.
> > 
> > I believe this should be
> > 
> >      if (!shut_txf_buf || !time_txf_buf || !hbeat_txf_buf) {
> >              printk(KERN_INFO
> >                     "Unable to allocate memory for receive buffer\n");
> >              kfree(hbeat_txf_buf);
> >              kfree(time_txf_buf);
> >              kfree(shut_txf_buf);
> >              return -ENOMEM;
> > ...
> > 
>  
> Oops, you are correct. Resubmitting the patch in a few minutes.
> 
Ohh and another little detail; shouldn't this log message be a 
KERN_WARNING level message?
And perhaps the log text should include "HyperV" or something so it's 
clear where it comes from..?

-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
