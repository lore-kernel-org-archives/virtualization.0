From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 05/10] staging: hv: Convert camel cased functions in
	hv.c to lower cases
Date: Wed, 3 Nov 2010 04:36:03 -0700
Message-ID: <20101103113603.GA13276@kroah.com>
References: <1288644369-12958-1-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-2-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-3-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-4-git-send-email-haiyangz@linuxonhyperv.com>
	<1288644369-12958-5-git-send-email-haiyangz@linuxonhyperv.com>
	<20101102170406.GA4557@jenkins.home.ifup.org>
	<1FB5E1D5CA062146B38059374562DF728BA55BD7@TK5EX14MBXC126.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1FB5E1D5CA062146B38059374562DF728BA55BD7@TK5EX14MBXC126.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 02, 2010 at 09:06:56PM +0000, Haiyang Zhang wrote:
> > From: Brandon Philips [mailto:brandon@ifup.org]
> > Sent: Tuesday, November 02, 2010 1:04 PM
> > > -static int HvQueryHypervisorInfo(void)
> > > +static int hvquery_hypervisor_info(void)
> > > -static u64 HvDoHypercall(u64 control, void *input, void *output)
> > > +static u64 hvdo_hypercall(u64 control, void *input, void *output)
> > 
> > Should these be hv_do_hypercall and hv_query_hypervisor? That seems to
> > be the style in the rest of the patch:
> 
> I didn't insert underscore between every word, for example, it's not
> added between two short words.

But you should.  Remember, be consistent.

Care to redo these again?

thanks,

greg k-h
