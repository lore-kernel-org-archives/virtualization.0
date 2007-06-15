From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 04/10] i386: clean up bzImage generation
Date: Fri, 15 Jun 2007 09:20:14 -0700
Message-ID: <4672BC3E.6080308__38188.3936621763$1181924514$gmane$org@zytor.com>
References: <20070615004818.424726597@goop.org>
	<20070615005012.962196819@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070615005012.962196819@goop.org>
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
Cc: Xen-Devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, v12n <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> -setup_move_size: .word  0x8000		# size to move, when setup is not
> +setup_move_size: .word  _setup_size	# size to move, when setup is not
>  					# loaded at 0x90000. We will move setup
>  					# to 0x90000 then just before jumping
>  					# into the kernel. However, only the

This is WRONG and will break 2.00 protocol bootloaders, if any still
exist, and quite possibly some 2.01 protocol bootloaders.  There are
definitiely bootloaders in the field that rely on this implicit value.

> @@ -246,7 +246,6 @@ setup2:
>  	jnz	1f
>  	movw	$0xfffc, %sp	# Make sure we're not zero
>  1:	movzwl	%sp, %esp	# Clear upper half of %esp
> -	sti

Motivation, please?

	-hpa
