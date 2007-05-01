From: Andi Kleen <ak@suse.de>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 1 May 2007 05:39:31 +0200
Message-ID: <20070501033931.GI25929__18560.6211926372$1177987355$gmane$org@bingen.suse.de>
References: <20070428175909.1D09D151CA@wotan.suse.de>
	<46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>
	<4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org>
	<m18xc9344o.fsf@ebiederm.dsl.xmission.com>
	<463670D1.3000003@goop.org>
	<m14pmx31bw.fsf@ebiederm.dsl.xmission.com>
	<463678BA.5080609@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <463678BA.5080609@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 30, 2007 at 04:16:10PM -0700, H. Peter Anvin wrote:
> Eric W. Biederman wrote:
> > 
> > I'm tempted to just reload the segments in setup.S, but that might
> > break loadlin support or one of the other bootloaders that starts the
> > kernel in 32bit mode so we need to be careful.
> > 
> 
> We already load all the segments in setup.S.  I'm retaining this in my
> rewrite.

It's still unclear to me why exactly you want to rewrite it?
Are there any particular bugs in the current code you want to fix?

-Andi
