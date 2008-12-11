From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Wed, 10 Dec 2008 21:33:40 -0700
Message-ID: <20081211043340.GA9783__13942.8383591168$1229013601$gmane$org@colo.lackof.org>
References: <20081022083809.GA3757@yzhao12-linux.sh.intel.com>
	<20081022084531.GP3773@yzhao12-linux.sh.intel.com>
	<20081106043235.GA30292@kroah.com> <4913AA03.5060807@intel.com>
	<20081107025032.GA12824@kroah.com> <4913B8A5.5010806@intel.com>
	<20081107041721.GB15439@parisc-linux.org>
	<20081211014313.GA4947@yzhao12-linux.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20081211014313.GA4947@yzhao12-linux.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 11, 2008 at 09:43:13AM +0800, Yu Zhao wrote:
...
> I believe this is the only problem that preclude us having the run-time
> resource rebalance. And I'm not sure how much effort we can fix it. Any
> comments?

Figure out the right sequence for driver resume so the probe function
can call resume as well?

Document the change and then start modifying drivers one-by-one.
API changes are alot of work.

grant
