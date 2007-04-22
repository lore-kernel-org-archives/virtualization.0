From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to
	binary modules
Date: Mon, 23 Apr 2007 09:37:07 +1000
Message-ID: <1177285027.17026.0.camel@localhost.localdomain>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<200704201134.42116.ak@suse.de> <4628D64A.4070900@goop.org>
	<46292FB2.5030404@vmware.com> <462931A2.2060104@goop.org>
	<46293266.9020306@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46293266.9020306@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chaz Masden <zamsden@gmail.com>, Petr Vandrovec <petr@vmware.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-04-20 at 14:36 -0700, Zachary Amsden wrote:
> Jeremy Fitzhardinge wrote:
> > Zachary Amsden wrote:
> >   
> >> Yes, I don't know either - but we should be consistent about their
> >> export regardless of whether PAE is selected or not.  So we should
> >> either have 5 arg macros or not export set_pte_at* at all, even in 4
> >> arg version.
> >>     
> >
> > So can you separately control exportability independently from patchability?
> >   
> 
> Nope.  But I think we should maintain parity between PAE and non-PAE - 
> and probably also maintain parity between non-paravirt-ops and 
> paravirt-ops, which means the 5 arg macros are a good idea.  It's not 
> like they are very hard to create or maintain.

Less exports good.  Consistency with all config options isn't a hard
requirement: I'd be tempted not to export the pte functions.

Rusty.
