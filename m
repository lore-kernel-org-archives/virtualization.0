From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH][VIRTIO] Fix vring_init() ring computations
Date: Thu, 8 Nov 2007 13:25:17 +1100
Message-ID: <200711081325.17558.rusty@rustcorp.com.au>
References: <11944039492411-git-send-email-aliguori@us.ibm.com> <200711071657.40992.rusty@rustcorp.com.au> <473260FF.1030101@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760036AbXKHCZ3@vger.kernel.org>
In-Reply-To: <473260FF.1030101@us.ibm.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 08 November 2007 12:06:07 Anthony Liguori wrote:
> Rusty Russell wrote:
> > On Wednesday 07 November 2007 13:52:29 Anthony Liguori wrote:
> >> This patch fixes a typo in vring_init().
> >
> > Thanks, applied.
> >
> > I've put it in the new, experimental virtio git tree on git.kernel.org.
>
> Hrm, perhaps you forgot to push?  I don't see it in the tree although I
> see the config ops refactoring.

It should be in the patches/1 branch.  I've pushed again...

Thanks,
Rusty.
