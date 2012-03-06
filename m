From: Wei Liu <wei.liu2@citrix.com>
Subject: Re: [Xen-devel] [PATCH 0001/001] xen: multi page ring support for
	block devices
Date: Tue, 6 Mar 2012 11:16:06 +0000
Message-ID: <1331032566.5407.4.camel__27059.2385008515$1331744714$gmane$org@leeds.uk.xensource.com>
References: <1330701099-18281-1-git-send-email-santoshprasadnayak@gmail.com>
	<7914B38A4445B34AA16EB9F1352942F1010A1FA12364@SJCPMAILBOX01.citrite.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <7914B38A4445B34AA16EB9F1352942F1010A1FA12364@SJCPMAILBOX01.citrite.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Santosh Jodh <Santosh.Jodh@citrix.com>
Cc: "jeremy@goop.org" <jeremy@goop.org>, wei.liu2@citrix.com, Ian Campbell <Ian.Campbell@citrix.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "waldi@debian.org" <waldi@debian.org>, "weiyi.huang@gmail.com" <weiyi.huang@gmail.com>, "joe.jin@oracle.com" <joe.jin@oracle.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jbeulich@novell.com" <jbeulich@novell.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Durrant <Paul.Durrant@citrix.com>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dgdegra@tycho.nsa.gov" <dgdegra@tycho.nsa.gov>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "lersek@redhat.com" <lersek@redhat>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-03-05 at 21:49 +0000, Santosh Jodh wrote:
> From: Santosh Jodh <santosh.jodh@citrix.com>
> 
> Add support for multi page ring for block devices.
> The number of pages is configurable for blkback via module parameter.
> blkback reports max-ring-page-order to blkfront via xenstore.
> blkfront reports its supported ring-page-order to blkback via xenstore.
> blkfront reports multi page ring references via ring-refNN in xenstore.
> The change allows newer blkfront to work with older blkback and
> vice-versa.
> Based on original patch by Paul Durrant.
> 
> Signed-off-by: Santosh Jodh <santosh.jodh@citrix.com>


Doesn't the xenbus interface change deserve another patch (as
prerequisite for block devices change)? Or at least please mention the
change in commit message?


Wei.
