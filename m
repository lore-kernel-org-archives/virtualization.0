From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/25] Staging: hv: Cleanup vmbus driver code
Date: Mon, 2 May 2011 16:00:12 -0400
Message-ID: <20110502200012.GA21619@infradead.org>
References: <6E21E5352C11B742B20C142EB499E0481DD266@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110427121856.GA20633@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DD676@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110429164025.GA7698@kroah.com>
 <20110501154041.GB15210@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF253@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501160721.GA8195@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF2A0@TK5EX14MBXC124.redmond.corp.microsoft.com>
 <20110501205315.GC1017@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481DF543@TK5EX14MBXC124.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481DF543@TK5EX14MBXC124.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 02, 2011 at 07:48:38PM +0000, KY Srinivasan wrote:
> By setting up appropriate modprobe rules, this can be addressed.

That assumes libata is a module, which it is not for many popular
distributions.
