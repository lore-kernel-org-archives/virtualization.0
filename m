From: Andy King <acking@vmware.com>
Subject: Re: [PATCH 12/12] VMCI: Some header and config files.
Date: Fri, 30 Nov 2012 08:47:46 -0800 (PST)
Message-ID: <1481496655.36482563.1354294066563.JavaMail.root__20289.8510186516$1354294100$gmane$org@vmware.com>
References: <20121127002357.GA27683@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20121127002357.GA27683@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: pv-drivers@vmware.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, George Zhang <georgezhang@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I didn't get the resend either, so it seems our corporate mail really is
eating messages.  Lovely.

> > > +#define IOCTLCMD(_cmd) IOCTL_VMCI_ ## _cmd
> > 
> > I don't recall ever getting a valid answer for this (if you did, my
> > appologies, can you repeat it).  What in the world are you talking
> > about here?  Why is your driver somehow special from the thousands
> > of other ones that use the in-kernel IO macros properly for an
> > ioctl?

Because we're morons.  And unfortunately, we've shipped our product
using those broken definitions: our VMX uses them to talk to the driver.
So here's what we'd like to do.  We will send out a patch soon that
fixes the other issues you mention and also adds IOCTL definitions the
proper way using _IOBLAH().  But we'd also like to retain these broken
definitions for a short period, commented as such, at least until we
can get out a patch release to Workstation 9, at which point we can
remove them.  Does that sound reasonable?

Thanks!
- Andy
