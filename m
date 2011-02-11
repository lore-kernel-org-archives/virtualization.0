From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH 1/3]: Staging: hv: Use native page allocation/free
	functions
Date: Fri, 11 Feb 2011 20:55:56 +0000
Message-ID: <FB42D5CCD7B5934EB1827DB5ED9B850E0B2653@tk5ex14mbxc106.redmond.corp.microsoft.com>
References: <1297447140-21777-1-git-send-email-kys@microsoft.com>
	<20110211182949.GA10751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20110211182949.GA10751@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: Greg KH <gregkh@suse.de>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh@suse.de]
> Sent: Friday, February 11, 2011 1:30 PM
> To: KY Srinivasan
> Cc: linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> virtualization@lists.osdl.org; Hank Janssen
> Subject: Re: [PATCH 1/3]: Staging: hv: Use native page allocation/free functions
> 
> On Fri, Feb 11, 2011 at 09:59:00AM -0800, K. Y. Srinivasan wrote:
> > --- a/drivers/staging/hv/hv.c
> > +++ b/drivers/staging/hv/hv.c
> > @@ -230,7 +230,12 @@ int hv_init(void)
> >  	* Allocate the hypercall page memory
> >  	* virtaddr = osd_page_alloc(1);
> >  	*/
> > -	virtaddr = osd_virtual_alloc_exec(PAGE_SIZE);
> > +#ifdef __x86_64__
> > +	virtaddr = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_EXEC);
> #else
> > +	virtaddr =  __vmalloc(PAGE_SIZE, GFP_KERNEL,
> > +			__pgprot(__PAGE_KERNEL & (~_PAGE_NX))); #endif
> 
> I'm not saying this patch is wrong at all, but I still don't understand why this is
> different depending on the architecture of the machine.  Why is this necessary, it
> should be ok to do the same type of allocation no matter what the processor is,
> right?

You are right Greg; I don't think there is a need to specify different page
protection bits based on the architecture - PAGE_KERNEL_EXEC should be enough.
However, this is the code that is currently in the tree - refer to osd.c.
If it is ok with you, I could submit an additional patch to clean this up.  

Regards,

K. Y 
> 
> thanks,
> 
> greg k-h
