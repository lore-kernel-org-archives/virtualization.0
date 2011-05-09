From: Greg KH <greg@kroah.com>
Subject: Re: various vmbus review comments
Date: Sun, 8 May 2011 20:04:52 -0700
Message-ID: <20110509030452.GA17182@kroah.com>
References: <20110503204641.GA11132@kroah.com>
	<6E21E5352C11B742B20C142EB499E0481E9404@TK5EX14MBXC128.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481E9404@TK5EX14MBXC128.redmond.corp.microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: KY Srinivasan <kys@microsoft.com>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 09, 2011 at 01:46:56AM +0000, KY Srinivasan wrote:
> > 	- the instances of hv_driver structures need to be static and
> > 	  not programatically defined, like all other USB and PCI
> > 	  drivers are handled.
> 
> Done. You had expressed some concern that this would expose some issue
> with the core vmbus driver (which is what I want to concentrate on this 
> go around). I have done this for both the block driver and the mouse driver
> and I am pretty sure I can do the same with the network driver. I have not 
> currently done this for the network driver, since the number of patches I have 
> to submit is already very large.

Ok, but it shouldn't be a major change to the code, right?

> > 	- module reference counting.  Are you sure you got it all right
> > 	  for the individual modules that attach to the bus?  I don't
> > 	  see any reference counting happening, is that correct?
> 
> I have already exchanged an email with you on this. To summarize, it
> does not look like there is a problem
> 
> > 	- fix the sparse warnings.
> Mostly done; most of the errors are in the base kernel coming out of
> the macro page_to_pfn()
> 
> > 	- fix the use of volatile in the ring buffer code.  It should
> > 	  not be needed and if you are relying on it, then the code is
> > 	  wrong.
> 
> You are right; all accesses were already serialized with a spin lock and the 
> Volatile attribute was unnecessary.
> 
> > 	- fix the namespace on the ringbuffer code to show that it
> > 	  really is only for the hyperv bus code internally.
> 
> Done.
> 
> > 
> > That should be enough for at least one more set of patches for you all
> > to work on :)
> 
> Greg,
> 
> I have had so much fun cleaning up these drivers that I lost track of the patch count.
> I have addressed all the issues you have raised in addition to some other cleanup
> that I was doing since about a week. As I look at the patch-set, I have little over 
> 200 patches. If it is ok with you, I would like to send them as a single set. Let me know 
> what you prefer. I need to circulate these patches internally before I can send them out. 
> I should be able to send these out early next week.

A single set is fine, if that's what you want to do, I can handle that
amount as long as they all build all along the way and don't break
anything.

thanks,

greg k-h
