From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem mappings
Date: Mon, 23 Apr 2007 19:54:46 +0200
Message-ID: <200704231954.46339.ak@suse.de>
References: <20070414204154.871250608@goop.org> <m1vefnvvyb.fsf@ebiederm.dsl.xmission.com> <462CF0C5.2040200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161182AbXDWRzR@vger.kernel.org>
In-Reply-To: <462CF0C5.2040200@zytor.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 23 April 2007 19:45:41 H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> > 
> > - I know of one system that had BIOS tables at 16MB I believe (and
> >   thus had a fairly low hole).
> > 
> 
> Please name names, otherwise this is just rumouring.  Seriously.  We 
> have enough cargo-cult programming as it is.

Unisys did this at some point in their large machines, but they fixed
that in a later BIOS.

Anyways, boot up should be robust against any holes if possible.

-Andi
