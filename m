From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 07:15:43 -0700
Message-ID: <20081217141542.GB19967__12833.6402624429$1229523481$gmane$org@parisc-linux.org>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200812161523.55238.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: randy.dunlap@oracle.com, grundler@parisc-linux.org, achiang@hp.com, linux-pci@vger.kernel.org, rdreier@cisco.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, horms@verge.net.au, kvm@vger.kernel.org, greg@kroah.com, mingo@elte.hu, yinghai@kernel.org, bjorn.helgaas@hp.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 16, 2008 at 03:23:53PM -0800, Jesse Barnes wrote:
> I applied 1-9 to my linux-next branch; and at least patch #10 needs a respin, 

I still object to #2.  We should have the flexibility to have 'struct
resource's that are not in this array in the pci_dev.  I would like to
see the SR-IOV resources _not_ in this array (and indeed, I'd like to
see PCI bridges keep their producer resources somewhere other than in
this array).  I accept that there are still some problems with this, but
patch #2 moves us further from being able to achieve this goal, not
closer.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
