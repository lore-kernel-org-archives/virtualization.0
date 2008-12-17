From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/13 v7] PCI: Linux kernel SR-IOV support
Date: Wed, 17 Dec 2008 09:51:03 -0800
Message-ID: <20081217175103.GA25562__27349.6220041581$1229538156$gmane$org@kroah.com>
References: <20081121183605.GA7810@yzhao12-linux.sh.intel.com>
	<200812161523.55238.jbarnes@virtuousgeek.org>
	<49486602.5000108@gmail.com> <20081217060608.GA12618@kroah.com>
	<43F901BD926A4E43B106BF17856F07554B525811@orsmsx508.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <43F901BD926A4E43B106BF17856F07554B525811@orsmsx508.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Rose, Gregory V" <gregory.v.rose@intel.com>
Cc: "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>, "grundler@parisc-linux.org" <grundler@parisc-linux.org>, "achiang@hp.com" <achiang@hp.com>, "matthew@wil.cx" <matthew@wil.cx>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "rdreier@cisco.com" <rdreier@cisco.com>, Jike Song <albcamus@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mingo@elte.hu" <mingo@elte.hu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "yinghai@kernel.org" <yinghai@kernel.org>, "bjorn.helgaas@hp.com" <bjorn.helgaas@hp.com>
List-Id: virtualization@lists.linuxfoundation.org


A: No.
Q: Should I include quotations after my reply?

On Wed, Dec 17, 2008 at 08:44:03AM -0800, Rose, Gregory V wrote:
> As noted in the attached email to the netdev list, we (e1000_devel) will support the API.

Great, will you have patches for the existing e1000 drivers soon to use
it?  Or will they be a while before they can be available?

As it is, the one posted user of this api is for a driver that has been
rejected, so as there are no users of the api, I feel it should be
deferrred until there is a user to make sure it all works and feels
proper.

thanks,

greg k-h
