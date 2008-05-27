From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 00/17] ia64/pv_ops take 6
Date: Tue, 27 May 2008 16:26:45 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC016FF410__31061.6875453436$1211931017$gmane$org@orsmsx424.amr.corp.intel.com>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
	<1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
	<20080527014628.GB23946%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080527014628.GB23946%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: "Dong, Eddie" <eddie.dong@intel.com>, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Thank you for testing.
>
> What was the result?

No problems found.

> No patch has been committed to
> git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#test

I had to spend time on a bugfix.  The bugfix is posted
in my 'release' branch. The pv_ops series (including the
documentation) is now in the 'test' branch.  Take a close
look at arch/is64/kernel/minstate.h as I had to re-merge
your changes because of collisions with the bugfix.

-Tony
