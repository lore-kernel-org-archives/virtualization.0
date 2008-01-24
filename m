From: yamamoto@valinux.co.jp (YAMAMOTO Takashi)
Subject: Re: [dm-devel] [PATCH 0/2] dm-band: The I/O bandwidth controller:
 Overview
Date: Thu, 24 Jan 2008 12:38:07 +0900 (JST)
Message-ID: <20080124033807.42D7B1E3C0C__49411.859145812$1201190991$gmane$org@siro.lan>
References: <20080124.012103.105433865.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Your message of "Thu, 24 Jan 2008 01:21:03 +0900 (JST)"
	<20080124.012103.105433865.taka@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: taka@valinux.co.jp
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> Hi,
> 
> > On Wed, Jan 23, 2008 at 09:53:50PM +0900, Ryo Tsuruta wrote:
> > > Dm-band gives bandwidth to each job according to its weight, 
> > > which each job can set its own value to.
> > > At this time, a job is a group of processes with the same pid or pgrp or uid.
> > 
> > It seems to rely on 'current' to classify bios and doesn't do it until the map
> > function is called, possibly in a different process context, so it won't
> > always identify the original source of the I/O correctly:
> 
> Yes, this should be mentioned in the document with the current implementation
> as you pointed out.
> 
> By the way, I think once a memory controller of cgroup is introduced, it will
> help to track down which cgroup is the original source.

do you mean to make this a part of the memory subsystem?

YAMAMOTO Takashi
