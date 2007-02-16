From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [patch 07/21] Xen-paravirt: remove ctor for pgd cache
Date: Fri, 16 Feb 2007 10:39:33 +0200
Message-ID: <84144f020702160039y11fb1f4dl7b77d4358cc189ee@mail.gmail.com>
References: <20070216022449.739760547@goop.org>
	 <20070216022531.047039320@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966231AbXBPIjf@vger.kernel.org>
In-Reply-To: <20070216022531.047039320@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2/16/07, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Remove the ctor for the pgd cache.  There's no point in having the
> cache machinery do this via an indirect call when all pgd are freed in
> the one place anyway.

The reason we have slab constructors and destructors is to _avoid_
reinitializing every time we allocate an object. AFAICT your changing
the code now to do _more_ work than before, so is there some other
reason why you want to do this than avoiding an indirect call?
