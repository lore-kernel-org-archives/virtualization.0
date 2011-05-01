From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Sun, 1 May 2011 11:40:41 -0400
Message-ID: <20110501154041.GB15210@infradead.org>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <20110426232843.GA31184@kroah.com>
 <6E21E5352C11B742B20C142EB499E0481DD185@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427064550.GA597@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD266@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427121856.GA20633@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110429164025.GA7698@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: KY Srinivasan <kys@microsoft.com>, Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 29, 2011 at 09:40:25AM -0700, Greg KH wrote:
> Are you sure the libata core can't see this ide controller and connect
> to it?  That way you would use the scsi system if you do that and you
> would need a much smaller ide driver, perhaps being able to merge it
> with your scsi driver.
> 
> We really don't want to write new IDE drivers anymore that don't use
> libata.

The blkvsc driver isn't an IDE driver, although it currently claims
the old IDE drivers major numbers, which is a no-no and can't work
in most usual setups.  I'm pretty sure I already complained about
this in a previous review round.
