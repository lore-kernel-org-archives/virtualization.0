From: Zachary Amsden <zach@vmware.com>
Subject: [RFC,
	PATCH 0/5] Paravirt: fix export of paravirt-ops to binary modules
Date: Thu, 19 Apr 2007 18:52:14 -0700 (PDT)
Message-ID: <20070420015214.6834BBFC@zach-dev2.vmware.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <petr@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Virtualization Mailing List <virtualization@lists.osdl.org>, Chaz Masden <zamsden@gmail.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

A clever set of manipulations allows us to fix binary modules with paravirt-ops
by just not exporting paravirt_ops at all and using the new patching code.

What do you think?  Experimental patches here... only partially tested, but
booting and appear to be a working prototype.

Thanks,
Zach
