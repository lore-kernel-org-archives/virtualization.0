From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 00/17] ia64/pv_ops take 6
Date: Wed, 28 May 2008 12:55:21 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC016FFB71__49260.2402381182$1212004799$gmane$org@orsmsx424.amr.corp.intel.com>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
	<1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
	<20080527014628.GB23946%yamahata@valinux.co.jp>
	<1FE6DD409037234FAB833C420AA843EC016FF410@orsmsx424.amr.corp.intel.com>
	<20080528083443.GE29174%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080528083443.GE29174%yamahata@valinux.co.jp>
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

> Since the effort to reduce code size had already been made, so 
> it is difficult to go further. By moving all of them, it would
> be consistent and we don't have to worry about code size anymore.

I've been caught by these a number of times while adding debug/monitor
hooks to ivt.S code.  Moving all of these squatters out is a good idea.

Thank you. Applied.

-Tony
