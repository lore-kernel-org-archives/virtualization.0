From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: lguest re-review
Date: Wed, 9 May 2007 17:50:18 -0700
Message-ID: <20070509175018.a4a685b8.akpm@linux-foundation.org>
References: <20070509025122.f3cb7247.akpm@linux-foundation.org>
	<1178756648.7286.182.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760131AbXEJAun@vger.kernel.org>
In-Reply-To: <1178756648.7286.182.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 10 May 2007 10:24:08 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> On Wed, 2007-05-09 at 02:51 -0700, Andrew Morton wrote:
> > Some concern was expressed over the lguest review status, so I shall send
> > the patches out again for people to review, to test, to make observations
> > about the author's personal appearance, etc.
> 
> Thanks Andrew,
> 
> 	This means I can finally ack this patch (thanks Eric):
> 
> From: ebiederm@xmission.com (Eric W. Biederman)
> Subject: [PATCH] Revert "[PATCH] paravirt: Add startup infrastructure for paravirtualization"
> 
> This reverts commit c9ccf30d77f04064fe5436027ab9d2230c7cdd94.

I don't get it.  Does lguest no longer need this code, or will
it be reintroduced with an lguest merge, or something else?
