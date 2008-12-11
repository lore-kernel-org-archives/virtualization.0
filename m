From: H L <swdevyid@yahoo.com>
Subject: Re: [PATCH 16/16 v6] PCI: document the new PCI boot parameters
Date: Thu, 11 Dec 2008 07:39:20 -0800 (PST)
Message-ID: <772646.16040.qm__21618.0548457944$1229010170$gmane$org@web45116.mail.sp1.yahoo.com>
References: <20081211043340.GA9783@colo.lackof.org>
Reply-To: swdevyid@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081211043340.GA9783@colo.lackof.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Yu Zhao <yu.zhao@intel.com>, Grant Grundler <grundler@parisc-linux.org>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "achiang@hp.com" <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, "rdreier@cisco.com" <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

--- On Wed, 12/10/08, Grant Grundler <grundler@parisc-linux.org> wrote:

> Date: Wednesday, December 10, 2008, 10:33 PM
> On Thu, Dec 11, 2008 at 09:43:13AM +0800, Yu Zhao wrote:
> ...
> > I believe this is the only problem that preclude us
> having the run-time
> > resource rebalance. And I'm not sure how much
> effort we can fix it. Any
> > comments?
> 
> Figure out the right sequence for driver resume so the
> probe function
> can call resume as well?
> 
> Document the change and then start modifying drivers
> one-by-one.
> API changes are alot of work.
> 
> grant
> --


I've been lurking awaiting to see such a discussion.  Alerting the PCI drivers that their resources have been changed from underneath them by extending the suspend/resume model, or perhaps (heresy?) adding a new callback entry point specifically for instructing PCI drivers to re-read their BARs, etc. would be a step in the right direction to enable this whole re-balancing work; well, granted root/paging devs bound to PCI devs could be tricky.  It seems entirely natural (to me) that Microsoft would shudder at the amount of work and verification of all drivers to do this, but the Linux community's attitude seems to embrace sweeping changes ;-).

--
LH
