From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Fri, 29 Apr 2011 08:08:04 -0700
Message-ID: <20110429150804.GB12142@suse.de>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426232843.GA31184@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110428002817.GE14294@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD5AA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DD5AA@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 29, 2011 at 02:26:13PM +0000, KY Srinivasan wrote:
> Perhaps I did not properly formulate my question here. The review
> process itself may be open-ended, and that is fine - we will fix all legitimate
> issues/concerns  in our drivers whether they are in the staging area or not. 
> My question was specifically with regards to the review process that may gate exiting
> staging. I am hoping to re-spin the remaining patches of the last patch-set and send it to
> you by early next week and ask for a review. I fully intend to address whatever review 
> comments I may get in a very timely manner. Assuming at some point in time after I ask
> for this review there are no outstanding issues, would that be sufficient to exit staging?  

If it looks acceptable to me, and there are no other objections from
other developers, then yes, that would be sufficient to move it out of
staging.

thanks,

greg k-h
