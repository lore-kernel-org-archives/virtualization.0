From: Dan Hecht <dhecht@vmware.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options and disable
 unsupported config options.
Date: Thu, 15 Feb 2007 23:52:44 -0800
Message-ID: <45D562CC.8000405@vmware.com>
References: <20070216022449.739760547@goop.org> <20070216022531.570154735@goop.org> <45D54BD5.8010707@vmware.com> <45D55784.1020000@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423374AbXBPHyK@vger.kernel.org>
In-Reply-To: <45D55784.1020000@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 02/15/2007 11:04 PM, Jeremy Fitzhardinge wrote:
> HZ - I'm assuming dynticks will appear in the short term, and this will
> become moot

Doesn't Xen send any non-blocked domain a 100hz alarm implicitly, 
without anyway for the guest to disable it?  I guess you'll have to 
break kernel/hypervisor compatibility if you want dynticks?
