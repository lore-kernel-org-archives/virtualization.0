From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 0/4] Enable LBR for the guest
Date: Tue, 26 Sep 2017 09:51:37 -0700
Message-ID: <20170926165137.GR4311__49863.9042060406$1506444708$gmane$org@tassilo.jf.intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
	<20170925145908.GN4311@tassilo.jf.intel.com>
	<59CA1417.7070602@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <59CA1417.7070602@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Wei Wang <wei.w.wang@intel.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, pbonzini@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

> On the other side, it seems that the (guest) kernel driver also works
> without
> the above being supported, should we change it to report error and stop
> using the PMU features when the check of the above two fails (at
> intel_pmu_init())?

You could add the extra check for the LBR code yes, although it already checks
if the LBR MSRs work, so in practice it's likely already covered.

-Andi
