From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] lguest feedback tidyups
Date: Fri, 11 May 2007 07:53:53 +0100
Message-ID: <20070511065353.GA25182__19471.9749423259$1178866492$gmane$org@infradead.org>
References: <1178846246.23513.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1178846246.23513.21.camel@localhost.localdomain>
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
Cc: Jeff Garzik <jeff@garzik.org>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Pekka J Enberg <penberg@cs.helsinki.fi>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 11, 2007 at 11:17:26AM +1000, Rusty Russell wrote:
>     - But the cost was high: lots of __force casts 8(

That sounds like something is very fishy.
