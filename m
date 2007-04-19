From: Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 20/20] Add apply_to_page_range() which applies a
	function to a pte range.
Date: Thu, 19 Apr 2007 14:59:57 -0500
Message-ID: <20070419195957.GF11115@waste.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.675793431@goop.org>
	<20070405044133.GE4892@waste.org> <46149CC9.2070903@goop.org>
	<20070417205652.GM11115@waste.org> <4627C6B9.7000605@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4627C6B9.7000605@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Matt Mackall <mpm@waste.org>, Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 19, 2007 at 12:44:57PM -0700, Jeremy Fitzhardinge wrote:
> Matt Mackall wrote:
> > I think adding a flags field and an allocate flag to my callback
> > struct would be sufficient here.
> >   
> 
> Yes, probably.
> 
> What about something that wants to shatter superpages?

Haven't thought a huge amount about that. Perhaps it's best done with
the level 3 callback?

> Don't know that that's a huge concern.  The typedef namespace (*_t) is
> pretty empty, and its not like we're talking about something that's
> visible outside the kernel.  And the syntax is *really* ugly.

Don't really care about this much.

-- 
Mathematics is the supreme nostalgia of our time.
