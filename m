From: Alasdair G Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH 0/2] dm-band: The I/O bandwidth controller:
	Overview
Date: Wed, 23 Jan 2008 14:47:17 +0000
Message-ID: <20080123144717.GS8075__7087.82324004478$1201103220$gmane$org@agk.fab.redhat.com>
References: <20080123.215350.193721890.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080123.215350.193721890.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: containers@lists.linux-foundation.org, dm-devel@redhat.com, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 23, 2008 at 09:53:50PM +0900, Ryo Tsuruta wrote:
> Dm-band gives bandwidth to each job according to its weight, 
> which each job can set its own value to.
> At this time, a job is a group of processes with the same pid or pgrp or uid.

It seems to rely on 'current' to classify bios and doesn't do it until the map
function is called, possibly in a different process context, so it won't
always identify the original source of the I/O correctly: people need to take
this into account when designing their group configuration and so this should
be mentioned in the documentation.

I've uploaded it here while we consider ways we might refine the architecture and
interfaces etc.:

  http://www.kernel.org/pub/linux/kernel/people/agk/patches/2.6/editing/dm-add-band-target.patch

Alasdair
-- 
agk@redhat.com
