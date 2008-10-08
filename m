From: "Zhao, Yu" <yu.zhao@intel.com>
Subject: RE: [PATCH 3/6 v3] PCI: support ARI capability
Date: Wed, 8 Oct 2008 10:56:18 +0800
Message-ID: <D8078B8B3B09934AA9F8F2D5FB3F28CE08A3D243B6__327.646037522022$1223434834$gmane$org@pdsmsx502.ccr.corp.intel.com>
References: <D8078B8B3B09934AA9F8F2D5FB3F28CE088751B5F3@pdsmsx502.ccr.corp.intel.com>
	<200810020903.16385.jbarnes@virtuousgeek.org>
	<20081002161701.GO13822@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081002161701.GO13822@parisc-linux.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Alex@smtp1.linux-foundation.org, Grant Grundler <grundler@parisc-linux.org>, Chiang <achiang@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Roland Dreier <rdreier@cisco.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: virtualization@lists.linuxfoundation.org

On Friday, October 03, 2008 12:17 AM, Matthew Wilcox wrote:
>On Thu, Oct 02, 2008 at 09:03:15AM -0700, Jesse Barnes wrote:
>> Maybe we should be consistent with the other APIs and call it pci_enable_ari
>> (like we do for wake & msi).  Looks pretty good otherwise.
>
>Those APIs are for drivers ... this is internal.  I don't have any
>objection of my own, though I agree with Alex's remark that the printk
>is unnecessary and just adds clutter to the boot process.

Will rename the function to pci_enable_ari, and remove the printk.

Thanks.

>
>--
>Matthew Wilcox                          Intel Open Source Technology Centre
>"Bill, look, we understand that you're interested in selling us this
>operating system, but compare it to ours.  We can't possibly take such
>a retrograde step."
>--
>To unsubscribe from this list: send the line "unsubscribe kvm" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
