From: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/2] lguest: handle dodgy/non-existent TSC.  Host code.
Date: Wed, 4 Jul 2007 08:20:26 -0500
Message-ID: <20070704132025.GZ11115@waste.org>
References: <1183529972.6005.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183529972.6005.1.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 04, 2007 at 04:19:32PM +1000, Rusty Russell wrote:
> Lguest currently requires a TSC, which breaks older machines and Matt
> Mackall who boots the host with "notsc".

I do? I temporarily had a "notsc" arg in my lguest launcher script,
but removing it made no difference. I do* boot the host with NO_HZ though.

-- 
Mathematics is the supreme nostalgia of our time.
