From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [PATCH 00/17] ia64/pv_ops take 6
Date: Tue, 27 May 2008 10:46:28 +0900
Message-ID: <20080527014628.GB23946%yamahata__646.600258960639$1211852922$gmane$org@valinux.co.jp>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
	<1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1FE6DD409037234FAB833C420AA843EC0162EBE6@orsmsx424.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Dong, Eddie" <eddie.dong@intel.com>, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 20, 2008 at 02:59:49PM -0700, Luck, Tony wrote:
> > Hi. This patchset implements ia64/pv_ops support which is the
> > framework for virtualization support.
> > Changes from take 5 are rebased to Linux 2.6.26-rc3,
> > bug fix ivt.S paravirtualization and multi entry point support.
> > I believe these patches can be applied to the linux ia64 repository.
> 
> Ok.  This series of 17 patches applied, and I can boot the
> resulting kernel as a native binary.  I'll run it for another
> day or two, if nothinstrange happens I'll add these to my
> "test" tree so they'll go to -mm and linux-next for more general
> testing.

Hello Tony. Thank you for testing.

What was the result?
No patch has been committed to
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git#test
Did anything go wrong?

-- 
yamahata
