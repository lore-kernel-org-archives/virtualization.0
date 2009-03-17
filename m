From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 03/15] NULL noise: arch/x86/xen/smp.c
Date: Tue, 17 Mar 2009 14:17:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0903171417300.11733@jikos.suse.cz>
References: <20090305190954.30062.44759.stgit@f10box.hanneseder.net> <20090305191350.30062.68789.stgit@f10box.hanneseder.net> <49B032E1.50303@goop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758389AbZCQNsq@vger.kernel.org>
In-Reply-To: <49B032E1.50303@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Hannes Eder <hannes@hanneseder.net>, trivial@kernel.org, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 5 Mar 2009, Jeremy Fitzhardinge wrote:

> Hannes Eder wrote:
> > Fix this sparse warnings:
> >   arch/x86/xen/smp.c:316:52: warning: Using plain integer as NULL pointer
> >   arch/x86/xen/smp.c:421:60: warning: Using plain integer as NULL pointer
> > 
> > Signed-off-by: Hannes Eder <hannes@hanneseder.net>
> >   
> Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Noone seems to have picked this so far, so I have applied it to trivial 
tree. Thanks,

-- 
Jiri Kosina
