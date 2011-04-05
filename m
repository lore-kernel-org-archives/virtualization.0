From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] staging: hv: Fix GARP not sent after Quick Migration
Date: Tue, 5 Apr 2011 09:19:45 -0700
Message-ID: <20110405161945.GA1674@suse.de>
References: <1302017268-22913-1-git-send-email-haiyangz@microsoft.com>
 <20110405154133.GA30923@suse.de>
 <A1F3067C9B68744AA19F6802BAB8FFDC03FB03A6@TK5EX14MBXC223.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A1F3067C9B68744AA19F6802BAB8FFDC03FB03A6@TK5EX14MBXC223.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Hank Janssen <hjanssen@microsoft.com>, KY Srinivasan <kys@microsoft.com>, "Abhishek Kane (Mindtree Consulting PVT LTD)" <v-abkane@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, Mike Surcouf <mike@surcouf.co.uk>, stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 05, 2011 at 03:54:54PM +0000, Haiyang Zhang wrote:
> > -----Original Message-----
> > From: Greg KH [mailto:gregkh@suse.de]
> > Sent: Tuesday, April 05, 2011 11:42 AM
> > But that's a hypervisor bug, right?  It shouldn't be sending a "connect"
> > event on the ethernet device if the network really isn't present.  How
> > about getting it fixed there, which will resolve the issues for all
> > guest operating systems, not just Linux.
> >
> > Or, if this is something that the hyperv developers are not going to
> > fix, we need to document it in the code itself so that people don't try
> > to remove it in a few years as an "optimization".
> 
> Fix on the Hyper-V side is not available for now at least. I will add the
> comments into code.

What happens when the hyperv code is fixed?  Will this be removed?  Or
will all guests have this delay in them for no reason and the older
"unfixed" guests suddenly work faster?  That seems odd...

thanks,

greg k-h
