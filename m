From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 4/6] Rename the parainstructions symbols to be
 consistent with the others
Date: Tue, 10 Apr 2007 11:44:37 -0700
Message-ID: <20070410114437.d1eb492e.akpm@linux-foundation.org>
References: <20070404010655.400913479@goop.org>
	<20070404011453.598418421@goop.org>
	<200704102007.49163.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1031433AbXDJSo4@vger.kernel.org>
In-Reply-To: <200704102007.49163.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 10 Apr 2007 20:07:48 +0200 Andi Kleen <ak@suse.de> wrote:

> On Wednesday 04 April 2007 03:06:59 Jeremy Fitzhardinge wrote:
> > The other symbols used to delineate the alt-instructions sections have
> > the form __foo/__foo_end.  Rename parainstructions to match.
> 
> This patch breaks x86-64
> 

Fixed version is in 2.6.21-rc6-mm1.

Please let me know when you've uploaded your new tree...
