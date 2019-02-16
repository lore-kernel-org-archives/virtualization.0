From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] VMCI: Support upto 64-bit PPNs
Date: Sat, 16 Feb 2019 20:52:53 +0100
Message-ID: <20190216195253.GB11061__12387.4343394832$1550346790$gmane$org@kroah.com>
References: <20190215162738.21334-1-vdasa@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190215162738.21334-1-vdasa@vmware.com>
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

On Fri, Feb 15, 2019 at 04:32:47PM +0000, Vishnu DASA wrote:
> diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> index b724ef7005de..eaa1e762bf06 100644
> --- a/include/linux/vmw_vmci_defs.h
> +++ b/include/linux/vmw_vmci_defs.h
> @@ -45,6 +45,7 @@
>  #define VMCI_CAPS_GUESTCALL     0x2
>  #define VMCI_CAPS_DATAGRAM      0x4
>  #define VMCI_CAPS_NOTIFICATIONS 0x8
> +#define VMCI_CAPS_PPN64         0x10

BIT()?
