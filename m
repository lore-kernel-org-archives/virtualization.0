From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 20/20] Add apply_to_page_range() which applies a function
 to a pte range.
Date: Thu, 19 Apr 2007 14:37:53 -0700
Message-ID: <4627E131.5070801@goop.org>
References: <20070404191151.009821039@goop.org>
	<20070404191206.675793431@goop.org>
	<20070405044133.GE4892@waste.org> <46149CC9.2070903@goop.org>
	<20070417205652.GM11115@waste.org> <4627C6B9.7000605@goop.org>
	<20070419195957.GF11115@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070419195957.GF11115@waste.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matt Mackall <mpm@selenic.com>
Cc: Matt Mackall <mpm@waste.org>, Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Matt Mackall wrote:
> Haven't thought a huge amount about that. Perhaps it's best done with
> the level 3 callback?
>   

Level 2, I think, assuming you count the pte pages as level 1.  I think
it can be dealt with, so long as it correctly skips level 1 callbacks
for superpages, and does the test after the level 2 callback has returned.

    J
