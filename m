From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [syslinux] Vmware crashes if compress/misc.c scrolls?
Date: Sat, 04 Aug 2007 13:14:15 -0700
Message-ID: <46B4DE17.7070108@zytor.com>
References: <4679BBCB.2000202@zytor.com> <46B40504.70208@vmware.com>	<200708041124.35526.ak@suse.de> <46B48ADF.9050006@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765112AbXHDUOd@vger.kernel.org>
In-Reply-To: <46B48ADF.9050006@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: For discussion of SYSLINUX and tftp-hpa <syslinux@zytor.com>
Cc: Andi Kleen <ak@suse.de>, Sahil Rihan <srihan@vmware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> 
> It was 2.6.21.4, so it is fairly recent, but with 32-bit decompress 
> stage.  GCC was 4.2.0.
> 
> Sounds like a gcc bug, to me.
> 

I would argue that anything that causes a function and its callsite to
diverge, when they're part of the same file, is a gcc bug almost by
definition.

That doesn't mean it's not a problem and that there is not a solution --
if nothing else there should be a patch for -stable.

	-hpa
