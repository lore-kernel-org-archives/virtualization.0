From: Andi Kleen <ak@suse.de>
Subject: Re: A proposal - binary
Date: Sat, 5 Aug 2006 13:57:09 +0200
Message-ID: <200608051357.09432.ak@suse.de>
References: <44D1CC7D.4010600@vmware.com> <200608050001.52535.ak@suse.de>
	<20060805104735.GS25692@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20060805104735.GS25692@stusta.de>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Adrian Bunk <bunk@stusta.de>
Cc: Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Christoph Hellwig <hch@infradead.org>, Jack Lo <jlo@vmware.com>, Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, James.Bottomley@steeleye.com, pazke@donpac.ru
List-Id: virtualization@lists.linuxfoundation.org


> Has anyone measured the performance impact of rutime CLOCK_TICK_RATE 
> switching (since this will no longer allow some compile time 
> optimizations in jiffies.h)?

SUSE shipped a kernel briefly that had runtime switchable jiffies
and there were some benchmarks done and they didn't show noticeable
slowdown.

But with hr timers it should be pretty much obsolete anyways.

-Andi
