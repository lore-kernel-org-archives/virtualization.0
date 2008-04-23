From: Jes Sorensen <jes@sgi.com>
Subject: Re: [PATCH 11/15] ia64/pv_ops: paravirtualize NR_IRQS
Date: Wed, 23 Apr 2008 16:03:58 +0200
Message-ID: <480F41CE.3000803__43282.6702869081$1208959571$gmane$org@sgi.com>
References: <1207716548202-git-send-email-yamahata@valinux.co.jp>
	<1207716549755-git-send-email-yamahata@valinux.co.jp>
	<yq08wz6l0jd.fsf@jaguar.mkp.net>
	<20080422101113.GH28863%yamahata@valinux.co.jp>
	<480DD4A7.9020207@sgi.com>
	<20080423025414.GA7679%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080423025414.GA7679%yamahata@valinux.co.jp>
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
Cc: eddie.dong@intel.com, xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
>> I'd rather have PARAVIRT_NR_IRQ set from Kconfig if possible given that
>> all of these are constants anyway. If we cannot do that, then it would
>> be better to do the #if FOO_NR_IRQ > PARAVIRT_NR_IRQ in the various
>> header files for Xen/KVM/lguest so we don't get the clutter in the main
>> makefile.
> 
> Unfotunately Kconfig doesn't support arithmetic comparison.
> So do you want something like the followings?

IMHO, that would be better.

Cheers,
Jes
