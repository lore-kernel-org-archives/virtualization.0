From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
Date: Thu, 16 Nov 2006 08:05:32 +0100
Message-ID: <200611160805.32539.ak@suse.de>
References: <20061114014125.dd315fff.akpm@osdl.org> <455BBF38.5030503@vmware.com> <20061116022753.GC6602@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422634AbWKPHFh@vger.kernel.org>
In-Reply-To: <20061116022753.GC6602@sequoia.sous-sol.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 16 November 2006 03:27, Chris Wright wrote:
> * Zachary Amsden (zach@vmware.com) wrote:
> > Well that shouldn't have happened.  Must have been some reject that went 
> > unnoticed?  Try this.
> 
> Thanks Zach, added to the pv patchqueue as well.

That was one of the things that got fixed in paravirt-compile too iirc

-Andi
