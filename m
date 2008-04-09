From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 01/23] ia64/xen: introduce synch bitops which is necessary
	for	ia64/xen support.
Date: Wed, 9 Apr 2008 18:01:39 +0900
Message-ID: <20080409090139.GA2583%yamahata__35884.9165183075$1207731869$gmane$org@valinux.co.jp>
References: <12077166301391-git-send-email-yamahata@valinux.co.jp>
	<12077166303062-git-send-email-yamahata@valinux.co.jp>
	<47FC4F9F.4060301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <47FC4F9F.4060301@goop.org>
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
Cc: eddie.dong@intel.com, virtualization@lists.linux-foundation.org, linux-ia64@vger.kernel.org, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 09, 2008 at 12:09:51AM -0500, Jeremy Fitzhardinge wrote:

> >+#define sync_cmpxchg	ia64_cmpxchg4_acq
> >  
> 
> Please always use arguments with function-like macros, to prevent 
> accidental namespace clashes.

Will fix.

> >+#define sync_cmpxchg_subword sync_cmpxchg
> >  
> 
> Ditto.

It looks like that sync_cmpxchg_subword isn't used any more.
Is it safe to eliminate sync_cmpxchg_subword?

-- 
yamahata
