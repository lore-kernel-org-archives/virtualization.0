From: Ian Campbell <Ian.Campbell@XenSource.com>
Subject: Re: [PATCH 1 of 1] x86_43: Put .note.* sections into a
	PT_NOTE segment in vmlinux
Date: Tue, 22 Aug 2006 12:43:09 +0100
Message-ID: <1156246989.5091.19.camel@localhost.localdomain>
References: <2bf2abf6e97048bbef24.1154462451@ezr>
	<1156245258.5091.17.camel@localhost.localdomain>
	<20060822133306.79fac714.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20060822133306.79fac714.ak@suse.de>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Virtualization <virtualization@lists.osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Christoph Lameter <clameter@sgi.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-08-22 at 13:33 +0200, Andi Kleen wrote:
> On Tue, 22 Aug 2006 12:14:18 +0100
> Ian Campbell <Ian.Campbell@XenSource.com> wrote:
> 
> > On Tue, 2006-08-01 at 13:00 -0700, Jeremy Fitzhardinge wrote:
> > > This patch will pack any .note.* section into a PT_NOTE segment in the
> > > output file.
> > [...]
> > > This only changes i386 for now, but I presume the corresponding
> > > changes for other architectures will be as simple.
> > 
> > Here is the patch for x86_64.
> 
> Ok, but can you please resubmit with complete changelog/rationale?

Will do.

I've just noticed a bunch of sections (.vsyscall_*, .xtime and others)
which aren't getting put into segments for some reason. I'll figure that
out first...

Ian.
