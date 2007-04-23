From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 03/25] xen: Add nosegneg capability to the vsyscall page
	notes
Date: Mon, 23 Apr 2007 16:29:41 -0700 (PDT)
Message-ID: <20070423232941.476FB1801A4@magilla.sf.frob.com>
References: <20070423215709.802499615@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: Jeremy Fitzhardinge's message of  Monday,
	23 April 2007 14:56:41 -0700 <20070423215709.802499615@goop.org>
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
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, Ulrich Drepper <drepper@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> + * It should contain:
> + *	hwcap 0 nosegneg
> + * to match the mapping of bit to name that we give here.

This needs to be "hwcap 0 nosegneg" to match:

> +NOTE_KERNELCAP_BEGIN(1, 2)
> +NOTE_KERNELCAP(1, "nosegneg")
> +NOTE_KERNELCAP_END

The actual bits you are using should be fine.  (You're intentionally
skipping bit 0 to work around hold glibc bugs, which you might want to add
to the comments.  Also a comment or perhaps using 1<<1 syntax would make it
more clear that "2" is the bit mask containing bit 1 and that's why it has
to be 2, and not because of some other magical property of 2.)  But if
kernel packagers don't write the matching bit number in their ld.so.conf.d
files, then ld.so.cache lookups won't work right.


Thanks,
Roland
