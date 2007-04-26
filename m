From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
	mappings
Date: Wed, 25 Apr 2007 17:33:37 -0700
Message-ID: <20070426003337.GB2819@sequoia.sous-sol.org>
References: <4627DDAD.4070805@redhat.com> <4627E099.209@goop.org>
	<m1abwwqiof.fsf@ebiederm.dsl.xmission.com>
	<462FC8CD.1030505@goop.org>
	<m11wi8qflo.fsf@ebiederm.dsl.xmission.com>
	<462FD0EF.5050706@goop.org>
	<m1tzv4p079.fsf@ebiederm.dsl.xmission.com>
	<462FDBB4.8020604@goop.org>
	<m14pn4owpy.fsf@ebiederm.dsl.xmission.com>
	<462FE728.5060802@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <462FE728.5060802@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Chuck Ebbert <cebbert@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Eric W. Biederman wrote:
> > Then why you had to allocate enough pages to cause a failure has me stumped.
> > Perhaps there is some other bug?
> 
> Perhaps, but nothing comes to mind. I'll see what happens when I boot
> this kernel on real hardware (rather than kvm).

I was using real hardware with your .config when I reproduced it.
