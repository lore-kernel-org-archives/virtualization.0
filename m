From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [Patch][00/18] kvm-ia64 for kernel V10
Date: Sun, 06 Apr 2008 12:08:56 +0300
Message-ID: <47F89328.9020605__45746.4836807505$1207473048$gmane$org@qumranet.com>
References: <42DFA526FC41B1429CE7279EF83C6BDC01048C4A@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <42DFA526FC41B1429CE7279EF83C6BDC01048C4A@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Zhang, Xiantao" <xiantao.zhang@intel.com>
Cc: Carsten Otte <cotte@de.ibm.com>, "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, kvm-devel@lists.sourceforge.net, Jes Sorensen <jes@sgi.com>, virtualization@lists.linux-foundation.org, "Xu,
	Anthony" <anthony.xu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Zhang, Xiantao wrote:
> Compared with V9, just fixed indentation issues  in patch 12. I put it
> the patchset in
> git://git.kernel.org/pub/scm/linux/kernel/git/xiantao/kvm-ia64.git
> kvm-ia64-mc10. Please help to review.
> Specially, the first two patches (TR Management patch and
> smp_call_function_mask patch) needs Tony's review and Ack. Thanks:-)
>   

Rebased and merged the latest version into kvm.git.  Thanks.


-- 
error compiling committee.c: too many arguments to function
