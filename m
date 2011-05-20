From: Christoph Hellwig <hch@infradead.org>
Subject: Re: vmbus driver
Date: Fri, 20 May 2011 09:22:20 -0400
Message-ID: <20110520132220.GA23390@infradead.org>
References: <1305842785-30206-1-git-send-email-kys@microsoft.com>
 <20110520122649.GA550@infradead.org>
 <6E21E5352C11B742B20C142EB499E0481FC2AF@TK5EX14MBXC122.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6E21E5352C11B742B20C142EB499E0481FC2AF@TK5EX14MBXC122.redmond.corp.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>, "gregkh@suse.de" <gregkh@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 20, 2011 at 01:12:32PM +0000, KY Srinivasan wrote:
> Well, the util driver that implements a range of other services such as KVP, 
> time synch, heartbeat etc. is also a client of the vmbus driver (perhaps not in the 

The KVP driver is a different module as far as I can see.  But it really
needs a lot of work, as no one should use the ugly connector interface
for new code.  The closest equivalent is gennetlink, but I'd like to
understand what it's actually supposed to do in practice.
