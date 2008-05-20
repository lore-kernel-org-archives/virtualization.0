From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH 00/17] ia64/pv_ops take 6
Date: Tue, 20 May 2008 14:59:49 -0700
Message-ID: <1FE6DD409037234FAB833C420AA843EC0162EBE6__2178.88042466274$1211321298$gmane$org@orsmsx424.amr.corp.intel.com>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <12112028241775-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>, linux-ia64@vger.kernel.org
Cc: xen-ia64-devel@lists.xensource.com, "Dong, Eddie" <eddie.dong@intel.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

> Hi. This patchset implements ia64/pv_ops support which is the
> framework for virtualization support.
> Changes from take 5 are rebased to Linux 2.6.26-rc3,
> bug fix ivt.S paravirtualization and multi entry point support.
> I believe these patches can be applied to the linux ia64 repository.

Ok.  This series of 17 patches applied, and I can boot the
resulting kernel as a native binary.  I'll run it for another
day or two, if nothinstrange happens I'll add these to my
"test" tree so they'll go to -mm and linux-next for more general
testing.

-Tony
