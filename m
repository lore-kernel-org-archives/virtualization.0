From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH 1/5] lguest host feedback tidyups
Date: Sun, 13 May 2007 19:47:50 +0100
Message-ID: <20070513184750.GA4095__38630.3157000386$1179082107$gmane$org@ftp.linux.org.uk>
References: <1178846246.23513.21.camel@localhost.localdomain>
	<1178846354.23513.23.camel@localhost.localdomain>
	<1179029245.23513.121.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1179029245.23513.121.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: hch <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, May 13, 2007 at 02:07:25PM +1000, Rusty Russell wrote:
> Most importantly, I now realize that Christoph's incorrect ranting
> about lgread_u32 et al was in fact a subtle ploy to make me diagnose
> the real issue: sparse 0.3 complains about casting a __user pointer
> to/from u32, but not an "unsigned long".  They are (currently)
> equivalent for lguest, but this is a much better solution than __force.

The real fix would be to declare it with u32 __user * as argument and deal
with callers.
