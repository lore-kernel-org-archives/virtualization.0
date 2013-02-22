From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [GIT PULL] x86/mm changes for v3.9-rc1
Date: Fri, 22 Feb 2013 09:30:07 -0800
Message-ID: <5127AB1F.1030407__15947.0939463519$1361554492$gmane$org@zytor.com>
References: <201302220034.r1M0Y6O8008311@terminus.zytor.com>
	<20130222165531.GA29308@phenom.dumpdata.com>
	<20130222172403.GA17056@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130222172403.GA17056@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-mips@linux-mips.org, Jeremy Fitzhardinge <jeremy@goop.org>, "H. J. Lu" <hjl.tools@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Joe Millenbach <jmillenbach@gmail.com>, virtualization@lists.linux-foundation.org, Gokul Caushik <caushik1@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, sparclinux@vger.kernel.org, Christoph Lameter <cl@linux.com>, Ingo Molnar <mingo@kernel.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrea Arcangeli <aarcange@redhat.com>, Lee Schermerhorn <Lee.Schermerhorn@hp.com>, xen-devel@lists.xensource.com, Russell King <linux@arm.linux.org.uk>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, linux-pm@vger.kernel.org, Hugh Dickins <hughd@google.com>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>Ingo Molnar <mingo@>
List-Id: virtualization@lists.linuxfoundation.org

On 02/22/2013 09:24 AM, Konrad Rzeszutek Wilk wrote:
>
> Here is a better serial log of the crash (just booting a normal Xen 4.1 + initial
> kernel with 8GB):
>

Configuration, please, especially: is early_printk compiled in?  Also, 
since this is Xen-related we really need your help on this.  A lot of 
this is not going to be meaningful to non-Xen people.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
