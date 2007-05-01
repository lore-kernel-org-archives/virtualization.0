From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
	relocatable bzImage
Date: Tue, 01 May 2007 14:50:14 +1000
Message-ID: <1177995014.28659.54.camel__9686.94959669865$1177995091$gmane$org@localhost.localdomain>
References: <20070428758.455116000@suse.de>
	<20070428175909.1D09D151CA@wotan.suse.de> <46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com> <4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<1177902195.30071.203.camel@localhost.localdomain>
	<463572B7.90202@zytor.com>
	<1177909434.30071.216.camel@localhost.localdomain>
	<m1ejm16flv.fsf@ebiederm.dsl.xmission.com>
	<1177990722.28659.39.camel@localhost.localdomain>
	<4636B7DE.5050005@zytor.com>  <4636BB6B.9070300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4636BB6B.9070300@zytor.com>
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

On Mon, 2007-04-30 at 21:00 -0700, H. Peter Anvin wrote:
> H. Peter Anvin wrote:
> > Rusty Russell wrote:
> >> It'd be nicer if there were a "struct boot_params" declaration, but we
> >> can't have everything.
> > 
> > It's in my patchset-under-development.
> > 
> > (Preview snapshot:
> > http://userweb.kernel.org/~hpa/setup-snapshot-2007.04.30.patch)
> 
> Just pushed out a git tree:
> 
> http://git.kernel.org/?p=linux/kernel/git/hpa/linux-2.6-newsetup.git;a=summary

Any chance of splitting off a "struct boot_params" header (includable by
non-kernel code) for inclusion immediately?  The rest can wait until
2.6.23, but it'd be sweet to get this in place sooner.

BTW, wrt. a new "platform type" field, should it go something like this?

-0235/3	N/A	pad2		Unused
+0235/1	2.07+	platform_type	Runtime platform (see below)
+0236/2	N/A	pad2		Unused
...
+  platform_type:
+	For kernels which can boot on multiple platforms.  Currently
+	0 == native (normal), 1 == lguest (paravirtualized).

Thanks,
Rusty.
