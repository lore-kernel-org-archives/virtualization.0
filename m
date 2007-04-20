From: Andi Kleen <ak@suse.de>
Subject: Re: [RFC,
	PATCH 0/5] Paravirt: fix export of paravirt-ops to binary modules
Date: Fri, 20 Apr 2007 11:34:41 +0200
Message-ID: <200704201134.42116.ak@suse.de>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070420015214.6834BBFC@zach-dev2.vmware.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 20 April 2007 03:52:14 Zachary Amsden wrote:
> A clever set of manipulations allows us to fix binary modules with paravirt-ops
> by just not exporting paravirt_ops at all and using the new patching code.
> 
> What do you think?  Experimental patches here... only partially tested, but
> booting and appear to be a working prototype.

Basic idea looks good.

But is the 5 argument support really needed? 	I don't see any paravirt 
ops functions that needs it and even if there was one it still wouldn't be clear
if it made sense to export it.

-Andi
