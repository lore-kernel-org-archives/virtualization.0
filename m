From: Andi Kleen <ak@suse.de>
Subject: Re: Re: [patch 12/21] Xen-paravirt: Allocate and free
	vmalloc areas
Date: Fri, 16 Feb 2007 12:34:23 +0100
Message-ID: <200702161234.24034.ak@suse.de>
References: <C1FB4190.98FA%keir@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <C1FB4190.98FA%keir@xensource.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: virtualization@lists.osdl.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Jan Beulich <JBeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 16 February 2007 12:10, Keir Fraser wrote:
> 
> On 16/2/07 09:18, "Andi Kleen" <ak@muc.de> wrote:
> 
> >> It's for populating the pagetable in a vmalloc area.  There's magic in
> > 
> > If the lazy setup doesn't work for you you can always call vmalloc_sync()
> > early.
> 
> vmalloc_sync_all()? 

Yes.

Credit goes to Jan for writing it originally.

-Andi
