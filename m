From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 0/4] Enable LBR for the guest
Date: Mon, 25 Sep 2017 07:59:08 -0700
Message-ID: <20170925145908.GN4311__40626.9128471196$1506351575$gmane$org@tassilo.jf.intel.com>
References: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1506314696-4632-1-git-send-email-wei.w.wang@intel.com>
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

On Mon, Sep 25, 2017 at 12:44:52PM +0800, Wei Wang wrote:
> This patch series enables the Last Branch Recording feature for the
> guest. Instead of trapping each LBR stack MSR access, the MSRs are
> passthroughed to the guest. Those MSRs are switched (i.e. load and
> saved) on VMExit and VMEntry.
> 
> Test:
> Try "perf record -b ./test_program" on guest.

I don't see where you expose the PERF capabilities MSR? 

That's normally needed for LBR too to report the version
number.

-Andi
