From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 04/25] xen: Add XEN config options
Date: Tue, 24 Apr 2007 21:45:06 +0200
Message-ID: <200704242145.06915.ak@suse.de>
References: <20070423215638.563901986@goop.org>
	<200704240100.31011.ak@suse.de> <462D3D31.1090702@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <462D3D31.1090702@goop.org>
Content-Disposition: inline
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
Cc: Ian Pratt <ian.pratt@xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> > Shouldn't this be after the change that adds arch/i386/xen/Kconfig?
> >
> > Otherwise you break bisects
> >   
> 
> It should be OK.  The series should build and run at each patch (though
> I have to admit I haven't tested this).  In general I've been adding
> config options for each feature as the feature itself is added.

But i don't see anything that creates arch/i386/xen before this?

-Andi
