From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 07/20] Allow paravirt backend to choose kernel PMD
 sharing
Date: Fri, 6 Apr 2007 18:21:55 -0700
Message-ID: <20070406182155.e72d8f95.akpm@linux-foundation.org>
References: <20070404191151.009821039@goop.org>
	<20070404191205.392155702@goop.org>
	<20070406164139.08cd343b.akpm@linux-foundation.org>
	<4616DFB2.4020802@goop.org>
	<20070406172844.12f7b8e7.akpm@linux-foundation.org>
	<4616E86D.30904@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964862AbXDGBWL@vger.kernel.org>
In-Reply-To: <4616E86D.30904@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>, Zachary Amsden <zach@vmware.com>, Christoph Lameter <clameter@sgi.com>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 06 Apr 2007 17:40:13 -0700 Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andrew Morton wrote:
> > Something like that.  I don't want to redo my patch if we're going to change
> > your patch ;)
> >   
> 
> OK.  I won't specifically redo it on top of your patches, but I'll
> rework it to remove the inline function and add the if() statement.  Do
> you want an incremental update or a complete replacement?
> 

Thanks.  A replacement would suit.
