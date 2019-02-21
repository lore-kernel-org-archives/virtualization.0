From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] VMCI: Support upto 64-bit PPNs
Date: Thu, 21 Feb 2019 20:42:19 +0100
Message-ID: <20190221194219.GA2347__12362.3268025526$1550778389$gmane$org@kroah.com>
References: <20190215162738.21334-1-vdasa@vmware.com>
	<20190216195253.GB11061@kroah.com>
	<8C694A7E-488C-42A9-83F8-AA4FB4E57A5A@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8C694A7E-488C-42A9-83F8-AA4FB4E57A5A@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vishnu DASA <vdasa@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Feb 21, 2019 at 07:26:29PM +0000, Vishnu DASA wrote:
> Hi Greg,
> Sounds like a good idea to use the BIT() macro but can I do that in a
> separate change to cover the entire file (and perhaps other vmci files
> too)?

Yes, that would be fine.

thanks,

greg k-h
