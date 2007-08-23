From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Thu, 23 Aug 2007 02:47:00 +0200
Message-ID: <20070823004700.GR2642@bingen.suse.de>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org> <46CCB56F.8090308@superbug.co.uk> <20070822222036.GD3672@sequoia.sous-sol.org> <46CCB8BA.6060007@superbug.demon.co.uk> <46CCC361.6020600@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933683AbXHVXxV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46CCC361.6020600@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2007 at 04:14:41PM -0700, Jeremy Fitzhardinge wrote:
> (which would also have VT, since
> all new processors do).

Not true unfortunately. The Intel low end parts like Celerons (which 
are actually shipped in very large numbers) don't. Also Intel
is still shipping some CPUs that don't support it at all, like
the ULV Centrinos which are based on an older core.

-Andi
