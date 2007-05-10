From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: lguest re-review
Date: Wed, 09 May 2007 19:22:32 -0600
Message-ID: <m1wszhsc9z.fsf@ebiederm.dsl.xmission.com>
References: <20070509025122.f3cb7247.akpm@linux-foundation.org>
	<1178756648.7286.182.camel@localhost.localdomain>
	<20070509175018.a4a685b8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754530AbXEJBXT@vger.kernel.org>
In-Reply-To: <20070509175018.a4a685b8.akpm@linux-foundation.org> (Andrew
	Morton's message of "Wed, 9 May 2007 17:50:18 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton <akpm@linux-foundation.org> writes:

> I don't get it.  Does lguest no longer need this code, or will
> it be reintroduced with an lguest merge, or something else?

No longer needed.

For the short term lguest has a separate entry point.  For the long term
2.6.23 we will rev the boot protocol, so lguest and Xen can work with
a bzImage and use our standard set of kernel parameters.

Eric
