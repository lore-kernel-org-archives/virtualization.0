From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] paravirt: noreplace-paravirt is implemented for x86 and
 ia-64
Date: Mon, 16 Aug 2010 15:04:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008161503550.1019@pobox.suse.cz>
References: <alpine.LNX.2.00.1008111832510.2702@pobox.suse.cz> <4C62D309.5010909@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C62D309.5010909@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 11 Aug 2010, Jeremy Fitzhardinge wrote:

>  On 08/11/2010 09:34 AM, Jiri Kosina wrote:
> > kernel-parameters.txt lists 'noreplace-paravirt' parameter as being
> > limited to X86-32, which is incorrect -- it's actually supported by
> > x86-32, x86-64 and ia-64.
> > 
> > Signed-off-by: Jiri Kosina<jkosina@suse.cz>
> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Thanks. As I haven't found the patch in linux-next as of today, I'll be 
taking it through trivial queue.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
