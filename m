From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 03/11] xen: add missing definitions for xen grant table
	which ia64/xen needs.
Date: Thu, 21 Feb 2008 11:40:03 -0800
Message-ID: <47BDD393.5080307__44423.6998483122$1203623441$gmane$org@goop.org>
References: <20080221084530.470680000@ls.local.valinux.co.jp>
	<20080221091001.314830000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080221091001.314830000@ls.local.valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: yamahata@valinux.co.jp
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

yamahata@valinux.co.jp wrote:

Yep.  We removed the guest handle stuff for the initial upstreaming, 
since it isn't necessary on x86 and it quietened some of the reviewer 
noise.  But I expected we'd need to reintroduce it at some stage.

    J
