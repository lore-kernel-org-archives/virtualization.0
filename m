From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Thu, 17 Jan 2008 16:59:15 +1100
Message-ID: <200801171659.16370.rusty__23091.3884159692$1200549726$gmane$org@rustcorp.com.au>
References: <20080114200357.GA18354@dmt>
	<200801171429.32888.rusty@rustcorp.com.au>
	<478ED32A.1060803@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <478ED32A.1060803@codemonkey.ws>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 17 January 2008 15:01:46 Anthony Liguori wrote:
> Rusty Russell wrote:
> > OTOH it's currently pretty obvious (and usually fatal) if the guest has
> > trouble meeting the balloon requirements.  A serious host needs a way of
> > detecting stress in the guest anyway, which this doesn't offer until it's
> > too late...
>
> The question I'm interested in answering though is not if but when.  I
> would like to know when the guest has reached it's target.

I'm saying that it will be v. quickly in all but "too much squeeze" case.

> And while we do get the madvise call outs, it's possible that pages have
> been faulted in since then.

But that's exactly what the balloon number *doesn't* tell you.  It can tell 
you that it's released pages back to be used by the OS, but not whether the 
OS has used them.

I think this number is good for debugging the balloon driver, but for anything 
else it's a false friend.

Rusty.
PS.  Please cut down mails when you reply.
