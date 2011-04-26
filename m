From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Tue, 26 Apr 2011 12:39:01 -0700
Message-ID: <20110426193901.GC17467@suse.de>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426165704.GA29301@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DAFB2@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DAFB2@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 26, 2011 at 05:04:36PM +0000, KY Srinivasan wrote:
> 
> 
> > -----Original Message-----
> > From: Christoph Hellwig [mailto:hch@infradead.org]
> > Sent: Tuesday, April 26, 2011 12:57 PM
> > To: KY Srinivasan
> > Cc: gregkh@suse.de; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; virtualization@lists.osdl.org
> > Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
> > 
> > Do you have a repository containing the current state of your patche
> > somewhere?  There's been so much cleanup that it's hard to review these
> > patches against the current mainline codebase.
> 
> Christoph,
> 
> Yesterday (April 25, 2011), Greg checked in all of the outstanding hv patches. So, if
> You checkout Greg's tree today, you will get the most recent hv codebase. This current
> patch-set is against Greg's current tree.

It's also always in the linux-next tree, which is easier for most people
to work off of.

thanks,

greg k-h
