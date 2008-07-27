From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: How to get a sense of VM pressure
Date: Sun, 27 Jul 2008 16:43:31 +1000
Message-ID: <200807271643.32338.rusty@rustcorp.com.au>
References: <488A1398.7020004@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757490AbYG0GoA@vger.kernel.org>
In-Reply-To: <488A1398.7020004@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>
List-Id: virtualization@lists.linuxfoundation.org

On Saturday 26 July 2008 03:55:36 Jeremy Fitzhardinge wrote:
> So I guess what I need is some measurement of "memory use" which is
> perhaps akin to a system-wide RSS; a measure of the number of pages
> being actively used, that if non-resident would cause a large amount of
> paging.  If you shrink the domain down to that number of pages + some
> padding (x%?), then the system will run happily in a stable state.  If
> that number increases, then the system will need new memory soon, to
> stop it from thrashing.  And if that number goes way below the domain's
> actual memory allocation, then it has "too much" memory.

Like everyone, I've thought about this.  The shrinker callbacks seem like a 
candidate here; have you played with them at all?

Some dynamic tension between the shrinker callback and slow feed of pages to 
the balloon seems like it should work...

Rusty.
