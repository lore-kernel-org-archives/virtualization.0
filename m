From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/6] Re-enable VDSO by default with PARAVIRT
Date: Wed, 4 Apr 2007 18:57:54 +0200
Message-ID: <200704041857.54535.ak@suse.de>
References: <20070404010655.400913479@goop.org> <20070404011453.193215073@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751292AbXDDQ6P@vger.kernel.org>
In-Reply-To: <20070404011453.193215073@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 04 April 2007 03:06:56 Jeremy Fitzhardinge wrote:
> Everyone wants VDSO to be enabled by default.  COMPAT_VDSO still needs
> a fix, but with luck that will turn up soon.

Hmm, that would break at least my test system until Jan's patch is applied.

-Andi
